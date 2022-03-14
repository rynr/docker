# rynr/mopidy

The simplest way to run mopidy is to just run `docker run -p 6680:6680 -p
5555:5555/upd rynr/mopidy`, which will start mopidy and publish the ports
[`6680/tcp`](http://localhost:6680/) and `5555/udp`.

Please refer to the [official docs](https://docs.mopidy.com/) for configuration
options.
