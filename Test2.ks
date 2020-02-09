Print "hello".
wait 1.
clearscreen.
print " WELCOME TO BIOMECAMAN'S FLIGHT CONTROLLER REVAMP ".
WAIT 2.
clearscreen.
set Timer to 0.
set prime to true.
set Throt to 1.
set i to 0.
set numOut to 0.
set x to 0.
set selection to 99.
set DisplayList to list("Press ag1").
set menuLevel to 0. //10, 100, 1000 ect
set Step to 0.
set RunMissionBool to false.
set MissionSequence to List().

  set twr to (ship:MAXTHRUST/ship:MASS)/(ship:SENSORS:GRAV:mag).

//BEGIN QUERY FUNCTIONS
Function QueryShip{
  if SHIP:PARTSDUBBED("parachute"):length > 0 {set HasChutes to true.}
  if SHIP:PARTSDUBBED("parachute"):length = 0 {set HasChutes to False.}

  if SHIP:PARTSDUBBED("J-"):length > 0 {set HasJets to true.}
  if SHIP:PARTSDUBBED("J-"):length = 0 {set HasJets to False.}

  if SHIP:PARTSDUBBED("Wing"):length > 0 {set HasWings to true.}
  if SHIP:PARTSDUBBED("Wing"):length = 0 {set HasWings to False.}

  if SHIP:PARTSDUBBED("Engine"):length > 0 {set HasEngines to true.}
  if SHIP:PARTSDUBBED("Engine"):length = 0 {set HasEngines to False.}

  If HasChutes = true {
    Print ("Parachute in atmosphere") at (1,i). set i to i +1.
    If HasJets = true {
      Print ("Jet in 02 atmosphere") at (1,i). set i to i +1.
    }
    if HasEngines = false{
      Print ("Free fall until safe speed") at (1,i). set i to i +1.
    }
  }

  If HasChutes = false {
    If HasWings = true {
      Print ("Glide in atmosphere") at (1,i). set i to i +1.
    }
    If HasEngines = true {
        Print ("Retro burn Touchdown") at (1,i). set i to i +1.
    }
    if HasWings = false {
      if HasEngines = false{
        Print ("NO REENTRY ARREST") at (1,i). set i to i +1.
      }
    }
  }

  print ("HEADING ") + HEADING at (1,i). set i to i +1.
  print ("PROGRADE ") + PROGRADE at (1,i). set i to i +1.
  print ("RETROGRADE ") + RETROGRADE at (1,i). set i to i +1.
  print ("FACING ") + FACING at (1,i). set i to i +1.
  print ("MAXTHRUST ") + MAXTHRUST at (1,i). set i to i +1.
  //print ("VELOCITY ") + VELOCITY at (1,i). set i to i +1.
  //print ("GEOPOSITION ") + GEOPOSITION at (1,i). set i to i +1.
  print ("LATITUDE ") + LATITUDE at (1,i). set i to i +1.
  print ("LONGITUDE ") + LONGITUDE at (1,i). set i to i +1.
  print ("UP ") + UP at (1,i). set i to i +1.
  print ("NORTH ") + NORTH at (1,i). set i to i +1.
  print ("BODY ") + BODY at (1,i). set i to i +1.
  //print ("ANGULARMOMENTUM ") + ANGULARMOMENTUM at (1,i). set i to i +1.
  //print ("ANGULARVEL ") + ANGULARVEL at (1,i). set i to i +1.
  //print ("ANGULARVELOCITY ") + ANGULARVELOCITY at (1,i). set i to i +1.
  print ("MASS ") + MASS at (1,i). set i to i +1.
  print ("VERTICALSPEED ") + VERTICALSPEED at (1,i). set i to i +1.
  print ("GROUNDSPEED ") + GROUNDSPEED  at (1,i). set i to i +1.	//Same as SHIP:GROUNDSPEED
  //print SURFACESPEED at (1,i). set i to i +1.	//This has been obsoleted as of kOS 0.18.0. Replace it with GROUNDSPEED.
  print ("AIRSPEED ") + AIRSPEED at (1,i). set i to i +1.
  print ("ALTITUDE ") + ALTITUDE at (1,i). set i to i +1.
  print ("APOAPSIS ") + APOAPSIS at (1,i). set i to i +1.
  print ("PERIAPSIS ") + PERIAPSIS at (1,i). set i to i +1.
   //SENSORS 	Same as SHIP:SENSORS
  print ("SRFPROGRADE ") + SRFPROGRADE at (1,i). set i to i +1.
  //SRFRETROGRADE 	Same as SHIP:SRFRETROGRADE
  print ("OBT ") + OBT at (1,i). set i to i +1.
  print ("STATUS ") + STATUS at (1,i). set i to i +1.
  print ("SHIPNAME ") + SHIPNAME at (1,i). set i to i +1.
  LIST ENGINES IN Eng.
   FOR en IN Eng {
     print "An engine exists with ISP = " + en:ISP at (1,i). set i to i +1.
   }.
}

