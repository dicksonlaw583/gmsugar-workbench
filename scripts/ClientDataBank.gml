///ClientDataBank(server, protocol, [raw])
// Utility 6-tuple of [
//  list of sockets,
//  altid-socket map,
//  nested map of data points,
//  server socket,
//  server protocol,
//  raw flag
// ]
{
var server = argument[0],
    protocol = argument[1],
    raw = false,
    tuple;
switch (argument_count) {
  case 3:
    raw = argument[2];
  case 2:
  break;
  default:
    show_error("Expected 2 or 3 arguments, got " + string(argument_count) + ".", true);
  break;
}
tuple[5] = raw;
tuple[4] = protocol;
tuple[3] = server;
tuple[2] = ds_map_create();
tuple[1] = ds_map_create();
tuple[0] = ds_list_create();
return tuple;
}
