package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import starling.core.Starling;
	import starling.events.Event;
	
	
	public class Main extends MovieClip {
		
		public function Main() {
			addEventListener(flash.events.Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:flash.events.Event):void {
			removeEventListener(flash.events.Event.ADDED_TO_STAGE, init);
			
			var mStarling:Starling = new Starling(Game, stage);
			mStarling.start();
			mStarling.addEventListener(starling.events.Event.ROOT_CREATED, function(e:starling.events.Event):void {
				var game:Game = mStarling.root as Game
				game.init();
			});
		}
	}
	
}
