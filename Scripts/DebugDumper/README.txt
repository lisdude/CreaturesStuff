Debug Dumper v1.0
-----------------------
Periodically dump the output of the debug log into a file. See the comments at the top of the
.cos file for variables that can be changed.

Why?

This is a useful alternative to having a debug output window open all the time, particularly
when it comes to long-running tasks. It can also be useful if you use the v2 Bootstrap files,
as they contain a lot of debug messages that fill up the log and never go anywhere useful.
(The debug log is a buffer that fills and fills until emptied with `dbg: poll`, so it can be
 nice to clear it if you have a lot of messages being generated and never viewed.)

================================================================================================

Installation:
1. Copy 'Debug Dumper.cos' into your '\Docking Station\Bootstrap\010 Docking Station' folder.

Existing Worlds or Updating:
2. Press 'CTRL-SHIFT-C' to open the CAOS command line and type: ject "Debug Dumper.cos" 7
3. Press 'CTRL-SHIFT'C' again to close the command line.

================================================================================================

Sharing, Distribution, Archiving, Etc:
Feel free to share and archive to your heart's content! All I ask is that you leave this README intact so people know where to find the latest source code.

================================================================================================

Author:         lisdude@lisdude.com
Last Modified:  2024-03-22
Source Code:    https://github.com/lisdude/CreaturesStuff
