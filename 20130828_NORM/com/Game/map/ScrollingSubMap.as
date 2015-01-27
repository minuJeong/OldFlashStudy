package com.Game.map{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Image;
	import com.Game.Game;
	import com.Main;

	public class ScrollingSubMap extends Sprite {

		private var mapManager:Background;

		private var maps:Array;

		private const tileCount:int = 3;

		public var mapScrollSpeed:Number = 3.5;
		private const tileWUnit:Number = 256;
		private var totalWidth:Number = 0;

		public function ScrollingSubMap(mapManager:Background, initScale:Number = 1) {

			this.mapManager = mapManager;

			scaleX = scaleY = initScale;

			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			maps = new Array();

			for (var i:int = tileCount; i >= 0; i--) {
				var newSubMapTile:SubMapTile = addChild(new SubMapTile(mapManager.targetMapType)) as SubMapTile;
				newSubMapTile.x = tileWUnit * i;
				newSubMapTile.y = Main.stageHeight * .35;

				maps.push(newSubMapTile);
			}

			totalWidth = (tileCount + 1) * tileWUnit;

			Game.gameEventDispatcher.addEventListener(Game.GAME_ENTER_FRAME, update);
		}


		private function update(e:Event):void {

			for each (var thisMap:SubMapTile in maps) {

				thisMap.x -=  mapScrollSpeed * Game.mapScrollEfficiency;

				if (thisMap.x <=  -  tileWUnit) {
					if (mapManager.targetMapType != thisMap.tileType) {
						thisMap.setTile(mapManager.targetMapType);
					}
					thisMap.x +=  totalWidth;
					setChildIndex(thisMap, numChildren - 1);
				}

				if (thisMap.x > totalWidth) {
					thisMap.x -=  totalWidth;
					setChildIndex(thisMap, 0);
				}
			}


		}

	}

}