Function QueryBody{
  Parameter BodyName.
  DisplayList:clear().
  DisplayList:ADD("NAME " + BodyName).
  //  The name of the body. Example: “Mun”.
  //print ("DESCRIPTION ") + Body:DESCRIPTION at (1,i). set i to i +1.
  //  Longer description of the body, often just a duplicate of the name.
  DisplayList:ADD("MASS " + Body(BodyName):MASS).
  //  The mass of the body in kilograms.
  DisplayList:ADD("HASOCEAN " + Body(BodyName):HASOCEAN).
  //  True if this body has an ocean. Example: In the stock solar system, this is True for Kerbin and False for Mun.
  DisplayList:ADD("HASSOLIDSURFACE " + Body(BodyName):HASSOLIDSURFACE).
  //  True if this body has a solid surface. Example: In the stock solar system, this is True for Kerbin and False for Jool.
  //print ("ORBITINGCHILDREN ") + Body:ORBITINGCHILDREN at (1,i). set i to i +1.
    // ^ looks ugly use below

  DisplayList:ADD("ROTATIONPERIOD " + Body(BodyName):ROTATIONPERIOD).
   //  The number of seconds it takes the body to rotate around its own axis. This is the sedereal rotation period which can differ from the length of a day due to the fact that the body moves a bit further around the Sun while it’s rotating around its own axis.
  DisplayList:ADD("RADIUS " + Body(BodyName):RADIUS).
   //  The radius from the body’s center to its sea level.
  DisplayList:ADD("MU " + Body(BodyName):MU).
  //  The Gravitational Parameter of the body.
  DisplayList:ADD("ATM " + Body(BodyName):ATM).
  //  A variable that describes the atmosphere of this body.
  //print ("ANGULARVEL ") + Body:ANGULARVEL at (1,i). set i to i +1.
  //  Angular velocity of the body’s rotation about its axis (its sidereal day) expressed as a vector.
  //  The direction the angular velocity points is in Ship-Raw orientation, and represents the axis of rotation. Remember that everything in Kerbal Space Program uses a left-handed coordinate system, which affects which way the angular velocity vector will point. If you curl the fingers of your left hand in the direction of the rotation, and stick out your thumb, the thumb’s direction is the way the angular velocity vector will point.
  //  The magnitude of the vector is the speed of the rotation, in radians.
  //    Note, unlike many of the other parts of kOS, the rotation speed is expressed in radians rather than degrees. This is to make it congruent with how VESSEL:ANGULARMOMENTUM is expressed, and for backward compatibility with older kOS scripts.
  //print Body:GEOPOSITIONOF(vectorPos) at (1,i). set i to i +1.
   //  Parameters:
   //      vectorPos – Vector input position in XYZ space.
   //  The geoposition underneath the given vector position. SHIP:BODY:GEOPOSITIONOF(SHIP:POSITION) should, in principle, give the same thing as SHIP:GEOPOSITION, while SHIP:BODY:GEOPOSITIONOF(SHIP:POSITION + 1000*SHIP:NORTH) would give you the lat/lng of the position 1 kilometer north of you. Be careful not to confuse this with :GEOPOSITION (no “OF” in the name), which is also a suffix of Body by virtue of the fact that Body is an Orbitable, but it doesn’t mean the same thing.
   //  (Not to be confused with the Orbitable:GEOPOSITION suffix, which Body inherits from Orbitable, and which gives the position that this body is directly above on the surface of its parent body.)
  //print Body:GEOPOSITIONLATLNG(latitude, longitude) at (1,i). set i to i +1.
 //    Parameters:
 //      latitude – Scalar input latitude
 //        longitude – Scalar input longitude
 //    Return type:
 //    GeoCoordinates
 //  Given a latitude and longitude, this returns a GeoCoordinates structure for that position on this body.
 //  (Not to be confused with the Orbitable:GEOPOSITION suffix, which Body inherits from Orbitable, and which gives the position that this body is directly above on the surface of its parent body.)
  //print ("ALTITUDEOF ") + Body:ALTITUDEOF at (1,i). set i to i +1.
    //The altitude of the given vector position, above this body’s ‘sea level’. SHIP:BODY:ALTITUDEOF(SHIP:POSITION) should, in principle, give the same thing as SHIP:ALTITUDE. Example: Eve:ALTITUDEOF(GILLY:POSITION) gives the altitude of gilly’s current position above Eve, even if you’re not actually anywhere near the SOI of Eve at the time. Be careful not to confuse this with :ALTITUDE (no “OF” in the name), which is also a suffix of Body by virtue of the fact that Body is an Orbitable, but it ////doesn’t mean the same thing.
  DisplayList:ADD("SOIRADIUS " + Body(BodyName):SOIRADIUS).
  //The radius of the body’s sphere of influence. Measured from the body’s center.
  //print ("ROTATIONANGLE ") + Body:ROTATIONANGLE at (1,i). set i to i +2.
  //The rotation angle is the number of degrees between the Solar Prime Vector and the current positon of the body’s prime meridian (body longitude of zero).
  //  The value is in constant motion, and once per body’s rotation period (“sidereal day”), its :rotationangle will wrap around through a full 360 degrees.

  set OrbitalsList to Body(BodyName):ORBITINGCHILDREN.
For OC in OrbitalsList {
  DisplayList:ADD("Satellite: " + OC:name).
  //print ("ALTITUDEOF ") + Body:ALTITUDEOF(OC:POSITION) at (1,i). set i to i +1.
  //print ("LATITUDE ") + OC:LATITUDE at (1,i). set i to i +1.
  //print ("LONGITUDE ") + OC:LONGITUDE at (1,i). set i to i +2.
}.
}

