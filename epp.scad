// Create 8 Point Polyhedron given vertices and hypoteneuse lengths. This is mostly useful
// in reproducing physical things that are shaped like a box or a skewed box, Just measure the item 
// and plug in the values as shown. We assume that corner a is sitting at 0,0,0  but this can be tranformed to anywhere on the
// plane


//base polygon a is 0,0,0 and b is along y axis while c and d are anywhere in the x,y plane
// a --- b
//  \     \
//   d --- c
//back polygon has bottom along y axis
// e --- f
//  \     \
//   a --- b
//front polygon
// h --- g
//  \     \
//   d --- c
//left polygon
// e --- h
//  \     \
//   a --- d
//right polygon
// g --- f
//  \     \
//   c --- b
//top polygon
// e --- f
//  \     \
//   h --- g

a_b = 50;
a_d = 60;
a_h = 110;
a_e = 100;
a_f = 110;

b_c = 70;
b_d = 75;
b_e = 80;
b_f = 110;
b_g = 110;

c_a = 60;
c_g = 100;

//c_d = 30;
d_a = 45;
d_h = 110;

e_f = 50;
f_g = 60;
g_h = 70;
h_f = 70;

//a_f =
//for simplicity the base polygon is sitting on the z origin with corner a at 0,0,0
pt_a = [0, 0, 0];
pt_b = [0,a_b, 0]; 

//now we know that c is heightOfTriangle away from our base a_b 
//and with height of triangle and the length of c we can easily figure out the missing side of
//90 degree triangle along x axis
c_height = heightOfTriangle(a_b, b_c, c_a, a_b);
pt_c = [ c_height, pythagForBase(b_c, c_height), 0 ];

d_height = heightOfTriangle(a_b, b_d, d_a , a_b);
pt_d = [ d_height, pythagForBase(d_a, d_height), 0 ];
 
e_height = heightOfTriangle(a_b, b_e, a_e, a_b);
pt_e = [0, pythagForBase(b_e, e_height), e_height];

f_height = heightOfTriangle(a_b, a_f,b_f, a_b);
pt_f = [0, pythagForBase(a_f, f_height), f_height];

g_height = heightOfTriangle(b_g, b_c, c_g, b_c);
pt_g = [pt_c[0], pythagForBase(b_g, g_height) , g_height];

h_height = heightOfTriangle(a_d, d_h, a_h, a_d);
pt_h = [pt_d[0], pythagForBase(a_h, h_height), h_height];

//point vector for polyhedron function
points_for_eight_point_poly = [pt_a, pt_b, pt_c, pt_d, pt_e, pt_f, pt_g, pt_h];
polyhedron( 
  points    = points_for_eight_point_poly, 
  triangles = trianglesForEightPointPoly()
);

//this is a default set of triangles to create a basic 8 point polygon;
//parameters a to h are defined for convienience and should not need to be overidden
//TOOD: function local variables? ftw
function trianglesForEightPointPoly(a=0,b=1,c=2,d=3,e=4,f=5,g=6,h=7) = ([
    [a,c,b], [c,a,d], //bottom
    [b,f,e], [b,e,a], //back
    [c,d,h], [c,h,g], //front 
    [b,c,f], [g,f,c], //left
    [a,h,d], [a,e,h], //right
    [e,f,g], [e,g,h]  //top 
]);

// We can just use standard formula for area of triangle
// A = b/2 * H and solve for H
// 2A/b = H
function heightOfTriangle(x,y,z,b) = (2 * areaOfTriangleGivenSides(x,y,z)) / b; 

//calculate the area of the triangle given the sides (herons formula)
// A = 1/4 * Sqrt( a^2 + b^2 + c^2 - 2(a^4 + b^4 + c^4)
function areaOfTriangleGivenSides(x,y,z) =  (1/4) * sqrt( pow(poweredSum(x,y,z,2),2) - (2 * poweredSum(x,y,z,4))  );

//Sum three points, each raised to the given power before sum
function poweredSum(x,y,z,p) = pow(x,p) + pow(y,p) + pow(z,p);

//now we just need good old pythagoras to help us out 
// a^2 + b^2 = c^2
// but we are not missing c we are missing a
// a = sqrt( c^2 - b^2)  
function pythagForBase(hyp,height) = sqrt(pow(hyp,2) - pow(height,2)) ;

