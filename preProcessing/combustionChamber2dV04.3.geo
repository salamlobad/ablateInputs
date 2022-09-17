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
Point(15) = {0.08, -0.075, 0, 1.0};
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
Line(13) = {7, 13};
//+
Line(14) = {6, 15};
//+
Line(15) = {14, 15};
//+
Line(16) = {3, 15};
//+
Curve Loop(1) = {12, 1, 2, 16, -15};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {3, 4, 14, -16};
//+
Plane Surface(2) = {2};
//+
Curve Loop(3) = {11, 15, -14, 5, 13};
//+
Plane Surface(3) = {3};
//+
Curve Loop(4) = {10, -13, 6, 7, 8, 9};
//+
Plane Surface(4) = {4};
//+
Transfinite Surface {3} = {14, 6, 7, 13};
//+
Transfinite Surface {1} = {1, 2, 15, 14};
//+
Transfinite Curve {14, 13} = 6 Using Progression 1;
//+
Transfinite Curve {5, 11} = 65 Using Progression 1;
//+
Transfinite Curve {3} = 9 Using Progression 1;
//+
Transfinite Curve {1, 12} = 5 Using Progression 1;
//+
Transfinite Curve {10} = 9 Using Progression 1;
//+
Transfinite Curve {8} = 9 Using Progression 1;
//+
Transfinite Curve {7} = 5 Using Progression 1;
//+
Transfinite Curve {9} = 5 Using Progression 1;
//+
Transfinite Curve {4} = 4 Using Progression 1;
