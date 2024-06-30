Egg Prioritizer v1.0
------------------------
* Usurp the normal egg timing mechanism and replace it with a weighted chance of hatching.
* The criteria for scoring eggs is:
*   - How populated the metaroom is vs its ideal population. (Highest weight.)
*   - How many eggs are in the metaroom vs total eggs in the game. (Medium weight.)
*   - The age of the egg. (Lowest weight.)
*
* The highest scoring egg is hatched.
*
* You can customize this in various ways. For example, if you want to disable a scoring
* criteria, you can simply set its weight to 0.0. (See below.)
*
* You can also change ov00 to the maximum number of creatures in a metaroom. By default,
* this isn't a hard cap; metarooms can exceed this number. However, it heavily encourages
* eggs in other metarooms to hatch if the population of another exceeds this number. If
* you DO want it to be a hard cap, you can set ov04 to 1.
*
* If you want to change these values without re-injecting, you can do so with these commands:
* rtar 1 1 41609 setv ov00 15.0     => Set the upper limit of creatures in a metaroom.
* rtar 1 1 41609 setv ov01 0.4      => Set the weight of the metaroom population to 0.4.
* rtar 1 1 41609 setv ov02 0.0      => Set the weight of the metaroom egg density to 0.0.
* rtar 1 1 41609 setv ov03 0.2      => Set the weight of the egg age to 0.2.
* rtar 1 1 41609 setv ov04 1        => Enable hard cap.
* rtar 1 1 41609 setv ov05 1        => Enable debug messages.
================================================================================================

Installation:
1. Copy 'Egg Prioritizer.cos' into your '\Docking Station\Bootstrap\010 Docking Station' folder.

Existing Worlds or Updating:
2. Press 'CTRL-SHIFT-C' to open the CAOS command line and type: ject "Egg Prioritizer.cos" 7
3. Press 'CTRL-SHIFT'C' again to close the command line.

================================================================================================

Sharing, Distribution, Archiving, Etc:
Feel free to share and archive to your heart's content! All I ask is that you leave this README intact so people know where to find the latest source code.

================================================================================================

Author:         lisdude@lisdude.com
Last Modified:  2024-06-30
Source Code:    https://github.com/lisdude/CreaturesStuff
