# [Firecracker](https://firecracker-microvm.github.io) Try-Out

I used this scripts to start 32 Firecracker VMMs in a Raspberry Pi 4 and run 32 simultaneous Python scripts that call an external web service in less than 30 seconds.

##Instructions
1. Download Firecracker for your architecture.
2. Run `massive-firecrackers.sh`, optionally passing in the number of VMMs you want to spin-up.
3. Run `server.py` to start the web service.
4. Run `get-kernel-rootfs.sh` to download the kernel and rootfs. Add `client.py` to the rootfs and make it run at boot.
5. Run `massive-guests.sh` to start and run the guests, passing the number of VMMs you spinned-up.
6. Check the server output, you should see the calls comming in.

##Contents
1. `init-network.sh` enables IP forwarding, only run it once.
2. `start-firecracker.sh`starts a single VMM with a specific ID.
3. `massive-firecrackers.sh` starts a number of VMMs.
4. `get-kernel-rootfs.sh` downloads the necessary kernel and rootfs.
5. `server.py` simple Python "hello" web service.
6. `client.py` simple Python script to call the "hello" web service.
7. `set-kernel.sh` configures a specific VMM's kernel.
8. `set-rootfs.sh` configures a specific VMM's rootfs.
9. `set-network.sh` configures a specific VMM's network.
10. `start-guest.sh` starts a specific VMM's guest OS.
11. `set-all.sh` does everything needs to configure and start a VMM guest.
12. `massive-guests.sh` starts a number of VMM guests.
