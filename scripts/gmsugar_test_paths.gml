///gmsugar_test_paths()
{
var expected, got;

// Plain paths
expected = Array2(4, 2,
  0, 0,
  100, 0,
  100, 100,
  50, 150,
);
got = Path(
  0, 0,
  100, 0,
  100, 100,
  50, 150,
);
assert_fail(path_get_closed(got), "Plain path got closed!");
for (var i = 0; i < array_height_2d(expected); i++) {
  assert_equal(path_get_point_x(got, i), expected[i, 0], "Plain path point " + string(i) + " x is wrong!");
  assert_equal(path_get_point_y(got, i), expected[i, 1], "Plain path point " + string(i) + " y is wrong!");
  assert_equal(path_get_point_speed(got, i), 100, "Plain path point " + string(i) + " speed is wrong!");
}
path_delete(got);

// Speed paths
expected = Array2(9, 3,
  0, 0, 100,
  10, 20, 50,
  20, 10, 100,
  20, 20, 100,
  30, 40, 50,
  40, 30, 50,
  55, 66, 25,
  70, 80, 50,
  80, 70, 50
);
got = Path(
  0, 0,
  "speed_point", 50,
    10, 20,
  20, 10,
  20, 20,
  "speed", 50,
    30, 40,
    40, 30,
    "speed_point", 25,
      55, 66,
    70, 80,
    80, 70
);
assert_fail(path_get_closed(got), "Speed path got closed!");
for (var i = 0; i < array_height_2d(expected); i++) {
  assert_equal(path_get_point_x(got, i), expected[i, 0], "Speed path point " + string(i) + " x is wrong!");
  assert_equal(path_get_point_y(got, i), expected[i, 1], "Speed path point " + string(i) + " y is wrong!");
  assert_equal(path_get_point_speed(got, i), expected[i, 2], "Speed path point " + string(i) + " speed is wrong!");
}
path_delete(got);

// Polygon paths
expected = Array2(4, 2,
  0, 0,
  100, 0,
  100, 100,
  50, 150,
);
got = Path(
  "closed", true,
  0, 0,
  100, 0,
  100, 100,
  50, 150,
);
assert(path_get_closed(got), "Polygon path got opened!");
for (var i = 0; i < array_height_2d(expected); i++) {
  assert_equal(path_get_point_x(got, i), expected[i, 0], "Polygon path point " + string(i) + " x is wrong!");
  assert_equal(path_get_point_y(got, i), expected[i, 1], "Polygon path point " + string(i) + " y is wrong!");
  assert_equal(path_get_point_speed(got, i), 100, "Polygon path point " + string(i) + " speed is wrong!");
}
path_delete(got);

// Curve paths
expected = Array2(7, 2,
  0, 200,
  50, 100,
  100, 200,
  100, 200,
  100, 200,
  150, 100,
  200, 0,
);
got = CurvePath(
  0, 200,
  50, 100,
  "absolute_point", true,
    100, 200,
  150, 100,
  200, 0,
);
assert_fail(path_get_closed(got), "Curve path got closed!");
for (var i = 0; i < array_height_2d(expected); i++) {
  assert_equal(path_get_point_x(got, i), expected[i, 0], "Curve path point " + string(i) + " x is wrong!");
  assert_equal(path_get_point_y(got, i), expected[i, 1], "Curve path point " + string(i) + " y is wrong!");
  assert_equal(path_get_point_speed(got, i), 100, "Curve path point " + string(i) + " speed is wrong!");
}
assert_equalish(path_get_x(got, 0.5), 100, "Curve path absolute point not included!");
assert_equalish(path_get_y(got, 0.5), 200, "Curve path absolute point not included!");

path_delete(got);

// Blob paths
expected = Array2(10, 3,
  0, 200, 100,
  50, 100, 50,
  100, 200, 100,
  100, 200, 100,
  100, 200, 100,
  150, 100, 50,
  200, 0, 50,
  175, 400, 25,
  100, 400, 50,
  25, 400, 100
);
got = CurvePath(
  0, 200,
  "speed_point", 50,
    50, 100,
  "absolute_point", true,
    100, 200,
  "speed", 50,
    150, 100,
    200, 0,
    "speed_point", 25,
      175, 400,
    100, 400,
  "speed", 100,
  25, 400
);
assert_fail(path_get_closed(got), "Blob path got closed!");
for (var i = 0; i < array_height_2d(expected); i++) {
  assert_equal(path_get_point_x(got, i), expected[i, 0], "Blob path point " + string(i) + " x is wrong!");
  assert_equal(path_get_point_y(got, i), expected[i, 1], "Blob path point " + string(i) + " y is wrong!");
  assert_equal(path_get_point_speed(got, i), expected[i, 2], "Blob path point " + string(i) + " speed is wrong!");
}
path_delete(got);
}
