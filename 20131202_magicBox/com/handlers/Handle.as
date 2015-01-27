package com.handlers{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class Handle extends Sprite {

		public static const VALID_CLICK:String = "validButtonClick";

		private var targetScale:Number = 1.0;

		public function Handle() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		protected function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			addEventListener(MouseEvent.MOUSE_DOWN, function(e){targetScale = 0.9;});
			addEventListener(MouseEvent.MOUSE_UP, function(e){targetScale = 1.0;});
			addEventListener(MouseEvent.MOUSE_OUT, function(e){targetScale = 1.0;});

			addEventListener(Event.ENTER_FRAME, function(e){
			 var deltaScale:Number = targetScale - scaleX;
			 scaleX += deltaScale * .3;
			 scaleY += deltaScale * .3;
			});
		}

		protected function onClick(e:MouseEvent):void {
			dispatchEvent(new Event(VALID_CLICK));
		}

	}

}