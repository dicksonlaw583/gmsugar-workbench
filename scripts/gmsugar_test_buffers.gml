///gmsugar_test_buffers()
{
var expected, got, data;

// Test fixed buffers
expected = undefined;
expected[0] = 255;
expected[1] = 65;
expected[2] = 0;
expected[3] = 3;
got = FixedBuffer($FF, "A", undefined, pi);
assert_equal(buffer_get_size(got), 4, "Fixed buffer has wrong size!");
assert_equal(buffer_get_type(got), buffer_fixed, "Fixed buffer has wrong type!");
for (var i = 0; i < 4; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i], "Unexpected byte " + string(i) + " for fixed buffer!");
}
buffer_delete(got);

// Test fixed buffers from file
expected = undefined;
expected[0] = ord("T");
expected[1] = ord("e");
expected[2] = ord("s");
expected[3] = ord("t");
expected[4] = ord("A");
expected[5] = ord("B");
expected[6] = ord("C");
got = FixedBuffer(working_directory + "bufferinput.txt");
assert_equal(buffer_get_size(got), 7, "Fixed buffer from file has wrong size!");
assert_equal(buffer_get_type(got), buffer_fixed, "Fixed buffer from file has wrong type!");
for (var i = 0; i < 7; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i], "Unexpected byte " + string(i) + " for fixed buffer from file!");
}
buffer_delete(got);

// Test fixed buffers from file with length
expected = undefined;
expected[0] = ord("T");
expected[1] = ord("e");
expected[2] = ord("s");
expected[3] = ord("t");
got = FixedBuffer(working_directory + "bufferinput.txt", 4);
assert_equal(buffer_get_size(got), 4, "Fixed buffer from file with length has wrong size!");
assert_equal(buffer_get_type(got), buffer_fixed, "Fixed buffer from file with length has wrong type!");
for (var i = 0; i < 4; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i], "Unexpected byte " + string(i) + " for fixed buffer from file with length!");
}
buffer_delete(got);

// Test fixed buffers from file with length and positive offset
expected = undefined;
expected[0] = ord("e");
expected[1] = ord("s");
expected[2] = ord("t");
expected[3] = ord("A");
got = FixedBuffer(working_directory + "bufferinput.txt", 4, 1);
assert_equal(buffer_get_size(got), 4, "Fixed buffer from file with length and positive offset has wrong size!");
assert_equal(buffer_get_type(got), buffer_fixed, "Fixed buffer from file with length and positive offset has wrong type!");
for (var i = 0; i < 4; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i], "Unexpected byte " + string(i) + " for fixed buffer from file with length and positive offset!");
}
buffer_delete(got);

// Test fixed buffers from file with default length and positive offset
expected = undefined;
expected[0] = ord("e");
expected[1] = ord("s");
expected[2] = ord("t");
expected[3] = ord("A");
expected[4] = ord("B");
expected[5] = ord("C");
got = FixedBuffer(working_directory + "bufferinput.txt", -1, 1);
assert_equal(buffer_get_size(got), 6, "Fixed buffer from file with default length and positive offset has wrong size!");
assert_equal(buffer_get_type(got), buffer_fixed, "Fixed buffer from file with default length and positive offset has wrong type!");
for (var i = 0; i < 6; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i], "Unexpected byte " + string(i) + " for fixed buffer from file with default length and positive offset!");
}
buffer_delete(got);

// Test fixed buffers from file with length and negative offset
expected = undefined;
expected[0] = ord("s");
expected[1] = ord("t");
expected[2] = ord("A");
expected[3] = ord("B");
got = FixedBuffer(working_directory + "bufferinput.txt", 4, -5);
assert_equal(buffer_get_size(got), 4, "Fixed buffer from file with length and negative offset has wrong size!");
assert_equal(buffer_get_type(got), buffer_fixed, "Fixed buffer has from file with length and negative offset has wrong type!");
for (var i = 0; i < 4; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i], "Unexpected byte " + string(i) + " for fixed buffer from file with length and negative offset!");
}
buffer_delete(got);

