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
Transfinite Curve {18, 16} = 20 Using Progression 1;//+
Transfinite Curve {3, 28} = 10 Using Progression 1;
