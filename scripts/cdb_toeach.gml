///cdb_toeach(cdb, buffer, [notthis])
{
if (argument_count != 2 && argument_count != 3) {
  show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
}
var cdb = argument[0],
    buffer = argument[1],
    protocol = cdb[4],
    raw = cdb[5],
    notthis = argument_count == 3 && argument[2],
    isize = ds_list_size(cdb[0]),
    current_socket = undefined,
    current_socket;
if (notthis) {
  if (!ds_exists(async_load, ds_type_map)) {
    show_error("Not-me form of cdb_toeach() can only be used in the Networking event.", true);
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
}
for (var i = 0; i < isize; i++) {
  current_socket = ds_list_find_value(cdb[0], i);
  if (is_undefined(socket) || current_socket != socket) {
    if (protocol = network_socket_tcp) {
      if (raw) {
        network_send_raw(current_socket, buffer, buffer_tell(buffer));
      } else {
        network_send_packet(current_socket, buffer, buffer_tell(buffer));
      }
    } else {
      var colonpos = string_pos(current_socket, ":"),
          ip = string_copy(current_socket, 1, colonpos),
          port = real(string_delete(current_socket, 1, colonpos));
      if (raw) {
        network_send_udp_raw(cdb[3], ip, port, buffer, buffer_tell(buffer));
      } else {
        network_send_udp(cdb[3], ip, port, buffer, buffer_tell(buffer));
      }
    }
  }
}
}
