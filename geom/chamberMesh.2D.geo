//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {0.025, 0, 0, 1.0};
//+
Point(3) = {.105, 0, 0, 1.0};
//+
Point(4) = {.165, 0, 0, 1.0};
//+
Point(5) = {.165, .0276, 0, 1.0};
//+
Point(6) = {0, .0276, 0, 1.0};
//+
Point(7) = {.036501, .01146, 0, 1.0};
//+
Point(8) = {.105, .01146, 0, 1.0};
//+
Line(1) = {2, 7};
//+
Line(2) = {7, 8};
//+
Line(3) = {8, 3};
//+
Line(4) = {3, 4};
//+
Line(5) = {4, 5};
//+
Line(6) = {5, 6};
//+
Line(7) = {6, 1};
//+
Line(8) = {1, 2};
//+
Curve Loop(1) = {2, 3, 4, 5, 6, 7, 8, 1};
//+
Plane Surface(1) = {1};
//+
Physical Curve("inlet", 9) = {7};
//+
Physical Curve("outlet", 10) = {5};
//+
Physical Curve("wall", 11) = {8};
//+
Physical Curve(" wall", 11) -= {8, 4};
//+
Physical Curve("wall", 12) = {8, 4, 6};
//+
Physical Curve("slab-fronte", 13) = {1};
//+
Physical Curve(" slab-fronte", 13) -= {1};
//+
Physical Curve("slab-front", 14) = {1};
//+
Physical Curve("slab-top", 15) = {2};
//+
Physical Curve("slab-back", 16) = {3};
//+
Physical Surface("burner", 17) = {1};
