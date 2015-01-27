package com.Game.map{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Image;
	import com.Game.Game;
	import com.Main;

	public class ScrollingMap extends Sprite {

		private var mapManager:Background;

		private var maps:Array;

		private const tileCount:int = 3;

		public var mapScrollSpeed:Number = 4.5;
		private const tileWUnit:Number = 256;
		private var totalWidth:Number = 0;

		public function ScrollingMap(mapManager:Background, initScale:Number = 1) {

			this.mapManager = mapManager;

			scaleX = scaleY = initScale;

			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			maps = new Array();

			for (var i:int = tileCount; i >= 0; i--) {
				var newMapTile:MapTile = addChild(new MapTile(mapManager.targetMapType)) as MapTile;
				newMapTile.x = tileWUnit * i;
				newMapTile.y = Main.stageHeight * .50;

				maps.push(newMapTile);
			}

			totalWidth = (tileCount + 1) * tileWUnit;

			Game.gameEventDispatcher.addEventListener(Game.GAME_ENTER_FRAME, update);
		}


		private function update(e:Event):void {

			for each (var thisMap:MapTile in maps) {

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