FUNCTION QueryBodyMenu2{
  DisplayList:clear().
  set Planets to sun:ORBITINGCHILDREN.
  for P in Planets{DisplayList:ADD(P:name).
    set Moons to p:ORBITINGCHILDREN.
    for M in Moons{DisplayList:ADD(M:name).}
  }set menuLevel to 520.
}

Function xQueryBody{
  Parameter BodyName.
  print ("NAME ") + Body:NAME at (1,i). set i to i +1.
  //  The name of the body. Example: “Mun”.
  //print ("DESCRIPTION ") + Body:DESCRIPTION at (1,i). set i to i +1.
  //  Longer description of the body, often just a duplicate of the name.
  print ("MASS ") + Body:MASS at (1,i). set i to i +1.
  //  The mass of the body in kilograms.
  print ("HASOCEAN ") + Body:HASOCEAN at (1,i). set i to i +1.
  //  True if this body has an ocean. Example: In the stock solar system, this is True for Kerbin and False for Mun.
  print ("HASSOLIDSURFACE ") + Body:HASSOLIDSURFACE at (1,i). set i to i +1.
  //  True if this body has a solid surface. Example: In the stock solar system, this is True for Kerbin and False for Jool.
  //print ("ORBITINGCHILDREN ") + Body:ORBITINGCHILDREN at (1,i). set i to i +1.
    // ^ looks ugly use below

  print ("ROTATIONPERIOD ") + Body:ROTATIONPERIOD at (1,i). set i to i +1.
   //  The number of seconds it takes the body to rotate around its own axis. This is the sedereal rotation period which can differ from the length of a day due to the fact that the body moves a bit further around the Sun while it’s rotating around its own axis.
  print ("RADIUS ") + Body:RADIUS at (1,i). set i to i +1.
   //  The radius from the body’s center to its sea level.
  print ("MU ") + Body:MU at (1,i). set i to i +1.
  //  The Gravitational Parameter of the body.
  print ("ATM ") + Body:ATM at (1,i). set i to i +1.
  //  A variable that describes the atmosphere of this body.
  //print ("ANGULARVEL ") + Body:ANGULARVEL at (1,i). set i to i +1.
  //  Angular velocity of the body’s rotation about its axis (its sidereal day) expressed as a vector.
  //  The direction the angular velocity points is in Ship-Raw orientation, and represents the axis of rotation. Remember that everything in Kerbal Space Program uses a left-handed coordinate system, which affects which way the angular velocity vector will point. If you curl the fingers of your left hand in the direction of the rotation, and stick out your thumb, the thumb’s direction is the way the angular velocity vector will point.
  //  The magnitude of the vector is the speed of the rotation, in radians.
  //    Note, unlike many of the other parts of kOS, the rotation speed is expressed in radians rather than degrees. This is to make it congruent with how VESSEL:ANGULARMOMENTUM is expressed, and for backward compatibility with older kOS scripts.
  //print Body:GEOPOSITIONOF(vectorPos) at (1,i). set i to i +1.
   //  Parameters:
   //      vectorPos – Vector input position in XYZ space.
   //  The geoposition underneath the given vector position. SHIP:BODY:GEOPOSITIONOF(SHIP:POSITION) should, in principle, give the same thing as SHIP:GEOPOSITION, while SHIP:BODY:GEOPOSITIONOF(SHIP:POSITION + 1000*SHIP:NORTH) would give you the lat/lng of the position 1 kilometer north of you. Be careful not to confuse this with :GEOPOSITION (no “OF” in the name), which is also a suffix of Body by virtue of the fact that Body is an Orbitable, but it doesn’t mean the same thing.
   //  (Not to be confused with the Orbitable:GEOPOSITION suffix, which Body inherits from Orbitable, and which gives the position that this body is directly above on the surface of its parent body.)
  //print Body:GEOPOSITIONLATLNG(latitude, longitude) at (1,i). set i to i +1.
 //    Parameters:
 //      latitude – Scalar input latitude
 //        longitude – Scalar input longitude
 //    Return type:
 //    GeoCoordinates
 //  Given a latitude and longitude, this returns a GeoCoordinates structure for that position on this body.
 //  (Not to be confused with the Orbitable:GEOPOSITION suffix, which Body inherits from Orbitable, and which gives the position that this body is directly above on the surface of its parent body.)
  //print ("ALTITUDEOF ") + Body:ALTITUDEOF at (1,i). set i to i +1.
    //The altitude of the given vector position, above this body’s ‘sea level’. SHIP:BODY:ALTITUDEOF(SHIP:POSITION) should, in principle, give the same thing as SHIP:ALTITUDE. Example: Eve:ALTITUDEOF(GILLY:POSITION) gives the altitude of gilly’s current position above Eve, even if you’re not actually anywhere near the SOI of Eve at the time. Be careful not to confuse this with :ALTITUDE (no “OF” in the name), which is also a suffix of Body by virtue of the fact that Body is an Orbitable, but it ////doesn’t mean the same thing.
  print ("SOIRADIUS ") + Body:SOIRADIUS at (1,i). set i to i +2.
  //The radius of the body’s sphere of influence. Measured from the body’s center.
  //print ("ROTATIONANGLE ") + Body:ROTATIONANGLE at (1,i). set i to i +2.
  //The rotation angle is the number of degrees between the Solar Prime Vector and the current positon of the body’s prime meridian (body longitude of zero).
  //  The value is in constant motion, and once per body’s rotation period (“sidereal day”), its :rotationangle will wrap around through a full 360 degrees.

  set OrbitalsList to Body:ORBITINGCHILDREN.
For OC in OrbitalsList {
  Print ("Satellite: ") + OC:name at (1,i). set i to i +1.
  //print ("ALTITUDEOF ") + Body:ALTITUDEOF(OC:POSITION) at (1,i). set i to i +1.
  //print ("LATITUDE ") + OC:LATITUDE at (1,i). set i to i +1.
  //print ("LONGITUDE ") + OC:LONGITUDE at (1,i). set i to i +2.
}.
}
// END QUERY FUNCTIONS


