sub EVENT_SAY {
	if ($text=~/hail/i) {
		quest::emote("Breya Nostulia stares off into the distance in meditation. Her eyes are a light blue, much like the tropical waters of the ocean between Odus and the mainland. She ignores your greeting.");
	}
	if ($text=~/Tiam sent me/i) {
		quest::emote("Seems you've slain quite a few kobolds, then. This is good. You will need to kill many more to fulfill your quest. While the kobolds are fairly primitive, they are an ancient race and have learned to wield the powers of the spirits. This ability is the only thing that has kept us from eradicating them completely. We need you to find [" . quest::saylink("instruments") . "] of their craft.");
	}
	if ($text=~/instruments/i) {
		quest::emote("There are two items we seek. The shamans carry medicine pouches in which they hold the materials of their craft. Only the more adept shamans are allowed to carry the pouches; seek them out. The [" . quest::saylink("other item") . "] we seek is of greater importance.");
	}
	if ($text=~/other item/i) {
		quest::emote("The other is a magical bowl from which a highly skilled shaman may divine the future or diagnose illness. Only the wisest of the kobold shamans have the intelligence to use the bowls, or perhaps an outcast with powers that the other, larger kobolds fear. Bring me a kobold medicine pouch and the diviner's bowl and you shall be rewarded with the armor of our trusted knights and priests");
	}
}
sub EVENT_ITEM {
	#:: Turn in for 17056 Kobolds Shaman Pouch and 1766 Diviner's bowl
	if (plugin::check_handin(\%itemcount, 17056 => 1, 1766 => 1 )) {
		quest::say("Well done, $name. I had a feeling you would return victorious. Here is your reward, the Leggings of Midnight Sea. Wear them with pride for the Ocean Lord. If you are interested in aiding us further, you may want to ask Gans about his brother.");
		#:: Give item 1762 Midnight Sea Mail Leggings
		quest::summonitem(1762);
		#:: Give a small amount of xp
		quest::exp(1000);
		#:: Ding!
		quest::ding();
		#:: Set faction
		quest::faction(79,2); 		#:: + Deepwater Knights
		quest::faction(145,2); 		#:: + High Council of Erudin
		quest::faction(143,-2); 	#:: - Heretics
	}
	plugin::return_items(\%itemcount);
}	
