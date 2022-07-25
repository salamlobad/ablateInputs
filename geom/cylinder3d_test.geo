// Gmsh project created on Mon Jul 18 12:18:44 2022
SetFactory("OpenCASCADE");
//+
Cylinder(1) = {0, 0, 0, 2.105, 0, 0, 0.25, 2*Pi};
//+
Surface Loop(2) = {3, 1, 2};
//+
Volume(2) = {2};
//+
Transfinite Curve {2} = 10 Using Progression 1;
