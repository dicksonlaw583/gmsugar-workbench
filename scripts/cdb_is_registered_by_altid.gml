///cdb_is_registered_by_altid(cdb, altid)
{
var cdb = argument0,
    socket = argument1;
return ds_map_exists(cdb[1], string(socket));
}

