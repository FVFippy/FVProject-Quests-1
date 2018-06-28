sub EVENT_SAY {
	if ($text=~/hail/i) {
		quest::say("Hello, hairrrrless one.  Welcome to the ourrrrr island. As you browse my wares please tell me if you would like to see my [" . quest::saylink("shiny tings") . "] that I have gathered from all over the world.");
	}
	if ($text=~/shiny tings/i) {
		quest::say("I thought you looked like one who is would be interested in them.  I have a [" . quest::saylink("dull ring") . "], a [" . quest::saylink("kinda shiny ring") . "] and a [" . quest::saylink("really shiny ring") . "].  These are just a few of the items that I have collected in my jourrrrneies, but I would be willing to parrrrt with them for a prrrrice");
	}
	if ($text=~/dull ring/i) {
		quest::say("Rrrrrow, I see that you are looking at my dull ring.  I will give it to you if you can bring me a bracket mildew");
	}
	if ($text=~/kinda shiny ring/i) {
		quest::say("So it is the kinda shiny ring that you want.  So be it, but you must brrrring me faerix spores before I will give it to you");
	}
	if ($text=~/really shiny ring/i) {
		quest::say("Ah, my favorite one, if I am to part with this one you must get me some degenerated guk weed");
	}
}

sub EVENT_ITEM {
	#:: Match a 14042 - Guk Bracket Mildew
	if (plugin::check_handin(\%itemcount, 14042 => 1)) {
		quest::say("Thank you for this item, here is the dull ring");
		#:: Give a 13733 - Copper Ring
		quest::summonitem(13733);
		#:: Ding!
		quest::ding();
	}
	#:: Match a 14043 - Faerix Spores
	if (plugin::check_handin(\%itemcount, 14043 => 1)) {
		quest::say("You have gotten the spores that I asked for, very well, here is the ring as agreed");
		#:: Give a 13731 - Silver Ring
		quest::summonitem(13731);
		#:: Ding!
		quest::ding();
	}
	#:: Match a 14044 - Degenerated Guk Weed
	if (plugin::check_handin(\%itemcount, 14044 => 1)) {
		quest::say("Excellent, I will gladly give you the ring for this weed that you have brought me");
		#:: Give a 13732 - Gold Ring
		quest::summonitem(13732);
		#:: Ding!
		quest::ding();
	}
	#:: Return unused items
	plugin::return_items(\%itemcount);
}
