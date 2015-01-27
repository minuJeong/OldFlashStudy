package com {

	import flash.display.MovieClip;
	import flash.events.Event;
	import starling.core.Starling;
	import starling.events.Event;
	import com.game.Game;

	[SWF(width = 2048, height = 1536)]
	public class Main extends MovieClip {

		private var mStarling: Starling;

		public function Main() {
			addEventListener(flash.events.Event.ADDED_TO_STAGE, init);
		}

		private function init(e: flash.events.Event): void {
			removeEventListener(flash.events.Event.ADDED_TO_STAGE, init);

			mStarling = new Starling(Game, stage);
			mStarling.addEventListener(starling.events.Event.ROOT_CREATED, function (e): void {
				var game: Game = mStarling.root as Game;
				game.start();
			});

			mStarling.start();
		}
	}

}