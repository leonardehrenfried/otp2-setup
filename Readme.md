## Automated setup for OTP2

This repo contains a Makefile for setting up an OTP2 instance for 
various cities/regions around the world.

### Required software

- make
- curl
- Java 11
- osmium (for some regions)

### Example Commands

- `make build-stuttgart` to download all requirements (OTP jar, OSM, GTFS) and build a graph
- `make run-stuttgart` to run OTP with the previously built graph

If you want to use a region other than `stuttgart`, replace it with your choice, ie. `make build-drammen` or `make build-oslo`.

The OTP debug UI runs on http://localhost:8080

If you want to use your own OTP code, replace `otp.jar` with the one compiled
by you.

### Available regions

Check out the folders to get an idea of what regions can be used.

### OTP version

By default a compiled JAR is downloaded from [my snapshot server](https://otp.leonard.io/snapshots/2.1-SNAPSHOT/) 
and automatically updated when there are new commits in the repo.
