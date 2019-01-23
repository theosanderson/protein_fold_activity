standard = 10;



plate_thickness = 2;
plate_width = 9.5;

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


module female_plate() {
    color("white")
    difference() {
        cube([plate_width, plate_width, plate_thickness]);

        translate([2, 2, -1]) cube([3, 1, plate_thickness * 5]);
        translate([2, 2, -1]) cube([1, 3, plate_thickness * 5]);
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

start() left() left() back() front() left() straight() left() straight() left() straight() back() right() back() straight() back() straight() straight() straight_notched3() back() straight() back() straight_notched3() left();

//straight_notched3();

//start() front() straight() front() straight()straight()straight() front() straight() front() straight() left()straight() left() front() left() front()front() back() back() front(); 

//left();
