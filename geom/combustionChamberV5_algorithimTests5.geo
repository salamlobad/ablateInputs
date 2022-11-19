// Gmsh project created on Tue Sep 06 00:35:01 2022
SetFactory("OpenCASCADE");
//+
Merge "CombustionChamberV5.stp";
//+
Physical Volume("combustionChamber", 31) = {1};
//+
Physical Surface("inlet", 32) = {13};
//+
Physical Surface("chamberWalls", 33) = {3, 12, 1, 11, 5, 7, 2, 6};
//+
Physical Surface("fuelGrain", 34) = {4, 8, 9, 10};
//+
Physical Surface("outlet", 35) = {14};
//+
Transfinite Surface {9};
//+
Transfinite Surface {4};
//+
Transfinite Curve {18, 16} = 160 Using Progression 1;
//+
Transfinite Curve {25, 23, 19, 21, 21} = 20 Using Progression 1;
//+
Transfinite Curve {20, 22} = 12 Using Progression 1;
//+
Transfinite Curve {8, 24} = 40 Using Progression 1;
//+
Transfinite Curve {7, 9} = 60 Using Progression 1;
//+
Transfinite Curve {17, 27, 26, 15} = 32 Using Progression 1;
//+
Transfinite Curve {3, 28, 21, 25} = 48 Using Progression 1;
//+
Transfinite Curve {6, 10, 23, 19} = 48 Using Progression 1;
//+
Transfinite Curve {2, 4} = 20 Using Progression 1;
//+
Transfinite Curve {30, 13} = 14 Using Progression 1;
//+
Transfinite Curve {1, 29, 5, 11} = 8 Using Progression 1;
