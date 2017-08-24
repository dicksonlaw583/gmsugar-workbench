///cdb_foreach(cdb, callback, [notthis])
{
if (argument_count != 2 && argument_count != 3) {
  show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
}
var cdb = argument[0],
    callback = argument[1],
    protocol = cdb[4],
    notthis = argument_count == 3 && argument[2],
    isize = ds_list_size(cdb[0]),
    socket, current_socket;
if (notthis) {
  if (!ds_exists(async_load, ds_type_map)) {
    show_error("Not-me form of cdb_foreach() can only be used in the Networking event.", true);
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
  for (var i = 0; i < isize; i++) {
    current_socket = ds_list_find_value(cdb[0], i);
    if (current_socket != socket) {
      script_execute(callback, ds_map_find_value(cdb[2], string(current_socket)));
    }
  }
} else {
  for (var i = 0; i < isize; i++) {
    current_socket = ds_list_find_value(cdb[0], i);
    script_execute(callback, ds_map_find_value(cdb[2], string(current_socket)));
  }
}
}
