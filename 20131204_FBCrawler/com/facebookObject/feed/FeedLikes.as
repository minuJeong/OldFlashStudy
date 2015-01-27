package com.facebookObject.feed {
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.geom.Rectangle;
	
	public class FeedLikes extends Sprite {
		
		private var likes:Object = new Object();

		public function FeedLikes(likes:Object, rect:Rectangle = null) {
			this.likes = likes;
			
			x = rect.x;
			y = rect.y;
			
			if (! likes || ! likes.data) {
				return;
			}
			
			if (! rect) {
				rect = new Rectangle(0,0,100,100);
			}
			
			var tf:TextField = addChild(new TextField()) as TextField;
			
			tf.selectable = false;
			tf.multiline = true;
			tf.width = rect.width;
			tf.height = rect.height;
			
			tf.appendText("Like Users: " + likes.data.length + "\n----------------\n");
			for each (var user:Object in likes.data) {
				tf.appendText(user.name + "\n");
			}
			
			var format:TextFormat = new TextFormat();
			format.font = "Segoe UI _all*";
			format.color = 0xffffff;
			format.size = 12;
			tf.setTextFormat(format);

		}

	}
	
}
