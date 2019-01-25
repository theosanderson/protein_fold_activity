joiner_diameter = 27;
cylinder_height=10;
depression=7;
lid_thickness=1;

standard=30;

module male_plate() {
    color("white")
    union() {
      translate([-joiner_diameter/2,-joiner_diameter/2]) cube([joiner_diameter,joiner_diameter,depression]);
      resize([joiner_diameter,joiner_diameter,depression])sphere(r=joiner_diameter/2);     
    }
};

module male_mask() {
    color("white")
    translate([-150,-150,-250]) cube([250,250,250]);
};



module female_plate() {
    color("white")
    difference() {
      translate([-joiner_diameter/2,-joiner_diameter/2]) cube([joiner_diameter,joiner_diameter,depression]);
      resize([joiner_diameter,joiner_diameter,depression])sphere(r=joiner_diameter/2);     
    }
};






module female_plate_lid() {
    color("white")
      translate([0,0,lid_thickness*0.5])
    difference() {
        translate([0,0,lid_thickness*0.5])
       resize([joiner_diameter,joiner_diameter,depression])sphere(r=joiner_diameter/2);   
        
      resize([joiner_diameter,joiner_diameter,depression])sphere(r=joiner_diameter/2);     
    }
    
        difference() {
        translate([0,0,lid_thickness*0.5])
       resize([joiner_diameter,joiner_diameter,depression])sphere(r=joiner_diameter/2);   
        
      resize([joiner_diameter,joiner_diameter,depression])sphere(r=joiner_diameter/2);   
        translate([-11,-10,0])  linear_extrude(100) text("C", size=20) ; 
    }
    
};


module male_plate_in_connector_context()
{
    translate([0,0,-standard/2])male_plate();
    };
    module male_mask_in_connector_context()
{
    translate([0,0,-standard/2])male_mask();
    };
    
    module female_plate_in_connector_context(angle)
{
    rotate(angle) translate([0,0,standard/2]) mirror([0,0,1])female_plate();
    };

module connecting_hull(){
    difference(){
        hull(){ children(0);
        children(1);};
        hull() children(2);
        hull() children(1);
}};



module connector(angle){
    
        male_plate_in_connector_context();
        female_plate_in_connector_context(angle);
        connecting_hull(){ male_plate_in_connector_context();
            female_plate_in_connector_context(angle);
            male_mask_in_connector_context();
            }
          //translate([0,0,standard/2])
          
    };
    
    
module piece_creator(angle,col="white"){
    color(col) connector(angle);
    
    rotate(angle) translate([0,0,standard]) children();
    
}

        
module straight(){
    piece_creator([0,0,0], "white") children();
}

module left(){
    
    piece_creator([0,90,0]) children();
}

module left45(){
    
    piece_creator([0,45,0]) children();
}

module right(){
    
    piece_creator([0,-90,0]) children();
}

module right45(){
    
    piece_creator([0,-45,0]) children();
}
module up45(){
   
    piece_creator([45,0,0]) children();
}
module down45(){

    piece_creator([-45,0,0]) children();
}
module up(){
   
    piece_creator([90,0,0]) children();
}
module down(){

    piece_creator([-90,0,0]) children();
}

module upleft45(){
   
    piece_creator([45,45,0]) children();
}

upleft45() ;
