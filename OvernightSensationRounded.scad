$fn = 80;
//Rounded Speaker Design
thickness = 12.7;
frontWidth = 127;
backWidth = 54.6;
height = 228.6 - thickness * 2;
effectiveArea = 16395.05;
//Front and Back Trapezoid
trapezoidalWingWidth = (frontWidth - backWidth)/2;

trapezoidalLength = effectiveArea/(trapezoidalWingWidth + backWidth);
chordLength = sqrt(pow(trapezoidalLength,2) + pow(trapezoidalWingWidth,2));
//Outershell
outsideTrapezoidalLength = trapezoidalLength + thickness*2;
outsideArea = trapezoidalWingWidth * outsideTrapezoidalLength + (backWidth + thickness *2) * outsideTrapezoidalLength;
outsideChordLength = sqrt(pow(outsideTrapezoidalLength, 2) + pow(trapezoidalWingWidth, 2));

//Rounded Side Curves
angleOfCurve = 60;
radiusOfCurve = chordLength/(2*sin(angleOfCurve/2));
areaOfCurve = (pow(radiusOfCurve, 2)/2) * (PI/180 *angleOfCurve - sin(angleOfCurve)); 
heightOfCurve = pow(chordLength, 2)/(8*radiusOfCurve - 0.5);
echo((areaOfCurve *2 + effectiveArea)*height);

//outer rounded side curves
outerRadiusOfCurve = outsideChordLength/(2*sin(angleOfCurve/2));
outerAreaOfCurve = (pow(outerRadiusOfCurve, 2)/2) * (PI/180 *angleOfCurve - sin(angleOfCurve)); 
outerHeightOfCurve = pow(outsideChordLength, 2)/(8*radiusOfCurve - 0.5);

//Tweeter Dimensions
tweeterOuterDiameter = 47;
tweeterInnerDiameter = 35;

tweeterThickness = 3;
tweeterX = 95.25;
tweeterY = (height + 2 * thickness) - 44.45;
//Woofer Dimensions
wooferDiameter = 118.5;
wooferInnerDiameter = 98;

wooferThickness = 5;
wooferX = (frontWidth + 2 * thickness)/2;
wooferY = (height + 2 * thickness) - 139.7;
wooferScrewDiameter = 2.5;
wooferScrewX = 38.6;
wooferScrewY = 38.6;
//Port Hole Dimensions
portDiameter = 42;
portScrewDiameter = 2.5;

portScrewRing = 52;
portX = (backWidth + 2 * thickness)/2;
portY = (height + 2* thickness) - 63.5;
portScrewX = portScrewRing/2*cos(45);
portScrewY = portScrewRing/2*sin(45);

