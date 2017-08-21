///gmsugar_test_ds()
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

// Map constructor
expected = ds_map_create();
expected[? "waahoo"] = "woohah";
expected[? "active"] = true;
expected[? "blob"] = 583;
got = Map(
  "waahoo", "woohah",
  "active", true,
  "blob", 583
);
assert_equal(ds_map_size(got), ds_map_size(expected), "Map constructor has different number of entries!");
for (var k = ds_map_find_first(expected); !is_undefined(k); k = ds_map_find_next(expected, k)) {
  assert_equal(got[? k], expected[? k], "Map constructor had wrong content!");
}
ds_map_destroy(expected);
ds_map_destroy(got);

// List constructor
expected = ds_list_create();
ds_list_add(expected, 57, "waahoo", undefined, true);
got = List(57, "waahoo", undefined, true);
assert_equal(ds_list_size(got), ds_list_size(expected), "List constructor has different number of entries!");
for (var i = 0; i < ds_list_size(expected); i++) {
  assert_equal(got[| i], expected[| i], "List constructor had wrong content!");
}
ds_list_destroy(expected);
ds_list_destroy(got);

// Grid constructor
expected = ds_grid_create(3, 2);
expected[# 0, 0] = 82;
expected[# 1, 0] = true;
expected[# 2, 0] = 99;
expected[# 0, 1] = undefined;
expected[# 1, 1] = "woohah";
expected[# 2, 1] = "ultrawaahoo";
got = Grid(3, 2,
  82, true, 99,
  undefined, "woohah", "ultrawaahoo"
);
assert_equal(ds_grid_width(got), ds_grid_width(expected), "Grid constructor has different width!");
assert_equal(ds_grid_height(got), ds_grid_height(expected), "Grid constructor has different height!");
for (var i = 0; i < ds_grid_width(expected); i++) {
  for (var j = 0; j < ds_grid_height(expected); j++) {
    assert_equal(got[# i, j], expected[# i, j], "Grid constructor had wrong content!");
  }
}
ds_grid_destroy(expected);
ds_grid_destroy(got);

// Stack constructor
data = Stack(
  5, 
  6, 
  7, 
  8
);
expected = undefined;
expected[0] = 5;
expected[1] = 6;
expected[2] = 7;
expected[3] = 8;
assert_equal(ds_stack_size(data), 4, "Stack constructor has different size!");
for (var i = 0; i < 4; i++) {
  got = ds_stack_pop(data);
  assert_equal(got, expected[i], "Stack pops out the wrong content!");
}
ds_stack_destroy(data);

// Queue constructor
data = Queue("Alice", "Bob", "Caitlyn", "David");
expected = undefined;
expected[0] = "Alice";
expected[1] = "Bob";
expected[2] = "Caitlyn";
expected[3] = "David";
assert_equal(ds_queue_size(data), 4, "Queue constructor has different size!");
for (var i = 0; i < 4; i++) {
  got = ds_queue_dequeue(data);
  assert_equal(got, expected[i], "Queue pops out the wrong content!");
}
ds_queue_destroy(data);

// Priority Queue constructor
data = PriorityQueue(
  "Alice", 583,
  "Bob", 907,
  "Caitlyn", 371,
  "David", 815
);
assert_equal(ds_priority_size(data), 4, "Priority Queue constructor has different size!");
assert_equal(ds_priority_find_priority(data, "Alice"), 583, "Priority Queue constructor gives wrong priority! (1)");
assert_equal(ds_priority_find_priority(data, "Bob"), 907, "Priority Queue constructor gives wrong priority! (2)");
assert_equal(ds_priority_find_priority(data, "Caitlyn"), 371, "Priority Queue constructor gives wrong priority! (3)");
assert_equal(ds_priority_find_priority(data, "David"), 815, "Priority Queue constructor gives wrong priority! (4)");
expected = undefined;
expected[0] = "Caitlyn";
expected[1] = "Alice";
expected[2] = "David";
expected[3] = "Bob";
for (var i = 0; i < 4; i++) {
  got = ds_priority_delete_min(data);
  assert_equal(got, expected[i], "Priority Queue pops out unexpected content!");
}
ds_priority_destroy(data);
}

