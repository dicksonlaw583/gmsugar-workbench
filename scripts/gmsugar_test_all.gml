///gmsugar_test_all()
{
var time_a, time_b;
time_a = get_timer();
gmsugar_test_arrays();
gmsugar_test_ds();
time_b = get_timer();
show_debug_message("GMSugar tests finished in " + string(time_b-time_a) + " microseconds.");
}

