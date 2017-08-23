///gmsugar_test_iap();
{
var expected, got, product;
// Simple list
expected = Array2(3, 4,
  "ID1", "Product 1", "This is a silly product.", "$0.99",
  "ID2", "Product 2", "This is a ludicrous product.", "$1.99",
  "ID3", "Product 3", "This is a ridiculous product.", "$2.99",
);
got = IapList(
  IapConsumable("ID1", "Product 1", "This is a silly product.", "$0.99"),
  IapProduct("ID2", "Product 2", "This is a ludicrous product.", "$1.99"),
  IapProduct("ID3", "Product 3", "This is a ridiculous product.", "$2.99")
);
assert_equal(ds_list_size(got), array_height_2d(expected), "Simple IAP list has wrong size!");
for (var i = 0; i < array_height_2d(expected); i++) {
  product = got[| i];
  assert_equal(product[? "id"], expected[i, 0], "Simple IAP list product " + string(i) + " has wrong ID!");
  assert_equal(product[? "title"], expected[i, 1], "Simple IAP list product " + string(i) + " has wrong title!");
  assert_equal(product[? "description"], expected[i, 2], "Simple IAP list product " + string(i) + " has wrong description!");
  assert_equal(product[? "price"], expected[i, 3], "Simple IAP list product " + string(i) + " has wrong price!");
}
ds_list_destroy(got);
if (os_browser != browser_not_a_browser) {
  assert_fail(ds_exists(product, ds_type_map), "Simple IAP list has leaky products!");
}
}
