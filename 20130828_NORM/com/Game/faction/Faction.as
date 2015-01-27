package com.Game.faction{

	import starling.events.EventDispatcher;
	import com.Game.faction.privates.Faction_Privates;
	import com.Game.faction.race.Faction_Race;
	import com.Game.faction.guild.Faction_Guild;
	import com.Game.faction.nation.Faction_Nation;
	import com.Game.faction.religion.Faction_Religion;

	public class Faction extends EventDispatcher {

		public static const FACTION_GAIN_PUBLIC_REPUTATION:String = 'faction gain public reputation';
		public static const FACTION_GAIN_PLAYER_REPUTATION:String = 'faction gain player reputation';
		public static const FACTION_FAIL_GAIN_PLAYER_REPUTATION:String = 'faction fail gain player reputation';

		public static const FACTION_BECOME_FAMILIAR:String = 'faction become familiar';
		public static const FACTION_BECOME_NEUTRAL:String = 'faction become neutral';
		public static const FACTION_BECOME_HOSTILE:String = 'faction become hostile';

		public var race:Faction_Race;
		public var guild:Faction_Guild;
		public var nation:Faction_Nation;
		public var religion:Faction_Religion;

		public var raceSeriocity:Number = 5.00;
		public var guildSeriocity:Number = 5.00;
		public var nationSeriocity:Number = 5.00;
		public var religionSeriocity:Number = 5.00;

		public var publicReputation:Number = 0.00;
		public var playerReputation:Number = 0.00;

		public var familiarRaces:Array;
		public var familiarGuilds:Array;
		public var familiarNations:Array;
		public var familiarReligions:Array;
		public var familiarPrivates:Array;
		public var familiarToPlayer:Boolean = false;

		public var neutralRaces:Array;
		public var neutralGuilds:Array;
		public var neutralNations:Array;
		public var neutralReligions:Array;
		public var neutralPrivates:Array;
		public var neutralToPlayer:Boolean = true;

		public var hostileRaces:Array;
		public var hostileGuilds:Array;
		public var hostileNations:Array;
		public var hostileReligions:Array;
		public var hostilePrivates:Array;
		public var hostileToPlayer:Boolean = false;

		public function Faction() {
			familiarRaces = new Array();
			familiarGuilds = new Array();
			familiarNations = new Array();
			familiarReligions = new Array();
			familiarPrivates = new Array();

			neutralRaces = new Array();
			neutralGuilds = new Array();
			neutralNations = new Array();
			neutralReligions = new Array();
			neutralPrivates = new Array();

			hostileRaces = new Array();
			hostileGuilds = new Array();
			hostileNations = new Array();
			hostileReligions = new Array();
			hostilePrivates = new Array();
		}

		public function gainPublicReputation(n:Number = 1.00):void {
			publicReputation +=  n;
			dispatchEventWith(Faction.FACTION_GAIN_PUBLIC_REPUTATION);
		}



		public function isFamiliarRace(someone:Faction):Boolean {
			for (var i:int = familiarRaces.length - 1; i >= 0; i--) {
				var thisRace:Faction_Race = familiarRaces[i];
				if (thisRace == someone.race) {
					return true;
				}
			}

			return false;
		}
		public function isFamiliarGuild(someone:Faction):Boolean {
			for (var i:int = familiarGuilds.length - 1; i >= 0; i--) {
				var thisGuild:Faction_Guild = familiarGuilds[i];

				if (thisGuild == someone.guild) {
					return true;
				}
			}

			return false;
		}
		public function isFamiliarNation(someone:Faction):Boolean {
			for (var i:int = familiarNations.length - 1; i >= 0; i--) {
				var thisNation:Faction_Nation = familiarNations[i];

				if (thisNation == someone.nation) {
					return true;
				}
			}

			return false;
		}
		public function isFamiliarReligion(someone:Faction):Boolean {
			for (var i:int = familiarReligions.length - 1; i >= 0; i--) {
				var thisReligion:Faction_Religion = familiarReligions[i];

				if (thisReligion == someone.religion) {
					return true;
				}
			}

			return false;
		}



		public function isNeutralRace(someone:Faction):Boolean {
			for (var i:int = neutralRaces.length - 1; i >= 0; i--) {
				var thisRace:Faction_Race = neutralRaces[i];
				if (thisRace == someone.race) {
					return true;
				}
			}

			return false;
		}
		public function isNeutralGuild(someone:Faction):Boolean {
			for (var i:int = neutralGuilds.length - 1; i >= 0; i--) {
				var thisGuild:Faction_Guild = neutralGuilds[i];

				if (thisGuild == someone.guild) {
					return true;
				}
			}

			return false;
		}
		public function isNeutralNation(someone:Faction):Boolean {
			for (var i:int = neutralNations.length - 1; i >= 0; i--) {
				var thisNation:Faction_Nation = neutralNations[i];

				if (thisNation == someone.nation) {
					return true;
				}
			}

			return false;
		}
		public function isNeutralReligion(someone:Faction):Boolean {
			for (var i:int = neutralReligions.length - 1; i >= 0; i--) {
				var thisReligion:Faction_Religion = neutralReligions[i];

				if (thisReligion == someone.religion) {
					return true;
				}
			}

			return false;
		}


		public function isHostileRace(someone:Faction):Boolean {
			for (var i:int = hostileRaces.length - 1; i >= 0; i--) {
				var thisRace:Faction_Race = hostileRaces[i];
				if (thisRace == someone.race) {
					return true;
				}
			}

			return false;
		}
		public function isHostileGuild(someone:Faction):Boolean {
			for (var i:int = hostileGuilds.length - 1; i >= 0; i--) {
				var thisGuild:Faction_Guild = hostileGuilds[i];

				if (thisGuild == someone.guild) {
					return true;
				}
			}

			return false;
		}
		public function isHostileNation(someone:Faction):Boolean {
			for (var i:int = hostileNations.length - 1; i >= 0; i--) {
				var thisNation:Faction_Nation = hostileNations[i];

				if (thisNation == someone.nation) {
					return true;
				}
			}

			return false;
		}
		public function isHostileReligion(someone:Faction):Boolean {
			for (var i:int = hostileReligions.length - 1; i >= 0; i--) {
				var thisReligion:Faction_Religion = hostileReligions[i];

				if (thisReligion == someone.religion) {
					return true;
				}
			}

			return false;
		}


		public function valueFirstMeetScore(someone:Faction):Number {

			if (isHostileGuild(someone) || isHostileNation(someone)   ||
			    isHostileRace(someone)  || isHostileReligion(someone) ) {
				return -50.00;
			}

			var score:Number = 0.00;

			if (isFamiliarGuild(someone)) {
				score +=  guildSeriocity;
			}

			if (isFamiliarNation(someone)) {
				score +=  nationSeriocity;
			}

			if (isFamiliarRace(someone)) {
				score +=  raceSeriocity;
			}

			if (isFamiliarReligion(someone)) {
				score +=  religionSeriocity;
			}

			return score;

		}



		public function gainPlayerReputation(n:Number = 1.00):void {
			if (! hostileToPlayer) {
				playerReputation +=  n;
				dispatchEventWith(Faction.FACTION_GAIN_PLAYER_REPUTATION);
			} else {
				dispatchEventWith(Faction.FACTION_FAIL_GAIN_PLAYER_REPUTATION);
			}


			if (playerReputation <= -50.00) {
				setHostile();
			}

			if (playerReputation >= 50.00) {
				setFamiliar();
			}

			if (playerReputation >= -30.00 && playerReputation <= 30.00) {
				setNeutral();
			}
		}

		public function setHostile():void {
			familiarToPlayer = false;
			neutralToPlayer = false;
			hostileToPlayer = true;

			if (playerReputation >= -50.00) {
				playerReputation = -50.00;
			}
		}

		public function setNeutral():void {
			familiarToPlayer = false;
			neutralToPlayer = true;
			hostileToPlayer = false;

			if (playerReputation >= 30.00) {
				playerReputation = 30.00;
			}

			if (playerReputation <= -30.00) {
				playerReputation = -30.00;
			}
		}

		public function setFamiliar():void {
			familiarToPlayer = true;
			neutralToPlayer = false;
			hostileToPlayer = false;

			if (playerReputation <= 50.00) {
				playerReputation = 50.00;
			}
		}

	}

}