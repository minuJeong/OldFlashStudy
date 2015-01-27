package  {	
	import flash.filesystem.File;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	import com.stage.GameStage;
	import com.GameView;
	
	public class Game extends Sprite {
		
		public static var mAssets:AssetManager;
		public static var game:GameView;

		public function Game() {
		}
		public function init():void {
			mAssets = new AssetManager(1);
			mAssets.verbose = true;
			
			var appDir:File = File.applicationDirectory;
			mAssets.enqueue(appDir.resolvePath("textures/"));
			
			mAssets.loadQueue(
				function(ratio):void {
					if (ratio == 1) {
						gameLoaded();
					}
				}
			);
		}
		
		private function gameLoaded():void {
			initStage();
			
		}
		
		private function initStage():void {
			var stages:Array = new Array();
			stages.push(new GameStage());
			addStage(stages[0]);
		}
		
		private function addStage(gameStage:GameStage):void {
			addChild(gameStage);
		}

	}
	
}
