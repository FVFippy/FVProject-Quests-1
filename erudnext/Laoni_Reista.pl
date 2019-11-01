sub EVENT_SAY {
	if ($text=~/hail/i) {
		quest::say("Very good to make your acquaintance $name. If you are a [new knight]. then let it be known. for I am seeking young knights of Deepwater.");
	}
	elsif ($text=~/new knight/i) {
		quest::say("You do seem a bit young. We shall have to test your mettle. Within this temple. you shall learn to swim as fast as the swordfish and attack with the bravery and skill of the shark. Are you willing to [assist with the cleansing of the ocean]?");
	}
	elsif ($text=~/assist with the cleansing of the ocean/i) {
		quest::say("Go to the waters near the harbor. We have heard of Qeynos' rogue guild attempting to smuggle our valuable Vasty Deep water from Odus by way of swimmers. We require proof of their involvement. It is said they often carry special coins. Return one of these coins to me.");
	}
}

sub EVENT_ITEM {
	#:: Match a 13881 -  Nicked Coin
	if (plugin::takeItems(13881 => 1)) {
		quest::say("Good work. You have shown these rogues who are the better swimmers. Now we have proof of their involvement. You are a fine addition to the temple. Take this small reward. Go, and serve Prexus.");
		#:: Give a random reward: 13003 - Small Lantern, 10004 - Copper Band
		quest::summonitem(quest::ChooseRandom(13003, 10004));
		#:: Ding!
		quest::ding();
		#:: Set factions
		quest::faction(242, 10);	 	#:: + Deepwater Knights
		quest::faction(266, 10); 		#:: + High Council of Erudin
		quest::faction(265, -15); 		#:: - Heretics
		#:: Grant a small amount of experience
		quest::exp(100);
		#:: Create a hash for storing cash - 5 to 10cp
		my %cash = plugin::RandomCash(5,10);
		#:: Grant a random cash reward
		quest::givecash($cash{copper},$cash{silver},$cash{gold},$cash{platinum});
	}
	#:: Return unused items
	plugin::returnUnusedItems();
}
