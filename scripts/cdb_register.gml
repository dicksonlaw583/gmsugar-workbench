///cdb_register(cdb, [socket], ...)
{
if (argument_count < 3) {
  show_error("Expected at least 3 arguments, got " + string(argument_count) + ".", true);
}
var cdb = argument[0],
    startindex = 1,
    entry = ds_map_create(),
    protocol = cdb[4],
    socket, entry;
switch (argument_count mod 2) {
  case 0:
    socket = argument[1];
    startindex = 2;
  break;
  case 1:
    if (!ds_exists(async_load, ds_type_map)) {
      show_error("Socket-free form of cdb_register() can only be used in the Networking event.", true);
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
}
for (var i = startindex; i < argument_count; i += 2) {
  entry[? argument[i]] = argument[i+1];
}
if (!ds_map_exists(entry, "altid")) {
  altid = chr(irandom_range(32, 127)) + chr(irandom_range(32, 127)) + chr(irandom_range(32, 127)) + chr(irandom_range(32, 127)) + chr(irandom_range(32, 127)) + chr(irandom_range(32, 127)) + chr(irandom_range(32, 127)) + chr(irandom_range(32, 127));
} else {
  altid = entry[? "altid"];
}
ds_list_add(cdb[0], socket);
ds_map_add(cdb[1], altid, socket);
ds_map_add(cdb[2], string(socket), entry);
return altid;
}
