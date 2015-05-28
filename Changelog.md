## Changelog ##

**v0.3.0**

 - Added Bounce Sprites info:
  - Table containing the current bounce sprites, with their id, type (number) and position;
  - Indication on the game, as normal sprites;
  - Turn blocks have a spinning timer indicated;
  - Disabled by default, you can enable it by changing the script in the Options section. NOTE: bounce and extended sprites info are not programmed to be shown simultaneously, due to Snes9x limited screen (or maybe I'm dumb) , so make sure to use one at time.
 - Added Extended Sprites info:
  - [the same as bounce sprite info]

**v0.2.0**
 
- Added Item Box cheat:
  - You can change the item by pressing up/down+L (hold to change quickly);
  - Made all 255 sprites available, so some of them may glitch the game or even crash;
  - Enabled by default, you can disable it by changing the script in the Options section;
- Added item box value above it;
- Added sprite number contained in the item box below it;
- Made Powerup cheat optional, you can disable it by changing the script in the Options section;
- Minor change on Yoshi display, to minimize screen pollution.

**V0.1.0 (Initial release)**

- Changed overall aspect of the original display:
  - Labeled main info, to make it easier for the user to see what is what;
  - Changed main info position;   
  - Setted Yoshi's info colour fixed to green; 
  - Changed sprite ID symbol from #ID to <ID>;
  - Minor other changes;
- Added Blocked Status;
- Added RNG value;
- Added sprite type in the sprite table next to the ID; 
- Improved PowerUp cheat:
  - Now you can explore all the PIs (0-255) using up/down+select (hold for increment/decrement quickly);
- Added a vector + grid that indicates Mario's speed (beta):
   - You can use in 3 different sizes (big may pollute the screen);
   - Hover the mouse over the buttons to change size or turn off;
   - Disabled by default, you can enable it by changing the script in the Options section.
