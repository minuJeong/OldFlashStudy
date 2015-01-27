package com.util.pop{

	import flash.display.MovieClip;
	import flash.events.Event;


	public class FileExistsWarning extends MovieClip {

		private var life:int = 0;
		private var targetAlpha:Number = 0.0;

		public function FileExistsWarning() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			alpha = 0;

			addEventListener(Event.ENTER_FRAME, update);
		}

		private function update(e:Event):void {
			if (life >= 0) {
				life--;
				targetAlpha = 1.0;
			} else {
				targetAlpha = 0.0;
			}

			var deltaAlpha:Number = targetAlpha - alpha;
			alpha +=  deltaAlpha * .3;
		}

		public function toast(life:uint):void {
			this.life = life;
		}
	}

}