package com{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.Stage;
	import com.tab.Tab;
	import com.handlers.ControlHandles;
	import com.handlers.BoxHandle;


	public class Main extends MovieClip {

		public static var MAIN_STAGE:Stage;
		private var mainLayer:Sprite;

		public function Main() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			MAIN_STAGE = stage;

			mainLayer = addChild(new Sprite()) as Sprite;

			var tab = mainLayer.addChild(new Tab()) as Tab;
			tab.x = stage.stageWidth * .5;
			tab.y = stage.stageHeight * .5;
		}
	}
}