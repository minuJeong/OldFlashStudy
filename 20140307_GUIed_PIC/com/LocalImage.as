package com {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;

	public class LocalImage extends Sprite {

		private var url: String;
		public function LocalImage(url: String) {
			this.url = url;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e: Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			var loader: Loader = new Loader();
			var req: URLRequest = new URLRequest();
			req.url = url;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (e: Event): void {
				var bmp: Bitmap = loader.content as Bitmap;
				addChild(bmp);
				
				bmp.x = Main.STAGE_WIDTH * .5 - bmp.width * .5;
				bmp.y = Main.STAGE_HEIGHT * .5 - bmp.height * .5;
			});
			loader.load(req);
			
			addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void {startDrag();});
			addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent):void {stopDrag();});
		}

	}

}