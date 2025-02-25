

/* [Box dimensions] */
  Length        = 260;       
  Width         = 180;                     
  TopHeight        = 40;  
  BottomHeight     = 31;  
  SlopeHeight      = 20;
  BackShelf     =130;
  Thick         = 3;//[2:5]  


  
/* [Box options] */
  PCBFeet       = 1;// [0:No, 1:Yes]
  Vent          = 1;// [0:No, 1:Yes]
  Vent_width    = 1.5;   
  Filet         = 9;//[0.1:12] 
  Resolution    = 50;//[1:100] 
  m             = 0.9;
  
/* [PCB_Feet--the_board_will_not_be_exported) ] */
PCBPosX         = 0;
PCBPosY         = 0;
PCBLength       = 142;
PCBWidth        = 360;
FootHeight      = 5;
FootDia         = 10;
FootHole        = 5;  /* 4.4 for melt in 5 for glue in */
  

/* [STL element to export] */
//Top shell
  TShell        = 1;// [0:No, 1:Yes]
//Bottom shell
  BShell        = 1;// [0:No, 1:Yes]
// Show PCBs
  ShowPCB       = 1;// [0:No, 1:Yes]
  ShowVertPCB   = 1;// [0:No, 1:Yes]
  ShowPowerSupply =0;
  ShowDrives    =1;

  
/* [Hidden] */
Couleur1        = "Orange";       
Couleur2        = "OrangeRed";    
Dec_Thick       = Vent ? Thick*2 : Thick; 
Dec_size        = Vent ? Thick*2 : 0.8;

PCBL=PCBLength;
PCBW=PCBWidth;



   
module SlopeRoundBox($a=Length, $b=Width, $c=TopHeight+BottomHeight){
                    $fn=Resolution;     
                         
                        translate([Filet,-Filet/2,Filet])
                        {  
                    minkowski ()
                    {  
              
                    translate([0,($b/2)+1,TopHeight])
                       rotate(a=[0,-90,90])
                          linear_extrude(height =(($b/2)-Filet/2)+1, center = false, convexity = 0, twist = 0)
                              polygon(points=[[0,0],[(SlopeHeight+TopHeight)*-1,0],[(SlopeHeight+TopHeight)*-1,BackShelf*-1],  [TopHeight*-1,($a-Filet*2)*-1],[0,($a-Filet*2)*-1]], paths=[[3,2,1,0]]);                      
                        
                     rotate([270,0,0]){    
                        cylinder(r=Filet,h=Width/2+1, center = false);
                            } 
                        }
                    }
                }// End of SlopeRoundBox Module                


module RoundBox($a=Length, $b=Width, $c=TopHeight+BottomHeight){
                    $fn=Resolution;            
                    translate([0,Filet,Filet]){  
                    minkowski (){                                              
                        cube ([$a-(Length/2),$b-(2*Filet),$c-(2*Filet)], center = false);
                        rotate([0,90,0]){   
                           translate([0,0,Filet]){  
                        cylinder(r=Filet,h=Length/2-(2*Filet), center = false);}
                            } 
                        rotate([270,0,0]){    
                        cylinder(r=Filet,h=.1, center = false);
                            } 
                        }
                    }
                }// End of RoundBox Module

      


module thinFoot(FootDia,FootHole,FootHeight){
    Filet=2;
    color("Orange")   
    translate([0,0,Filet-1.5])
    difference(){
    
    difference(){
            //translate ([0,0,-Thick]){
                cylinder(d=(FootDia),FootHeight-Thick, $fn=100);
                        //}
                    rotate_extrude($fn=100){
                            translate([(FootDia)/1.75,0,0]){
                                    minkowski(){
                                            square(10);
                                            circle(Filet, $fn=100);
                                        }
                                 }
                           }
                   }
            cylinder(d=FootHole/2,FootHeight+1, $fn=100);
               }          
}
module foot(FootDia,FootHole,FootHeight){
    Filet=2;
    color("Orange")   
    translate([0,0,Filet-1.5])
    difference(){
    
    difference(){
            //translate ([0,0,-Thick]){
                cylinder(d=FootDia+Filet,FootHeight-Thick, $fn=100);
                        //}
                    rotate_extrude($fn=100){
                            translate([(FootDia+Filet*2)/2,Filet,0]){
                                    minkowski(){
                                            square(10);
                                            circle(Filet, $fn=100);
                                        }
                                 }
                           }
                   }
            cylinder(d=FootHole,FootHeight+1, $fn=100);
               }          
}


