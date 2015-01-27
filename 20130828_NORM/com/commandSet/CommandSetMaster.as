package com.commandSet{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.DisplayObject;

	public class CommandSetMaster extends Sprite {

		private var btns:Array;

		public function CommandSetMaster() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			btns = new Array();
			var length:int = numChildren;
			for (var i:int = 0; i < numChildren; i++) {
				var thisChild:DisplayObject = getChildAt(i);
				if (thisChild is CommandSetTemplate) {
					btns.push(thisChild);
				}
			}

		}

		public function on():void {
			for each (var thisBtn in btns) {
				thisBtn.on();
			}
		}

		public function off():void {
			for each (var thisBtn in btns) {
				thisBtn.off();
			}
		}

	}

}