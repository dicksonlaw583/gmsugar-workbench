///gmsugar_test_json()
{
var expected, got, row, subentries;

// Simple map
got = JsonData(
  JsonMap(
    "abc", 9,
    "def", "foobar"
  )
);
assert_equal(ds_map_size(got), 2, "Simple map has wrong size!");
assert_equal(got[? "abc"], 9, "Simple map has wrong content 0!");
assert_equal(got[? "def"], "foobar", "Simple map has wrong content 1!");
ds_map_destroy(got);

// Simple list
got = JsonData(
  JsonList("abc", 9, undefined, "waahoo")
);
assert_equal(ds_list_size(got), 4, "Simple list has wrong size!");
assert_equal(got[| 0], "abc", "Simple list has wrong content 0!");
assert_equal(got[| 1], 9, "Simple list has wrong content 1!");
assert_equal(got[| 2], undefined, "Simple list has wrong content 2!");
assert_equal(got[| 3], "waahoo", "Simple list has wrong content 3!");
ds_list_destroy(got);

// Simple 1D array
got = JsonData(
  JsonArray(Array("abc", 9, undefined, "waahoo"))
);
assert_equal(ds_list_size(got), 4, "Simple list from array has wrong size!");
assert_equal(got[| 0], "abc", "Simple list from array has wrong content 0!");
assert_equal(got[| 1], 9, "Simple list from array has wrong content 1!");
assert_equal(got[| 2], undefined, "Simple list from array has wrong content 2!");
assert_equal(got[| 3], "waahoo", "Simple list from array has wrong content 3!");
ds_list_destroy(got);

// Simple 2D array
expected = Array2(2, 3,
  "abc", 9, undefined,
  583, "waahoo", "foobar"
);
got = JsonData(
  JsonArray(expected)
);
assert_equal(ds_list_size(got), 2, "Simple list from 2D array has wrong top size!");
assert_equal(ds_list_size(got[| 0]), 3, "Simple list from 2D array has wrong subsize 0!");
assert_equal(ds_list_size(got[| 1]), 3, "Simple list from 2D array has wrong subsize 1!");
for (var i = 0; i < array_height_2d(expected); i++) {
  row = got[| i];
  for (var j = 0; j < array_length_2d(expected, i); j++) {
    assert_equal(row[| j], expected[i, j], "Simple list from 2D array has wrong content at " + string(i) + "," + string(j) + "!");
  }
}
ds_list_destroy(got);
if (os_browser == browser_not_a_browser) {
  assert_fail(ds_exists(row, ds_type_list), "Simple list from 2D array has leaky sub-lists!");
}

// Nested mashup
got = JsonData(
  JsonMap(
    "abc", JsonList(5, "ab", undefined),
    "bcd", JsonArray(Array(99, "bc")),
    "cde", JsonArray(Array2(2, 2, 0, 1, 2, 3))
  )
);
row = got[? "abc"];
subentries[0] = row;
assert_equal(ds_list_size(row), 3, "Nested mashup has wrong abc size!");
assert_equal(row[| 0], 5, "Nested mashup missing abc content!");
assert_equal(row[| 1], "ab", "Nested mashup missing abc content!");
assert_equal(row[| 2], undefined, "Nested mashup missing abc content!");
row = got[? "bcd"];
subentries[1] = row;
assert_equal(ds_list_size(row), 2, "Nested mashup has wrong bcd size!");
assert_equal(row[| 0], 99, "Nested mashup missing bcd content!");
assert_equal(row[| 1], "bc", "Nested mashup missing bcd content!");
row = got[? "cde"];
row = row[| 0];
subentries[2] = row;
assert_equal(ds_list_size(row), 2, "Nested mashup has wrong cde,0 size!");
assert_equal(row[| 0], 0, "Nested mashup missing cde,0 content!");
assert_equal(row[| 1], 1, "Nested mashup missing cde,0 content!");
row = got[? "cde"];
row = row[| 1];
subentries[3] = row;
assert_equal(ds_list_size(row), 2, "Nested mashup has wrong cde,1 size!");
assert_equal(row[| 0], 2, "Nested mashup missing cde,1 content!");
assert_equal(row[| 1], 3, "Nested mashup missing cde,1 content!");
ds_map_destroy(got);
if (os_browser == browser_not_a_browser) {
  for (var i = 0; i < array_length_1d(subentries); i++) {
    assert_fail(ds_exists(subentries[i], ds_type_list), "Nested mashup has leaky content!");
  }
}
}

