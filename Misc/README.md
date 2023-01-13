## Other Stuff
- `RebuildCreatures2Registry.cmd` deletes existing Creatures 2 registry entries and adds a minimum set to run the game. This has mildly handy configuration variables for the Blueberry4$ cheat by default and setting MaxNorns. You probably won't ever need to use this file unless you're experimenting with, and horribly breaking, Creatures 2.
- `RebuildCreatures1Registry.cmd` is the Creatures 1 version of the above. Deletes existing keys, adds new ones, has an option for the 'doctor' cheat.
- `FixRegistryWINE.cmd` is the same thing as the regular registry fix except it hardcodes the path and removes some incompatible flags. Mainly intended for the macOS guide.
- `machine.cfg` is a pre-configured machine.cfg for a dual install of Creatures 3 and Docking Station in WINE. Mainly intended for the macOS guide.
- `minicaos` is the official CAOS command line script modified to have a history.
- `CrEd32Fix.reg` is a registry entry that will point [Creatures Editor](https://creatures.wiki/Creatures_Editor) to the correct path. (**NOTE**: This is the correct path for Windows XP. Windows 10 and above will need to modify it to point to where Creatures 1 is actually installed.)
