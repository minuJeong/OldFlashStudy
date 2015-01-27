package com.units {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;

	public class Unit extends Sprite {

		public var targetX: Number = 0;
		public var unitName: String = "no name player";
		public var score: Number = 0;

		public static var unitCount: int = 0;

		public function Unit(unitName: String) {
			this.unitName = unitName;
			unitCount++;

			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e: Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			var childNumber: TextField = addChild(new TextField()) as TextField;
			childNumber.x = -20;
			childNumber.y = 25;
			childNumber.appendText("player" + unitCount.toString());

			targetX = x;

			addEventListener(Event.ENTER_FRAME, update);
		}

		private function update(e: Event): void {
			var dx: Number = targetX - x;
			x += dx * .3;
		}

	}

}