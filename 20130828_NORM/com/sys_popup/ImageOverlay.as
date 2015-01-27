package com.sys_popup{
	import starling.display.Sprite;
	import starling.display.Image;
	import com.Game.Game;
	import starling.animation.Tween;
	import starling.animation.Transitions;
	import starling.core.Starling;

	public class ImageOverlay extends Sprite {

		public function ImageOverlay() {

		}

		public static function overlayImage(textureName:String, 
		                                    initX:Number = 0, initY:Number = 0,
		                                    targetX:Number = 0, targetY:Number = 0, 
		                                    duration:Number = 0.50,
		                                    fade:Boolean = true,
		                                    scaleFactor:Number = 1.50, onComplete:Function = null):void {

			var image:Image = new Image(Game.mAssets.getTexture(textureName));
			image.scaleX = image.scaleY = scaleFactor;
			image.pivotX = image.width / (scaleFactor * 2);
			image.pivotY = image.height / (scaleFactor * 2);

			image.x = initX;
			image.y = initY;
			Game.imagePopLayer.addChild(image);

			var tween:Tween = new Tween(image,duration,Transitions.LINEAR);
			tween.moveTo(targetX, targetY);
			if (fade) {
				tween.fadeTo(0.00);
			}

			Starling.juggler.add(tween);
			tween.onComplete = onComplete;

		}

	}

}