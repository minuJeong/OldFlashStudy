package com.toy{

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Bitmap;

	import com.facebook.graph.FacebookDesktop;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.BitmapData;
	import com.oskarwicha.images.FaceDetection.FaceDetector;
	import com.oskarwicha.images.FaceDetection.Events.FaceDetectorEvent;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import com.util.RGBHSLConverter;
	import flash.text.TextField;

	public class CharacterFromFacebook extends Sprite {

		private var id:String = "";

		public function CharacterFromFacebook(id:String) {
			var loader:Loader = new Loader();

			this.id = id;
			loader.load(new URLRequest("http://graph.facebook.com/" + id + "/picture?type=large"));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadPicture);
		}

		private function onLoadPicture(e:Event):void {
			var bitmap:Bitmap = addChild(e.target.content) as Bitmap;
			bitmap.x = 400;
			bitmap.y = 200;


			// making pallete
			// face color
			var f:Number = getFaceColor(bitmap);
			var comment_f:TextField = addChild(new TextField()) as TextField;
			comment_f.text = "face color";
			comment_f.textColor = 0xffffff - f;
			comment_f.x = 0;
			comment_f.y = 0;
			graphics.beginFill(f);
			graphics.drawRect(0,0,200, 200);

			// average color
			var a:Number = getAverageColor(bitmap);
			var comment_a:TextField = addChild(new TextField()) as TextField;
			comment_a.text = "average color";
			comment_a.textColor = 0xffffff - a;
			comment_a.x = 200;
			comment_a.y = 0;
			graphics.beginFill(a);
			graphics.drawRect(200,0,200, 200);

			//face-average color
			var m:Number = colorize(getMiddleRGB(decolorize(a),decolorize(f)));
			var comment_m:TextField = addChild(new TextField()) as TextField;
			comment_m.text = "face-average color";
			comment_m.textColor = 0xffffff - m;
			comment_m.x = 50;
			comment_m.y = 50;
			graphics.beginFill(m);
			graphics.drawRect(50,50,100, 100);

			// rgb sample color
			var r:Number = a >> 16 & 0xff;
			var g:Number = a >> 8 & 0xff;
			var b:Number = a & 0xff;

			// darker color
			var d:Number = colorize(hslMod([r,g,b],[1,0.8,0.75]));
			var comment_d:TextField = addChild(new TextField()) as TextField;
			comment_d.text = "dark color";
			comment_d.textColor = 0xffffff - d;
			comment_d.x = 0;
			comment_d.y = 200;
			graphics.beginFill(d);
			graphics.drawRect(0,200,200, 200);

			// darker color 2
			var k:Number = colorize(rgbMod([r,g,b],[0.3,0.3,0.3]));
			var comment_k:TextField = addChild(new TextField()) as TextField;
			comment_k.text = "darker color";
			comment_k.textColor = 0xffffff - k;
			comment_k.x = 50;
			comment_k.y = 250;
			graphics.beginFill(k);
			graphics.drawRect(50,250,100,100);

			// brighter color
			var l:Number = colorize(hslMod([r,g,b],[1.5,1.2,1]));
			var comment_l:TextField = addChild(new TextField()) as TextField;
			comment_l.text = "bright color";
			comment_l.textColor = 0xffffff - l;
			comment_l.x = 200;
			comment_l.y = 200;
			graphics.beginFill(l);
			graphics.drawRect(200,200,200, 200);

			// strong color
			var s:Number = colorize(hslMod([r,g,b],[1,1.4,0.9]));
			var comment_s:TextField = addChild(new TextField()) as TextField;
			comment_s.text = "strong color";
			comment_s.textColor = 0xffffff - s;
			comment_s.x = 200;
			comment_s.y = 400;
			graphics.beginFill(s);
			graphics.drawRect(200,400,200,200);

			// source image
			var source:Array = [];
			source.push([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
			source.push([0,0,0,0,0,0,d,d,d,d,d,d,d,0,0,0,0,0,0,0,0]);
			source.push([0,0,0,0,0,d,d,s,d,d,d,s,d,d,0,0,0,0,0,0,0]);
			source.push([0,0,0,0,0,d,d,s,s,s,s,s,d,d,0,0,0,0,0,0,0]);
			source.push([0,0,0,0,a,m,a,s,f,f,f,s,d,m,a,0,0,0,0,0,0]);
			source.push([0,0,0,0,a,m,f,k,f,f,f,k,f,m,a,0,0,0,0,0,0]);
			source.push([0,0,0,0,0,a,m,k,f,f,f,k,m,a,0,0,0,0,0,0,0]);
			source.push([0,0,0,0,0,0,m,f,f,f,f,f,m,0,0,0,0,0,0,0,0]);
			source.push([0,0,0,0,0,0,0,a,m,s,m,a,0,0,0,0,0,0,0,0,0]);
			source.push([0,0,0,0,0,0,r,r,l,s,l,r,r,0,0,0,0,0,0,0,0]);
			source.push([0,k,0,0,0,g,g,r,l,s,l,r,g,g,0,0,0,0,0,0,0]);
			source.push([0,k,k,0,0,g,g,r,l,s,l,r,g,g,k,0,0,0,0,0,0]);
			source.push([0,0,k,k,0,g,g,m,r,b,r,m,g,g,k,0,0,0,0,0,0]);
			source.push([0,0,0,k,k,f,f,0,r,b,r,0,f,f,k,0,0,0,0,0,0]);
			source.push([0,0,0,0,k,k,f,0,b,0,b,0,f,0,k,k,0,0,0,0,0]);
			source.push([0,0,0,0,0,k,k,0,b,0,b,0,0,k,k,k,0,0,0,0,0]);
			source.push([0,0,0,0,0,0,0,0,a,0,a,0,0,k,k,0,0,0,0,0,0]);
			source.push([0,0,0,0,0,0,0,0,a,0,a,0,0,k,0,0,0,0,0,0,0]);
			source.push([0,0,0,0,0,0,k,k,k,0,k,k,k,0,0,0,0,0,0,0,0]);
			source.push([0,0,0,0,0,0,k,k,k,0,k,k,k,0,0,0,0,0,0,0,0]);
			source.push([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);

			// paint
			for (var i:int = source.length - 1; i >= 0; i--) {
				for (var j:int = source[0].length; j >= 0; j--) {
					if (source[i][j] == 0 || source[i][j] == null) {
						continue;
					}
					graphics.beginFill(source[i][j]);
					graphics.drawRect(50 + 5 * j, 450 + 5 * i, 5, 5);
				}
			}
		}

		// tools
		private function colorize(rgb:Array):Number {
			var r:Number = rgb[0];
			var g:Number = rgb[1];
			var b:Number = rgb[2];

			return r << 16 | g << 8 | b;
		}

		private function decolorize(n:Number):Array {
			var result:Array = new Array();
			result.push(n >> 16 & 0xff);
			result.push(n >> 8 & 0xff);
			result.push(n & 0xff);

			return result;
		}

		private function getAverageColorOf(colors:Vector.<Number>):Number {
			var sumR:Number = 0;
			var sumG:Number = 0;
			var sumB:Number = 0;

			for each (var color:Number in colors) {
				sumR +=  color >> 16 & 0xff;
				sumG +=  color >> 8 & 0xff;
				sumB +=  color & 0xff;
			}

			var averageR:Number = sumR / colors.length;
			var averageG:Number = sumG / colors.length;
			var averageB:Number = sumB / colors.length;

			var resultColor:Number = averageR << 16 | averageG << 8 | averageB;

			return resultColor;
		}

		private function gatherAround(bitmap:Bitmap, centerPoint:Point = null, range:Number = 10, unit:Number = 1):Vector.<Number >  {
			if (! centerPoint) {
				centerPoint = new Point();
				centerPoint.x = bitmap.bitmapData.width * .5;
				centerPoint.y = bitmap.bitmapData.height * .5;
			}

			var result:Vector.<Number> = new Vector.<Number>();
			for (var x_cor:int = range; x_cor >= 0; x_cor -= unit) {
				for (var y_cor:int = range; y_cor >= 0; y_cor -= unit) {
					result.push(bitmap.bitmapData.getPixel(centerPoint.x + x_cor, centerPoint.y + y_cor));
				}
			}

			return result;
		}

		private function hslMod(rgb:Array, hslMod:Array):Array {
			var hsl_ified:Array = RGBHSLConverter.RGBtoHSL(rgb);

			hsl_ified[0] *=  hslMod[0];
			hsl_ified[1] *=  hslMod[0];
			hsl_ified[2] *=  hslMod[0];

			var result:Array = RGBHSLConverter.HSLtoRGB(hsl_ified);

			return result;
		}

		private function rgbMod(rgb:Array, rgbMod:Array):Array {
			var result:Array = new Array();
			result.push(rgb[0] * rgbMod[0]);
			result.push(rgb[1] * rgbMod[1]);
			result.push(rgb[2] * rgbMod[2]);

			return result;
		}

		private function getMiddleRGB(rgb:Array, rgbMod:Array):Array {
			var result:Array = new Array();
			result.push(rgb[0]/2 + rgbMod[0]/2);
			result.push(rgb[1]/2 + rgbMod[1]/2);
			result.push(rgb[2]/2 + rgbMod[2]/2);

			return result;
		}

		// methods
		private function getFaceColor(bitmap:Bitmap):Number {
			var detectorDisplay:Sprite = addChild(new Sprite()) as Sprite;
			var detector:FaceDetector = new FaceDetector();

			var resultColor:Number = 0;

			detector.addEventListener(FaceDetectorEvent.NO_FACES_DETECTED, function(e):void {
			   trace("no faces detected..");
			   var centerPoint:Point = new Point(bitmap.width * .5, bitmap.height * .5);
			   var aroundCenterColors:Vector.<Number> = new Vector.<Number>();
			   
			   aroundCenterColors = gatherAround(bitmap, centerPoint, 40, 5);
			   
			   resultColor = getAverageColorOf(aroundCenterColors);
			});

			detector.addEventListener(FaceDetectorEvent.FACE_CROPPED, function(e):void {
			   var detected:Vector.<Rectangle> = detector.objectDetector.detected;
			   for each (var rec:Rectangle in detected) {
			      var centerPoint:Point = new Point(rec.x + rec.width * .5, rec.y + rec.height * .5);
			      var aroundCenterColors:Vector.<Number> = gatherAround(bitmap, centerPoint, 20);
			  detectorDisplay.graphics.lineStyle(1.5, 0xff0000);
			  detectorDisplay.graphics.drawRect(rec.x, rec.y, rec.width, rec.height);
			  detectorDisplay.graphics.endFill();
			  
			  detectorDisplay.x = bitmap.x;
			  detectorDisplay.y = bitmap.y;
			  
			      resultColor = getAverageColorOf(aroundCenterColors);
			   }
			});

			detector.loadFaceImageFromBitmap(bitmap);

			return resultColor;
		}


		private function getAverageColor(bitmap:Bitmap):Number {
			var sourceToGetAverageColor:Vector.<Number> = new Vector.<Number>();

			var targetX:int = 0;
			var targetY:int = 0;

			for (targetX = 2; targetX < bitmap.width; targetX += 4) {
				for (targetY = 2; targetY < bitmap.height; targetY += 4) {
					sourceToGetAverageColor.push(bitmap.bitmapData.getPixel(targetX, targetY));
				}
			}


			return getAverageColorOf(sourceToGetAverageColor);

		}

	}
}