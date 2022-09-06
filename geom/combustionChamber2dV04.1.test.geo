// Gmsh project created on Thu Aug 04 09:31:56 2022
SetFactory("OpenCASCADE");
//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0, -0.075, 0, 1.0};
//+
Point(3) = {0.015, -0.075, 0, 1.0};
//+
Point(4) = {0.045, -0.15, 0, 1.0};
//+
Point(5) = {0.08, -0.18, 0, 1.0};
//+
Point(6) = {0.08, -0.1375, 0, 1.0};
//+
Point(7) = {1.86, -0.1375, 0, 1.0};
//+
Point(8) = {1.86, -0.19, 0, 1.0};
//+
Point(9) = {1.97, -0.19, 0, 1.0};
//+
Point(10) = {2.04, -0.07, 0, 1.0};
//+
Point(11) = {2.105, -0.13, 0, 1.0};
//+
Point(12) = {2.105, 0, 0, 1.0};
//+
Point(13) = {1.86, 0, 0, 1.0};
//+
Point(14) = {0.08, 0, 0, 1.0};
//+
Line(1) = {1, 2};
//+
Line(2) = {2, 3};
//+
Spline(3) = {3, 4, 5};
//+
Line(4) = {5, 6};
//+
Line(5) = {6, 7};
//+
Line(6) = {7, 8};
//+
Line(7) = {8, 9};
//+
Spline(8) = {9, 10, 11};
//+
Line(9) = {11, 12};
//+
Line(10) = {12, 13};
//+
Line(11) = {13, 14};
//+
Line(12) = {14, 1};
//+
Physical Curve("inlet", 16) = {1};
//+
Physical Curve("fuelGrain", 17) = {4, 5, 6};
//+
Physical Curve("outlet", 18) = {9};
//+
Physical Curve("chamberWalls", 19) = {2, 3, 7, 8};
//+
//+
Curve Loop(1) = {11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
//+
Plane Surface(1) = {1};
//+
Transfinite Curve {11} = 10 Using Progression 1;
