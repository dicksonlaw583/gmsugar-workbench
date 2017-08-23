///gmsugar_test_dates()
{
var expected, got, original_timezone;
original_timezone = date_get_timezone();

// Test Date()
expected = date_current_datetime();
got = Date();
assert_equalish(got, expected, "Date() failed!");

// Test Date("")
expected = date_current_datetime();
date_set_timezone(timezone_utc);
got = Date("");
assert_equalish(got, expected, "Date('') failed!");
assert_equal(date_get_timezone(), timezone_utc, "Date('') changed timezone!");
date_set_timezone(timezone_local);

// Test Date("timezone")
date_set_timezone(timezone_utc);
expected = date_inc_hour(date_current_datetime(), 9);
date_set_timezone(timezone_local);
got = Date("KST");
assert_equalish(got, expected, "Date(KST) failed!");
assert_equal(date_get_timezone(), timezone_local, "Date(KST) changed timezone!");

// Test Date("timezone", offset)
date_set_timezone(timezone_utc);
expected = date_inc_hour(date_current_datetime(), 9);
date_set_timezone(timezone_local);
got = Date("UTC", 9);
assert_equalish(got, expected, "Date(UTC, 9) failed!");
assert_equal(date_get_timezone(), timezone_local, "Date(UTC, 9) changed timezone!");

// Test Date(y, m, d)
expected = date_create_datetime(2017, 08, 22, 0, 0, 0);
got = Date(2017, 08, 22);
assert_equalish(got, expected, "Date(2017, 08, 22) failed!");

// Test Date(Y, M, D, h, m, s)
expected = date_create_datetime(2017, 08, 22, 07, 44, 52);
got = Date(2017, 08, 22, 07, 44, 52);
assert_equalish(got, expected, "Date(2017, 08, 22, 07, 44, 52) failed!");

// Revert
date_set_timezone(original_timezone);
}
