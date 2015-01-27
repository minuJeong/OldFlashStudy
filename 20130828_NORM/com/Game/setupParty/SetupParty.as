package com.Game.setupParty{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Image;
	import com.Game.Game;
	import starling.textures.TextureAtlas;

	public class SetupParty extends Sprite {

		private var mUserParty:UserParty;

		public function SetupParty() {
			addEventListener(Event.ADDED_TO_STAGE,init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE,init);

			var setupPartyAtlas:TextureAtlas = Game.mAssets.getTextureAtlas('setupParty');
			//list of current possess mobs(characters)
			//select party
		}

		public function get userParty():UserParty {

			return mUserParty;

		}

	}

}