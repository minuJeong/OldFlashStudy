package com.Game.map{
	import starling.display.Sprite;
	import starling.display.Image;
	import com.Game.Game;
	import starling.events.Event;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureSmoothing;

	public class SubMapTile extends Sprite {

		public var tileType:String;

		private var image:Image;
		private var fade:Image;

		public function SubMapTile(tileType:String) {

			this.tileType = tileType;

			scaleX = scaleY = 2.00;

			addEventListener(Event.ADDED_TO_STAGE, init);

		}

		private function init(e:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, init);

			var textureAtlas:TextureAtlas = Game.mAssets.getTextureAtlas('subMapTile');
			image = addChild(new Image(textureAtlas.getTexture(tileType))) as Image;
			image.smoothing = TextureSmoothing.NONE;

		}

		public function setTile(str:String):void {

			if (str == tileType) {
				return;
			}

			if (image) {
				image.removeFromParent(true);
			}

			if (fade) {
				fade.removeFromParent(true);
			}

			tileType = str;

			var textureAtlas:TextureAtlas = Game.mAssets.getTextureAtlas('subMapTile');
			image = addChild(new Image(textureAtlas.getTexture(tileType))) as Image;
			image.smoothing = TextureSmoothing.NONE;

			fade = addChild(new Image(textureAtlas.getTexture(tileType + '_fade'))) as Image;
			fade.x =  -  fade.width;
			fade.smoothing = TextureSmoothing.NONE;

		}

	}

}