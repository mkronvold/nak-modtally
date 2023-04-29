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
echo modfolder=$(find /mnt/c -ipath *Steam/steamapps/workshop/content/107410 -print -quit 2> /dev/null)
```

## Importing Presets
On the releases page there are presets that you can download and import into the launcher.

There are many ways to import but the launcher is very bad about giving useful error messages when it can't continue.

I have found only one reliable way to import the preset list that works every time.

- On the launcher `MODS` tab in the upper right click `Unload all`.
- Then click on the `PRESET` dropdown and scroll all the way to the bottom and click on the `Import` button there.
- Navigate to the place you downloaded the preset html file to (probably your downloads folder) and double click it.
- If prompted to overwrite the "Imported Preset" select `Overwrite`.
- It may ask to download additional mods that you're missing at this point.
