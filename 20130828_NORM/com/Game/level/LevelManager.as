package com.Game.level{
	import starling.display.Sprite;
	import starling.events.Event;
	import com.Game.map.Background;
	import com.Game.Game;

	public class LevelManager extends Sprite {

		private var targetBackground:Background;

		private var currentLevel:String;

		public function LevelManager(bg:Background) {

			targetBackground = bg;

			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			//to do ::  change map tile

		}

	}

}