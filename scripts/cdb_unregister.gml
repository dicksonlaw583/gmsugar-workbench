///cdb_unregister(cdb, [socket])
{
var cdb = argument[0],
    startindex = 1,
    protocol = cdb[4],
    socket, altid;
switch (argument_count) {
  case 2:
    socket = argument[1];
  break;
  case 1:
    if (!ds_exists(async_load, ds_type_map)) {
      show_error("Socket-free form of cdb_unregister() can only be used in the Networking event.", true);
    }
    if (protocol == network_socket_tcp) {
      if (async_load[? "type"] == network_type_data) {
        socket = async_load[? "id"];
      } else {
        socket = async_load[? "socket"];
      }
    } else if (protocol == network_socket_udp) {
      socket = async_load[? "ip"] + ":" + string(async_load[? "port"]);
    } else {
      show_error("Unknown CDB protocol type " + string(protocol) + ".", true);
    }
  break;
  default:
    show_error("Expected 1 or 2 arguments, got " + string(argument_count) + ".", true);
  break;
}
altid = ds_map_find_value(ds_map_find_value(cdb[2], string(socket)), "altid");
ds_list_delete(cdb[0], ds_list_find_index(cdb[0], socket));
ds_map_delete(cdb[1], altid);
ds_map_delete(cdb[2], string(socket));
}
