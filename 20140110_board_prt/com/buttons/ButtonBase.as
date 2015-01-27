package com.buttons {
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.Sprite;

	public class ButtonBase extends Sprite {

		public function ButtonBase() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}


		private var targetScale: Number = 1.00;
		private function init(e: Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			addEventListener(MouseEvent.MOUSE_DOWN, function (e: MouseEvent): void {
				targetScale = .95;
			});
			addEventListener(MouseEvent.MOUSE_UP, function (e: MouseEvent): void {
				targetScale = 1.00;
			});

			addEventListener(Event.ENTER_FRAME, function (e: Event): void {
				var deltaScaleX: Number = targetScale - scaleX;
				var deltaScaleY: Number = targetScale - scaleY;

				scaleX += deltaScaleX * .3;
				scaleY += deltaScaleX * .3;
			});
		}


	}

}