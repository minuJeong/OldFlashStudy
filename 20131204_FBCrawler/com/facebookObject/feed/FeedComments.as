package com.facebookObject.feed {
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class FeedComments extends Sprite {
		
		private var comments:Object = new Object();

		public function FeedComments(comments:Object, rect:Rectangle = null) {
			this.comments = comments;
			
			if (! comments || ! comments.data) {
				return;
			}
			
			x = rect.x;
			y = rect.y;
			
			if (! comments || ! comments.data) {
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
			
			tf.appendText("Comment Users: " + comments.data.length + "\n----------------\n");
			for each (var user:Object in comments.data) {
				tf.appendText(user.from.name + "\n");
			}
			
			var format:TextFormat = new TextFormat();
			format.font = "Segoe UI _all*";
			format.color = 0xffffff;
			format.size = 12;
			tf.setTextFormat(format);
		}

	}
	
}
