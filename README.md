Minimum Requirements:
- Raspberry Pi 5
- 4GB RAM
- 64-bit OS

## Running the Container

To run the Raspiheim Valheim server, use the following Docker command. Make sure to replace the placeholders with your actual values:

```bash
docker run -d \
  --name raspiheim \
  --hostname raspiheim \
  -p 2456:2456/udp \
  -p 2457:2457/udp \
  -e SERVER_NAME=Raspiheim \
  -e WORLD_NAME=Raspiworld \
  -e SERVER_PASS=Raspipass \
  -e PUBLIC=disabled \
  -e UPDATE=enabled \
  -e PAUSE=disabled \
  -e CROSSPLAY=enabled \
  -e SAVE_INTERVAL=1800 \
  -v /path/to/valheim/data:/data \
  -v /path/to/valheim/server:/valheim \
  --restart=unless-stopped \
  ghcr.io/atoll6/raspiheim:latest
```

**Notes:**
- Replace `/path/to/valheim/data` and `/path/to/valheim/server` with actual paths on your host system.
- The container will download Valheim on first run if no persistent data is found.
- For public servers, set `PUBLIC=enabled` and ensure port 2456/udp is forwarded in your router.


## Environment Variables

- `SERVER_NAME`: Server name displayed in the lobby (default: Raspiheim)
- `WORLD_NAME`: Name of your save data (default: Raspiworld)
- `SERVER_PASS`: Your server password (default: Raspipass)
- `PUBLIC`: Determines if the server is shown in the lobby. Set to `enabled` for public, `disabled` for private (or use `1`/`0`). Remember to forward port 2456/udp in your router for public servers.
- `UPDATE`: Determines if the server should check for and install updates. Set to `enabled` or `disabled`.
- `PAUSE`: Pauses the container when no players are connected and resumes when someone tries to connect. Set to `enabled` or `disabled`. Recommended for Raspberry Pi 5.
- `CROSSPLAY`: Enables crossplay between PC and console players. Set to `enabled` or `disabled`.
- `SAVE_INTERVAL`: Interval in seconds for automatic saves (default: 1800, which is 30 minutes).