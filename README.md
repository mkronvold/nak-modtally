# nak-modtally

Parses an ArmA3 Launcher Mod Presets html file and tallys the sizes of all of the installed mods.

Can read:
- presets saved from the Launcher as a file
- URL to a preset saved from the Launcher
- URL to a discord link of a saved html preset
- URL to a steam collection of mods

Can export community collections to preset.html files for the launcher.

## Usage:

./modtally.sh { Input.html || https://full.url.to/file.html || https://steamcommunity.com/sharedfiles/filedetails/?id=COLLECTIONID } { Output.html }

Examples:
```
./modtally.sh Nak_Core_Event_23.html
```
```
./modtally.sh https://cdn.discordapp.com/attachments/841664698306134046/1086804997074853919/Nak_Core_Event_22.html
```
```
./modtally.sh https://cdn.discordapp.com/attachments/841664698306134046/1086805064355692674/Nak_OptionalCore_22.html
```
```
./modtally.sh https://steamcommunity.com/sharedfiles/filedetails/?id=2966740096
```
```
./modtally.sh https://steamcommunity.com/sharedfiles/filedetails/?id=2966751999
```
```
./modtally.sh https://steamcommunity.com/sharedfiles/filedetails/?id=2966740096 Nak_Event_23_Core.html
```

## Configure:

Install xidel if it's not already installed:
 https://github.com/benibela/xidel

For WSL2/Ubuntu:
```
curl -s https://versaweb.dl.sourceforge.net/project/videlibri/Xidel/Xidel%200.9.8/xidel-0.9.8.linux64.tar.gz | tar xfpz - xidel
install -v xidel /usr/bin
```

modfolder: point this to the steam workshop folder your mods are in.
For example under WSL2/Ubuntu your path might be:
 - modfolder=/mnt/c/Games/Steam/steamapps/workshop/content/107410/
```
find /mnt/c -type d -name 107410 -print 2> /dev/null
```
