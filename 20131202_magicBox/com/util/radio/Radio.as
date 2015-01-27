package com.util.radio{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;


	public class Radio extends MovieClip {

		public var siblings:Vector.<Radio > ;
		private var group:RadioGroup;
		private var toFrame:int = 1;

		// get/set
		public var m_isOn:Boolean = false;
		public function set isOn(_isOn:Boolean):void {
			m_isOn = _isOn;

			if (m_isOn) {
				toFrame = 60;
				dispatchEvent(new Event(Event.CHANGE));

				for each (var radio:Radio in siblings) {
					radio.isOn = false;
					radio.toFrame = 1;
				}
			} else {
				toFrame = 1;
			}
		}
		public function get isOn():Boolean {
			return m_isOn;
		}



		public function Radio() {
			// init;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			siblings = new Vector.<Radio>();
			if (parent) {
				for (var i:int = parent.numChildren - 1; i >= 0; i--) {
					var child:Radio = parent.getChildAt(i) as Radio;
					if (child) {
						if (child == this) {
							continue;
						}
						siblings.push(child);
					}
				}
			}

			addEventListener(MouseEvent.CLICK, toggleOnOff);
			addEventListener(Event.ENTER_FRAME, update);
		}

		public function toggleOnOff(e:MouseEvent):void {
			isOn = ! isOn;
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