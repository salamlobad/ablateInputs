//+
Point(1) = {-.5, -.5, -.5, 1.0};
//+
Point(2) = {.5, -.5, -.5, 1.0};
//+
Point(3) = {.5, .5, -.5, 1.0};
//+
Point(4) = {-.5, .5, -.5, 1.0};
//+
Point(5) = {-.5, -.5, .5, 1.0};
//+
Point(6) = {.5, -.5, .5, 1.0};
//+
Point(7) = {.5, .5, .5, 1.0};
//+
Point(8) = {-.5, .5, .5, 1.0};
//+
Line(1) = {3, 4};
//+
Line(2) = {4, 1};
//+
Line(3) = {1, 2};
//+
Line(4) = {2, 3};
//+
Line(5) = {3, 7};
//+
Line(6) = {7, 6};
//+
Line(7) = {6, 2};
//+
Line(8) = {8, 7};
//+
Line(9) = {8, 4};
//+
Line(10) = {5, 5};
//+
Line(11) = {1, 5};
//+
Line(12) = {5, 8};
//+
Line(13) = {5, 6};
//+
Curve Loop(1) = {1, 2, 3, 4};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {2, 11, 12, 9};
//+
Plane Surface(2) = {2};
//+
Curve Loop(3) = {13, -6, -8, -12};
//+
Plane Surface(3) = {3};
//+
Curve Loop(4) = {5, 6, 7, 4};
//+
Plane Surface(4) = {4};
//+
Curve Loop(5) = {7, -3, 11, 13};
//+
Plane Surface(5) = {5};
//+
Curve Loop(6) = {8, -5, 1, -9};
//+
Plane Surface(6) = {6};
//+
Surface Loop(1) = {1, 6, 3, 5, 4, 2};
//+
Volume(1) = {1};
//+
Physical Surface("z-", 14) = {1, 2};
//+
Physical Surface("z+", 15) = {3};
//+
Physical Surface("x+", 16) = {4};
//+
Physical Surface("x-", 17) = {2};
//+
Physical Surface("y-", 18) = {5};
//+
Physical Surface("y+", 19) = {6};
//+
Physical Volume("vol", 20) = {1};