// BEGIN MAP FUNCTIONS
Function SystemMap{
  DisplayList:clear().
  set Planets to sun:ORBITINGCHILDREN.
  set Current to Body:name.
  for p in Planets{
    DisplayList:ADD("Planet: " + p:name).

    local Angle is p:longitude - body:longitude.
    set Angle to mod(Angle, 360).
    set Angle to choose 360 - Angle if Angle > 180 else Angle.
    set Angle to choose 360 + Angle if Angle < -180 else Angle.
    //if target:name = p:name{return Angle.}

    if p:name<>Current{
      DisplayList:ADD(" Angle: " + round(Angle,2)).
      DisplayList:ADD("").
    }
    if p:name=Current{
      DisplayList:ADD(" - you are here - ").
    }
    set Moons to p:ORBITINGCHILDREN.
    for M in Moons{
      DisplayList:ADD("  Moon: " + M:name).
      DisplayList:ADD("").

      if p:name=Current{
        local mAngle is M:longitude - ship:longitude.
        set mAngle to mod(mAngle, 360).
        set mAngle to choose 360 - mAngle if mAngle > 180 else mAngle.
        set mAngle to choose 360 + mAngle if mAngle < -180 else mAngle.
        DisplayList:ADD("   Angle: " + round(mAngle,2)).
        DisplayList:ADD("").
        //if target:name = m:name{return Angle.}
      }
    }
    set i to i +1.
  }
  set i to i+1.
}
// END MAP FUNCTIONS

