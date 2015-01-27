package com.facebookObject.feed{

	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class FeedMessage extends Sprite {

		private var message:String = "";

		public function FeedMessage(message:String = "", rect:Rectangle = null, pictureURL:String = "") {
			this.message = message;
			
			x = rect.x;
			y = rect.y;
			
			var tf:TextField = addChild(new TextField()) as TextField;
			tf.text = message;
			tf.selectable = true;
			tf.multiline = true;
			
			var format:TextFormat = new TextFormat();
			format.font = "Segoe UI _all*";
			format.color = 0xffffff;
			format.size = 12;
			tf.setTextFormat(format);
			
			if (! rect) {
				rect = new Rectangle(0, 0, 100, 100);
			}
			
			tf.width = rect.width;
			tf.height = rect.height;
			
			if (pictureURL == "") {
				return;
			}
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {
				
				loader.width = Math.min(loader.width, rect.width);
				loader.height = Math.min(loader.height, rect.height);

				loader.width = Math.max(loader.width, 30);
				loader.height = Math.max(loader.height, 30);				
				
				loader.x = rect.right - loader.width - rect.x;
				loader.y = rect.bottom - loader.height - rect.y;

				var sprite:Sprite = addChild(new Sprite()) as Sprite;
				sprite.graphics.lineStyle(3, 0x0C345E);
				sprite.graphics.drawRect(loader.x, loader.y, loader.width, loader.height);
				
				addChild(loader);
				
				loader.alpha = 0.2;
				
				loader.addEventListener(MouseEvent.MOUSE_OUT, function(e:MouseEvent):void {
					loader.alpha = 0.2;
				});
				
				loader.addEventListener(MouseEvent.MOUSE_OVER, function(e:MouseEvent):void {
					loader.alpha = 1.0;
				});
			});
			loader.load(new URLRequest(pictureURL));
		}

	}

}