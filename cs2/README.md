# CS2 Setup

1. Rename `install_example.txt` to `install.txt`
2. Replace the `<steamuser>`, `<steampass>`, `<steamguard>` entries with your steam account details
3. Run the following command to build the image with CS2 installed

```
sktan ➜ ~/…/sktan-gaming/docker-game-servers/cs2 (master) $ docker build  --secret id=csgoinstall,src=steamcmd/install.txt . -t cs2
```