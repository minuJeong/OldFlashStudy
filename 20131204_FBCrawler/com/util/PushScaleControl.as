package com.util{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.events.Event;

	public class PushScaleControl {

		public function PushScaleControl() {
			// constructor code
		}

		public static function add(object:DisplayObject, scaleControl:Number = 0.60):void {

			var targetScaleX:Number = 1.00;
			var targetScaleY:Number = 1.00;

			object.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void {
			   targetScaleX = scaleControl;
			   targetScaleY = scaleControl;
			});

			object.addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent):void {
			   targetScaleX = 1.00;
			   targetScaleY = 1.00;
			});

			object.addEventListener(Event.ENTER_FRAME, function(e:Event):void {
			   object.scaleX += (targetScaleX - object.scaleX) * .45;
			   object.scaleY += (targetScaleY - object.scaleY) * .45;
			});

		}

	}

}