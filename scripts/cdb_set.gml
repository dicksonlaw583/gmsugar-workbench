///cdb_set(cdb, [socket], ...)
{
if (argument_count < 3) {
  show_error("Expected at least 3 arguments, got " + string(argument_count) + ".", true);
}
var cdb = argument[0],
    cdb_data = cdb[2],
    startpos = 1,
    socket;
switch (argument_count mod 2) {
  case 0:
    socket = argument[1];
    startpos = 2;
  break;
  case 1:
    if (!ds_exists(async_load, ds_type_map)) {
      show_error("Socket-free form of cdb_registered() can only be used in the Networking event.", true);
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
for (var i = startpos; i < argument_count; i += 2) {
  if (argument[i] == "altid") {
    ds_map_delete(cdb[1], ds_map_find_value(cdb_data[? string(socket)], "altid"));
    ds_map_add(cdb[1], argument[i+1], socket);
  }
  ds_map_replace(cdb_data[? string(socket)], argument[i], argument[i+1]);
}
}

