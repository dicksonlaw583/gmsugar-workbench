///cdb_get_entry(cdb, [socket])
{
var cdb = argument[0],
    protocol = cdb[4],
    data_map = cdb[2],
    socket;
switch (argument_count) {
  case 2:
    socket = argument[1];
  break;
  case 1:
    if (!ds_exists(async_load, ds_type_map)) {
      show_error("1-parameter form of cdb_get() can only be used in the Networking event.", true);
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
return ds_map_find_value(data_map, string(socket));
}
