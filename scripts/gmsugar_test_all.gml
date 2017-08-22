///gmsugar_test_all()
{
var time_a, time_b;
time_a = get_timer();
gmsugar_test_arrays();
gmsugar_test_ds();
if (os_browser == browser_not_a_browser) {
  gmsugar_test_buffers();
} else {
  show_debug_message("Bypassing buffer constructor tests on HTML5.");
}
time_b = get_timer();
show_debug_message("GMSugar tests finished in " + string(time_b-time_a) + " microseconds.");
}

