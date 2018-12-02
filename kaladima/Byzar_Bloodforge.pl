sub EVENT_SAY {
	if ($text=~/hail/i) {
		quest::say("State your business!!  I have no time for chitchat.  Well..  speak up, toad!!  What?!!..  Have you come here to [" . quest::saylink("return goblin beads") . "]?");
	}
	if ($text=~/return goblin beads/i) {
		#:: Match if faction is amiable or better
		if ($faction <= 4) {
			quest::say("If you wish to return Runnyeye Warbeads you best have at least four of them.  Do not waste my time with any less.  If I am in a good mood I just may reward you with some trash, err..  I mean equipment from our armory.");
		}
		else {
			quest::say("Your shifty eyes tell me that you are no ally of the Stormguard.");
		}
	}
	if (($text=~/Zachoomi/i) || ($text=~/Corflunk/i)) {
		#:: Match if faction is amiable or better
		if ($faction <= 4) {
			quest::say("Do not speak the names of Zarchoomi and Corflunk!!  I have heard enough of those ogres!!  I would pay greatly for their heads!!");
		}
		else {
			quest::say("Your shifty eyes tell me that you are no ally of the Stormguard.");
		}
	}
	if ($text=~/take a little trip/i) {
		#:: Match if faction is amiable or better
		if ($faction <= 4) {
			quest::say("Yes.  You will do.  My sister was once engaged to a fellow warrior.  He disgraced her and left her crying at the altar.  I will have his head for such a slap in the face of my family.  His name was Trumpy Irontoe, once a member of the now defunct Irontoe Brigade.  I know not where he went.  Find his whereabouts and return his head to me.  Do so, and I shall make you an honorary member of the Bloodforge Brigade.");
		}
		else {
			quest::say("Your shifty eyes tell me that you are no ally of the Stormguard.");
		}
	}
}

