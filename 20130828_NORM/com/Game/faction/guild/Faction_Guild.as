package com.Game.faction.guild{

	import com.Game.faction.Faction;
	import com.Game.faction.race.Faction_Race;

	public class Faction_Guild extends Faction {

		public static const GUILD_NONE:String = 'guild none';

		public static const GUILD_EVENT_JOIN:String = 'guild event join';

		public var isMember:Boolean = false;

		public function Faction_Guild() {
		}


		public function joinGuild():void {
			isMember = true;

			if (hostileToPlayer) {
				setNeutral();
			}
		}

		public function dropOutGuild():void {
			isMember = false;
		}

	}

}