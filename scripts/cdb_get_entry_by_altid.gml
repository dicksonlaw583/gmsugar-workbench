///cdb_get_entry_by_altid(cdb, altid)
{
var cdb = argument0,
    altid = argument1,
    socket;
if (!ds_map_exists(cdb[1], altid)) {
  return undefined;
}
socket = string(ds_map_find_value(cdb[1], altid));
if (!ds_map_exists(cdb[2], socket)) {
  return undefined;
}
return ds_map_find_value(cdb[2], socket);
}

