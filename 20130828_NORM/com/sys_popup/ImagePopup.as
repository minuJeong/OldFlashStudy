package com.sys_popup{

	import starling.core.Starling;

	import starling.display.Sprite;
	import starling.display.Image;
	import starling.display.Graphics;
	import starling.animation.Tween;
	import starling.animation.Transitions;

	import com.Main;
	import com.Game.Game;

	public class ImagePopup extends Sprite {

		public function ImagePopup() {

		}

		public static function popImage(textureName:String, completeCallBack:Function, scaleFactor:Number = 1.50):void {

			var g:Graphics = new Graphics(Game.graphicsLayer);
			g.beginFill(0x000000, .4);
			g.drawRect(0, 0, Main.stageWidth, Main.stageHeight);

			var image:Image = new Image(Game.mAssets.getTexture(textureName));
			image.scaleX = image.scaleY = scaleFactor;
			image.pivotX = image.width / (scaleFactor * 2);
			image.pivotY = image.height / (scaleFactor * 2);
			image.x = Main.stageWidth >> 1;
			image.y = 0;
			Game.imagePopLayer.addChild(image);

			var tween:Tween = new Tween(image,0.70,Transitions.EASE_OUT_BOUNCE);
			tween.moveTo(Main.stageWidth >> 1, Main.stageHeight >> 1);
			Starling.juggler.add(tween);

			tween.onComplete = function () {
			    Starling.juggler.remove(tween);
			
			    Starling.juggler.delayCall(function(){
			       tween = new Tween(image, 0.20, Transitions.LINEAR);
			       tween.moveTo(Main.stageWidth >> 1, Main.stageHeight * 2);
			       Starling.juggler.add(tween);
			   
			       tween.onComplete = function () {
			           Starling.juggler.remove(tween);
			           g.clear();
			   
			           Game.imagePopLayer.removeChild(image);
			           completeCallBack();
			       }
			    }, 0.50);
			};

		}

	}

}