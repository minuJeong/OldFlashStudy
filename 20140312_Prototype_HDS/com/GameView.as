package com {
	import starling.display.Sprite;
	import starling.events.Event;

	public class GameView extends Sprite {

		public function GameView() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e: Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

	}

}