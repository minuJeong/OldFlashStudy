package com {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.display.Sprite;


	public class Main extends MovieClip {


		public function Main() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e: Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			var bitmapData: BitmapData = new BitmapData(stage.stageWidth * .5, stage.stageHeight, false, 0x904050);

			var bitmap_left: Bitmap = addChild(new Bitmap(bitmapData)) as Bitmap;
			var bitmap_right: Bitmap = addChild(new Bitmap(bitmapData)) as Bitmap;

			bitmap_right.scaleX = -1;
			bitmap_right.x = bitmap_left.width * 2;

			var temps: Sprite = addChild(new Sprite()) as Sprite;
			var isDrawing: Boolean = false;
			stage.addEventListener(MouseEvent.MOUSE_DOWN, function (e: MouseEvent): void {
				temps.graphics.lineStyle(1, 0xc89060);
				temps.graphics.moveTo(mouseX, mouseY);

				isDrawing = true;
			});

			addEventListener(Event.ENTER_FRAME, function (e: Event): void {
				if (!isDrawing) {
					return;
				}

				temps.graphics.lineTo(mouseX, mouseY);

				bitmapData.draw(temps);
			});

			stage.addEventListener(MouseEvent.MOUSE_UP, function (e: MouseEvent): void {
				temps.graphics.lineTo(mouseX, mouseY);

				isDrawing = false;
				temps.graphics.clear();
			});
		}
	}

}