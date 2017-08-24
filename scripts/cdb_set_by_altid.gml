///cdb_set_by_altid(cdb, altid, ...)
{
if (argument_count < 4) {
  show_error("Expected at least 4 arguments, got " + string(argument_count) + ".", true);
}
if (argument_count mod 2 != 0) {
  show_error("Expected an even number of arguments, got " + string(argument_count) + ".", true);
}
var cdb = argument[0],
    cdb_data = cdb[2],
    altid = argument[1],
    socket = ds_map_find_value(cdb[1], altid);
for (var i = 2; i < argument_count; i += 2) {
  if (argument[i] == "altid") {
    ds_map_delete(cdb[1], altid);
    ds_map_add(cdb[1], argument[i+1], socket);
  }
  ds_map_replace(cdb_data[? string(socket)], argument[i], argument[i+1]);
}
}

