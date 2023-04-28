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
./modtally.sh https://steamcommunity.com/sharedfiles/filedetails/?id=2966740096 Nak_Event_23_Core.html
```
