///cdb_get_by_altid(cdb, property, altid)
{
var cdb = argument0,
    property = argument1,
    altid = argument2,
    socket, entry;
if (!ds_map_exists(cdb[1], altid)) {
  return undefined;
}
socket = string(ds_map_find_value(cdb[1], altid));
if (!ds_map_exists(cdb[2], socket)) {
  return undefined;
}
entry = ds_map_find_value(cdb[2], socket);
return entry[? property];
}

