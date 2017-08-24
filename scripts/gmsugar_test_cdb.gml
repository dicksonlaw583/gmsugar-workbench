///gmsugar_test_cdb()
{
var expected, got, entry;

// Verify basic CDB format
got = ClientDataBank(0, network_socket_tcp);
assert(ds_exists(got[0], ds_type_list), "Basic CDB format failed!");
assert(ds_exists(got[1], ds_type_map), "Basic CDB format failed!");
assert(ds_exists(got[2], ds_type_map), "Basic CDB format failed!");
assert(is_real(got[3]), "Basic CDB format failed!");
assert_equal(got[4], network_socket_tcp, "Basic CDB format failed!");
assert(!got[5], "Basic CDB format failed!");
_ClientDataBank(got);

// Verify raw CDB format
got = ClientDataBank(0, network_socket_udp, true);
assert(ds_exists(got[0], ds_type_list), "Basic CDB format failed!");
assert(ds_exists(got[1], ds_type_map), "Basic CDB format failed!");
assert(ds_exists(got[2], ds_type_map), "Basic CDB format failed!");
assert(is_real(got[3]), "Basic CDB format failed!");
assert_equal(got[4], network_socket_udp, "Basic CDB format failed!");
assert(got[5], "Basic CDB format failed!");
_ClientDataBank(got);

// Verify registration and unregistration and get/set
got = ClientDataBank(0, network_socket_udp, true);
assert_fail(cdb_is_registered(got, 1), "CDB registered something before it exists!");
assert_fail(cdb_is_registered_by_altid(got, "ALT1"), "CDB registered something before it exists!");
// Register
cdb_register(got, 1, "altid", "ALT1", "x", 583);
cdb_register(got, 2, "altid", "ALT2", "x", 907);
assert_equal(cdb_count(got), 2, "CDB has wrong size after registration!");
assert(cdb_is_registered(got, 1), "CDB failed to register something after it exists!");
assert(cdb_is_registered_by_altid(got, "ALT1"), "CDB failed to register something after it exists!");
// Get
assert_equal(cdb_get(got, "altid", 1), "ALT1", "CDB failed to get by socket!");
assert_equal(cdb_get_by_altid(got, "x", "ALT2"), 907, "CDB failed to get by altid!");
assert_equal(ds_map_find_value(cdb_get_entry(got, 1), "altid"), "ALT1", "CDB failed to get entry by socket!");
assert_equal(ds_map_find_value(cdb_get_entry_by_altid(got, "ALT2"), "x"), 907, "CDB failed to get entry by altid!");
// Set
cdb_set(got, 1, "x", 5583, "altid", "alt1", "y", 385);
cdb_set_by_altid(got, "ALT2", "x", 9907, "altid", "alt2", "y", 709);
assert_equal(cdb_get(got, "x", 1), 5583, "CDB failed to set existing value!");
assert_equal(cdb_get(got, "x", 2), 9907, "CDB failed to set existing value by altid!");
assert_equal(cdb_get(got, "y", 1), 385, "CDB failed to set new value!");
assert_equal(cdb_get(got, "y", 2), 709, "CDB failed to set new value by altid!");
assert(!cdb_is_registered_by_altid(got, "ALT1") && cdb_is_registered_by_altid(got, "alt1"), "CDB set failed to update altid!");
assert(!cdb_is_registered_by_altid(got, "ALT2") && cdb_is_registered_by_altid(got, "alt2"), "CDB set by ID failed to update altid!");
// Foreach
score = 0;
cdb_foreach(got, __gmsugar_test_cdb_addy_callback);
assert_equal(score, 1094, "CDB foreach not working!");
score = 0;
// Unregister
cdb_unregister(got, 2);
assert_equal(cdb_count(got), 1, "CDB has wrong size after unregistration!");
cdb_unregister_by_altid(got, "alt1");
assert_equal(cdb_count(got), 0, "CDB has wrong size after unregistration by altid!");
_ClientDataBank(got);


}
