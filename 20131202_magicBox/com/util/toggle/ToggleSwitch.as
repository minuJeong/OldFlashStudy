package com.util.toggle{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;


	public class ToggleSwitch extends MovieClip {

		public var isOn:Boolean = false;
		private var toFrame:int = 1;

		public function ToggleSwitch() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			stop();

			addEventListener(MouseEvent.CLICK, toggleOnOff);
			addEventListener(Event.ENTER_FRAME, update);
		}

		private function toggleOnOff(e:MouseEvent):void {
			isOn = ! isOn;
			dispatchEvent(new Event(Event.CHANGE));

			if (isOn) {
				toFrame = 60;
			} else {
				toFrame = 1;
			}
		}

		private function update(e:Event):void {
			var deltaFrames:Number = toFrame - currentFrame;
			if (Math.abs(deltaFrames) < 1) {
				gotoAndStop(toFrame);
			} else {
				var targetFrame:int = Math.round(currentFrame + deltaFrames * .4);
				gotoAndStop(targetFrame);
			}
		}
	}

}