sub EVENT_ITEM {
	#:: Match if faction is amiable or better and four 13931 - Runnyeye Warbeads
	if (($faction <= 4) && (plugin::takeItems(13931 => 4))) {
		quest::say("You finally have proven yourself a warrior, a slow one!!  Take this reward and ask for nothing else.  You should be proud to defend Kaladim and expect no reward.");
		#:: Reward a 2113 - Small Tattered Skullcap, 2114 - Small Tattered Mask, 2115 - Small Tattered Gorget, 2117 - Small Tattered Shoulderpads, 2119 - Small Tattered Belt, 2121 - Small Tattered Wristbands, 2122 - Small Tattered Gloves
		quest::summonitem(quest::ChooseRandom(2113,2114,2115,2117,2119,2121,2122));
		#:: Ding!
		quest::ding();
		#:: Grant a moderate amount of expierence
		quest::exp(10000);
		#:: Create a hash for storing cash - 200 to 250cp
		my %cash = plugin::RandomCash(200,250);
		#:: Grant a random cash reward
		quest::givecash($cash{copper},$cash{silver},$cash{gold},$cash{platinum});
		#:: Set factions
		quest::faction(314, 15);	#:: + Storm Guard
		quest::faction(169, 15);	#:: + Kazon Stormhammer
		quest::faction(219, 15);	#:: + Miners Guild 249
		quest::faction(215, 15);	#:: + Merchants Of Kaladim
		quest::faction(57,- 15);	#:: - Craknek Warriors
	}
	#:: Match if faction is Indifferent or worse and four 13931 - Runnyeye Warbeads
	elsif (($faction > 4) && (plugin::takeItems(13931 => 4))) {
		quest::say("Your shifty eyes tell me that you are no ally of the Stormguard.");
		#:: Return a 13931 - Runnyeye Warbeads
		quest::summonitem(13931);
		#:: Return a 13931 - Runnyeye Warbeads
		quest::summonitem(13931);
		#:: Return a 13931 - Runnyeye Warbeads
		quest::summonitem(13931);
		#:: Return a 13931 - Runnyeye Warbeads
	}
	#:: Match if faction is amiable or better and a 13741 - Ogre Head and 13740 - Ogre Head
	elsif (($faction <= 4) && (plugin::takeItems(13741 => 1, 13740 => 1))) {
		quest::say("I underestimated you.  You are truly a great warrior.  I reward you with a piece of my own Bloodforge armor.  You would be fine Bloodforge Brigade material!  How would you like to [" . quest::saylink("take a little trip") . "] in the name of the Bloodforge Brigade?");
		#:: Reward a 3090 - Bloodforge Helm, 3091 - Bloodforge Mail, 3092 - Bloodforge Armplates, 3093 - Bloodforge Bracers, 3094 - Bloodforge Gauntlets, 3095 - Bloodforge Legplates, 3096 - Bloodforge Boots
		quest::summonitem(quest::ChooseRandom(3090,3090,3090,3090,3090,3090,3091,3092,3093,3094,3095,3096));
		#:: Ding!
		quest::ding();
		#:: Grant a moderate amount of expierence
		quest::exp(10000);
		#:: Create a hash for storing cash - 200 to 250cp
		my %cash = plugin::RandomCash(200,250);
		#:: Grant a random cash reward
		quest::givecash($cash{copper},$cash{silver},$cash{gold},$cash{platinum});
		#:: Set factions
		quest::faction(314, 15);	#:: + Storm Guard
		quest::faction(169, 15);	#:: + Kazon Stormhammer
		quest::faction(219, 15);	#:: + Miners Guild 249
		quest::faction(215, 15);	#:: + Merchants Of Kaladim
		quest::faction(57, -15);	#:: - Craknek Warriors
	}
	#:: Match if faction is Indifferent or worse and a 13741 - Ogre Head and 13740 - Ogre Head
	elsif (($faction > 4) && (plugin::takeItems(13741 => 1, 13740 => 1))) {
		quest::say("Your shifty eyes tell me that you are no ally of the Stormguard.");
		#:: Return a 13741 - Ogre Head
		quest::summonitem(13741);
		#:: Return a 13740 - Ogre Head
		quest::summonitem(13740);
	}
	#:: Match if faction is amiable or better and a 12136 - Dwarf Head
	elsif (($faction <= 4) && (plugin::takeItems(12136 => 1))) {
		quest::say("Ha!! His death brings me great happiness.  I owe you much.  Take this hammer.  It is the hammer of the Bloodforge Brigade.  May it serve you well.  Now go, so I can enjoy this moment of happiness alone.");
 		#:: Reward a 13314 - Bloodforge Hammer
		quest::summonitem(13314);
		#:: Ding!
		quest::ding();
		#:: Grant a moderate amount of expierence
		quest::exp(10000);
		#:: Create a hash for storing cash - 200 to 250cp
		my %cash = plugin::RandomCash(200,250);
		#:: Grant a random cash reward
		quest::givecash($cash{copper},$cash{silver},$cash{gold},$cash{platinum});
		#:: Set factions
		quest::faction(314, 15);	#:: + Storm Guard
		quest::faction(169, 15);	#:: + Kazon Stormhammer
		quest::faction(219, 15);	#:: + Miners Guild 249
		quest::faction(215, 15);	#:: + Merchants Of Kaladim
		quest::faction(57, -15);	#:: - Craknek Warriors   
	}
	#:: Match if faction is Indifferent or worse and a 12136 - Dwarf Head
	elsif (($faction > 4) && (plugin::takeItems(12136 => 1))) {
		quest::say("Your shifty eyes tell me that you are no ally of the Stormguard.");
 		#:: Return a 12136 - Dwarf Head
		quest::summonitem(12136);
	}
	#:: plugin::try_tome_handins(\%itemcount, $class, 'Warrior');
	#:: Return unused items
	plugin::return_items(\%itemcount);
}