// Test fixed buffers from file with default length and negative offset
expected = undefined;
expected[0] = ord("s");
expected[1] = ord("t");
expected[2] = ord("A");
expected[3] = ord("B");
expected[4] = ord("C");
got = FixedBuffer(working_directory + "bufferinput.txt", -1, -5);
assert_equal(buffer_get_size(got), 5, "Fixed buffer from file with default length and negative offset has wrong size!");
for (var i = 0; i < 5; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i], "Unexpected byte " + string(i) + " for fixed buffer from file with default length and negative offset!");
}
buffer_delete(got);

// Test wrap buffers
expected = undefined;
expected[0] = 66;
expected[1] = 252;
expected[2] = 0;
expected[3] = 3;
got = WrapBuffer("B", $FC, undefined, pi);
assert_equal(buffer_get_size(got), 4, "Wrap buffer has wrong size!");
assert_equal(buffer_get_type(got), buffer_wrap, "Wrap buffer has wrong type!");
for (var i = 0; i < 8; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i mod 4], "Unexpected byte " + string(i) + " for wrap buffer!");
}
buffer_delete(got);

// Test wrap buffers from file
expected = undefined;
expected[0] = ord("T");
expected[1] = ord("e");
expected[2] = ord("s");
expected[3] = ord("t");
expected[4] = ord("A");
expected[5] = ord("B");
expected[6] = ord("C");
got = WrapBuffer(working_directory + "bufferinput.txt");
assert_equal(buffer_get_size(got), 7, "Wrap buffer from file has wrong size!");
assert_equal(buffer_get_type(got), buffer_wrap, "Wrap buffer from file has wrong type!");
for (var i = 0; i < 14; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i mod 7], "Unexpected byte " + string(i) + " for wrap buffer from file!");
}
buffer_delete(got);

// Test wrap buffers from file with length
expected = undefined;
expected[0] = ord("T");
expected[1] = ord("e");
expected[2] = ord("s");
expected[3] = ord("t");
got = WrapBuffer(working_directory + "bufferinput.txt", 4);
assert_equal(buffer_get_size(got), 4, "Wrap buffer from file with length has wrong size!");
assert_equal(buffer_get_type(got), buffer_wrap, "Wrap buffer from file with length has wrong type!");
for (var i = 0; i < 8; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i mod 4], "Unexpected byte " + string(i) + " for wrap buffer from file with length!");
}
buffer_delete(got);

// Test wrap buffers from file with length and positive offset
expected = undefined;
expected[0] = ord("e");
expected[1] = ord("s");
expected[2] = ord("t");
expected[3] = ord("A");
got = WrapBuffer(working_directory + "bufferinput.txt", 4, 1);
assert_equal(buffer_get_size(got), 4, "Wrap buffer from file with length and positive offset has wrong size!");
assert_equal(buffer_get_type(got), buffer_wrap, "Wrap buffer from file with length and positive offset has wrong type!");
for (var i = 0; i < 8; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i mod 4], "Unexpected byte " + string(i) + " for wrap buffer from file with length and positive offset!");
}
buffer_delete(got);

// Test wrap buffers from file with default length and positive offset
expected = undefined;
expected[0] = ord("e");
expected[1] = ord("s");
expected[2] = ord("t");
expected[3] = ord("A");
expected[4] = ord("B");
expected[5] = ord("C");
got = WrapBuffer(working_directory + "bufferinput.txt", -1, 1);
assert_equal(buffer_get_size(got), 6, "Wrap buffer from file with default length and positive offset has wrong size!");
assert_equal(buffer_get_type(got), buffer_wrap, "Wrap buffer from file with default length and positive offset has wrong type!");
for (var i = 0; i < 12; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i mod 6], "Unexpected byte " + string(i) + " for wrap buffer from file with default length and positive offset!");
}
buffer_delete(got);

