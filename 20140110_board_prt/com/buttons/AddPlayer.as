package com.buttons {
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class AddPlayer extends ButtonBase {
		public static const ADD_PLAYER: String = "add player";
		public function AddPlayer() {
			addEventListener(MouseEvent.CLICK, function (e: MouseEvent): void {
				dispatchEvent(new Event(ADD_PLAYER));
			});
		}
	}

}