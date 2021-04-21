## Automated setup for OTP2

This repo contains a Makefile for setting up an OTP2 instance with 
the configuration for the city of Herrenberg quickly.

### Commands

- `make build-stuttgart` to download all requirements (OTP jar, OSM, GTFS) and build a graph
- `make run-stuttgart` to run OTP with previously built graph


If you want to use your own OTP code, replace `otp.jar` with the one compiled
by you.