// Test wrap buffers from file with length and negative offset
expected = undefined;
expected[0] = ord("s");
expected[1] = ord("t");
expected[2] = ord("A");
expected[3] = ord("B");
got = WrapBuffer(working_directory + "bufferinput.txt", 4, -5);
assert_equal(buffer_get_size(got), 4, "Wrap buffer from file with length and negative offset has wrong size!");
assert_equal(buffer_get_type(got), buffer_wrap, "Wrap buffer from file with length and negative offset has wrong type!");
for (var i = 0; i < 8; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i mod 4], "Unexpected byte " + string(i) + " for wrap buffer from file with length and negative offset!");
}
buffer_delete(got);

// Test wrap buffers from file with default length and negative offset
expected = undefined;
expected[0] = ord("s");
expected[1] = ord("t");
expected[2] = ord("A");
expected[3] = ord("B");
expected[4] = ord("C");
got = WrapBuffer(working_directory + "bufferinput.txt", -1, -5);
assert_equal(buffer_get_size(got), 5, "Wrap buffer from file with default length and negative offset has wrong size!");
assert_equal(buffer_get_type(got), buffer_wrap, "Wrap buffer from file with default length and negative offset has wrong type!");
for (var i = 0; i < 10; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i mod 5], "Unexpected byte " + string(i) + " for wrap buffer from file with default length and negative offset!");
}
buffer_delete(got);

// Test fast buffers
expected = undefined;
expected[0] = 255;
expected[1] = 65;
expected[2] = 0;
expected[3] = 3;
got = FastBuffer($FF, "A", undefined, pi);
assert_equal(buffer_get_size(got), 4, "Fast buffer has wrong size!");
assert_equal(buffer_get_type(got), buffer_fast, "Fast buffer has wrong type!");
for (var i = 0; i < 4; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i], "Unexpected byte " + string(i) + " for fast buffer!");
}
buffer_delete(got);

// Test fast buffers from file
expected = undefined;
expected[0] = ord("T");
expected[1] = ord("e");
expected[2] = ord("s");
expected[3] = ord("t");
expected[4] = ord("A");
expected[5] = ord("B");
expected[6] = ord("C");
got = FastBuffer(working_directory + "bufferinput.txt");
assert_equal(buffer_get_size(got), 7, "Fast buffer from file has wrong size!");
assert_equal(buffer_get_type(got), buffer_fast, "Fast buffer from file has wrong type!");
for (var i = 0; i < 7; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i], "Unexpected byte " + string(i) + " for fast buffer from file!");
}
buffer_delete(got);

// Test fast buffers from file with length
expected = undefined;
expected[0] = ord("T");
expected[1] = ord("e");
expected[2] = ord("s");
expected[3] = ord("t");
got = FastBuffer(working_directory + "bufferinput.txt", 4);
assert_equal(buffer_get_size(got), 4, "Fast buffer from file with length has wrong size!");
assert_equal(buffer_get_type(got), buffer_fast, "Fast buffer from file with length has wrong type!");
for (var i = 0; i < 4; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i], "Unexpected byte " + string(i) + " for fast buffer from file with length!");
}
buffer_delete(got);

// Test fast buffers from file with length and positive offset
expected = undefined;
expected[0] = ord("e");
expected[1] = ord("s");
expected[2] = ord("t");
expected[3] = ord("A");
got = FastBuffer(working_directory + "bufferinput.txt", 4, 1);
assert_equal(buffer_get_size(got), 4, "Fast buffer from file with length and positive offset has wrong size!");
assert_equal(buffer_get_type(got), buffer_fast, "Fast buffer from file with length and positive offset has wrong type!");
for (var i = 0; i < 4; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i], "Unexpected byte " + string(i) + " for fast buffer from file with length and positive offset!");
}
buffer_delete(got);

