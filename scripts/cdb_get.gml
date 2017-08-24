///cdb_get(cdb, property, [socket])
{
var cdb = argument[0],
    protocol = cdb[4],
    data_map = cdb[2],
    property = argument[1],
    socket, entry;
switch (argument_count) {
  case 3:
    socket = argument[2];
  break;
  case 2:
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
    show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
  break;
}
entry = ds_map_find_value(data_map, string(socket));
if (is_real(entry) && ds_exists(entry, ds_type_map)) {
  return entry[? property];
}
return undefined;
}
