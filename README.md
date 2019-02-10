# av1_bitstreamparser
extracts qp values from av1 bitstreams

this project is based on https://ffmpeg.org/releases/ffmpeg-4.1.tar.xz
modifications to ffmeg are mostly done in libaomdec.c and marked.

Author: Steve Göring

## requirements
for ubuntu 18.04 just run `./prepare.sh`, all requirements will be installed

otherwise install:
```
autoconf automake build-essential cmake git \
        libass-dev libfreetype6-dev libsdl2-dev libtheora-dev libtool \
        libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev \
        libxcb-xfixes0-dev mercurial pkg-config texinfo wget \
        zlib1g-dev yasm
```
and uncomment `requirements` in `prepare.sh` and run `./prepare.sh`

## Usage
Assuming that the prepare script successfully compiles the patched ffmpeg version
it is possible to extract bitstream statistics with
```
./av1_parser.py


usage: av1_parser.py [-h] [--report_file REPORT_FILE] [--nostdout] video_file

extract qp values from av1 encoded videos

positional arguments:
  video_file            input video file

optional arguments:
  -h, --help            show this help message and exit
  --report_file REPORT_FILE
                        file to store the report, supports compression, e.g.
                        using report.bz2 (default: report.json.bz2)
  --nostdout            no report output on stdout (default: False)

stg7 2019

```