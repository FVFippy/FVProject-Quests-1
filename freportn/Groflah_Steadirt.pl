sub EVENT_SAY {
	if ($text=~/hail/i) {
		quest::say("Greetings, adventurer! Certainly a person who looks as hardened as yourself deserves a fine blade to match your prowess. Here at Groflah's Forge, we supply you with only the finest quality weapons.");
	}
	elsif ($text=~/ariska zimel/i) {
		quest::say("Zimel!! I do not know who you mean. Now go away. I am very busy. I will not talk here!!");
	}
}

sub EVENT_ITEM {
	#:: Turn in for 18818 - a tattered flier
	if (plugin::takeItems(18818 => 1 )) {
		quest::say("Where did you find this? This was the main price list of Zimel's Blades, but it should be all burnt up. I was at Zimel's right after the fire and I did not see it hanging where it should have been. The entire inside was gutted and . . . wait . . . the sequence of the dots!! Hmmm. I cannot talk with you here. Meet me at the Seafarer's by the docks at night. Give me the note when next we meet.");
		#:: Give item 18818 - a tattered flier
		quest::summonitem(13540);
	}
	#:: Turn in for 18820 - sealed letter
	if (plugin::takeItems(18820 => 1 )) {
		quest::say("I am afraid I have some bad news, Steel Warrior. I had one of my workers take the raw blades out to be engraved by the Rivervale craftsmen. On his return, he was killed by the orcs in the Commonlands. The orcs now have the blades in their possession. I believe they have a camp nearby in the Commonlands. You may still be able to find all four blades within their camp and return them to Larn Brugal. Good Luck.");
		#:: Ding!
		quest::ding();
		#:: Grant a small amount of experience
		quest::exp(100);
	}
	#:: Return unused items
	plugin::returnUnusedItems();
}	

sub EVENT_DEATH_COMPLETE {
	quest::say("The good people of this city will know of this. They will strike back at you!");
}
