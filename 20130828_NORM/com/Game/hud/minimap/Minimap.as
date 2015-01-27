package com.Game.hud.minimap{
	import starling.display.Sprite;
	import starling.events.Event;

	public class Minimap extends Sprite {

		public function Minimap() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			
		}

	}

}