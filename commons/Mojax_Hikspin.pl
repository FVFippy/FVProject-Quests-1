#:: Create a scalar variable to count pathing loops
my $pathcount = 0;

sub EVENT_SPAWN {
	#:: Create a timer to trigger every 5 seconds
	quest::settimer("MojaxTimer",5);
}

sub EVENT_SAY {
	if ($text=~/hail/i) {
		quest::say("Hi. How are you? The fish are biting pretty good. That is what Skipynn tells me. I sure wish I had a different [" . quest::saylink("job") . "]. If I did, I could fish all day long.");
	}
	if ($text=~/job/i) {
		quest::say("I am a messenger for [" . quest::saylink("Antonius Bayle") . "], ruler of the great city of [" . quest::saylink("Qeynos") . "].");
	}
	if ($text=~/qeynos/i) {
		quest::say("Huh?! Have you been living in a cave? The great city of Qeynos is the mightiest nation in Antonica! You'd best journey toward the west and visit the city whose influence stretches beyond the horizons.");
	}
	if ($text=~/antonius bayle/i) {
		quest::say("How can it be that you do not know of Antonius Bayle? Was it not he who named this great continent of Antonica? Is it not he who rules over the most powerful city on Norrath? Surely you jest!");
	}
}

sub EVENT_ITEM {
	#:: Match 13087 - Bottle of Milk
	if (plugin::takeItems(13087 => 1 )) {
		quest::say("Aaahhhh. Now that is refreshing. Just let me rest for a bit. The note is safe and sound in my bedroll inside the inn.");
		#:: Set factions
		quest::faction(184,1);	#:: Knights of Truth
		quest::faction(86,-1);	#:: Dismal Rage
		quest::faction(105,-1);	#:: Freeport Militia
		quest::faction(311,1);	#:: Steel Warriors
		quest::faction(258,1);	#:: Priests of Marr
		#:: Start Grid 86 - Path to the nearby Inn
		quest::start(86);
	}
	#:: Return unused items
	plugin::return_items(\%itemcount);
}

sub EVENT_TIMER {
	#:: Match "MojaxTimer" every five seconds
	if ($timer eq "MojaxTimer") {
		quest::say("MojaxTimer $zonehour");
		#:: Match if the time is 2 AM
		if ($zonehour == 2) {
			#:: Start Grid 88 - Path to the nearby stone marker
			quest::start(88);
		}
	}
}
			

sub EVENT_WAYPOINT_ARRIVE {
	#:: Match if on grid 86 -- the path to the inn
	if ($npc->GetGrid() == 86) {
		#:: Match at grid entry 2 - at the inn
		if ($wp == 2 && $pathcount == 0) {
			#:: Spawn 21136 - West Commonlands >> Duggin_Scumber
			quest::spawn2(21136,0,0,$x,$y,$z,$h);
			$pathcount = 1;
		}
		elsif ($wp == 2 && $pathcount == 1) {
			#:: Do nothing
		}
		#:: Match at grid entry 0 - spawn point
		elsif ($wp == 0 && $pathcount == 1) {
			#:: Stop Grid 86
			quest::stop();
			#:: Reset scalar to 0
			$pathcount = 0;
		}
	}
	#:: Match if on grid 88 -- the path to the marker
	if ($npc->GetGrid() == 88) {
		#:: Match at grid entry 10 - at the marker
		if ($wp == 10) {
			#:: Create a proximity 10 units across
			quest::set_proximity($x - 5, $x + 5, $y - 5, $y + 5);
			$pathcount = 1;
		}
		elsif ($wp == 0 && $pathcount == 1) {
			#:: Stop Grid 88
			quest::stop();
			#:: Reset scalar to 0
			$pathcount = 0;
		}
		else {
			quest::clear_proximity();
		}
	}
}

sub EVENT_ENTER {
	quest::say("Here you are. I hid it in this box behind the marker. Take it to Eestyana of the Temple of Marr. Goodbye.");
	#:: Give a 18822 - Note
	quest::summonitem(18822)
}