// BEGIN MISSION FUNCTIONS
Function Start{
  if prime = true{
    //QueryShip().
    //QueryBody().
    //SystemMap().
  }
  set prime to false.
  set Timer to 0.
  set HomeLat to LATITUDE.
  set HomeLon to LONGITUDE.
    if Status = "Prelaunch" {
      Set Step to Step + 1.
      set SHIP:CONTROL:PILOTMAINTHROTTLE to Throt.}

}

Function AutoStage {
  LIST ENGINES IN engines.
    FOR eng IN engines  {IF eng:FLAMEOUT  {
        SET numOut TO numOut + 1.}  }
    if numOut > 0 { stage. set numOut to 0.}.
}

Function launch{
  rcs on.
  SET STEERINGMANAGER:MAXSTOPPINGTIME TO 1.
  set factor to Kerbin:radius / 89000.
  set targetAlt to Body:radius / factor.
  if APOAPSIS < 10 {set ap to 1.}
  if APOAPSIS > 10 {set ap to APOAPSIS.}
  set Theta to min(110,(90*(ap/targetAlt))).
  Lock Steering to up+r(0,-Theta,90).

if ETA:APOAPSIS < ETA:PERIAPSIS{
  set diff to (APOAPSIS - PERIAPSIS).
  set remaining to targetAlt - APOAPSIS.
  if diff > Body:radius/1000{
    set th to remaining+(diff/(ETA:apoapsis*ETA:apoapsis)).
    if th > 0.01 {set throttle to th.}
    if th < 0.01 {set throttle to 0.01.}

  }
  //Print ("D: ")+Diff at (5,10).
  //print ("T: ")+th at (5,11).
  if ETA:APOAPSIS < ETA:PERIAPSIS{
  //  set throt to max((targetAlt - APOAPSIS)/10,10/ETA:APOAPSIS).
  //  //set throt to (-0.5 + (0.1*(targetAlt - APOAPSIS)/(ETA:APOAPSIS/2))).
  //    if throt > 0.01{set throttle to throt.}
  //    if throt < 0.01{set throttle to 0.}
  }
}
  if ETA:APOAPSIS > ETA:PERIAPSIS{set throttle to 1.}

  if Status = "Prelaunch" {Stage.}
  AutoStage().
  //set warp to 0.
  //if PERIAPSIS > targetAlt*0.95 { set warp to 0.}
  if PERIAPSIS > targetAlt*0.99 {
    Set Step to Step + 1.
   }
    //print ("targetAlt ") + targetAlt at (1,i).
    //print ("APOAPSIS ") + APOAPSIS at (1,i+1).
    //print ("Theta ") + Theta at (1,i+2).
    //print ("ETA:APOAPSIS ") + ETA:APOAPSIS  at (1,i+3).
    //print ("throt ") + throt at (1,i+4).
}

