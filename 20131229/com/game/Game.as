package com.game {
	import starling.display.Sprite;
	import Box2D.Dynamics.b2World;
	import starling.utils.AssetManager;
	import flash.filesystem.File;

	public class Game extends Sprite {

		public static var b2world: b2World;
		public static var mAssets: AssetManager;

		public function Game() {}

		public function setup(): void {
			mAssets = new AssetManager(1.0, false);
			mAssets.enqueue(File.applicationDirectory.resolvePath("res/textures"));
			mAssets.loadQueue(function (ratio: Number): void {});
		}

	}

}