sub EVENT_SPAWN {
	quest::settimer("follow",10);
	quest::say("Ding!");
}

sub EVENT_TIMER {
	if ($timer eq "follow") {
		my $OpponentID = 2161;
		my $getmobbynpctype = $entity_list->GetMobByNpcTypeID($OpponentID);
		my $follow_target = $getmobbynpctype->GetID();
		quest::follow($follow_target);
		quest::stoptimer("follow");
	}
}

sub EVENT_SAY {
	if ($text=~/hail/i) {
		if (plugin::deity("Innoruuk")) {
			quest::ding();
		}
		elsif (plugin:deity(206)) {
			quest::ding();
			quest::ding();
		}
	}
	if ($text=~/level/i) {
		if ($ulevel <= 20) {
		    quest::level($ulevel+1);
		}
		elsif ($ulevel >= 21) {
			$npc->CastSpell(808, $userid);
			quest::say("Begone!");
		}
	}
}
