sub EVENT_WAYPOINT_ARRIVE {
	if ($wp == 5) {
		#:: Set running to true (run)
		quest::SetRunning(1);
	}
}
