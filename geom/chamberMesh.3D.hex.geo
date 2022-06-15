// wax points
Point(1) = {0.025, 0, 0.00381, 1.0};
Point(2) = {0.025, 0, -0.00381, 1.0};
Point(3) = {.036501, .01146, -0.00381, 1.0};
Point(4) = {.036501, .01146, 0.00381, 1.0};
Point(5) = {.105, .01146, 0.00381, 1.0};
Point(6) = {.105, .01146, -0.00381, 1.0};
Point(7) = {.105, 0.0, -0.00381, 1.0};
Point(8) = {.105, 0.0, 0.00381, 1.0};
// outside boundary 
Point(9) = {0, 0, .0127, 1.0};
Point(10) = {0, .0276, .0127, 1.0};
Point(11) = {.165, .0276, .0127, 1.0};
Point(12) = {.165, 0, .0127, 1.0};
Point(13) = {0, 0, -.0127, 1.0};
Point(14) = {0, .0276, -.0127, 1.0};
Point(15) = {.165, .0276, -.0127, 1.0};
Point(16) = {.165, 0, -.0127, 1.0};//+
Line(1) = {1, 4};
//+
Line(2) = {4, 3};
//+
Line(3) = {3, 2};
//+
Line(4) = {2, 1};
//+
Line(5) = {1, 8};
//+
Line(6) = {8, 5};
//+
Line(7) = {5, 4};
//+
Line(8) = {3, 6};
//+
Line(9) = {6, 5};
//+
Line(10) = {7, 8};
//+
Line(11) = {6, 7};
//+
Line(12) = {7, 2};
//+
Line(13) = {9, 13};
//+
Line(14) = {13, 14};
//+
Line(15) = {14, 10};
//+
Line(16) = {10, 9};
//+
Line(17) = {9, 12};
//+
Line(18) = {12, 11};
//+
Line(19) = {11, 10};
//+
Line(20) = {14, 15};
//+
Line(21) = {15, 16};
//+
Line(22) = {16, 12};
//+
Line(23) = {11, 15};
//+
Line(24) = {16, 13};
//+
Curve Loop(1) = {15, -19, 23, -20};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {16, 13, 14, 15}; 
//+
Plane Surface(2) = {2};
//+
Curve Loop(3) = {18, 23, 21, 22};
//+
Plane Surface(3) = {3};
//+
Curve Loop(4) = {24, 14, 20, 21};
//+
Plane Surface(4) = {4};
//+
Curve Loop(5) = {13, -24, 22, -17};
//+
Curve Loop(6) = {5, -10, 12, 4};
//+
Plane Surface(5) = {5, 6};
//+
Curve Loop(7) = {1, -7, -6, -5};
//+
Plane Surface(6) = {7};
//+
Curve Loop(8) = {6, -9, 11, 10};
//+
Plane Surface(7) = {8};
//+
Curve Loop(9) = {7, 2, 8, 9};
//+
Plane Surface(8) = {9};
//+
Curve Loop(10) = {12, -3, 8, 11};
//+
Plane Surface(9) = {10};
//+
Curve Loop(11) = {3, 4, 1, 2};
//+
Plane Surface(10) = {11};
//+
Curve Loop(12) = {16, 17, 18, 19};
//+
Plane Surface(11) = {12};
//+
Surface Loop(1) = {1, 2, 11, 5, 4, 3, 10, 9, 8, 6, 7};
//+
Volume(1) = {1};
//+
Physical Volume("flowVolume", 25) = {1};
//+
Physical Surface("inlet", 26) = {2};
//+
Physical Surface("outlet", 27) = {3};
//+
Physical Surface("slabBlow", 28) = {10};
//+
Physical Surface("wall", 29) = {11, 1, 4, 5};
//+
Physical Surface("waxWall", 30) = {6, 8, 7, 9};
