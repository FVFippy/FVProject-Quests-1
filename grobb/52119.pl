sub EVENT_SPAWN {
	#:: Set a timer that loops every 900 seconds (15 min)
	quest::settimer("despawn", 900);
}

sub EVENT_SAY {
	if ($text=~/hail/i) {
		quest::emote("stops playing a lively tune.");
		quest::say("Here I stand high and above, a minstrel supreme, my words offer love. Love between all, troll and ogre alike. I sing to all, except Tabaz, so take a hike!'");
	}
	elsif ($text=~/come back to the closet/i) {
		quest::say("No!! I'm getting so good!! Even these trolls appreciate my music! <sigh>...fine I'll go. But before I do, can you do me a favor first? I'd like to study a new instrument. I hear that some lizardmen near the ogre city make an interesting instrument called a fife. If you can get me a few samples, say four, just to make sure I get a good quality one, I'll gladly go back in the closet.");
	}
}

sub EVENT_TIMER {
	#:: Match the timer "despawn"
	if ($timer eq "despawn") {
		#:: Stop the timer from looping over and over
		quest::stoptimer("despawn");
		#:: Depop
		quest::depop();
	}
}

sub EVENT_ITEM {
	#:: Match four 12198 - Lizardman Scout Fife
	if (plugin::takeItems(12198 => 4)) {
		quest::say("All right! I was kinda hoping the lizards would finish you off and I could stay free, but a deal is a deal. Let's go.");
		#:: Give a 12216 - The Minstrel
		quest::summonitem(12216);
		#:: Ding!
		quest::ding();
		#:: Stop the timer from looping over and over
		quest::stoptimer("despawn");
		#:: Depop
		quest::depop();
	}
	#:: Return unused items
	plugin::returnUnusedItems();
}
