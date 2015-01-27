package com.Game.mob.party{

	import flash.utils.ByteArray;

	import starling.display.Sprite;
	import starling.events.Event;

	import com.Game.mob.Mob;
	import com.Game.Game;
	import com.Game.mob.MobManager;

	public class Party extends Sprite {

		[Embed(source = '/res/xml/partyData.xml',mimeType = 'application/octet-stream')]
		private static var partyDataXML:Class;
		private static var partyDataParsedXML:XML;

		private var partyName:String;

		public var mobs:Array;

		public function Party(targetName:String) {

			if (partyDataParsedXML == null) {
				var byteArray:ByteArray = new partyDataXML();
				var string:String = byteArray.readUTFBytes(byteArray.length);
				partyDataParsedXML = new XML(string);
			}

			partyName = targetName;

			mobs = getResultParty();
			mobs.length = 3;

		}

		private function getResultParty():Array {

			var resultArray:Array = [];

			for (var i:int = partyDataParsedXML.Party.length() - 1; i >= 0; i--) {
				var thisPartyName:String = partyDataParsedXML.Party[i].partyName;
				if (thisPartyName == partyName) {
					for (var n in partyDataParsedXML.Party[i].mob) {
						var mobName:String = partyDataParsedXML.Party[i].mob[n].type;
						var mob:Mob = new Mob(mobName);
						resultArray.push(mob);
					}
				}
			}

			return resultArray;

		}


		public function incount():void {
			for (var i:int = mobs.length - 1; i >= 0; i--) {
				var thisMob:Mob = mobs[i];
				Game.mobManager.addMob(thisMob.mobName, MobManager.ANTI_SIDE, MobManager.ANON_POSITION);
			}
		}

	}

}