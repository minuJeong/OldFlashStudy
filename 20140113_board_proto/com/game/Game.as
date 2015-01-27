package com.game {
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	import flash.filesystem.File;

	public class Game extends Sprite {

		public function Game() {}

		public static var mAssets: AssetManager;
		public function start(): void {
			mAssets = new AssetManager();
			mAssets.enqueue(File.applicationDirectory.resolvePath("/res/texture"));
			mAssets.loadQueue(function (ratio: Number): void {
				if (ratio == 1.00) {
					initGame();
				}
			});
		}

		private function initGame(): void {
			trace("initGame");

			
		}

	}

}