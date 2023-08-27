integer water = 50;
integer food  = 50;
integer love  = 50;
integer aura  = 0;
float direct = 0;
integer is_alive = 1;
integer act = 0;
integer gListen;
vector current;
vector new_pos;
vector xyz_angles;
vector angles_in_radians; 
rotation rot_xyzq;
        
default
{
    state_entry()
    {
        llSetTimerEvent(1.0);
    }
    
    touch_start(integer i)
    {
    // llSetPos(llGetPos() + <0,0,1>);
     llListenRemove(gListen);
     key user = llDetectedKey(0);
     gListen = llListen(-98, "",user,"");
     llDialog(user, "\nWhat Action Would you like to do?",["FEED","GIVE WATER","PET"],-98);  
    }
    
    timer()
    {
          llSetText("BUNNY:\nFood: "+(string)food+"%\nWater: "+(string)water+"%\nLove: "+(string)love+"%\nLevel: "+(string)aura+"\n\n\n ",<0,1,0>,1.0);
          act = (integer)(llFrand(100.0)+1.0);
          if(act == 1) {
              food = food - 5;
          }
          if(act == 2) {
              water = water - 5;
          }
          if(act == 3) {
              love = love - 5;
          }
          if(act == 4) {
              if(love > 70 && water > 90 && food > 90) {
                  aura = aura + 1;
              }
          }  
          if(aura == 10){
                     llRezObject("Bunny_breed", llGetPos() + <0.0,0.0,1.0>, <0.0,0.0,0.0>, <0.0,0.0,0.0,1.0>, 0);
                     aura = 0;
          }
          if(water <= 0 || food <= 0 || love <= 0){
              is_alive = 0;
          }else{
              is_alive = 1;    
          }
          if(is_alive == 1){
           //   act = 0;
           act = (integer)(llFrand(20.0)+1.0);
           if(act == 1){
             float dirx = llFrand(2.0) - 1.0;
             float diry = llFrand(2.0) - 1.0;
             direct = (llAtan2(dirx,diry)+180) * RAD_TO_DEG;
             xyz_angles = <0,0,direct>;
             angles_in_radians = xyz_angles*DEG_TO_RAD;
             rot_xyzq = llEuler2Rot(angles_in_radians);
             llSetRot(rot_xyzq);
            // llSetRot(<0,0,direct,1>);
             llSetPos(llGetPos() + <dirx,diry,1>);
             llSetStatus(STATUS_PHYSICS, TRUE);
           }
          }
    }
    listen(integer chan, string name, key id, string msg)
    {
        if(msg == "FEED"){
            llSay(0,"nom nom nwn");
            food = food + 10;            
        }
        if(msg == "GIVE WATER"){
            llSay(0,"*Drinks water*");
            water = water + 10;
        }
        if(msg == "PET"){
            llSay(0,"-w- <3");
            love = love +10;
        }
        llSetText("BUNNY:\nFood: "+(string)food+"%\nWater: "+(string)water+"%\nLove: "+(string)love+"%\nLevel: "+(string)aura+"\n\n\n ",<0,1,0>,1.0);
    }
    collision(integer col){
        llSetStatus(STATUS_PHYSICS, FALSE);
        xyz_angles = <0,0,direct>;
        angles_in_radians = xyz_angles*DEG_TO_RAD;
        rot_xyzq = llEuler2Rot(angles_in_radians);
        llSetRot(rot_xyzq);
        //llSetRot(<0,0,direct,1>);
    }
}
