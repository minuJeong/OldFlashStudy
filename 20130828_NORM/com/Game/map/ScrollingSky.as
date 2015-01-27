package com.Game.map{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Image;
	import com.Game.Game;
	import com.Main;
	import starling.textures.TextureSmoothing;

	public class ScrollingSky extends Sprite {

		private var maps:Array;

		public var mapScrollSpeed:Number = 0.25;

		public function ScrollingSky(initScale:Number = 1) {
			scaleX = scaleY = initScale;

			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			maps = new Array();

			for (var i:int = 3; i >= 0; i--) {
				var newMapTile:Image = new Image(Game.mAssets.getTexture("sky"));
				var wUnit:Number = newMapTile.width;
				newMapTile.smoothing = TextureSmoothing.NONE;
				newMapTile.x = wUnit * i;
				addChild(newMapTile);

				maps.push(newMapTile);
			}

			var totalWidth:Number = (maps.length - 1) * wUnit;

			Game.gameEventDispatcher.addEventListener(Game.GAME_ENTER_FRAME, function(e:Event):void {
			        for each(var thisMap:Image in maps) {
			           thisMap.x -= mapScrollSpeed * Game.mapScrollEfficiency;
			   
			           if (thisMap.x <= - thisMap.width) {
			              thisMap.x += totalWidth;
			              setChildIndex(thisMap, 0);
			           }
			   
			           if (thisMap.x >= totalWidth - thisMap.width) {
			              thisMap.x -= totalWidth; 
			              setChildIndex(thisMap, numChildren - 1);
			           }
			        }
			     }
			  );
		}

	}

}