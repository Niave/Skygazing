with Ada.Text_Io; use Ada.Text_Io;
with ada.Numerics; use ada.Numerics;
with Ada.Numerics.Elementary_Functions;
use Ada.Numerics.Elementary_Functions;
with Ada.Calendar;use Ada.Calendar;
with Ada.Real_Time; use ada.Real_Time;
with MicroBit.DisplayRT;
with MicroBit.DisplayRT.Symbols;
with MicroBit.Accelerometer;

package body planets is
   function GetDay return Day_Number is
      Now : Ada.Calendar.Time := Ada.Calendar.Clock;
      Now_Year    : Year_Number;
      Now_Month   : Month_Number;
      Now_Day     : Day_Number;
      Now_Seconds : Day_Duration;
   begin
      Split(Now, Now_Year,Now_Month, Now_Day, Now_Seconds);
      Now_Year := Now_Year;
      Now_Month:= Now_Month;
      --day number
      Now_Day:= Now_Day + 22;
      Now_Seconds:= Now_Seconds;

      return Now_Day;
   end GetDay;

   function GetSeconds return Day_Duration is
      Now : Ada.Calendar.Time := Ada.Calendar.Clock;
      Now_Year    : Year_Number;
      Now_Month   : Month_Number;
      Now_Day     : Day_Number;
      Now_Seconds : Day_Duration;
   begin
      Split(Now, Now_Year,Now_Month, Now_Day, Now_Seconds);
      Now_Year := Now_Year;
      Now_Month:= Now_Month;
      Now_Day:= Now_Day;
      --Covert hours min seconds to seconds 42180.0 = 11:43
      Now_Seconds:= Now_Seconds + 42180.0;

      return Now_Seconds;
   end GetSeconds;

   procedure ConvertMapCoordToLedCoord (mapX : in Long_Long_Float; mapY : in Long_Long_Float; ledX : out MicroBit.DisplayRT.Coord; ledY : out MicroBit.DisplayRT.Coord ) is
   begin
      if (mapX < -0.15) then
         ledX := 0;
      elsif (mapX < -0.05) then
         ledX := 1;
      elsif (mapX < 0.05) then
         ledX := 2;
      elsif (mapX < 0.15) then
         ledX := 3;
       else
         ledX := 4;
      end if;

      if (mapY < -0.66) then
         ledY := 0;
      elsif (mapY < -0.33) then
         ledY := 1;
      elsif (mapY < 0.33) then
         ledY := 2;
      elsif (mapY < 0.66) then
         ledY := 3;
       else
         ledY := 4;
      end if;

   end ConvertMapCoordToLedCoord;



   task body mecury  is 
      --Lat and long for drammen 
      lat:Long_Long_Float:=59.7441;
      lon:Long_Long_Float:=10.2045;




      type Index is range 1 .. 25;

      type My_float_Array is array (Index) of Long_Long_Float;
   --                                    ^ Type of elements
   --                          ^ Bounds of the array
      ra : My_float_Array := (((13.0 + 24.0 / 60.0 + 47.0 / 3600.0) * 15.0),
                              ((13.0 + 30.0 / 60.0 + 18.0 / 3600.0) * 15.0),
                              ((13.0 + 35.0 / 60.0 + 56.0 / 3600.0) * 15.0),
                              ((13.0 + 41.0 / 60.0 + 40.0 / 3600.0) * 15.0),
                              ((13.0 + 47.0 / 60.0 + 29.0 / 3600.0) * 15.0),
                              ((13.0 + 53.0 / 60.0 + 22.0 / 3600.0) * 15.0),
                              ((13.0 + 59.0 / 60.0 + 19.0 / 3600.0) * 15.0),
                              ((14.0 + 5.0 / 60.0 + 19.0 / 3600.0) * 15.0),
                              ((14.0 + 11.0 / 60.0 + 21.0 / 3600.0) * 15.0),
                              ((14.0 + 17.0 / 60.0 + 26.0 / 3600.0) * 15.0),
                              ((14.0 + 23.0 / 60.0 + 33.0 / 3600.0) * 15.0),
                              ((14.0 + 29.0 / 60.0 + 43.0 / 3600.0) * 15.0),
                              ((14.0 + 35.0 / 60.0 + 53.0 / 3600.0) * 15.0),
                              ((14.0 + 42.0 / 60.0 + 6.0 / 3600.0) * 15.0),
                              ((14.0 + 48.0 / 60.0 + 20.0 / 3600.0) * 15.0),
                              ((14.0 + 54.0 / 60.0 + 36.0 / 3600.0) * 15.0),
                              ((15.0 + 00.0 / 60.0 + 53.0 / 3600.0) * 15.0),
                              ((15.0 + 07.0 / 60.0 + 12.0 / 3600.0) * 15.0),
                              ((15.0 + 13.0 / 60.0 + 32.0 / 3600.0) * 15.0),
                              ((15.0 + 19.0 / 60.0 + 53.0 / 3600.0) * 15.0),
                              ((15.0 + 26.0 / 60.0 + 16.0 / 3600.0) * 15.0),
                              ((15.0 + 32.0 / 60.0 + 41.0 / 3600.0) * 15.0),
                              ((15.0 + 39.0 / 60.0 + 7.0 / 3600.0) * 15.0),
                              ((15.0 + 45.0 / 60.0 + 35.0 / 3600.0) * 15.0),
                              ((15.0 + 52.0 / 60.0 + 4.0 / 3600.0) * 15.0));

      dec : My_float_Array:=  ((-14.0 + 19.0/60.0 + 39.0/3600.0),
                               (-14.0 + 38.0/60.0 + 50.0/3600.0),
                               (-14.0 + 57.0/60.0 + 46.0/3600.0),
                               (-15.0 + 16.0/60.0 + 28.0/3600.0),
                               (-15.0 + 34.0/60.0 + 55.0/3600.0),
                               (-15.0 + 53.0/60.0 + 07.0/3600.0),
                               (-16.0 + 11.0/60.0 + 02.0/3600.0),
                               (-16.0 + 28.0/60.0 + 42.0/3600.0),
                               (-16.0 + 46.0/60.0 + 04.0/3600.0),
                               (-17.0 + 03.0/60.0 + 10.0/3600.0),
                               (-17.0 + 19.0/60.0 + 58.0/3600.0),
                               (-17.0 + 36.0/60.0 + 28.0/3600.0),
                               (-17.0 + 52.0/60.0 + 39.0/3600.0),
                               (-18.0 + 08.0/60.0 + 32.0/3600.0),
                               (-18.0 + 24.0/60.0 + 06.0/3600.0),
                               (-18.0 + 39.0/60.0 + 21.0/3600.0),
                               (-18.0 + 54.0/60.0 + 15.0/3600.0),
                               (-19.0 + 08.0/60.0 + 49.0/3600.0),
                               (-19.0 + 23.0/60.0 + 03.0/3600.0),
                               (-19.0 + 36.0/60.0 + 56.0/3600.0),
                               (-19.0 + 50.0/60.0 + 27.0/3600.0),
                               (-20.0 + 03.0/60.0 + 37.0/3600.0),
                               (-20.0 + 16.0/60.0 + 25.0/3600.0),
                               (-20.0 + 28.0/60.0 + 51.0/3600.0),
                               (-20.0 + 40.0/60.0 + 54.0/3600.0));


      type TodayRaDec is record
         TOra : Long_Long_Float;
         TOdec : Long_Long_Float;
      end record;

      Todayde : TodayRaDec:= (ra(Index(GetDay)), dec(Index(GetDay)));

      -- getseconds

      --convert seconds to day decimal
      timeDuration : Long_Long_Float:= Long_Long_Float(GetSeconds/ 86400.0);
      --convert seconds to hours
      temptime : Long_Long_Float:= Long_Long_Float((GetSeconds/3600.0)) * 15.0;


      -- split time in hour min seconds and convert to d;
      -- date = clock. day + 44500;
      --time is = hour/24 + min/1440 + s/86400;
      juliandate:long_long_float:= Long_Long_Float(GetDay) + 2415018.5 + timeDuration -(1.0/24.0);
      -- juliancentury:long_long_float:=(juliandate - 2451545.0)/36535.0;

      d: Long_Long_Float:= juliandate - 2451545.0;
      --localsidertime fmod(100.46 + First + lon + Second, 360.0)
      modYlst:Long_Long_Float:=360.0;
      eqLST: Long_Long_Float:= 100.46 + (0.985647 * d) + lon + (15.0 * temptime);
      tempEqLST:Long_Long_Float:=eqLST/modYlst;
      flooredeqLST:Long_Long_Float:= Long_Long_Float'Floor(tempEqLST);
      localsideraltime:Long_Long_Float:= eqLST - (flooredeqLST * modYlst);

      --degreeRa  fmod(RA * 15.0 , 360.0);
      modYRA:Long_Long_Float:= 360.0;
      eqRA:Long_Long_Float:=Todayde.TOra * 15.0;
      tempRA:Long_Long_Float:=eqRA/modYRA;
      flooredeqRA:Long_Long_Float:=Long_Long_Float'Floor(tempRA);
      degreeRA:Long_Long_Float:=eqRA - (flooredeqRA * modYRA);

      HA:Long_Long_Float:= localsideraltime -degreeRA;

      SinAlt:Long_Long_Float:= Long_Long_Float(sin(Float(Todayde.TOdec) *(Pi/180.0)) * sin(Float(lat) * (Pi/180.0)) + cos(Float(Todayde.TOdec) *(Pi/180.0)) * cos(Float(lat) *(Pi/180.0)) * (cos(Float(HA) * (pi/180.0))));
      alt:Long_Long_Float:=Long_Long_Float((180.0/Pi)*(Arcsin(Float(SinAlt))));

      CosA:Long_Long_Float:= Long_Long_Float((sin(Float(Todayde.TOdec) * (pi/180.0)) - (sin(Float(alt) * (pi/180.0)) * sin(Float(LAT) * (pi/180.0)))) / cos(Float(alt) * (pi/180.0)) * cos(Float(LAT) * (pi/180.0)));
      A:Long_Long_Float:= Long_Long_Float((180.0/Pi)*(Arccos(Float(CosA))));

      
      AZ:Long_Long_Float:=0.0;

      --conversion to cartiesian coordinates
      r:Long_Long_Float:=1.0;
      x:Long_Long_Float:=0.0;
      y:Long_Long_Float:=0.0;
      z:Long_Long_Float:=0.0;
      Time_Now : Ada.Real_Time.Time;


      ledX: MicroBit.DisplayRT.Coord :=2;
      ledY: MicroBit.DisplayRT.Coord :=2;

      Start_Time, Stop_Time : ADA.Real_Time.Time;
      Elapsed_Time          : Ada.Real_Time.Time_Span;


   BEGIN -- SimpleTask
      loop
         Start_Time := Clock;

         Time_Now := Ada.Real_Time.Clock;
         if HA < 0.0 then
            Az := A;
         else
            AZ := 360.0 - A;
         end if;
         x:= r * Long_Long_Float(cos(Float(alt) * (pi/180.0)) * cos(Float(AZ) * (Pi/180.0)));
         y:= r * Long_Long_Float(cos(Float(alt) * (pi/180.0)) * sin(Float(AZ) * (Pi/180.0)));
         z:= r * Long_Long_Float(sin(Float(AZ) * (Pi/180.0)));


         ConvertMapCoordToLedCoord(x,y,ledX, ledY);

         MicroBit.DisplayRT.Set(ledX,ledY,7);

         Put_Line (" merx  is: " & Long_Long_Float'Image(x));
         Put_Line (" mercy  is: " & Long_Long_Float'Image(y));
         Put_Line (" mercz  is: " & Long_Long_Float'Image(z));
         Put_Line (" mercaz  is: " & Long_Long_Float'Image(AZ));
         New_Line;
         Stop_Time    := Clock;
         Elapsed_Time := Stop_Time - Start_Time;
         Put_Line ("Elapsed time merc: "
                   & Duration'Image (To_Duration (Elapsed_Time))
                   & " seconds");
         delay until Time_Now + Ada.Real_Time.Seconds(10);
      end loop;

   END mecury;





   task body venus  is

      lat:Long_Long_Float:=59.7441;
      lon:Long_Long_Float:=10.2045;

      Start_Time, Stop_Time : ADA.Real_Time.Time;
      Elapsed_Time          : Ada.Real_Time.Time_Span;




      type Index is range 1 .. 25;

      type My_float_Array is array (Index) of Long_Long_Float;
   --                                    ^ Type of elements
   --                          ^ Bounds of the array
      ra : My_float_Array := (((17.0 + 39.0/60.0 + 20.0/3600.0) * 15.0),
                              ((17.0 + 43.0/60.0 + 44.0/3600.0) * 15.0),
                              ((17.0 + 48.0/60.0 + 05.0/3600.0) * 15.0),
                              ((17.0 + 52.0/60.0 + 25.0/3600.0) * 15.0),
                              ((17.0 + 56.0/60.0 + 44.0/3600.0) * 15.0),
                              ((18.0 + 01.0/60.0 + 00.0/3600.0) * 15.0),
                              ((18.0 + 05.0/60.0 + 14.0/3600.0) * 15.0),
                              ((18.0 + 09.0/60.0 + 25.0/3600.0) * 15.0),
                              ((18.0 + 13.0/60.0 + 34.0/3600.0) * 15.0),
                              ((18.0 + 17.0/60.0 + 41.0/3600.0) * 15.0),
                              ((18.0 + 21.0/60.0 + 45.0/3600.0) * 15.0),
                              ((18.0 + 25.0/60.0 + 46.0/3600.0) * 15.0),
                              ((18.0 + 29.0/60.0 + 43.0/3600.0) * 15.0),
                              ((18.0 + 33.0/60.0 + 38.0/3600.0) * 15.0),
                              ((18.0 + 37.0/60.0 + 29.0/3600.0) * 15.0),
                              ((18.0 + 41.0/60.0 + 17.0/3600.0) * 15.0),
                              ((18.0 + 45.0/60.0 + 01.0/3600.0) * 15.0),
                              ((18.0 + 48.0/60.0 + 41.0/3600.0) * 15.0),
                              ((18.0 + 52.0/60.0 + 17.0/3600.0) * 15.0),
                              ((18.0 + 55.0/60.0 + 49.0/3600.0) * 15.0),
                              ((18.0 + 59.0/60.0 + 17.0/3600.0) * 15.0),
                              ((19.0 + 02.0/60.0 + 40.0/3600.0) * 15.0),
                              ((19.0 + 05.0/60.0 + 58.0/3600.0) * 15.0),
                              ((19.0 + 09.0/60.0 + 12.0/3600.0) * 15.0),
                              ((19.0 + 12.0/60.0 + 20.0/3600.0) * 15.0));


      dec : My_float_Array:=  ((-27.0 + 04.0/60.0 + 23.0/3600.0),
                               (-27.0 + 07.0/60.0 + 34.0/3600.0),
                               (-27.0 + 10.0/60.0 + 10.0/3600.0),
                               (-27.0 + 12.0/60.0 + 09.0/3600.0),
                               (-27.0 + 13.0/60.0 + 33.0/3600.0),
                               (-27.0 + 14.0/60.0 + 22.0/3600.0),
                               (-27.0 + 14.0/60.0 + 35.0/3600.0),
                               (-27.0 + 14.0/60.0 + 14.0/3600.0),
                               (-27.0 + 13.0/60.0 + 19.0/3600.0),
                               (-27.0 + 11.0/60.0 + 50.0/3600.0),
                               (-27.0 + 09.0/60.0 + 48.0/3600.0),
                               (-27.0 + 07.0/60.0 + 13.0/3600.0),
                               (-27.0 + 04.0/60.0 + 06.0/3600.0),
                               (-27.0 + 00.0/60.0 + 27.0/3600.0),
                               (-26.0 + 56.0/60.0 + 18.0/3600.0),
                               (-26.0 + 51.0/60.0 + 38.0/3600.0),
                               (-26.0 + 46.0/60.0 + 28.0/3600.0),
                               (-26.0 + 40.0/60.0 + 49.0/3600.0),
                               (-26.0 + 34.0/60.0 + 43.0/3600.0),
                               (-26.0 + 28.0/60.0 + 09.0/3600.0),
                               (-26.0 + 21.0/60.0 + 08.0/3600.0),
                               (-26.0 + 13.0/60.0 + 42.0/3600.0),
                               (-26.0 + 05.0/60.0 + 51.0/3600.0),
                               (-25.0 + 57.0/60.0 + 37.0/3600.0),
                               (-25.0 + 48.0/60.0 + 59.0/3600.0));



      type TodayRaDec is record
         TOra : Long_Long_Float;
         TOdec : Long_Long_Float;
      end record;

      Todayde : TodayRaDec:= (ra(Index(GetDay)), dec(Index(GetDay)));

      -- getseconds

      --convert seconds to day decimal
      timeDuration : Long_Long_Float:= Long_Long_Float(GetSeconds/ 86400.0);
      --convert seconds to hours
      temptime : Long_Long_Float:= Long_Long_Float((GetSeconds/3600.0)) * 15.0;


      -- split time in hour min seconds and convert to d;
      -- date = clock. day + 44500;
      --time is = hour/24 + min/1440 + s/86400;
      juliandate:long_long_float:= Long_Long_Float(GetDay) + 2415018.5 + timeDuration -(1.0/24.0);
      -- juliancentury:long_long_float:=(juliandate - 2451545.0)/36535.0;

      d: Long_Long_Float:= juliandate - 2451545.0;
      --localsidertime fmod(100.46 + First + lon + Second, 360.0)
      modYlst:Long_Long_Float:=360.0;
      eqLST: Long_Long_Float:= 100.46 + (0.985647 * d) + lon + (15.0 * temptime);
      tempEqLST:Long_Long_Float:=eqLST/modYlst;
      flooredeqLST:Long_Long_Float:= Long_Long_Float'Floor(tempEqLST);
      localsideraltime:Long_Long_Float:= eqLST - (flooredeqLST * modYlst);

      --degreeRa  fmod(RA * 15.0 , 360.0);
      modYRA:Long_Long_Float:= 360.0;
      eqRA:Long_Long_Float:=Todayde.TOra * 15.0;
      tempRA:Long_Long_Float:=eqRA/modYRA;
      flooredeqRA:Long_Long_Float:=Long_Long_Float'Floor(tempRA);
      degreeRA:Long_Long_Float:=eqRA - (flooredeqRA * modYRA);

      HA:Long_Long_Float:= localsideraltime -degreeRA;

      SinAlt:Long_Long_Float:= Long_Long_Float(sin(Float(Todayde.TOdec) *(Pi/180.0)) * sin(Float(lat) * (Pi/180.0)) + cos(Float(Todayde.TOdec) *(Pi/180.0)) * cos(Float(lat) *(Pi/180.0)) * (cos(Float(HA) * (pi/180.0))));
      alt:Long_Long_Float:=Long_Long_Float((180.0/Pi)*(Arcsin(Float(SinAlt))));

      CosA:Long_Long_Float:= Long_Long_Float((sin(Float(Todayde.TOdec) * (pi/180.0)) - (sin(Float(alt) * (pi/180.0)) * sin(Float(LAT) * (pi/180.0)))) / cos(Float(alt) * (pi/180.0)) * cos(Float(LAT) * (pi/180.0)));
      A:Long_Long_Float:= Long_Long_Float((180.0/Pi)*(Arccos(Float(CosA))));

      AZ:Long_Long_Float:=0.0;

      --conversion to cartiesian coordinates
      r:Long_Long_Float:=1.0;
      x:Long_Long_Float:=0.0;
      y:Long_Long_Float:=0.0;
      z:Long_Long_Float:=0.0;
      Time_Now : Ada.Real_Time.Time;


      ledX: MicroBit.DisplayRT.Coord :=2;
      ledY: MicroBit.DisplayRT.Coord :=2;


   BEGIN -- SimpleTask
      loop
         Start_Time := Clock;
         Time_Now := Ada.Real_Time.Clock;
         if HA < 0.0 then
            Az := A;
         else
            AZ := 360.0 - A;
         end if;
         x:= r * Long_Long_Float(cos(Float(alt) * (pi/180.0)) * cos(Float(AZ) * (Pi/180.0)));
         y:= r * Long_Long_Float(cos(Float(alt) * (pi/180.0)) * sin(Float(AZ) * (Pi/180.0)));
         z:= r * Long_Long_Float(sin(Float(AZ) * (Pi/180.0)));


         ConvertMapCoordToLedCoord(x,y,ledX, ledY);

         MicroBit.DisplayRT.Set(ledX,ledY,7);

         Put_Line (" venx  is: " & Long_Long_Float'Image(x));
         Put_Line (" veny  is: " & Long_Long_Float'Image(y));
         Put_Line (" venz  is: " & Long_Long_Float'Image(z));
         Put_Line (" venaz  is: " & Long_Long_Float'Image(AZ));
         New_Line;
         Stop_Time    := Clock;
         Elapsed_Time := Stop_Time - Start_Time;
         Put_Line ("Elapsed time venus: "
                   & Duration'Image (To_Duration (Elapsed_Time))
                   & " seconds");
         delay until Time_Now + Ada.Real_Time.Seconds(10);
      end loop;

   END venus;

task body mars  is

      lat:Long_Long_Float:=59.7441;
      lon:Long_Long_Float:=10.2045;

      Start_Time, Stop_Time : ADA.Real_Time.Time;
      Elapsed_Time          : Ada.Real_Time.Time_Span;




      type Index is range 1 .. 25;

      type My_float_Array is array (Index) of Long_Long_Float;
   --                                    ^ Type of elements
   --                          ^ Bounds of the array
      ra : My_float_Array :=(((13.0 + 54.0/60.0 + 45.0/3600.0) * 15.0),
                             ((13.0 + 57.0/60.0 + 18.0/3600.0) * 15.0),
                             ((13.0 + 59.0/60.0 + 52.0/3600.0) * 15.0),
                             ((14.0 + 02.0/60.0 + 26.0/3600.0) * 15.0),
                             ((14.0 + 05.0/60.0 + 01.0/3600.0) * 15.0),
                             ((14.0 + 07.0/60.0 + 37.0/3600.0) * 15.0),
                             ((14.0 + 10.0/60.0 + 12.0/3600.0) * 15.0),
                             ((14.0 + 12.0/60.0 + 48.0/3600.0) * 15.0),
                             ((14.0 + 15.0/60.0 + 25.0/3600.0) * 15.0),
                             ((14.0 + 18.0/60.0 + 02.0/3600.0) * 15.0),
                             ((14.0 + 20.0/60.0 + 39.0/3600.0) * 15.0),
                             ((14.0 + 23.0/60.0 + 17.0/3600.0) * 15.0),
                             ((14.0 + 25.0/60.0 + 55.0/3600.0) * 15.0),
                             ((14.0 + 28.0/60.0 + 34.0/3600.0) * 15.0),
                             ((14.0 + 31.0/60.0 + 13.0/3600.0) * 15.0),
                             ((14.0 + 33.0/60.0 + 53.0/3600.0) * 15.0),
                             ((14.0 + 36.0/60.0 + 33.0/3600.0) * 15.0),
                             ((14.0 + 39.0/60.0 + 13.0/3600.0) * 15.0),
                             ((14.0 + 41.0/60.0 + 55.0/3600.0) * 15.0),
                             ((14.0 + 44.0/60.0 + 36.0/3600.0) * 15.0),
                             ((14.0 + 47.0/60.0 + 18.0/3600.0) * 15.0),
                             ((14.0 + 50.0/60.0 + 01.0/3600.0) * 15.0),
                             ((14.0 + 52.0/60.0 + 44.0/3600.0) * 15.0),
                             ((14.0 + 55.0/60.0 + 27.0/3600.0) * 15.0),
                             ((14.0 + 58.0/60.0 + 11.0/3600.0) * 15.0));


      dec : My_float_Array:=  ((-11.0 + 15.0/60.0 + 47.0/3600.0),
                               (-11.0 + 30.0/60.0 + 18.0/3600.0),
                               (-11.0 + 44.0/60.0 + 44.0/3600.0),
                               (-11.0 + 59.0/60.0 + 05.0/3600.0),
                               (-12.0 + 13.0/60.0 + 22.0/3600.0),
                               (-12.0 + 27.0/60.0 + 35.0/3600.0),
                               (-12.0 + 41.0/60.0 + 42.0/3600.0),
                               (-12.0 + 55.0/60.0 + 45.0/3600.0),
                               (-13.0 + 09.0/60.0 + 42.0/3600.0),
                               (-13.0 + 23.0/60.0 + 34.0/3600.0),
                               (-13.0 + 37.0/60.0 + 20.0/3600.0),
                               (-13.0 + 51.0/60.0 + 01.0/3600.0),
                               (-14.0 + 04.0/60.0 + 36.0/3600.0),
                               (-14.0 + 18.0/60.0 + 06.0/3600.0),
                               (-14.0 + 31.0/60.0 + 29.0/3600.0),
                               (-14.0 + 44.0/60.0 + 47.0/3600.0),
                               (-14.0 + 57.0/60.0 + 58.0/3600.0),
                               (-15.0 + 11.0/60.0 + 03.0/3600.0),
                               (-15.0 + 24.0/60.0 + 01.0/3600.0),
                               (-15.0 + 36.0/60.0 + 53.0/3600.0),
                               (-15.0 + 49.0/60.0 + 38.0/3600.0),
                               (-16.0 + 02.0/60.0 + 16.0/3600.0),
                               (-16.0 + 14.0/60.0 + 48.0/3600.0),
                               (-16.0 + 27.0/60.0 + 12.0/3600.0),
                               (-16.0 + 39.0/60.0 + 29.0/3600.0));



      type TodayRaDec is record
         TOra : Long_Long_Float;
         TOdec : Long_Long_Float;
      end record;

      Todayde : TodayRaDec:= (ra(Index(GetDay)), dec(Index(GetDay)));

      -- getseconds

      --convert seconds to day decimal
      timeDuration : Long_Long_Float:= Long_Long_Float(GetSeconds/ 86400.0);
      --convert seconds to hours
      temptime : Long_Long_Float:= Long_Long_Float((GetSeconds/3600.0)) * 15.0;


      -- split time in hour min seconds and convert to d;
      -- date = clock. day + 44500;
      --time is = hour/24 + min/1440 + s/86400;
      juliandate:long_long_float:= Long_Long_Float(GetDay) + 2415018.5 + timeDuration -(1.0/24.0);
      -- juliancentury:long_long_float:=(juliandate - 2451545.0)/36535.0;

      d: Long_Long_Float:= juliandate - 2451545.0;
      --localsidertime fmod(100.46 + First + lon + Second, 360.0)
      modYlst:Long_Long_Float:=360.0;
      eqLST: Long_Long_Float:= 100.46 + (0.985647 * d) + lon + (15.0 * temptime);
      tempEqLST:Long_Long_Float:=eqLST/modYlst;
      flooredeqLST:Long_Long_Float:= Long_Long_Float'Floor(tempEqLST);
      localsideraltime:Long_Long_Float:= eqLST - (flooredeqLST * modYlst);

      --degreeRa  fmod(RA * 15.0 , 360.0);
      modYRA:Long_Long_Float:= 360.0;
      eqRA:Long_Long_Float:=Todayde.TOra * 15.0;
      tempRA:Long_Long_Float:=eqRA/modYRA;
      flooredeqRA:Long_Long_Float:=Long_Long_Float'Floor(tempRA);
      degreeRA:Long_Long_Float:=eqRA - (flooredeqRA * modYRA);

      HA:Long_Long_Float:= localsideraltime -degreeRA;

      SinAlt:Long_Long_Float:= Long_Long_Float(sin(Float(Todayde.TOdec) *(Pi/180.0)) * sin(Float(lat) * (Pi/180.0)) + cos(Float(Todayde.TOdec) *(Pi/180.0)) * cos(Float(lat) *(Pi/180.0)) * (cos(Float(HA) * (pi/180.0))));
      alt:Long_Long_Float:=Long_Long_Float((180.0/Pi)*(Arcsin(Float(SinAlt))));

      CosA:Long_Long_Float:= Long_Long_Float((sin(Float(Todayde.TOdec) * (pi/180.0)) - (sin(Float(alt) * (pi/180.0)) * sin(Float(LAT) * (pi/180.0)))) / cos(Float(alt) * (pi/180.0)) * cos(Float(LAT) * (pi/180.0)));
      A:Long_Long_Float:= Long_Long_Float((180.0/Pi)*(Arccos(Float(CosA))));

      AZ:Long_Long_Float:=0.0;

      --conversion to cartiesian coordinates
      r:Long_Long_Float:=1.0;
      x:Long_Long_Float:=0.0;
      y:Long_Long_Float:=0.0;
      z:Long_Long_Float:=0.0;

      Time_Now : Ada.Real_Time.Time;


      ledX: MicroBit.DisplayRT.Coord :=2;
      ledY: MicroBit.DisplayRT.Coord :=2;


   BEGIN -- SimpleTask
      loop
         Start_Time := Clock;
         Time_Now := Ada.Real_Time.Clock;
         if HA < 0.0 then
            Az := A;
         else
            AZ := 360.0 - A;
         end if;
         x:= r * Long_Long_Float(cos(Float(alt) * (pi/180.0)) * cos(Float(AZ) * (Pi/180.0)));
         y:= r * Long_Long_Float(cos(Float(alt) * (pi/180.0)) * sin(Float(AZ) * (Pi/180.0)));
         z:= r * Long_Long_Float(sin(Float(AZ) * (Pi/180.0)));


         ConvertMapCoordToLedCoord(x,y,ledX, ledY);

         MicroBit.DisplayRT.Set(ledX,ledY,7);
         Put_Line (" marx  is: " & Long_Long_Float'Image(x));
         Put_Line (" mary  is: " & Long_Long_Float'Image(y));
         Put_Line (" marz  is: " & Long_Long_Float'Image(z));
         Put_Line (" maraz  is: " & Long_Long_Float'Image(AZ));
         New_Line;
         Stop_Time    := Clock;
         Elapsed_Time := Stop_Time - Start_Time;
         Put_Line ("Elapsed time mars: "
                   & Duration'Image (To_Duration (Elapsed_Time))
                   & " seconds");
         delay until Time_Now + Ada.Real_Time.Seconds(10);

      end loop;

   END mars;
   task body jupiter  is

      lat:Long_Long_Float:=59.7441;
      lon:Long_Long_Float:=10.2045;

      Start_Time, Stop_Time : ADA.Real_Time.Time;
      Elapsed_Time          : Ada.Real_Time.Time_Span;



      type Index is range 1 .. 25;

      type My_float_Array is array (Index) of Long_Long_Float;
   --                                    ^ Type of elements
   --                          ^ Bounds of the array
      ra : My_float_Array := (((21.0 + 40.0/60.0 + 18.0/3600.0) * 15.0),
                              ((21.0 + 40.0/60.0 + 29.0/3600.0) * 15.0),
                              ((21.0 + 40.0/60.0 + 41.0/3600.0) * 15.0),
                              ((21.0 + 40.0/60.0 + 53.0/3600.0) * 15.0),
                              ((21.0 + 41.0/60.0 + 06.0/3600.0) * 15.0),
                              ((21.0 + 41.0/60.0 + 20.0/3600.0) * 15.0),
                              ((21.0 + 41.0/60.0 + 35.0/3600.0) * 15.0),
                              ((21.0 + 41.0/60.0 + 50.0/3600.0) * 15.0),
                              ((21.0 + 42.0/60.0 + 07.0/3600.0) * 15.0),
                              ((21.0 + 42.0/60.0 + 23.0/3600.0) * 15.0),
                              ((21.0 + 42.0/60.0 + 41.0/3600.0) * 15.0),
                              ((21.0 + 42.0/60.0 + 59.0/3600.0) * 15.0),
                              ((21.0 + 43.0/60.0 + 18.0/3600.0) * 15.0),
                              ((21.0 + 43.0/60.0 + 38.0/3600.0) * 15.0),
                              ((21.0 + 43.0/60.0 + 58.0/3600.0) * 15.0),
                              ((21.0 + 44.0/60.0 + 20.0/3600.0) * 15.0),
                              ((21.0 + 44.0/60.0 + 41.0/3600.0) * 15.0),
                              ((21.0 + 45.0/60.0 + 04.0/3600.0) * 15.0),
                              ((21.0 + 45.0/60.0 + 27.0/3600.0) * 15.0),
                              ((21.0 + 45.0/60.0 + 51.0/3600.0) * 15.0),
                              ((21.0 + 46.0/60.0 + 15.0/3600.0) * 15.0),
                              ((21.0 + 46.0/60.0 + 40.0/3600.0) * 15.0),
                              ((21.0 + 47.0/60.0 + 06.0/3600.0) * 15.0),
                              ((21.0 + 47.0/60.0 + 32.0/3600.0) * 15.0),
                              ((21.0 + 47.0/60.0 + 59.0/3600.0) * 15.0));



      dec : My_float_Array:=((-15.0 + 07.0/60.0 + 00.0/3600.0),
                             (-15.0 + 05.0/60.0 + 56.0/3600.0),
                             (-15.0 + 04.0/60.0 + 49.0/3600.0),
                             (-15.0 + 03.0/60.0 + 38.0/3600.0),
                             (-15.0 + 02.0/60.0 + 23.0/3600.0),
                             (-15.0 + 01.0/60.0 + 04.0/3600.0),
                             (-14.0 + 59.0/60.0 + 41.0/3600.0),
                             (-14.0 + 58.0/60.0 + 15.0/3600.0),
                             (-14.0 + 56.0/60.0 + 45.0/3600.0),
                             (-14.0 + 55.0/60.0 + 11.0/3600.0),
                             (-14.0 + 53.0/60.0 + 33.0/3600.0),
                             (-14.0 + 51.0/60.0 + 52.0/3600.0),
                             (-14.0 + 50.0/60.0 + 07.0/3600.0),
                             (-14.0 + 48.0/60.0 + 19.0/3600.0),
                             (-14.0 + 46.0/60.0 + 27.0/3600.0),
                             (-14.0 + 44.0/60.0 + 31.0/3600.0),
                             (-14.0 + 42.0/60.0 + 32.0/3600.0),
                             (-14.0 + 40.0/60.0 + 30.0/3600.0),
                             (-14.0 + 38.0/60.0 + 24.0/3600.0),
                             (-14.0 + 36.0/60.0 + 14.0/3600.0),
                             (-14.0 + 34.0/60.0 + 01.0/3600.0),
                             (-14.0 + 31.0/60.0 + 45.0/3600.0),
                             (-14.0 + 29.0/60.0 + 25.0/3600.0),
                             (-14.0 + 27.0/60.0 + 02.0/3600.0),
                             (-14.0 + 24.0/60.0 + 35.0/3600.0));




      type TodayRaDec is record
         TOra : Long_Long_Float;
         TOdec : Long_Long_Float;
      end record;

      Todayde : TodayRaDec:= (ra(Index(GetDay)), dec(Index(GetDay)));

      -- getseconds

      --convert seconds to day decimal
      timeDuration : Long_Long_Float:= Long_Long_Float(GetSeconds/ 86400.0);
      --convert seconds to hours
      temptime : Long_Long_Float:= Long_Long_Float((GetSeconds/3600.0)) * 15.0;


      -- split time in hour min seconds and convert to d;
      -- date = clock. day + 44500;
      --time is = hour/24 + min/1440 + s/86400;
      juliandate:long_long_float:= Long_Long_Float(GetDay) + 2415018.5 + timeDuration -(1.0/24.0);
      -- juliancentury:long_long_float:=(juliandate - 2451545.0)/36535.0;

      d: Long_Long_Float:= juliandate - 2451545.0;
      --localsidertime fmod(100.46 + First + lon + Second, 360.0)
      modYlst:Long_Long_Float:=360.0;
      eqLST: Long_Long_Float:= 100.46 + (0.985647 * d) + lon + (15.0 * temptime);
      tempEqLST:Long_Long_Float:=eqLST/modYlst;
      flooredeqLST:Long_Long_Float:= Long_Long_Float'Floor(tempEqLST);
      localsideraltime:Long_Long_Float:= eqLST - (flooredeqLST * modYlst);

      --degreeRa  fmod(RA * 15.0 , 360.0);
      modYRA:Long_Long_Float:= 360.0;
      eqRA:Long_Long_Float:=Todayde.TOra * 15.0;
      tempRA:Long_Long_Float:=eqRA/modYRA;
      flooredeqRA:Long_Long_Float:=Long_Long_Float'Floor(tempRA);
      degreeRA:Long_Long_Float:=eqRA - (flooredeqRA * modYRA);

      HA:Long_Long_Float:= localsideraltime -degreeRA;

      SinAlt:Long_Long_Float:= Long_Long_Float(sin(Float(Todayde.TOdec) *(Pi/180.0)) * sin(Float(lat) * (Pi/180.0)) + cos(Float(Todayde.TOdec) *(Pi/180.0)) * cos(Float(lat) *(Pi/180.0)) * (cos(Float(HA) * (pi/180.0))));
      alt:Long_Long_Float:=Long_Long_Float((180.0/Pi)*(Arcsin(Float(SinAlt))));

      CosA:Long_Long_Float:= Long_Long_Float((sin(Float(Todayde.TOdec) * (pi/180.0)) - (sin(Float(alt) * (pi/180.0)) * sin(Float(LAT) * (pi/180.0)))) / cos(Float(alt) * (pi/180.0)) * cos(Float(LAT) * (pi/180.0)));
      A:Long_Long_Float:= Long_Long_Float((180.0/Pi)*(Arccos(Float(CosA))));

      AZ:Long_Long_Float:=0.0;

      --conversion to cartiesian coordinates
      r:Long_Long_Float:=1.0;
      x:Long_Long_Float:=0.0;
      y:Long_Long_Float:=0.0;
      z:Long_Long_Float:=0.0;
      Time_Now : Ada.Real_Time.Time;


      ledX: MicroBit.DisplayRT.Coord :=2;
      ledY: MicroBit.DisplayRT.Coord :=2;


   BEGIN -- SimpleTask
      loop
         Start_Time := Clock;
         Time_Now := Ada.Real_Time.Clock;
         if HA < 0.0 then
            Az := A;
         else
            AZ := 360.0 - A;
         end if;
         x:= r * Long_Long_Float(cos(Float(alt) * (pi/180.0)) * cos(Float(AZ) * (Pi/180.0)));
         y:= r * Long_Long_Float(cos(Float(alt) * (pi/180.0)) * sin(Float(AZ) * (Pi/180.0)));
         z:= r * Long_Long_Float(sin(Float(AZ) * (Pi/180.0)));


         ConvertMapCoordToLedCoord(x,y,ledX, ledY);

         MicroBit.DisplayRT.Set(ledX,ledY,7);

         Put_Line (" jupx  is: " & Long_Long_Float'Image(x));
         Put_Line (" jupy  is: " & Long_Long_Float'Image(y));
         Put_Line (" jupz  is: " & Long_Long_Float'Image(z));
         Put_Line (" jupaz  is: " & Long_Long_Float'Image(AZ));
         New_Line;
         Stop_Time    := Clock;
         Elapsed_Time := Stop_Time - Start_Time;

         Put_Line ("Elapsed time jupiter: "
                   & Duration'Image (To_Duration (Elapsed_Time))
                   & " seconds");
         delay until Time_Now + Ada.Real_Time.Seconds(10);
      end loop;


   END jupiter;

   task body saturn  is

      lat:Long_Long_Float:=59.7441;
      lon:Long_Long_Float:=10.2045;

      Start_Time, Stop_Time : ADA.Real_Time.Time;
      Elapsed_Time          : Ada.Real_Time.Time_Span;



      type Index is range 1 .. 25;

      type My_float_Array is array (Index) of Long_Long_Float;
   --                                    ^ Type of elements
   --                          ^ Bounds of the array
      ra : My_float_Array := (((20.0 + 38.0/60.0 + 13.0/3600.0)*15.0),
                              ((20.0 + 38.0/60.0 + 22.0/3600.0)*15.0),
                              ((20.0 + 38.0/60.0 + 31.0/3600.0)*15.0),
                              ((20.0 + 38.0/60.0 + 41.0/3600.0)*15.0),
                              ((20.0 + 38.0/60.0 + 51.0/3600.0)*15.0),
                              ((20.0 + 39.0/60.0 + 01.0/3600.0)*15.0),
                              ((20.0 + 39.0/60.0 + 12.0/3600.0)*15.0),
                              ((20.0 + 39.0/60.0 + 23.0/3600.0)*15.0),
                              ((20.0 + 39.0/60.0 + 34.0/3600.0)*15.0),
                              ((20.0 + 39.0/60.0 + 46.0/3600.0)*15.0),
                              ((20.0 + 39.0/60.0 + 58.0/3600.0)*15.0),
                              ((20.0 + 40.0/60.0 + 11.0/3600.0)*15.0),
                              ((20.0 + 40.0/60.0 + 24.0/3600.0)*15.0),
                              ((20.0 + 40.0/60.0 + 37.0/3600.0)*15.0),
                              ((20.0 + 40.0/60.0 + 51.0/3600.0)*15.0),
                              ((20.0 + 41.0/60.0 + 05.0/3600.0)*15.0),
                              ((20.0 + 41.0/60.0 + 19.0/3600.0)*15.0),
                              ((20.0 + 41.0/60.0 + 34.0/3600.0)*15.0),
                              ((20.0 + 41.0/60.0 + 49.0/3600.0)*15.0),
                              ((20.0 + 42.0/60.0 + 04.0/3600.0)*15.0),
                              ((20.0 + 42.0/60.0 + 20.0/3600.0)*15.0),
                              ((20.0 + 42.0/60.0 + 36.0/3600.0)*15.0),
                              ((20.0 + 42.0/60.0 + 53.0/3600.0)*15.0),
                              ((20.0 + 43.0/60.0 + 10.0/3600.0)*15.0),
                              ((20.0 + 43.0/60.0 + 27.0/3600.0)*15.0));




      dec : My_float_Array:=((-19.0 + 19.0/60.0 + 31.0/3600.0),
                             (-19.0 + 18.0/60.0 + 58.0/3600.0),
                             (-19.0 + 18.0/60.0 + 24.0/3600.0),
                             (-19.0 + 17.0/60.0 + 48.0/3600.0),
                             (-19.0 + 17.0/60.0 + 11.0/3600.0),
                             (-19.0 + 16.0/60.0 + 32.0/3600.0),
                             (-19.0 + 15.0/60.0 + 52.0/3600.0),
                             (-19.0 + 15.0/60.0 + 10.0/3600.0),
                             (-19.0 + 14.0/60.0 + 27.0/3600.0),
                             (-19.0 + 13.0/60.0 + 42.0/3600.0),
                             (-19.0 + 12.0/60.0 + 56.0/3600.0),
                             (-19.0 + 12.0/60.0 + 09.0/3600.0),
                             (-19.0 + 11.0/60.0 + 20.0/3600.0),
                             (-19.0 + 10.0/60.0 + 29.0/3600.0),
                             (-19.0 + 09.0/60.0 + 38.0/3600.0),
                             (-19.0 + 08.0/60.0 + 45.0/3600.0),
                             (-19.0 + 07.0/60.0 + 50.0/3600.0),
                             (-19.0 + 06.0/60.0 + 54.0/3600.0),
                             (-19.0 + 05.0/60.0 + 57.0/3600.0),
                             (-19.0 + 04.0/60.0 + 58.0/3600.0),
                             (-19.0 + 03.0/60.0 + 58.0/3600.0),
                             (-19.0 + 02.0/60.0 + 57.0/3600.0),
                             (-19.0 + 01.0/60.0 + 54.0/3600.0),
                             (-19.0 + 00.0/60.0 + 50.0/3600.0),
                             (-18.0 + 59.0/60.0 + 45.0/3600.0));




      type TodayRaDec is record
         TOra : Long_Long_Float;
         TOdec : Long_Long_Float;
      end record;

      Todayde : TodayRaDec:= (ra(Index(GetDay)), dec(Index(GetDay)));

      -- getseconds

      --convert seconds to day decimal
      timeDuration : Long_Long_Float:= Long_Long_Float(GetSeconds/ 86400.0);
      --convert seconds to hours
      temptime : Long_Long_Float:= Long_Long_Float((GetSeconds/3600.0)) * 15.0;


      -- split time in hour min seconds and convert to d;
      -- date = clock. day + 44500;
      --time is = hour/24 + min/1440 + s/86400;
      juliandate:long_long_float:= Long_Long_Float(GetDay) + 2415018.5 + timeDuration -(1.0/24.0);
      -- juliancentury:long_long_float:=(juliandate - 2451545.0)/36535.0;

      d: Long_Long_Float:= juliandate - 2451545.0;
      --localsidertime fmod(100.46 + First + lon + Second, 360.0)
      modYlst:Long_Long_Float:=360.0;
      eqLST: Long_Long_Float:= 100.46 + (0.985647 * d) + lon + (15.0 * temptime);
      tempEqLST:Long_Long_Float:=eqLST/modYlst;
      flooredeqLST:Long_Long_Float:= Long_Long_Float'Floor(tempEqLST);
      localsideraltime:Long_Long_Float:= eqLST - (flooredeqLST * modYlst);

      --degreeRa  fmod(RA * 15.0 , 360.0);
      modYRA:Long_Long_Float:= 360.0;
      eqRA:Long_Long_Float:=Todayde.TOra * 15.0;
      tempRA:Long_Long_Float:=eqRA/modYRA;
      flooredeqRA:Long_Long_Float:=Long_Long_Float'Floor(tempRA);
      degreeRA:Long_Long_Float:=eqRA - (flooredeqRA * modYRA);

      HA:Long_Long_Float:= localsideraltime -degreeRA;

      SinAlt:Long_Long_Float:= Long_Long_Float(sin(Float(Todayde.TOdec) *(Pi/180.0)) * sin(Float(lat) * (Pi/180.0)) + cos(Float(Todayde.TOdec) *(Pi/180.0)) * cos(Float(lat) *(Pi/180.0)) * (cos(Float(HA) * (pi/180.0))));
      alt:Long_Long_Float:=Long_Long_Float((180.0/Pi)*(Arcsin(Float(SinAlt))));

      CosA:Long_Long_Float:= Long_Long_Float((sin(Float(Todayde.TOdec) * (pi/180.0)) - (sin(Float(alt) * (pi/180.0)) * sin(Float(LAT) * (pi/180.0)))) / cos(Float(alt) * (pi/180.0)) * cos(Float(LAT) * (pi/180.0)));
      A:Long_Long_Float:= Long_Long_Float((180.0/Pi)*(Arccos(Float(CosA))));

      AZ:Long_Long_Float:=0.0;

      --conversion to cartiesian coordinates
      r:Long_Long_Float:=1.0;
      x:Long_Long_Float:=0.0;
      y:Long_Long_Float:=0.0;
      z:Long_Long_Float:=0.0;
      Time_Now : Ada.Real_Time.Time;


      ledX: MicroBit.DisplayRT.Coord :=2;
      ledY: MicroBit.DisplayRT.Coord :=2;


   BEGIN -- SimpleTask
      loop
         Start_Time := Clock;
         Time_Now := Ada.Real_Time.Clock;
         if HA < 0.0 then
            Az := A;
         else
            AZ := 360.0 - A;
         end if;
         x:= r * Long_Long_Float(cos(Float(alt) * (pi/180.0)) * cos(Float(AZ) * (Pi/180.0)));
         y:= r * Long_Long_Float(cos(Float(alt) * (pi/180.0)) * sin(Float(AZ) * (Pi/180.0)));
         z:= r * Long_Long_Float(sin(Float(AZ) * (Pi/180.0)));


         ConvertMapCoordToLedCoord(x,y,ledX, ledY);

         MicroBit.DisplayRT.Set(ledX,ledY,7);

         Put_Line (" sataz  is: " & Long_Long_Float'Image(AZ));
         Put_Line (" saturnx  is: " & Long_Long_Float'Image(x));
         Put_Line (" saturny  is: " & Long_Long_Float'Image(y));
         Put_Line (" saturnz is: " & Long_Long_Float'Image(z));
         New_Line;
         Stop_Time    := Clock;
         Elapsed_Time := Stop_Time - Start_Time;

         Put_Line ("Elapsed time saturn: "
                   & Duration'Image (To_Duration (Elapsed_Time))
                   & " seconds");
         delay until Time_Now + Ada.Real_Time.Seconds(10);
      end loop;



   END saturn;

   task body uranus  is

      lat:Long_Long_Float:=59.7441;
      lon:Long_Long_Float:=10.2045;
      ledX: MicroBit.DisplayRT.Coord :=2;
      ledY: MicroBit.DisplayRT.Coord :=2;

      Start_Time, Stop_Time : ADA.Real_Time.Time;
      Elapsed_Time          : Ada.Real_Time.Time_Span;


      type Index is range 1 .. 25;

      type My_float_Array is array (Index) of Long_Long_Float;
   --                                    ^ Type of elements
   --                          ^ Bounds of the array
      ra : My_float_Array := (((2.0 + 41.0/60.0 + 20.0/3600.0) * 15.0),
                              ((2.0 + 41.0/60.0 + 10.0/3600.0) * 15.0),
                              ((2.0 + 41.0/60.0 + 0.0) * 15.0),
                              ((2.0 + 40.0/60.0 + 51.0/3600.0) * 15.0),
                              ((2.0 + 40.0/60.0 + 41.0/3600.0) * 15.0),
                              ((2.0 + 40.0/60.0 + 31.0/3600.0) * 15.0),
                              ((2.0 + 40.0/60.0 + 21.0/3600.0) * 15.0),
                              ((2.0 + 40.0/60.0 + 11.0/3600.0) * 15.0),
                              ((2.0 + 40.0/60.0 + 2.0/3600.0) * 15.0),
                              ((2.0 + 39.0/60.0 + 52.0/3600.0) * 15.0),
                              ((2.0 + 39.0/60.0 + 42.0/3600.0) * 15.0),
                              ((2.0 + 39.0/60.0 + 32.0/3600.0) * 15.0),
                              ((2.0 + 39.0/60.0 + 23.0/3600.0) * 15.0),
                              ((2.0 + 39.0/60.0 + 13.0/3600.0) * 15.0),
                              ((2.0 + 39.0/60.0 + 3.0/3600.0) * 15.0),
                              ((2.0 + 38.0/60.0 + 54.0/3600.0) * 15.0),
                              ((2.0 + 38.0/60.0 + 44.0/3600.0) * 15.0),
                              ((2.0 + 38.0/60.0 + 35.0/3600.0) * 15.0),
                              ((2.0 + 38.0/60.0 + 25.0/3600.0) * 15.0),
                              ((2.0 + 38.0/60.0 + 16.0/3600.0) * 15.0),
                              ((2.0 + 38.0/60.0 + 7.0/3600.0) * 15.0),
                              ((2.0 + 37.0/60.0 + 58.0/3600.0) * 15.0),
                              ((2.0 + 37.0/60.0 + 48.0/3600.0) * 15.0),
                              ((2.0 + 37.0/60.0 + 39.0/3600.0) * 15.0),
                              ((2.0 + 37.0/60.0 + 30.0/3600.0) * 15.0));





      dec : My_float_Array:=((15.0 + 13.0/60.0 + 42.0/3600.0),
                             (15.0 + 12.0/60.0 + 58.0/3600.0),
                             (15.0 + 12.0/60.0 + 13.0/3600.0),
                             (15.0 + 11.0/60.0 + 28.0/3600.0),
                             (15.0 + 10.0/60.0 + 43.0/3600.0),
                             (15.0 + 9.0/60.0 + 59.0/3600.0),
                             (15.0 + 9.0/60.0 + 14.0/3600.0),
                             (15.0 + 8.0/60.0 + 29.0/3600.0),
                             (15.0 + 7.0/60.0 + 44.0/3600.0),
                             (15.0 + 7.0/60.0 + 0.0),
                             (15.0 + 6.0/60.0 + 15.0/3600.0),
                             (15.0 + 5.0/60.0 + 31.0/3600.0),
                             (15.0 + 4.0/60.0 + 47.0/3600.0),
                             (15.0 + 4.0/60.0 + 3.0/3600.0),
                             (15.0 + 3.0/60.0 + 19.0/3600.0),
                             (15.0 + 2.0/60.0 + 35.0/3600.0),
                             (15.0 + 1.0/60.0 + 52.0/3600.0),
                             (15.0 + 1.0/60.0 + 8.0/3600.0),
                             (15.0 + 0.0 + 25.0/3600.0),
                             (14.0 + 59.0/60.0 + 43.0/3600.0),
                             (14.0 + 59.0/60.0 + 0.0),
                             (14.0 + 58.0/60.0 + 18.0/3600.0),
                             (14.0 + 57.0/60.0 + 36.0/3600.0),
                             (14.0 + 56.0/60.0 + 55.0/3600.0),
                             (14.0 + 56.0/60.0 + 14.0/3600.0));




      type TodayRaDec is record
         TOra : Long_Long_Float;
         TOdec : Long_Long_Float;
      end record;

      Todayde : TodayRaDec:= (ra(Index(GetDay)), dec(Index(GetDay)));

      -- getseconds

      --convert seconds to day decimal
      timeDuration : Long_Long_Float:= Long_Long_Float(GetSeconds/ 86400.0);
      --convert seconds to hours
      temptime : Long_Long_Float:= Long_Long_Float((GetSeconds/3600.0)) * 15.0;


      -- split time in hour min seconds and convert to d;
      -- date = clock. day + 44500;
      --time is = hour/24 + min/1440 + s/86400;
      juliandate:long_long_float:= Long_Long_Float(GetDay) + 2415018.5 + timeDuration -(1.0/24.0);
      -- juliancentury:long_long_float:=(juliandate - 2451545.0)/36535.0;

      d: Long_Long_Float:= juliandate - 2451545.0;
      --localsidertime fmod(100.46 + First + lon + Second, 360.0)
      modYlst:Long_Long_Float:=360.0;
      eqLST: Long_Long_Float:= 100.46 + (0.985647 * d) + lon + (15.0 * temptime);
      tempEqLST:Long_Long_Float:=eqLST/modYlst;
      flooredeqLST:Long_Long_Float:= Long_Long_Float'Floor(tempEqLST);
      localsideraltime:Long_Long_Float:= eqLST - (flooredeqLST * modYlst);

      --degreeRa  fmod(RA * 15.0 , 360.0);
      modYRA:Long_Long_Float:= 360.0;
      eqRA:Long_Long_Float:=Todayde.TOra * 15.0;
      tempRA:Long_Long_Float:=eqRA/modYRA;
      flooredeqRA:Long_Long_Float:=Long_Long_Float'Floor(tempRA);
      degreeRA:Long_Long_Float:=eqRA - (flooredeqRA * modYRA);

      HA:Long_Long_Float:= localsideraltime -degreeRA;

      SinAlt:Long_Long_Float:= Long_Long_Float(sin(Float(Todayde.TOdec) *(Pi/180.0)) * sin(Float(lat) * (Pi/180.0)) + cos(Float(Todayde.TOdec) *(Pi/180.0)) * cos(Float(lat) *(Pi/180.0)) * (cos(Float(HA) * (pi/180.0))));
      alt:Long_Long_Float:=Long_Long_Float((180.0/Pi)*(Arcsin(Float(SinAlt))));

      CosA:Long_Long_Float:= Long_Long_Float((sin(Float(Todayde.TOdec) * (pi/180.0)) - (sin(Float(alt) * (pi/180.0)) * sin(Float(LAT) * (pi/180.0)))) / cos(Float(alt) * (pi/180.0)) * cos(Float(LAT) * (pi/180.0)));
      A:Long_Long_Float:= Long_Long_Float((180.0/Pi)*(Arccos(Float(CosA))));

      AZ:Long_Long_Float:=0.0;

      --conversion to cartiesian coordinates
      r:Long_Long_Float:=1.0;
      URAx:Long_Long_Float:=0.0;
      URay:Long_Long_Float:=0.0;
      URaz:Long_Long_Float:=0.0;

      Time_Now : Ada.Real_Time.Time;




    BEGIN -- SimpleTask
      loop
         Start_Time := Clock;

         Time_Now := Ada.Real_Time.Clock;
         if HA < 0.0 then
            Az := A;
         else
            AZ := 360.0 - A;
         end if;
         URAx:= r * Long_Long_Float(cos(Float(alt) * (pi/180.0)) * cos(Float(AZ) * (Pi/180.0)));
         URay:= r * Long_Long_Float(cos(Float(alt) * (pi/180.0)) * sin(Float(AZ) * (Pi/180.0)));
         URaz:= r * Long_Long_Float(sin(Float(AZ) * (Pi/180.0)));


        ConvertMapCoordToLedCoord(URAx,URay,ledX, ledY);

        MicroBit.DisplayRT.Set(ledX,ledY,7);

         Put_Line (" uraaz  is: " & Long_Long_Float'Image(AZ));
         Put_Line (" uraX  is: " & Long_Long_Float'Image(URAx));
         Put_Line (" uray  is: " & Long_Long_Float'Image(URay));
         Put_Line (" uraz  is: " & Long_Long_Float'Image(URaz));
         New_Line;
         Stop_Time    := Clock;
         Elapsed_Time := Stop_Time - Start_Time;

         Put_Line ("Elapsed time ura: "
                   & Duration'Image (To_Duration (Elapsed_Time))
                   & " seconds");
         delay until Time_Now + Ada.Real_Time.Seconds(10);
      end loop;



   END uranus;

   task body neptune  is

      lat:Long_Long_Float:=59.7441;
      lon:Long_Long_Float:=10.2045;


      ledX: MicroBit.DisplayRT.Coord :=2;
      ledY: MicroBit.DisplayRT.Coord :=2;

      Start_Time, Stop_Time : ADA.Real_Time.Time;
      Elapsed_Time          : Ada.Real_Time.Time_Span;

      type Index is range 1 .. 25;

      type My_float_Array is array (Index) of Long_Long_Float;
   --                                    ^ Type of elements
   --                          ^ Bounds of the array
      ra : My_float_Array := (((23.0 + 26.0/60.0 + 23.0/3600.0) * 15.0),
                              ((23.0 + 26.0/60.0 + 20.0/3600.0) * 15.0),
                              ((23.0 + 26.0/60.0 + 16.0/3600.0) * 15.0),
                              ((23.0 + 26.0/60.0 + 13.0/3600.0) * 15.0),
                              ((23.0 + 26.0/60.0 + 10.0/3600.0) * 15.0),
                              ((23.0 + 26.0/60.0 + 07.0/3600.0) * 15.0),
                              ((23.0 + 26.0/60.0 + 04.0/3600.0) * 15.0),
                              ((23.0 + 26.0/60.0 + 01.0/3600.0) * 15.0),
                              ((23.0 + 25.0/60.0 + 58.0/3600.0) * 15.0),
                              ((23.0 + 25.0/60.0 + 55.0/3600.0) * 15.0),
                              ((23.0 + 25.0/60.0 + 52.0/3600.0) * 15.0),
                              ((23.0 + 25.0/60.0 + 50.0/3600.0) * 15.0),
                              ((23.0 + 25.0/60.0 + 48.0/3600.0) * 15.0),
                              ((23.0 + 25.0/60.0 + 45.0/3600.0) * 15.0),
                              ((23.0 + 25.0/60.0 + 43.0/3600.0) * 15.0),
                              ((23.0 + 25.0/60.0 + 41.0/3600.0) * 15.0),
                              ((23.0 + 25.0/60.0 + 39.0/3600.0) * 15.0),
                              ((23.0 + 25.0/60.0 + 37.0/3600.0) * 15.0),
                              ((23.0 + 25.0/60.0 + 36.0/3600.0) * 15.0),
                              ((23.0 + 25.0/60.0 + 34.0/3600.0) * 15.0),
                              ((23.0 + 25.0/60.0 + 33.0/3600.0) * 15.0),
                              ((23.0 + 25.0/60.0 + 31.0/3600.0) * 15.0),
                              ((23.0 + 25.0/60.0 + 30.0/3600.0) * 15.0),
                              ((23.0 + 25.0/60.0 + 29.0/3600.0) * 15.0),
                              ((23.0 + 25.0/60.0 + 28.0/3600.0) * 15.0));





      dec : My_float_Array:=((-04.0 + 53.0/60.0 + 25.0/3600.0),
                             (-04.0 + 53.0/60.0 + 46.0/3600.0),
                             (-04.0 + 54.0/60.0 + 07.0/3600.0),
                             (-04.0 + 54.0/60.0 + 27.0/3600.0),
                             (-04.0 + 54.0/60.0 + 46.0/3600.0),
                             (-04.0 + 55.0/60.0 + 05.0/3600.0),
                             (-04.0 + 55.0/60.0 + 23.0/3600.0),
                             (-04.0 + 55.0/60.0 + 40.0/3600.0),
                             (-04.0 + 55.0/60.0 + 56.0/3600.0),
                             (-04.0 + 56.0/60.0 + 12.0/3600.0),
                             (-04.0 + 56.0/60.0 + 27.0/3600.0),
                             (-04.0 + 56.0/60.0 + 41.0/3600.0),
                             (-04.0 + 56.0/60.0 + 55.0/3600.0),
                             (-04.0 + 57.0/60.0 + 07.0/3600.0),
                             (-04.0 + 57.0/60.0 + 19.0/3600.0),
                             (-04.0 + 57.0/60.0 + 31.0/3600.0),
                             (-04.0 + 57.0/60.0 + 41.0/3600.0),
                             (-04.0 + 57.0/60.0 + 51.0/3600.0),
                             (-04.0 + 57.0/60.0 + 59.0/3600.0),
                             (-04.0 + 58.0/60.0 + 08.0/3600.0),
                             (-04.0 + 58.0/60.0 + 15.0/3600.0),
                             (-04.0 + 58.0/60.0 + 21.0/3600.0),
                             (-04.0 + 58.0/60.0 + 27.0/3600.0),
                             (-04.0 + 58.0/60.0 + 32.0/3600.0),
                             (-04.0 + 58.0/60.0 + 36.0/3600.0));




      type TodayRaDec is record
         TOra : Long_Long_Float;
         TOdec : Long_Long_Float;
      end record;

      Todayde : TodayRaDec:= (ra(Index(GetDay)), dec(Index(GetDay)));

      -- getseconds

      --convert seconds to day decimal
      timeDuration : Long_Long_Float:= Long_Long_Float(GetSeconds/ 86400.0);
      --convert seconds to hours
      temptime : Long_Long_Float:= Long_Long_Float((GetSeconds/3600.0)) * 15.0;


      -- split time in hour min seconds and convert to d;
      -- date = clock. day + 44500;
      --time is = hour/24 + min/1440 + s/86400;
      juliandate:long_long_float:= Long_Long_Float(GetDay) + 2415018.5 + timeDuration -(1.0/24.0);
      -- juliancentury:long_long_float:=(juliandate - 2451545.0)/36535.0;

      d: Long_Long_Float:= juliandate - 2451545.0;
      --localsidertime fmod(100.46 + First + lon + Second, 360.0)
      modYlst:Long_Long_Float:=360.0;
      eqLST: Long_Long_Float:= 100.46 + (0.985647 * d) + lon + (15.0 * temptime);
      tempEqLST:Long_Long_Float:=eqLST/modYlst;
      flooredeqLST:Long_Long_Float:= Long_Long_Float'Floor(tempEqLST);
      localsideraltime:Long_Long_Float:= eqLST - (flooredeqLST * modYlst);

      --degreeRa  fmod(RA * 15.0 , 360.0);
      modYRA:Long_Long_Float:= 360.0;
      eqRA:Long_Long_Float:=Todayde.TOra * 15.0;
      tempRA:Long_Long_Float:=eqRA/modYRA;
      flooredeqRA:Long_Long_Float:=Long_Long_Float'Floor(tempRA);
      degreeRA:Long_Long_Float:=eqRA - (flooredeqRA * modYRA);

      HA:Long_Long_Float:= localsideraltime -degreeRA;

      SinAlt:Long_Long_Float:= Long_Long_Float(sin(Float(Todayde.TOdec) *(Pi/180.0)) * sin(Float(lat) * (Pi/180.0)) + cos(Float(Todayde.TOdec) *(Pi/180.0)) * cos(Float(lat) *(Pi/180.0)) * (cos(Float(HA) * (pi/180.0))));
      alt:Long_Long_Float:=Long_Long_Float((180.0/Pi)*(Arcsin(Float(SinAlt))));

      CosA:Long_Long_Float:= Long_Long_Float((sin(Float(Todayde.TOdec) * (pi/180.0)) - (sin(Float(alt) * (pi/180.0)) * sin(Float(LAT) * (pi/180.0)))) / cos(Float(alt) * (pi/180.0)) * cos(Float(LAT) * (pi/180.0)));
      A:Long_Long_Float:= Long_Long_Float((180.0/Pi)*(Arccos(Float(CosA))));

      AZ:Long_Long_Float:=0.0;

      --conversion to cartiesian coordinates
      rnep:Long_Long_Float:=1.0;
      xnep:Long_Long_Float:=0.0;
      ynep:Long_Long_Float:=0.0;
      znep:Long_Long_Float:=0.0;
      r:Long_Long_Float:= 1.0;
      tempnepx: Integer:=0;
      tempnepy: Integer:=0;


      Time_Now : Ada.Real_Time.Time;





   BEGIN -- SimpleTask
      loop
         Start_Time := Clock;
         Time_Now := Ada.Real_Time.Clock;
         if HA < 0.0 then
            Az := A;
         else
            AZ := 360.0 - A;
         end if;
         xnep:= r * Long_Long_Float(cos(Float(alt) * (pi/180.0)) * cos(Float(AZ) * (Pi/180.0)));
         ynep:= r * Long_Long_Float(cos(Float(alt) * (pi/180.0)) * sin(Float(AZ) * (Pi/180.0)));
         znep:= r * Long_Long_Float(sin(Float(AZ) * (Pi/180.0)));


        ConvertMapCoordToLedCoord(xnep,ynep,ledX, ledY);

         MicroBit.DisplayRT.Set(ledX,ledY,7);

         Put_Line (" nepaz  is: " & Long_Long_Float'Image(AZ));
         Put_Line (" nepx  is: " & Long_Long_Float'Image(xnep));
         Put_Line (" nepy  is: " & Long_Long_Float'Image(ynep));
         Put_Line (" nepz  is: " & Long_Long_Float'Image(znep));
         New_Line;
         Stop_Time    := Clock;
         Elapsed_Time := Stop_Time - Start_Time;

         Put_Line ("Elapsed time nep: "
                   & Duration'Image (To_Duration (Elapsed_Time))
                   & " seconds");
         delay until Time_Now + Ada.Real_Time.Seconds(10);
      end loop;



   END neptune;






   task body sun is
      lat:Long_Long_Float:=59.6689;
      lon:Long_Long_Float:=9.6502;

      Start_Time, Stop_Time : ADA.Real_Time.Time;
      Elapsed_Time          : Ada.Real_Time.Time_Span;

      --decimal days, current time covert to decimal day
      sunTime :Long_Long_Float:=  0.0;
      -- split time in hour min seconds and convert to d;
      date:Long_Long_Float:= 0.0;
      --time is = hour/24 + min/1440 + s/86400;
      juliandate:long_long_float:=0.0;
      -- juliancentury:long_long_float:=(juliandate - 2451545.0)/36535.0;
      -- D = juliandate - 2451545.0;

      juliancentury:Long_Long_Float:= 0.0;

      --fmod(280.46646 + juliancentury * (36000.76983 + juliancentury * 0.0003032), 360.0);
      modYGML:Long_Long_Float:=360.0;
      eqGML: Long_Long_Float:= 0.0;
      tempEqGML:Long_Long_Float:=0.0;
      flooredeqGML:Long_Long_Float:= 0.0;
      gmlSun:Long_Long_Float:=0.0;

      gmaSun:Long_Long_Float:=0.0;
      eeo:Long_Long_Float:=0.0;
      SunEqofCtr:Long_Long_Float:=0.0;
      SunTrueLong:Long_Long_Float:= 0.0;
      SunTrueAnomoly:Long_Long_Float:= 0.0;
      SunAppLong:Long_Long_Float:= 0.0;
      MeanobliqEcliptic:Long_Long_Float:= 0.0;
      obliqCorr:Long_Long_Float:= 0.0;
      SunRtAscending:Long_Long_Float:=0.0;
      SunDeclin:Long_Long_Float:= 0.0;
      varY:Long_Long_Float:= 0.0;
      EqofTime:Long_Long_Float:= 0.0;
      HaSunrise:Long_Long_Float:= 0.0;


      --TrueSolarTime = fmod(sunTime * 1440.0 + EqofTime + 4.0 * lon - 60.0 * Timezone, 1440.0);
      modYTST:Long_Long_Float:=1440.0;
      eqTST: Long_Long_Float:= 0.0;
      tempEqTST:Long_Long_Float:=0.0;
      flooredeqTST:Long_Long_Float:= 0.0;
      TrueSolarTime:Long_Long_Float:=0.0;
      --convert getseconds to decmial day.
      sunHa:Long_Long_Float:=0.0;
      SolarzenithAngle:Long_Long_Float:=0.0;
      SolarElevationAngle:Long_Long_Float:=0.0;

      --TrueSolarTime = fmod(sunTime * 1440.0 + EqofTime + 4.0 * lon - 60.0 * Timezone, 1440.0);
      modYAZ:Long_Long_Float:=360.0;

      eqAZMORE: Long_Long_Float:= 0.0;
      eqAZESS: Long_Long_Float:=0.0;


      tempEqAZMORE:Long_Long_Float:=0.0;
      tempEqAZLESS:Long_Long_Float:=0.0;

      flooredeqAZMORE:Long_Long_Float:= 0.0;
      flooredeqAZLESS:Long_Long_Float:= 0.0;

      SolarAzimuth:Long_Long_Float:=0.0;
      rSun:Long_Long_Float:=1.0;
      xSun:Long_Long_Float:=0.0;
      ySun:Long_Long_Float:=0.0;
      zSun:Long_Long_Float:=0.0;
      timeh : Long_Long_Float:= 0.0;
      timehour :Long_Long_Float:= 0.0;
      timem: Long_Long_Float:=0.0;
      timemin :Long_Long_Float:= 0.0;
      



      Time_Now : Ada.Real_Time.Time;
      ledX: MicroBit.DisplayRT.Coord:=0;
      ledY: MicroBit.DisplayRT.Coord:=0;

   begin
      loop
         Start_Time := Clock;
         Time_Now := Ada.Real_Time.Clock;
                    
         sunTime :=  Long_Long_Float(GetSeconds/ 86400.0);
         -- split time in hour min seconds and convert to d;
         date:= Long_Long_Float(GetDay) + 44500.0;
         --time is = hour/24 + min/1440 + s/86400;
         juliandate:= date + 2415018.5+ sunTime -(1.0/24.0);
         -- juliancentury:long_long_float:=(juliandate - 2451545.0)/36535.0;
         -- D = juliandate - 2451545.0;

         juliancentury:= ((juliandate- 2451545.0)/36525.0);

         --fmod(280.46646 + juliancentury * (36000.76983 + juliancentury * 0.0003032), 360.0);
            
         eqGML:= 280.46646 + (juliancentury * (36000.76983 + juliancentury * 0.0003032));
         tempEqGML:=eqGML/modYGML;
         flooredeqGML:= Long_Long_Float'Floor(tempEqGML);
         gmlSun:=eqGML - (flooredeqGML * modYGML);

         gmaSun:=357.52911 + juliancentury * (35999.05029 - 0.0001537 * juliancentury);
         eeo:= 0.016708634-juliancentury*(0.000042037+0.0000001267*juliancentury);
         SunEqofCtr:=Long_Long_Float(sin(Float(gmaSun) * (Pi/180.0)) * (1.914602 - Float(juliancentury) * (0.004817 + 0.000014 * float(juliancentury))) + sin(2.0 * Float(gmaSun) * (Pi/180.0)) * (0.019993 - 0.000101 * Float(juliancentury)) + sin(3.0 * Float(gmaSun) * (Pi/180.0)) * 0.000289);
         SunTrueLong:= gmlSun + SunEqofCtr;
         SunTrueAnomoly:= gmaSun + SunEqofCtr;
         SunAppLong:= SunTrueLong - 0.00569 - 0.00478 * Long_Long_Float(sin(125.04 - 1934.136 * Float(juliancentury) * (Pi/180.0)));
         MeanobliqEcliptic:= 23.0 + (26.0 + ((21.448 - juliancentury * (46.815 + juliancentury * (0.00059 - juliancentury * 0.001813)))) / 60.0) / 60.0;
         obliqCorr:= MeanobliqEcliptic + 0.00256 * Long_Long_Float(cos(125.04 - 1934.136 * Float(juliancentury)));
         SunRtAscending:= Long_Long_Float(Arctan((Cos(Float(obliqCorr) * (PI/180.0)) * Sin(Float(SunAppLong) * (PI/180.0))), Cos(Float(SunAppLong)*(Pi/180.0))) * (180.0/PI));
         SunDeclin:= Long_Long_Float(arcsin(sin(float(obliqCorr) *(pi/180.0)) * sin(float(SunAppLong) * (pi/180.0))) *(180.0/Pi ));
         varY:= Long_Long_Float(tan((Float((obliqCorr) * (Pi/180.0))) / 2.0) * (tan(((Float(obliqCorr) *(pi/180.0))) / 2.0)));
         EqofTime:= 60.0 * (4.0 * ((varY * Long_Long_Float(sin(2.0 * Float(gmlSun) *(Pi/180.0)))) - 2.0 * eeo * Long_Long_Float(sin(Float(gmaSun) *(Pi/180.0))) + 4.0 * eeo * varY * Long_Long_Float(sin(Float(gmaSun) *(Pi/180.0))) *
                              Long_Long_Float(cos(2.0 * Float(gmlSun) * (Pi/180.0))) - 0.5 * varY * varY * Long_Long_Float(sin(4.0 * Float(gmlSun) - 1.25 * Float(eeo) * Float(eeo) * (Pi/180.0) * sin(2.0 * Float(gmaSun) * (Pi/180.0))))));
         HaSunrise:= Long_Long_Float((180.0/Pi)* Arccos(cos(90.833 * (Pi/180.0)) / (cos(Float(lat) * (Pi/180.0)) * cos(Float(SunDeclin) * (Pi/180.0))) - tan(Float(LAT) * (Pi/180.0)) * tan(Float(SunDeclin) * (Pi/180.0))));


         --TrueSolarTime = fmod(sunTime * 1440.0 + EqofTime + 4.0 * lon - 60.0 * Timezone, 1440.0);
            
         eqTST:= sunTime * 1440.0 + EqofTime + 4.0 * lon - 60.0 * 1.0;
         tempEqTST:=eqTST/modYTST;
         flooredeqTST:= Long_Long_Float'Floor(tempEqTST);
         TrueSolarTime:=eqTST - (flooredeqTST * modYTST);
         --convert getseconds to decmial day.
         
        
         
         timeh:= Long_Long_Float(GetSeconds/3600.0);
         timehour:= Long_Long_Float'Floor(timeh);
         timem:=timeh- Long_Long_Float'Floor(timeh);
         timemin:= timem * 60.0;
         
         if TrueSolarTime/ 4.0 < 0.0 then
            sunHa:= TrueSolarTime / 4.0 + 180.0;
         else
            sunHa:= TrueSolarTime / 4.0 - 180.0;
         end if;
         SolarzenithAngle:= (180.0/Pi) * Long_Long_Float(Arccos(sin(Float(LAT) *(Pi/180.0)) * sin(Float(SunDeclin) *(pi/180.0)) + cos(Float(lat) *(pi/180.0)) * cos(Float(SunDeclin) *(pi/180.0)) * cos(Float(sunHa) *(pi/180.0))));
         SolarElevationAngle:= 90.0 - SolarzenithAngle;

         if sunHa > 0.0 then
            eqAZMORE:= Long_Long_Float((180.0/Pi) * Arccos(((sin(Float(LAT) * (Pi/180.0)) * cos(Float(SolarzenithAngle) *(Pi/180.0))) - sin(Float(SunDeclin)* (Pi/180.0))) / (cos(Float(LAT) * (Pi/180.0)) * sin(Float(SolarzenithAngle)*(Pi/180.0)))) + 180.0);
            tempEqAZMORE:=eqAZMORE/modYAZ;
            flooredeqAZMORE:= Long_Long_Float'Floor(tempEqAZMORE);
            SolarAzimuth:=eqAZMORE - (flooredeqAZMORE * modYAZ);

         else
            eqAZESS:= 540.0 -(180.0/Pi) * Long_Long_Float(Arccos(((sin(Float(lat) *(Pi/180.0)) * cos(Float(SolarzenithAngle)* (Pi/180.0))) - sin(Float(SunDeclin) * (Pi/180.0))) / (cos(Float(LAT) * (pi/180.0)) * sin(Float(SolarzenithAngle) *(Pi/180.0)))));
            tempEqAZLESS:=eqAZESS/modYAZ;
            flooredeqAZLESS:= Long_Long_Float'Floor(tempEqAZLESS);
            SolarAzimuth:=eqAZESS - (flooredeqAZLESS * modYAZ);

         end if;
         xSun:= rSun * Long_Long_Float(cos(Float(SolarElevationAngle) * (pi/180.0)) * cos(Float(SolarAzimuth) * (Pi/180.0)));
         ySun:= rSun* Long_Long_Float(cos(Float(SolarElevationAngle) * (pi/180.0)) * sin(Float(SolarAzimuth) * (Pi/180.0)));
         zSun:= rSun * Long_Long_Float(sin(Float(SolarAzimuth) * (Pi/180.0)));

         ConvertMapCoordToLedCoord(xSun,ySun,ledX, ledY);

         MicroBit.DisplayRT.Set(ledX,ledY,9);







         -- Put_Line("juliandate" & Long_Long_Float'image(juliandate));
         --Put_Line("juliancentury" & Long_Long_Float'image(juliancentury));

         --Put_Line("gml" & Long_Long_Float'image(gmlSun));
         -- Put_Line("gma" & Long_Long_Float'image(gmaSun));
         --Put_Line("eeo" & Long_Long_Float'image(eeo));
         ---Put_Line("SunEqofCtr" & Long_Long_Float'image(SunEqofCtr));
         --Put_Line("SunTrueAnomoly" & Long_Long_Float'image(SunTrueAnomoly));
         --Put_Line("SunTrueLong" & Long_Long_Float'image(SunTrueLong));
         --Put_Line("MeanobliqEcliptic" & Long_Long_Float'image(MeanobliqEcliptic));
         --Put_Line("obliqCorr" & Long_Long_Float'image(obliqCorr));
         --Put_Line("SunRtAscending" & Long_Long_Float'image(SunRtAscending));
         --Put_Line("SunDeclin" & Long_Long_Float'image(SunDeclin));
         --Put_Line("varY" & Long_Long_Float'image(varY));
         --Put_Line("EqofTime" & Long_Long_Float'image(EqofTime));
         --Put_Line("HaSunrise" & Long_Long_Float'image(HaSunrise));
         -- Put_Line("TrueSolarTime" & Long_Long_Float'image(TrueSolarTime));
         -- Put_Line("sunHa" & Long_Long_Float'image(sunHa));
         -- Put_Line("SolarElevationAngle" & Long_Long_Float'image(SolarElevationAngle));
         --Put_Line("SolarzenithAngle" & Long_Long_Float'image(SolarzenithAngle));
         Put_Line("SolarAzimuth" & Long_Long_Float'image(SolarAzimuth));
         Put_Line("xSun" & Long_Long_Float'image(xSun));
         Put_Line("ySun" & Long_Long_Float'image(ySun));
         Put_Line("zSun" & Long_Long_Float'image(zSun));
         Put_Line("timehour" & Long_Long_Float'image(timehour));
         Put_Line("timemin" & Long_Long_Float'Image(timemin));
         Put_Line("seconds" & Long_Long_Float'Image(Long_Long_Float(GetSeconds)));

         New_Line;
         Stop_Time    := Clock;
         Elapsed_Time := Stop_Time - Start_Time;

         Put_Line ("Elapsed time Sun: "
                   & Duration'Image (To_Duration (Elapsed_Time))
                   & " seconds");
         delay until Time_Now + Ada.Real_Time.Seconds(1);
      end loop;
   END sun;

end planets;
