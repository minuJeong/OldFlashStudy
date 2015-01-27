package com.stage {
	import starling.display.Sprite;
	import starling.events.Event;

	public class GameStage extends Sprite {

		public function GameStage() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e: Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

	}

}