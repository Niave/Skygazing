with Ada.Calendar;use Ada.Calendar;
with MicroBit.DisplayRT;
package planets is

   function GetDay return Day_Number;
   function GetSeconds return Day_Duration;

   task type Sun with Priority => 8;
   SUNTask : Sun;

   task type mecury with Priority => 7;
   mercs : mecury;
   task type venus with Priority => 6;
   ven : venus;
   task type mars with Priority => 5;
   mar : mars;
   task type jupiter with Priority => 4;
   jup : jupiter;
   task type saturn with Priority => 3;
   sat : saturn;
   task type uranus with Priority => 2;
   ura : uranus;
   task type neptune with Priority => 1;
   nep : neptune;

   procedure ConvertMapCoordToLedCoord (mapX : in Long_Long_Float; mapY : in Long_Long_Float; ledX : out MicroBit.DisplayRT.Coord; ledY : out MicroBit.DisplayRT.Coord );





end planets;
