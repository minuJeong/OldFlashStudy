package com.buttons {
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class RollDice extends ButtonBase {
		public static const ROLL: String = 'roll'
		public function RollDice() {
			addEventListener(MouseEvent.CLICK, function (e: MouseEvent): void {
				dispatchEvent(new Event(ROLL));
			});
		}

	}

}