// Test fast buffers from file with default length and positive offset
expected = undefined;
expected[0] = ord("e");
expected[1] = ord("s");
expected[2] = ord("t");
expected[3] = ord("A");
expected[4] = ord("B");
expected[5] = ord("C");
got = FastBuffer(working_directory + "bufferinput.txt", -1, 1);
assert_equal(buffer_get_size(got), 6, "Fast buffer from file with default length and positive offset has wrong size!");
assert_equal(buffer_get_type(got), buffer_fast, "Fast buffer from file with default length and positive offset has wrong type!");
for (var i = 0; i < 6; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i], "Unexpected byte " + string(i) + " for fast buffer from file with default length and positive offset!");
}
buffer_delete(got);

// Test fast buffers from file with length and negative offset
expected = undefined;
expected[0] = ord("s");
expected[1] = ord("t");
expected[2] = ord("A");
expected[3] = ord("B");
got = FastBuffer(working_directory + "bufferinput.txt", 4, -5);
assert_equal(buffer_get_size(got), 4, "Fast buffer from file with length and negative offset has wrong size!");
assert_equal(buffer_get_type(got), buffer_fast, "Fast buffer from file with length and negative offset has wrong type!");
for (var i = 0; i < 4; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i], "Unexpected byte " + string(i) + " for fast buffer from file with length and negative offset!");
}
buffer_delete(got);

// Test fast buffers from file with default length and negative offset
expected = undefined;
expected[0] = ord("s");
expected[1] = ord("t");
expected[2] = ord("A");
expected[3] = ord("B");
expected[4] = ord("C");
got = FastBuffer(working_directory + "bufferinput.txt", -1, -5);
assert_equal(buffer_get_size(got), 5, "Fast buffer from file with default length and negative offset has wrong size!");
assert_equal(buffer_get_type(got), buffer_fast, "Fast buffer from file with default length and negative offset has wrong type!");
for (var i = 0; i < 5; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i], "Unexpected byte " + string(i) + " for fast buffer from file with default length and negative offset!");
}
buffer_delete(got);

// Test grow buffers from file
expected = undefined;
expected[0] = ord("T");
expected[1] = ord("e");
expected[2] = ord("s");
expected[3] = ord("t");
expected[4] = ord("A");
expected[5] = ord("B");
expected[6] = ord("C");
got = Buffer(working_directory + "bufferinput.txt");
assert_equal(buffer_get_size(got), 7, "Grow buffer from file has wrong size!");
assert_equal(buffer_get_type(got), buffer_grow, "Grow buffer has wrong type!");
buffer_seek(got, buffer_seek_start, 0);
for (var i = 0; i < 7; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i], "Unexpected byte " + string(i) + " for grow buffer from file!");
}
buffer_delete(got);

// Test grow buffers from file with length
expected = undefined;
expected[0] = ord("T");
expected[1] = ord("e");
expected[2] = ord("s");
expected[3] = ord("t");
got = Buffer(working_directory + "bufferinput.txt", 4);
assert_equal(buffer_get_size(got), 4, "Grow buffer from file with length has wrong size!");
assert_equal(buffer_get_type(got), buffer_grow, "Grow buffer from file with length has wrong type!");
buffer_seek(got, buffer_seek_start, 0);
for (var i = 0; i < 4; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i], "Unexpected byte " + string(i) + " for grow buffer from file with length!");
}
buffer_delete(got);

// Test grow buffers from file with length and positive offset
expected = undefined;
expected[0] = ord("e");
expected[1] = ord("s");
expected[2] = ord("t");
expected[3] = ord("A");
got = Buffer(working_directory + "bufferinput.txt", 4, 1);
assert_equal(buffer_get_size(got), 4, "Grow buffer from file with length and positive offset has wrong size!");
assert_equal(buffer_get_type(got), buffer_grow, "Grow buffer from file with length and positive offset has wrong type!");
buffer_seek(got, buffer_seek_start, 0);
for (var i = 0; i < 4; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i], "Unexpected byte " + string(i) + " for grow buffer from file with length and positive offset!");
}
buffer_delete(got);