Function DeOrbit{
  AutoStage().
    if body:name = "Kerbin"{
      //print ("Home longitude: ") + round(HomeLon,2) at (1,i). set i to i +1.
      set DecelPoint to mod((HomeLon),360).
      //print ("Retro Burn at: ") + round(DecelPoint,2) at (1,i). set i to i +1.
      //print ("Current longitude: ") + round(ship:longitude,2) at (1,i). set i to i +1.
      //print ("Sea Pressure: ") + round(body:ATM:SEALEVELPRESSURE,2) at (1,i). set i to i +1.

    local lAngle is HomeLon-103.5 - ship:longitude.
    set lAngle to mod(lAngle, 360).
    set lAngle to choose 360 - lAngle if lAngle > 180 else lAngle.
    set lAngle to choose 360 + lAngle if lAngle < -180 else lAngle.
    //print ("Deg until retroburn: ") + round(lAngle,2) at (1,i). set i to i +1.

    if abs(lAngle) > 7 {
      SET WARPMODE TO "RAILS".
      set warp to 5.
    }

    if abs(lAngle) < 7 {
      set warp to 0.
      if abs(lAngle) < 3 {
        //lock steering to RETROGRADE+r(0,theta,0).
        lock steering to RETROGRADE+r(0,0,0).

       if PERIAPSIS > 0 {
          RCS on.
        if VECTORANGLE(ship:FACING:Vector,ship:retrograde:vector) < 10{ set throttle to throttle + 0.1. }
        }
      }
    }

    if PERIAPSIS < 0 {
      set throttle to 0.
      Set Step to Step + 1.

    }
  }
}

Function VtolLand {
  panels off.
  RCS on.
  if ship:VERTICALSPEED < 0 {
    if ship:VERTICALSPEED < -3 {
     //lock steering to SHIP:SRFRETROGRADE.
    }
    if ship:VERTICALSPEED > -6 {
     //lock steering to up.
    }
  }
  Lock targetVertSpeed to (-alt:radar/10).
  if targetVertSpeed < - 4 {
    Lock throttle to targetVertSpeed-verticalspeed.
  }
  if targetVertSpeed > - 4 {
    Lock throttle to (-4)-verticalspeed.
  }
}

Function PowerLand {
  panels off.
  if ship:MAXTHRUST = 0 {print ("WARNING NO THRUST!!!").if alt:radar<2000{chutes on.}}
  if ship:VERTICALSPEED < 0 {
    if ship:VERTICALSPEED < -3 {
      local cAngle is HomeLon - ship:longitude.
      set cAngle to mod(cAngle, 360).
      set cAngle to choose 360 - cAngle if cAngle > 180 else cAngle.
      set cAngle to choose 360 + cAngle if cAngle < -180 else cAngle.

      set ActualVal to 90-vang(ship:up:vector, retrograde:vector).
      set TrackVal to ((cAngle*cAngle)*400)/alt:radar.
      set offset to TrackVal-ActualVal.
      set theta to max(-40,min(40,offset)).

      print cAngle at (5,9).
      print ActualVal at (5,10).
      print TrackVal at (5,11).
      print offset at (5,12).
      print theta at (5,13).

     lock steering to SHIP:SRFRETROGRADE+r(0,theta,0).
    }
    if ship:VERTICALSPEED > -3 {
     lock steering to up.
    }
  }
  set twr to (ship:MAXTHRUST/ship:MASS).
  set TTI to ((ship:verticalspeed*ship:verticalspeed)/(alt:radar)).

  set throt to TTI/10.

  if Throt > 0.3{set throttle to throt.}
  if Throt < 0.3{set throttle to 0.}
  //print TTI at (5,5).
  //Lock targetVertSpeed to (-alt:radar/10*twr).
  //if targetVertSpeed < - 4 {
    //Lock throttle to targetVertSpeed-verticalspeed.
  //}
  //if targetVertSpeed > - 4 {
  //  Lock throttle to (-4)-verticalspeed.
  //}
  if verticalspeed > -0.1 if VERTICALSPEED < 0.1{
    if alt:radar < 50 {unlock Throttle. unlock steering. Set Step to Step + 1.}}

}

Function  GliderLandAtmos {
  if ALT:radar > body:ATM:height/2 {lock Steering to Up+r(180,110,90).}
  if ALT:radar < body:ATM:height/2 {lock Steering to Up+r(180,110,90).}
}

Function Hover{
  Parameter targetHeight.
  //set targetHeight to 100.
  Lock targetVertSpeed to (targetHeight-alt:radar)/10.
  Lock throttle to targetVertSpeed-verticalspeed.
}

