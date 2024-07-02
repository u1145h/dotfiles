#!/usr/bin/env python3
import gi
gi.require_version("Playerctl", "2.0")
from gi.repository import Playerctl, GLib
import logging
import sys
import signal
import json
import os
import argparse  # Importing argparse

logger = logging.getLogger(__name__)

def signal_handler(sig, frame):
    logger.info("Received signal to stop, exiting")
    sys.stdout.write("\n")
    sys.stdout.flush()
    sys.exit(0)

class PlayerManager:
    def __init__(self):
        self.manager = Playerctl.PlayerManager()
        self.loop = GLib.MainLoop()
        self.manager.connect("name-appeared", self.on_player_appeared)
        self.manager.connect("player-vanished", self.on_player_vanished)

        signal.signal(signal.SIGINT, signal_handler)
        signal.signal(signal.SIGTERM, signal_handler)
        signal.signal(signal.SIGPIPE, signal.SIG_DFL)

        self.init_players()

    def init_players(self):
        for player_name in self.manager.props.player_names:
            self.init_player(Playerctl.Player.new_from_name(player_name))

    def run(self):
        logger.info("Starting main loop")
        self.loop.run()

    def init_player(self, player):
        logger.info(f"Initialize new player: {player.props.player_name}")
        player.connect("playback-status", self.on_playback_status_changed)
        player.connect("metadata", self.on_metadata_changed)
        self.manager.manage_player(player)
        self.on_metadata_changed(player, player.props.metadata)

    def get_players(self):
        return self.manager.props.players

    def write_output(self, text):
        logger.debug(f"Writing output: {text}")

        output = {"text": text}

        sys.stdout.write(json.dumps(output) + "\n")
        sys.stdout.flush()

    def clear_output(self):
        sys.stdout.write("\n")
        sys.stdout.flush()

    def on_playback_status_changed(self, player, status):
        logger.debug(f"Playback status changed for player {player.props.player_name}: {status}")
        self.on_metadata_changed(player, player.props.metadata)

    def get_first_playing_player(self):
        players = self.get_players()
        logger.debug(f"Getting first playing player from {len(players)} players")
        if players:
            for player in players[::-1]:
                if player.props.status == "Playing":
                    return player
            return players[0]
        else:
            logger.debug("No players found")
            return None

    def show_most_important_player(self):
        logger.debug("Showing most important player")
        current_player = self.get_first_playing_player()
        if current_player:
            self.on_metadata_changed(current_player, current_player.props.metadata)
        else:
            self.clear_output()

    def on_metadata_changed(self, player, metadata):
        logger.debug(f"Metadata changed for player {player.props.player_name}")
        current_playing = self.get_first_playing_player()
        if not current_playing or current_playing.props.player_name == player.props.player_name:
            self.write_output(player.props.player_name)
        else:
            logger.debug(f"Other player {current_playing.props.player_name} is playing, skipping")

    def on_player_appeared(self, _, player):
        logger.info(f"Player has appeared: {player.props.player_name}")
        self.init_player(player)

    def on_player_vanished(self, _, player):
        logger.info(f"Player {player.props.player_name} has vanished")
        self.show_most_important_player()

def parse_arguments():
    parser = argparse.ArgumentParser()

    parser.add_argument("-v", "--verbose", action="count", default=0)
    parser.add_argument("--enable-logging", action="store_true")

    return parser.parse_args()

def main():
    arguments = parse_arguments()

    if arguments.enable_logging:
        logfile = os.path.join(os.path.dirname(os.path.realpath(__file__)), "media-player.log")
        logging.basicConfig(filename=logfile, level=logging.DEBUG,
                            format="%(asctime)s %(name)s %(levelname)s:%(lineno)d %(message)s")

    logger.setLevel(max((3 - arguments.verbose) * 10, 0))

    logger.info("Creating player manager")
    player = PlayerManager()
    player.run()

if __name__ == "__main__":
    main()