// Test grow buffers from file with default length and positive offset
expected = undefined;
expected[0] = ord("e");
expected[1] = ord("s");
expected[2] = ord("t");
expected[3] = ord("A");
expected[4] = ord("B");
expected[5] = ord("C");
got = Buffer(working_directory + "bufferinput.txt", -1, 1);
assert_equal(buffer_get_size(got), 6, "Grow buffer from file with default length and positive offset has wrong size!");
assert_equal(buffer_get_type(got), buffer_grow, "Grow buffer from file with default length and positive offset has wrong type!");
buffer_seek(got, buffer_seek_start, 0);
for (var i = 0; i < 6; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i], "Unexpected byte " + string(i) + " for grow buffer from file with default length and positive offset!");
}
buffer_delete(got);

// Test grow buffers from file with length and negative offset
expected = undefined;
expected[0] = ord("s");
expected[1] = ord("t");
expected[2] = ord("A");
expected[3] = ord("B");
got = Buffer(working_directory + "bufferinput.txt", 4, -5);
assert_equal(buffer_get_size(got), 4, "Grow buffer from file with length and negative offset has wrong size!");
assert_equal(buffer_get_type(got), buffer_grow, "Grow buffer with length and negative offset has wrong type!");
buffer_seek(got, buffer_seek_start, 0);
for (var i = 0; i < 4; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i], "Unexpected byte " + string(i) + " for grow buffer from file with length and negative offset!");
}
buffer_delete(got);

// Test grow buffers from file with default length and negative offset
expected = undefined;
expected[0] = ord("s");
expected[1] = ord("t");
expected[2] = ord("A");
expected[3] = ord("B");
expected[4] = ord("C");
got = Buffer(working_directory + "bufferinput.txt", -1, -5);
assert_equal(buffer_get_size(got), 5, "Grow buffer from file with default length and negative offset has wrong size!");
assert_equal(buffer_get_type(got), buffer_grow, "Grow buffer from file with default length and negative offset has wrong type!");
buffer_seek(got, buffer_seek_start, 0);
for (var i = 0; i < 5; i++) {
  assert_equal(buffer_read(got, buffer_u8), expected[i], "Unexpected byte " + string(i) + " for grow buffer from file with default length and negative offset!");
}
buffer_delete(got);

// Test grow buffers
got = Buffer(
  buffer_u8, $FF,
  buffer_string, "ABCD",
  buffer_s16, -32445,
);
assert_equal(buffer_get_size(got), 8, "Grow buffer has wrong size!");
assert_equal(buffer_get_type(got), buffer_grow, "Grow buffer has wrong type!");
buffer_seek(got, buffer_seek_start, 0);
assert_equal(buffer_read(got, buffer_u8), $FF, "Unexpected content 1 for grow buffer!");
assert_equal(buffer_read(got, buffer_string), "ABCD", "Unexpected content 2 for grow buffer!");
assert_equal(buffer_read(got, buffer_s16), -32445, "Unexpected content 3 for grow buffer!");
buffer_delete(got);

// Test grow buffers with alignment
got = Buffer(4,
  buffer_u32, $1234ABCD,
  buffer_f32, pi,
  buffer_s32, -9912399,
);
assert_equal(buffer_get_size(got), 12, "Grow buffer with alignment has wrong size!");
assert_equal(buffer_get_type(got), buffer_grow, "Grow buffer with alignment has wrong type!");
buffer_seek(got, buffer_seek_start, 0);
assert_equal(buffer_read(got, buffer_u32), $1234ABCD, "Unexpected content 1 for grow buffer with alignment!");
assert_equalish(buffer_read(got, buffer_f32), pi, "Unexpected content 2 for grow buffer with alignment!");
assert_equal(buffer_read(got, buffer_s32), -9912399, "Unexpected content 3 for grow buffer with alignment!");
buffer_delete(got);
}

