my $following;

sub EVENT_SPAWN {
	$following = 0;
}

sub EVENT_WAYPOINT_ARRIVE {
	if ($following == 1) {
		if ($wp == 3) {
			quest::say("Hey, waypoint 3!");
			quest::stop();
			$following = 0;
		}
		else {
			quest::stop();
			$wp--;
			mob->UpdateWaypoint($wp);
			quest::start(42);
		}
	}
}

sub EVENT_COMBAT {
	if ($combat_state == 1) {
		quest::say("Time to die $name!");
	}
}

sub EVENT_SAY {
	if ($text=~/hail/i) {
		quest::say("Hello, $name. What brings you to Qeynos? Must be the mighty fine muffins over at [" . quest::saylink("Voleen's Bakery") . "]. I just love those muffins!");
	}
	elsif ($text=~/voleen/i) {
		quest::say("Oh, it will be easier for us both if I just show you where it is. Follow me. But be quick about it, because I have to get back to my patrol.");
		quest::stop();
		$following = 1;
		$wp--;
		mob->UpdateWaypoint($wp);
		quest::start(42);
	}
}

sub EVENT_ITEM {
	#:: Match a 13014 - Muffin
	if (plugin::takeItems(13014 => 1)) {
		quest::say("Oh, thank you so much. I do get hungry on patrol. Here, please take this reward for your kindness.");
		#:: Ding!
		quest::ding();
		my $randomchance = (quest::ChooseRandom(1,2,3,4,5));
		if ($randomchance < 5) {
			#:: Set factions
			quest::faction(262, 1);		#:: + Guards of Qeynos
			quest::faction(219, 1);		#:: + Antonius Bayle
			quest::faction(230, -1);	#:: - Corrupt Qeynos Guards
			quest::faction(223, -1);	#:: - Circle Of Unseen Hands
			quest::faction(291, 1);		#:: + Merchants of Qeynos
			#:: Grant a small amount of experience
			quest::exp(15);
			#:: Create a hash for storing cash - 1 to 10cp
			my %cash = plugin::RandomCash(1,10);
			#:: Grant a random cash reward
			quest::givecash($cash{copper},$cash{silver},$cash{gold},$cash{platinum});
		}
		elsif ($randomchance > 4) {
			#:: Give a 13053 - Brass Ring
			quest::summonitem(13053);
			#:: Set factions
			quest::faction(262, 1);		#:: + Guards of Qeynos
			quest::faction(219, 1);		#:: + Antonius Bayle
			quest::faction(230, -1);	#:: - Corrupt Qeynos Guards
			quest::faction(223, -1);	#:: - Circle Of Unseen Hands
			quest::faction(291, 1);		#:: + Merchants of Qeynos
			#:: Grant a small amount of experience
			quest::exp(15);
			#:: Create a hash for storing cash - 1 to 10cp
			my %cash = plugin::RandomCash(1,10);
			#:: Grant a random cash reward
			quest::givecash($cash{copper},$cash{silver},$cash{gold},$cash{platinum});
		}
	}
	#:: Return unused items
	plugin::returnUnusedItems();
}
