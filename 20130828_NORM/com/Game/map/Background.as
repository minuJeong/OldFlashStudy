package com.Game.map{
	import starling.display.Sprite;
	import starling.events.Event;
	import com.Game.Game;

	public class Background extends Sprite {

		public var targetMapType:String;

		public function Background() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			targetMapType = 'ice';

			addChild(new ScrollingSky(6.00));
			addChild(new ScrollingSubMap(this, 1.00));
			addChild(new ScrollingMap(this, 1.00));

			var d:int = 180;
			Game.gameEventDispatcher.addEventListener(Game.GAME_ENTER_FRAME, function(e:Event):void {
			   d--;
			   if (d == 0) {
			      d = 180;
			      var arr:Array = new Array ('dirt','ice','rock','grass');
			      var n:int = Math.floor(Math.random() * arr.length);
			      targetMapType = arr[n];
			  
			      trace('to ' + targetMapType);
			  
			   }
			});

		}

	}

}