Function Orbit{
  panels on.
  set throttle to 0.
  set PILOTMAINTHROTTLE to 0.
  Set Step to Step + 1.
}

Function Transfer{
  set targetObject to target.
  set targetsAngle to SystemMap@.
  //if targetObject:name = p:name{return Angle.}
  //print targetsAngle at (12,12).
}

FUNCTION Stop{
  unlock steering.
  unlock throttle.
}

// END MISSION FUNCTIONS

// BEGIN TEST FUNCTION

Function test{
    if Status = "Prelaunch" {stage.}
    set pointA to 300.
    print Timer at (0,i). set i to i + 1.
  if Timer < pointA {

    Hover(5000).
  }
  if Timer > pointA {
    PowerLand().
    //VtolLand().
  }
  print twr at (10,10).
}
// END TEST Function

// BEGIN OPERATING SYSTEM FUNCTIONS
Function Display {
  //Print ("+-B-I-O-M-E-C-A-M-A-N-+") at (0,i).
  //if selection = 99 {MainMenu().}
  if ag1 {set Selection to 99. ag1 off.}
  if ag2 {set Selection to x + MenuLevel. ag2 off.}
  if ag3 {set x to x - 1. ag3 off.}
  if ag4 {set x to x + 1. ag4 off.}
  if x < 0 {set x to DisplayList:length-1.}
  if x > DisplayList:length-1 {set x to 0.}

  if DisplayList:length = 0{MainMenu().}

  Print ("->") at (0,x).

  //Set DisplayList to Displayer@.
  //set dLine to DisplayList:length.
  set dL to 0.
  for dLine in DisplayList{
    print DisplayList[dL] at (3,dL).
    set dL to dL + 1.
  }
//}

//Function Displayer{
    if selection = 99 {MainMenu().}
  if Selection = 0 {RunMissionMenu().}
    if selection = 10 {RunMission().}
  if selection = 1 {StopMissionMenu().}
      if selection = 100 {StopMission().}
  if selection = 2 {PauseMissionMenu().}
      if selection = 20 {PauseMission().}
  if selection = 3 {SetupMissionMenu().}
      if selection = 30 {NewMissionMenu(). set LastMissionStepSelect to MissionStepSelect.}
        if selection >= 300 {if selection < 310 {set msel to selection-300.
          set MissionStepSelect to DisplayList[msel].
          print msel.
          if MissionStepSelect <> LastMissionStepSelect{
            addMissionStep(msel).}
            //add step to mission.
          set selection to 30.}
        }
      if selection = 31 {LoadMissionMenu().}
        if selection >=310 {if selection < 320{set smsel to selection-310.}}
      if selection = 32 {DeleteMissionMenu().}
        if selection = 300{}
  if selection = 4 {KAHMenu().}
      if selection = 40 {RunMission().}
  if selection = 5 {ShowInfoMenu().}
      if selection = 50 {QueryShip().}
      if selection = 51 {SystemMap().}
      if selection = 52 {QueryBodyMenu().}
        if selection >= 520 {if selection < 600 {set bsel to selection-520.
          set BodySelect to DisplayList[bsel].
          //set target to BodySelect.
          QueryBody(BodySelect).
          set selection to 5200.}}
  if selection = 6 {OptionsMenu().}
      if selection = 60 {RunMission().}
  if selection = 7 {About().}

}
// factor by 10 for menu levels
FUNCTION MainMenu {
  set j to 0. set k to 0.
  set MissionListTemp to List().
  set MissionSequenceTemp to List().
  set StepListTemp to List().
  set MissionStepSelect to -1.
  set LastMissionStepSelect to -1.
  set DisplayList to list("Run Mission","Stop Mission","Pause Mission","Setup Mission ",
  "KILL ALL HUMANS ","Show Info ","Options ","About ").
  set menuLevel to 0.
}

Function LoadMissionMenu2{
  MissionSequence:clear().
  SET MissionSequenceJSONread TO READJSON("MissionSequenceJSON.json").
  set MissionSequence to MissionSequenceJSONread.
  set DisplayList to list("Loaded: MissionSequenceJSON.json").
  //set listOfMissions to MissionSequenceJSONread.
  //for ML in listOfMissions{MissionListTemp:add(listOfMissions[ML]).
    //For MS in MissionListTemp{StepListTemp:add(MissionListTemp[MS]).}
  //}

  //For MissionStep in MissionSequenceJSONread{
  //  DisplayList:ADD(MissionStep).
  //  MissionSequence:ADD(MissionStep).
  //}
  set menuLevel to 310.
}

