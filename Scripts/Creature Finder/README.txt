Creature Finder v1.2
--------------------
Allows you to type simple commands to the hand to find specific creatures by name:

  goto <name>       Move the camera to the creature named <name>.
  hold <name>       Move the camera to the creature named <name> and hold its hand.
  summon <name>     Pick up the creature named <name>, teleporting it to you.
  get <name>        Move the camera to the creature named <name> and pick it up.

If <name> ends with an asterisk (*), it will return the first creature with a name that starts with <name>.
e.g. "summon ron*" could match to a creature named Ronald.

================================================================================================

Installation:
1. Copy 'Creature Finder.cos' into your '\Docking Station\Bootstrap\010 Docking Station' folder.

Existing Worlds or Updating:
2. Press 'CTRL-SHIFT-C' to open the CAOS command line and type: ject "Creature Finder.cos" 7
3. Press 'CTRL-SHIFT'C' again to close the command line.

================================================================================================

Sharing, Distribution, Archiving, Etc:
Please, feel free to share and archive to your heart's content! All I ask is that you leave this README intact so people know where to find the latest source code.

================================================================================================

Changelog:
v1.2            Add partial matching to creature names.
v1.1            Try to make 'get' less jarring. Also various internal updates to the code.
v1.0            Initial release.

================================================================================================

Author:         lisdude@lisdude.com
Last Modified:  2021-05-09
Source Code:    https://github.com/lisdude/CreaturesStuff
