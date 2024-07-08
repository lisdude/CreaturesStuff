Agent Search v0.1
------------------------
Adds a search bar to the Docking Station agent injector.

By default, searches will find any part of your query in an agent's name.
For example, "ps" would match to "Autopsy Report" and "PST-001 Trapdoor Bouncer"

You can add modifiers to your search term to help narrow down your search. In the above
example, you could use the 'exact' modifier to find all agents beginning with PST by
using the search: "exact:pst"

The available modifiers are:
c3:     Search Creatures 3 agents.
desc:   Search agent descriptions rather than names.
exact:  Only return results that match from the beginning of the name.

You can also combine modifiers. For example, to find all Creatures 3 addons that have
the word "monitor" in the description, you would type something like: "c3:desc:monitor"

================================================================================================

Installation:
1. Copy 'Agent Search.cos' into your '\Docking Station\Bootstrap\010 Docking Station' folder.
2. Copy 'injector_search.c16' into your '\Docking Station\Images' folder.

Existing Worlds or Updating:
2. Press 'CTRL-SHIFT-C' to open the CAOS command line and type: ject "Agent Search.cos" 7
3. Press 'CTRL-SHIFT'C' again to close the command line.

================================================================================================

Sharing, Distribution, Archiving, Etc:
Feel free to share and archive to your heart's content! All I ask is that you leave this README intact so people know where to find the latest source code.

================================================================================================

Author:         lisdude@lisdude.com
Last Modified:  2024-07-08
Source Code:    https://github.com/lisdude/CreaturesStuff
