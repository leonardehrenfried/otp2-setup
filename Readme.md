## Automated setup for OTP2

This repo contains a Makefile for setting up an OTP2 instance with 
the configuration for the city of Herrenberg quickly.

### Required software

- make
- curl
- Java 11

### Commands

- `make build-stuttgart` to download all requirements (OTP jar, OSM, GTFS) and build a graph
- `make run-stuttgart` to run OTP with the previously built graph

The OTP debug UI runs on http://localhost:8080

If you want to use your own OTP code, replace `otp.jar` with the one compiled
by you.


### OTP version

By default a compiled JAR is downloaded from a server maintained by 
@leonardehrenfried and this is periodically updated.