//Terminal Hole Dimensions
terminalDiameter = 5.5;
terminalY = (height + 2*thickness)/2 - 50;
terminal1X =(backWidth + 2* thickness)/2 + 15;
terminal2X = (backWidth + 2*thickness)/2 -15;
difference(){
    difference(){
     union(){
    //Outside of the box dimension
    //Body of Speaker
    linear_extrude(height + 2* thickness)
        polygon(points = [[0,0],[frontWidth + 2* thickness,0], [(frontWidth + 2*thickness)/2 - (backWidth + 2*thickness)/2,outsideTrapezoidalLength], [(frontWidth + 2 * thickness)/2 + (backWidth + 2 * thickness)/2, outsideTrapezoidalLength]], paths= [[0,1,3,2]]);

        //Curved Sides
        //LeftSide
        rotate([0,0,-12.5])
        translate([-outerHeightOfCurve, -outerRadiusOfCurve + outsideChordLength/2 + 2.5, 0])
        linear_extrude(height + 2 * thickness)
        difference(){
        translate([outerRadiusOfCurve, outerRadiusOfCurve, 0])
        circle(outerRadiusOfCurve);
        translate([outerHeightOfCurve, 0, 0])
        square(outerRadiusOfCurve*2);
        };

        //Right Side
        translate([frontWidth + 2 * thickness,0,0])
        mirror([1,0,0])
        rotate([0,0,-12.5])
        translate([-outerHeightOfCurve, -outerRadiusOfCurve + outsideChordLength/2 + 2.5, 0])
        linear_extrude(height + 2 * thickness)
        difference(){
        translate([outerRadiusOfCurve, outerRadiusOfCurve, 0])
        circle(outerRadiusOfCurve);
        translate([outerHeightOfCurve, 0, 0])
        square(outerRadiusOfCurve*2);
        };
    };
        //Woofer hole cut out
        translate([wooferX, wooferThickness, wooferY])
        rotate([90, 0, 0])
        linear_extrude(thickness * 1.01)
        circle(d=wooferDiameter);
        //Woofer Inner Diameter
        translate([wooferX, wooferThickness + thickness, wooferY])
        rotate([90,0,0])
        linear_extrude(thickness)
        circle(d=wooferInnerDiameter);
        //Woofer Screws
        translate([wooferX + wooferScrewX, thickness * 1.01, wooferY + wooferScrewY])
        rotate([90,0,0])
        linear_extrude(thickness * 1.01)
        circle(d=wooferScrewDiameter);
        
        translate([wooferX + wooferScrewX, thickness * 1.01, wooferY - wooferScrewY])
        rotate([90,0,0])
        linear_extrude(thickness* 1.01)
        circle(d=wooferScrewDiameter);

        translate([wooferX - wooferScrewX, thickness * 1.01, wooferY + wooferScrewY])
        rotate([90,0,0])
        linear_extrude(thickness* 1.01)
        circle(d=wooferScrewDiameter);

        translate([wooferX - wooferScrewX, thickness* 1.01, wooferY - wooferScrewY])
        rotate([90,0,0])
        linear_extrude(thickness* 1.01)
        circle(d=wooferScrewDiameter);

        //Tweeter Outer hole cut out
        translate([tweeterX, tweeterThickness, tweeterY])
        rotate([90, 0, 0])
        linear_extrude(tweeterThickness)
        circle(d=tweeterOuterDiameter);
                
        //Tweeter Inner hole cut out
        translate([tweeterX, tweeterThickness + thickness, tweeterY])
        rotate([90, 0, 0 ])
        linear_extrude(thickness)
        circle(d=tweeterInnerDiameter);
        
    //Cleaning up from curves
    translate([0, outsideTrapezoidalLength,0])
    linear_extrude(height + 2 * thickness)
    square([frontWidth + 2 * thickness, thickness]);
    };
    
    //Port for back panel
    translate([(frontWidth + 2 * thickness)/2 - (backWidth + 2*thickness)/2 + portX, outsideTrapezoidalLength, portY])
    rotate([90,0,0])
    linear_extrude(thickness * 1.01)
    circle(d=portDiameter);
    //Port Screws
    translate([(frontWidth + 2 * thickness)/2 - (backWidth + 2*thickness)/2 + portX + portScrewX, outsideTrapezoidalLength, portY + portScrewY])
        rotate([90,0,0])
        linear_extrude(thickness * 1.01)
        circle(d=portScrewDiameter);
        
    translate([(frontWidth + 2 * thickness)/2 - (backWidth + 2*thickness)/2 + portX - portScrewX, outsideTrapezoidalLength, portY + portScrewY])
        rotate([90,0,0])
        linear_extrude(thickness* 1.01)
        circle(d=portScrewDiameter);

    translate([(frontWidth + 2 * thickness)/2 - (backWidth + 2*thickness)/2 + portX + portScrewX, outsideTrapezoidalLength, portY - portScrewY])
        rotate([90,0,0])
        linear_extrude(thickness* 1.01)
        circle(d=portScrewDiameter);

    translate([(frontWidth + 2 * thickness)/2 - (backWidth + 2*thickness)/2 + portX - portScrewX, outsideTrapezoidalLength, portY - portScrewY])
        rotate([90,0,0])
        linear_extrude(thickness* 1.01)
        circle(d=portScrewDiameter);

    //Terminal for back panel
    translate([(frontWidth + 2 * thickness)/2 - (backWidth + 2*thickness)/2 + terminal1X, outsideTrapezoidalLength, terminalY])
    rotate([90,0,0])
    linear_extrude(thickness * 1.01)
    circle(d=terminalDiameter);
    
    translate([(frontWidth + 2 * thickness)/2 - (backWidth + 2*thickness)/2 + terminal2X, outsideTrapezoidalLength, terminalY])
    rotate([90,0,0])
    linear_extrude(thickness * 1.01)
    circle(d=terminalDiameter);

    //Inside of the box dimension
    translate([thickness, thickness, thickness])
    union(){
        //Body of Speaker
        linear_extrude(height)
        polygon(points = [[0,0],[frontWidth,0], [frontWidth/2 - backWidth/2,trapezoidalLength], [frontWidth/2 +backWidth/2, trapezoidalLength]], paths= [[0,1,3,2]]);

        //Curved Sides
        //LeftSide
        rotate([0,0,-12.5])
        translate([-heightOfCurve, -radiusOfCurve + chordLength/2, 0])
        linear_extrude(height)
        difference(){
        translate([radiusOfCurve, radiusOfCurve, 0])
        circle(radiusOfCurve);
        translate([heightOfCurve, 0, 0])
        square(radiusOfCurve*2);
        };

        //Right Side
        translate([frontWidth,0,0])
        mirror([1,0,0])
        rotate([0,0,-12.5])
        translate([-heightOfCurve, -radiusOfCurve + chordLength/2, 0])
        linear_extrude(height)
        difference(){
        translate([radiusOfCurve, radiusOfCurve, 0])
        circle(radiusOfCurve);
        translate([heightOfCurve, 0, 0])
        square(radiusOfCurve*2);
        };
    };
};