module TopShell(){
    translate([0,0,BottomHeight+TopHeight+Thick*6]){
        
    Thick = Thick*2;  
    difference(){    
        difference(){
            union(){    
                     difference() {
                      
                        difference(){
                            union() {                                
                                       

                            difference(){
                                RoundBox($a=Length, $b=Width-2, $c=TopHeight+BottomHeight);
                                translate([Thick/2,Thick/2,Thick/2]){     
                                        RoundBox($a=Length-Thick, $b=Width-Thick-2, $c=TopHeight+BottomHeight-Thick);
                                        }
                                        }
                                    }
                               translate([-Thick,-Thick,TopHeight]){
                                   cube ([Length+100, Width+100, TopHeight+BottomHeight], center=false);
                                            }                                            
                                                            Drive35();
                                            }
                                }                                          




                            
                 
                    
                    
            }
        }

       }


           


            
        
        }
        
        
        

}
module BottomShell(){
    Thick = Thick*2;  
    translate([0,2,0]){
        
    difference(){    
        difference(){
            //Main Box
            union(){    
                     difference() {
                      
                        difference(){
                            union() {
                            difference(){
                                RoundBox($a=Length, $b=Width-2, $c=TopHeight+BottomHeight);
                                translate([Thick/2,Thick/2,Thick/2]){     
                                        RoundBox($a=Length-Thick, $b=Width-Thick-2, $c=TopHeight+BottomHeight-Thick);
                                        }
                                        }

                                    }
                               translate([-Thick,-Thick,BottomHeight]){
                                   cube ([Length+100, Width+100, TopHeight+BottomHeight], center=false);
                                            }                                            
                                      }
                                }                                          

              
            }

       
            // vent holes
            union(){           
            for(i=[0:Thick:Length/4]){
                    translate([10+i,-Dec_Thick+Dec_size,1]){
                    cube([Vent_width,Dec_Thick,BottomHeight/3]);
                    }
                    translate([(Length-10) - i,-Dec_Thick+Dec_size,1]){
                    cube([Vent_width,Dec_Thick,BottomHeight/3]);
                    }
                  }
            for(i=[0:Thick:Length/4]){
                    translate([10+i,Width-Thick,1]){
                    cube([Vent_width,Dec_Thick,BottomHeight/1.5]);
                    }
                    translate([(Length-10) - i,Width-Thick,1]){
                    cube([Vent_width,Dec_Thick,BottomHeight/1.5]);
                    }
                  }
        
                }
                
            }


            union(){ //sides holes
                $fn=50;
                translate([10*Thick+5,20,BottomHeight-4]){
                    rotate([90,0,0]){
                    cylinder(d=2,20);
                    }
                }
                translate([Length-((10*Thick)+5),20,BottomHeight-4]){
                    rotate([90,0,0]){
                    cylinder(d=2,20);
                    }
                }
                translate([10*Thick+5,Width+5,BottomHeight-4]){
                    rotate([90,0,0]){
                    cylinder(d=2,20);
                    }
                }
                translate([Length-((10*Thick)+5),Width+5,BottomHeight-4]){
                   rotate([90,0,0]){
                    cylinder(d=2,20);
                    }
                }
                
               // front and back
               translate([Length-Thick-0.5,(Width/2)-Thick/2+2.4,BottomHeight-4]){
                 rotate([90,0,90]){
                    cylinder(d=2,20);
                    }
                }
                
                  // front and back
               translate([Thick-11.5,(Width/2)-Thick/2+2.4,BottomHeight-4]){
                 rotate([90,0,90]){
                    cylinder(d=2,20);
                    }
                }
            }
        }
        }
}



module BottomFeet(){     

    // Feet
    translate([18,16,Thick/2-8.2])foot(FootDia,FootHole,FootHeight+8.4);
    translate([243,16,Thick/2-8.2])foot(FootDia,FootHole,FootHeight+8.4);
    
    translate([18,166,Thick/2-8.2])foot(FootDia,FootHole,FootHeight+8.4);
    translate([243,166,Thick/2-8.2])foot(FootDia,FootHole,FootHeight+8.4);

    // Reinforcements
    translate([Thick,(Width/2)-5,Thick/2-8.2]) cube([Length-(Thick*2),2,FootHeight+5.9]);   
    translate([Thick,156,Thick/2-8.2]) cube([Length-(Thick*2),2,FootHeight+5.9]);
    translate([Thick+18,15,Thick/2-8.2]) cube([(Length-(Thick*2))-35,2,FootHeight+5.9]);
    
    translate([(Length/3)+15,Thick+2,Thick/2-8.2]) cube([2,Width-(Thick*2)-2,FootHeight+5.9]);
    translate([Length-(Length/3)-16,Thick+2,Thick/2-8.2]) cube([2,Width-(Thick*2)-2,FootHeight+5.9]);
    
    translate([18,Thick+15.5,Thick/2-8.2]) cube([2,Width-(Thick*2)-29,FootHeight+5.9]);
    translate([243,Thick+15.5,Thick/2-8.2]) cube([2,Width-(Thick*2)-29,FootHeight+5.9]);
   

}


module MainPCB()
{
rotate([0,0,0])
    translate([-22,241,.5])
        color("Green",0.30)    
            import("./backfixed.stl");
}


module TemplatePCB()
{
rotate([90,0,0])
    translate([-22,241,-86])
        color("Green",0.30)    
            import("./temfixed.stl");
}

module PowerSupply()
{
        translate([Thick+70,Width-44-Thick,FootHeight]) cube([171,39,107]);
}

module Drive35()
{
    translate([Thick+6,-2,5]) cube([101.6,147.2,26.1]);
    
    translate([Length-110,-2,5]) cube([101.6,147.2,26.1]);
}

///////////////////////////////////// - Main - ///////////////////////////////////////



if(BShell==1)
{
    color(Couleur1){ 
        BottomShell();
    }
    translate([PCBPosX,PCBPosY,0]){ 
    BottomFeet();
    }
}
if(ShowVertPCB==1)
{
        TemplatePCB();   
}
if(ShowPCB==1)
{
        MainPCB();      
}
    if(ShowPowerSupply==1)
    {
     color("Blue",0.30)    
        PowerSupply();
    }
    if(ShowDrives==1)
    {
    color("Red",0.30)    
            translate([0,37,-TopHeight-Thick*6+4])
     Drive35();
    }
     

    



if(TShell==1)
{
    color( Couleur1,1){
        translate([0,Width,TopHeight+BottomHeight+0.2]){
            rotate([0,180,180]){
                TopShell();
            }
        }
    }
 
}


