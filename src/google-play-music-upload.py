#import the library used to query a website
import time
import sys
import re
import datetime
import os
import random
from os import system

from gmusicapi import Musicmanager

# API Documentation https://unofficial-google-music-api.readthedocs.io/en/latest/reference/musicmanager.html

if __name__ == "__main__":
    print("Start > " + datetime.datetime.now().isoformat())

    mm = Musicmanager()
    # mm.perform_oauth()

    mm.login()

    # Get list of uploaded songs
    upl_song_list = mm.get_uploaded_songs()

    print upl_song_list

    # Upload a song to the library
    #resp = mm.upload(
    #    "/tmp/Unconditionally - Katy Perry Piano Cover - Music Video.mp3", enable_matching=True)

    # Download a song from Library
    filename, audio = mm.download_song(u'db0c6360-73a9-341f-a794-b627742748b6')

    # if open() throws a UnicodeEncodeError, either use
    #   filename.encode('utf-8')
    # or change your default encoding to something sane =)
    with open(filename, 'wb') as f:
        f.write(audio)

