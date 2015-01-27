package com.optionsets{

	import flash.display.MovieClip;
	import flash.events.Event;
	import com.util.radio.RadioGroup;


	public class OptionSet_artworks extends RadioGroup {

		private static const ARTWORKS:String = "artworks";
		private static const ILLUST:String = "illust";

		private var toFrame:int = 1;
		private var _currentSet:String = ARTWORKS;
		private function set currentSet(setName:String):void {
			_currentSet = setName;
			switch (_currentSet) {
				case ARTWORKS :
					toFrame = 1;
					break;

				case ILLUST :
					toFrame = totalFrames;
					break;
			}
		}
		private function get currentSet():String {
			return _currentSet;
		}

		public function OptionSet_artworks() {
			addEventListener(Event.ENTER_FRAME, update);
		}

		public function changeSet():void {
			if (currentSet == ARTWORKS) {
				currentSet = ILLUST;
			} else {
				currentSet = ARTWORKS;
			}
		}

		private function update(e:Event):void {
			if (currentFrame < toFrame) {
				nextFrame();
			} else if (currentFrame > toFrame) {
				prevFrame();
			}
		}
	}

}