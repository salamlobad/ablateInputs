// Gmsh project created on Tue Jul 19 11:12:16 2022
SetFactory("OpenCASCADE");
//+
Rectangle(1) = {0, 0, 0, 1, 0.25, 0};
//+
Transfinite Curve {3, 1} = 4 Using Progression 1;
//+
Transfinite Curve {4, 2} = 2 Using Progression 1;
