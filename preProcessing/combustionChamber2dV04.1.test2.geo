// Gmsh project created on Sun Sep 04 22:21:46 2022
SetFactory("OpenCASCADE");
//+
Merge "combustionChamber2dV04.1.test.msh";
//+
Physical Surface("combustionChamber", 515) = {501, 1, 2, 502, 503, 3};
//+
Physical Curve("inlet", 516) = {1, 501};
//+
Physical Curve("fuelGrain", 517) = {4, 5, 6, 504, 505, 506};
//+
Physical Curve("outlet", 518) = {9, 509};
//+
Physical Curve("chamberWalls", 519) = {2, 3, 7, 8, 502, 503, 507, 508};
