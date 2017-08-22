///gmsugar_test_arrays()
{
var expected, got, data;
  
// Array constructor
expected = undefined;
expected[0] = 57;
expected[1] = "waahoo";
expected[2] = undefined;
expected[3] = true;
got = Array(57, "waahoo", undefined, true);
assert_equal(got, expected, "Array constructor failed!");

// Array2 constructor
expected = undefined;
expected[0, 0] = 82;
expected[0, 1] = undefined;
expected[0, 2] = true;
expected[1, 0] = "woohah";
expected[1, 1] = 99;
expected[1, 2] = "ultrawaahoo";
got = Array2(2, 3,
  82, undefined, true,
  "woohah", 99, "ultrawaahoo"
);
assert_equal(got, expected, "Array2 constructor failed!");
assert_equal(array_height_2d(got), 2, "Array2 constructor has wrong height!");
assert_equal(array_length_2d(got, 0), 3, "Array2 constructor has the wrong length!");

// Lattice constructor
expected = undefined;
expected[0, 0] = 82;
expected[1, 0] = "woohah";
expected[0, 1] = undefined;
expected[1, 1] = 99;
expected[0, 2] = true;
expected[1, 2] = "ultrawaahoo";
got = Lattice(2, 3,
  82, "woohah",
  undefined, 99,
  true, "ultrawaahoo"
);
assert_equal(got, expected, "Lattice constructor failed!");
assert_equal(array_height_2d(got), 2, "Lattice constructor has wrong height!");
assert_equal(array_length_2d(got, 0), 3, "Lattice constructor has the wrong length!");
assert_equal(lattice_width(got), 2, "Lattice width helper has wrong width!");
assert_equal(lattice_height(got), 3, "Lattice height helper has wrong height!");

// OpenGL matrix
expected = undefined;
expected = Array(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
got = OpenGlMatrix(
   1,  5,  9, 13,
   2,  6, 10, 14,
   3,  7, 11, 15,
   4,  8, 12, 16
);
assert_equal(got, expected, "OpenGL matrix doesn't match!");
}

