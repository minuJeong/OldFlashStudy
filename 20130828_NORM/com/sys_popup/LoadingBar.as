package com.sys_popup{

	import flash.display.Shape;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import starling.display.Quad;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.core.Starling;
	import starling.text.TextField;

	public class LoadingBar extends Sprite {

		private var baseRect:Rectangle;

		private var mBar:Quad;
		private var mBackground:Image;

		public function LoadingBar(initX:Number, initY:Number, width, height) {

			x = initX;
			y = initY;

			baseRect = new Rectangle();
			baseRect.width = width;
			baseRect.height = height;

			init();
		}

		private function init():void {

			var scale:Number = Starling.contentScaleFactor;

			x -=  scale * baseRect.width * .5;
			y -=  scale * baseRect.height * .5;

			var bgShape:Shape = new Shape();
			bgShape.graphics.beginFill(0x0, 0.5);
			bgShape.graphics.drawRect(0, 0,
			                          baseRect.width*scale, baseRect.height*scale);
			bgShape.graphics.endFill();

			var bgBitmapData:BitmapData = new BitmapData(baseRect.width * scale,baseRect.height * scale,true,0x0);
			bgBitmapData.draw(bgShape);
			var bgTexture:Texture = Texture.fromBitmapData(bgBitmapData,false,false,scale);

			mBackground = new Image(bgTexture);
			addChild(mBackground);


			mBar = new Quad(baseRect.width,baseRect.height,0x30b020);
			mBar.setVertexColor(2, 0x208030);
			mBar.setVertexColor(3, 0x208030);
			mBar.scaleX = 0;
			addChild(mBar);

		}

		public function set ratio(n:Number):void {
			mBar.scaleX = Math.max(0.0,Math.min(1.0,n));
		}

		public function get ratio():Number {
			return mBar.scaleX;
		}
	}

}