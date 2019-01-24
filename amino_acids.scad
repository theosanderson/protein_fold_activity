standard = 30;
$fn = 20;
indicator_size = 3;
edge_thickness = 2;
compress_factor = 1;

plate_thickness = 3.1;
plate_width = 30;
lid_thickness = 1;

module complex_hull() {
    children(0); //male
    children(1); //female
    difference() {
        hull() {
            children(0);
            children(1);
        }
        union() {
            hull() children(0);
            hull() children(1);
        }
    }



}

module magnet_hole() {
    cylinder(r = 2.55, h = 3.1);
}

module join_hole() {
    cylinder(r = 2, h = 3.1);
}

module join_hole_connector() {
    cylinder(r = 2, h = 3.0);
}

module female_plate() {
    color("white")
    difference() {
        cube([plate_width, plate_width, plate_thickness]);
        translate([10, 5, 0]) magnet_hole();
        translate([22, 5, 0]) magnet_hole();
        translate([20, 20, 0]) magnet_hole();

        translate([5, 15, 0]) join_hole();
        translate([17, 12, 0]) join_hole();


    }
};


module plate_lid() {
    color("red")
    difference() {
        union() {
            cube([plate_width, plate_width, lid_thickness]);


            translate([5, 15, 0]) join_hole_connector();
            translate([17, 12, 0]) join_hole_connector();




        }
        mirror() translate([-25, 5, 0]) linear_extrude(0.25) text("N", size = 20);
    }
};

module plate_lid2() {
    color("red")
    difference() {
        union() {
            cube([plate_width, plate_width, lid_thickness]);


            translate([5, 15, -3]) join_hole_connector();
            translate([17, 12, -3]) join_hole_connector();




        }
        translate([5, 5, 0.5]) linear_extrude(5.25) text("C", size = 20);
    }
};

module male_plate() {


    color("gray")
    female_plate();

};

module start() {
    translate([(standard - plate_width) / 2, (standard - plate_width) / 2, standard - plate_thickness]) female_plate();

    translate([(standard - plate_width) / 2, (standard - plate_width) / 2, 0]) {
        color("red") {
            cube([plate_width, plate_width, standard - 1 * plate_thickness]);
        };
    };

    translate([0, 0, standard]) children();

};




module end_indicator() {
    color("black") cube([indicator_size, indicator_size, indicator_size]);
};

module straight() {
    translate([(standard - plate_width) / 2, (standard - plate_width) / 2, standard - plate_thickness]) female_plate();

    translate([(standard - plate_width) / 2, (standard - plate_width) / 2, plate_thickness]) {
        color("darkred") {
            cube([plate_width, plate_width, standard - 2 * plate_thickness]);
        };
    };

    translate([0, 0, standard]) children();

    translate([(standard - plate_width) / 2, (standard - plate_width) / 2, 0]) male_plate();
};



module left() {
    complex_hull() {
        //Male:
        translate([(standard - plate_width) / 2, (standard - plate_width) / 2, 0]) male_plate();

        //Female:
        translate([plate_thickness, (standard - plate_width) / 2, (standard - plate_width) / 2]) rotate([0, -90, 0]) female_plate();
    }
    //Children
    translate([0, 0, 0]) rotate([0, -90, 0]) children();

};

module right() {
    complex_hull() {
        //Male:
        translate([(standard - plate_width) / 2, (standard - plate_width) / 2, 0]) male_plate();

        //Female:
        translate([standard - plate_thickness, (standard - plate_width) / 2, standard - (standard - plate_width) / 2]) rotate([0, 90, 0]) female_plate();
    }
    //Children
    translate([standard, 0, standard]) rotate([0, 90, 0]) children();



};

module back() {


    complex_hull() {
        //Male:
        translate([(standard - plate_width) / 2, (standard - plate_width) / 2, 0]) male_plate();

        //Female:
        translate([(standard - plate_width) / 2, standard - plate_thickness, standard - (standard - plate_width) / 2]) rotate([-90, 0, 0]) female_plate();
    }
    //Children
    translate([0, standard, standard]) rotate([-90, 0, 0]) children();


};

module front() {

    complex_hull() {

        //Male:
        translate([(standard - plate_width) / 2, (standard - plate_width) / 2, 0]) male_plate();


        //Female:
        translate([(standard - plate_width) / 2, plate_thickness, (standard - plate_width) / 2]) rotate([90, 0, 0]) female_plate();
    };
    //Children
    translate([0, 0, 0]) rotate([90, 0, 0]) children();

};


module straight_notched() {
    difference() {
        straight() children();
        hull() {
            translate([0, 0, 3])# cube([1, standard, .01]);
            translate([standard / 2, 0, standard / 2])# cube([1, standard, .01]);
            translate([0, 0, standard - 3])# cube([1, standard, .01]);

        }
    }
};

module straight_notched2() {
    difference() {
        straight() children();
        hull() {
            translate([0, 0, 3])# cube([standard, 0.01, .01]);
            translate([0, standard / 2, standard / 2])# cube([standard, .01, .01]);
            translate([0, 0, standard - 3])# cube([standard, .01, .01]);

        }
    }
};

module straight_notched3() {
    difference() {
        straight() children();
        hull() {
            translate([0, standard, 3])# cube([standard, 0.01, .01]);
            translate([0, standard / 2, standard / 2])# cube([standard, .01, .01]);
            translate([0, standard, standard - 3])# cube([standard, .01, .01]);

        }
    }
};

module straight_notched4() {
    difference() {
        straight() children();
        hull() {
            translate([standard, 0, 3])# cube([1, standard, .01]);
            translate([standard / 2, 0, standard / 2])# cube([1, standard, .01]);
            translate([standard, 0, standard - 3])# cube([1, standard, .01]);

        }
    }
};


plate_lid2();
//straight();
//straight_notched3();

//start() front() straight() front() straight()straight()straight() front() straight() front() straight() left()straight() left() front() left() front()front() back() back() front(); 

//left();
