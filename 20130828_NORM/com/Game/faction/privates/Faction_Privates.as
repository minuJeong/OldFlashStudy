package com.Game.faction.privates{

	import com.Game.faction.Faction;
	import com.Game.faction.race.Faction_Race;
	import com.Game.faction.guild.Faction_Guild;
	import com.Game.faction.nation.Faction_Nation;

	public class Faction_Privates extends Faction {

		public static const NAME_ANONYMOUS:String = 'name anonymous';

		public var name:String;
		public var friends:Array;

		public function Faction_Privates() {

			friends  = new Array();

		}

		public function meetNewFaction(someone:Faction_Privates):void {
			var score:Number = valueFirstMeetScore(someone);
			if (score >= 50.00) {
				familiarPrivates.push(someone);
			}
		}

	}

}