FUNCTION NewMissionMenu2{
  set DisplayList to list("Start", "Launch", "Orbit", "DeOrbit", "PowerLand", "Transfer","Glider Land", "VTOL Land","BLANK","SAVE SEQUENCE").
  set menuLevel to 300.
}

FUNCTION addMissionStep{
  Parameter MissionStepSelect.
  if MissionStepSelect <> 9{
    MissionSequenceTemp:ADD(MissionStepSelect).
    set DisplayList to list("Step Recorded.").
  }
  if MissionStepSelect = 9 {
    WRITEJSON(MissionSequenceTemp, "MissionSequenceJSON.json").
    set step to 0.
    //set MissionSequence to MissionSequenceTemp. //ram only for now until json works
    set DisplayList to list("Mission Saved.").
    set MissionSequenceTemp to List().
  }
}

FUNCTION RunMissionMenu {set DisplayList to list("Run Mission Confirm").set menuLevel to 10.}
FUNCTION RunMission{set DisplayList to list("Running Current Mission"). set RunMissionBool to true.}
FUNCTION StopMissionMenu{ set DisplayList to list("Stop Mission Confirm").set menuLevel to 100.}
FUNCTION StopMission{ set DisplayList to list("Stopped and Unlocked").set RunMissionBool to false. Unlock steering. Unlock Throttle.}
FUNCTION PauseMissionMenu{ set DisplayList to list("Pause Mission Confirm").set menuLevel to 20.}
FUNCTION PauseMission{ set DisplayList to list("Stopped and Unlocked").set RunMissionBool to false. Unlock steering. Unlock Throttle.}
FUNCTION SetupMissionMenu{ set DisplayList to list("Create New Mission","Load Saved Mission", "Delete Saved Mission").set menuLevel to 30.}
FUNCTION NewMissionMenu{NewMissionMenu2().}
FUNCTION LoadMissionMenu{LoadMissionMenu2().}
FUNCTION DeleteMissionMenu{}
FUNCTION KAHMenu{ set DisplayList to list("Kill All Humans Confirm").set menuLevel to 40.}
FUNCTION ShowInfoMenu{ set DisplayList to list("Ship info","Star System Map","Body Info").set menuLevel to 50.}
FUNCTION QueryBodyMenu{QueryBodyMenu2().}
FUNCTION OptionsMenu{}
FUNCTION About{set DisplayList to list
("This flight controller was designed by Biomecaman",
"In an attempt to give greater control to complex craft:",
"while creating a vintage style text based controller.").}

Function Executor{
  //flightplan().
  //set DisplaySelection to ModeDisplay. // get from FUNCTION
  if RunMissionBool = true {
    //set MissionStep to list(MissionSequence).
    if Step >= MissionSequence:length {set RunMissionBool to false.}
    if Step < MissionSequence:length {Set Runmode to MissionSequence[Step].
      //DisplayList:ADD("Mission" + MissionSequence).
      //DisplayList:ADD("runmode:" + Runmode).
      //DisplayList:ADD("Step:" + Step).
    }
  }
  if RunMissionBool = false {
    Set Runmode to -1.
  }
}
// END OS FUNCTIONS

// BEGIN MAIN LOOP
set Runmode to -1.

until False{
  EXECUTOR().
  if mod(timer,30)=0{
    clearscreen.
    Display().
  }
  If runmode =-1{
    //test(). //UnComment test for Testing
    Stop().
  }
  if runmode =0{
    start().
  }
  if runmode =1{
    launch().
  }
  if runmode =2{
    orbit().
  }
  if runmode =3{
   DeOrbit().
  }
  if runmode =4{
   PowerLand().
  }
  if runmode =5{
   Transfer().
  }
  if runmode =6{
    GliderLandAtmos().
  }
  if runmode =7{
    VtolLand().
  }
  set i to 0.
  set Timer to Timer+1.
  wait 0.001.
  //print (ship:MAXTHRUST/ship:MASS)/10.
  //print body:MASS/100000000000000000000.00.

}
