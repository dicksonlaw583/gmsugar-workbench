///cdb_unregister_by_altid(cdb, altid)
{
var cdb = argument0,
    startindex = 1,
    protocol = cdb[4],
    altid = argument1,
    socket = ds_map_find_value(cdb[1], altid);
ds_list_delete(cdb[0], ds_list_find_index(cdb[0], socket));
ds_map_delete(cdb[1], altid);
ds_map_delete(cdb[2], string(socket));
}
