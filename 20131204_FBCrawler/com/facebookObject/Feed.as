package com.facebookObject{

	import flash.display.Sprite;
	import flash.events.Event;

	import com.facebookObject.feed.FeedMessage;
	import com.facebookObject.feed.FeedLikes;
	import com.facebookObject.feed.FeedComments;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;

	public class Feed extends Sprite {

		private var feed:Object;

		public function Feed(feed:Object) {

			this.feed = feed;

			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var message:String = "";
			message += "message: " + feed.message + "\n";
			message += "caption: " + feed.caption + "\n";
			message += "story: " + feed.story + "\n";
			
			var feedMessage:FeedMessage = addChild(
										new FeedMessage(message,
										new Rectangle(area_message.x, area_message.y,
													  area_message.width - 20, area_message.height - 20),
										feed.picture?feed.picture:"")) as FeedMessage;
			
			var feedLikes:FeedLikes = addChild(
										new FeedLikes(feed.likes?feed.likes:null,
										new Rectangle(area_likes.x, area_likes.y,
													  area_likes.width - 30, area_likes.height - 20))) as FeedLikes;
			
			var feedComments:FeedComments = addChild(new FeedComments(feed.comments?feed.comments:null,
										new Rectangle(area_comments.x, area_comments.y,
													  area_comments.width - 30, area_comments.height - 20))) as FeedComments;
			
			var loader:Loader = new Loader();
			var url:URLRequest = new URLRequest();
			url.url = "https://graph.facebook.com/" + feed.from.id + "/picture?type=square";
			loader.load(url);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {
				addChild(loader);
				loader.x = area_picture.x;
				loader.y = area_picture.y;
			});
			
		}
		
		public function showNumbering(currentFeedNumbering:int, totalFeedsNumbering:int):void {
			
			t_numbering.text = currentFeedNumbering + " / " + totalFeedsNumbering;
			
		}

	}

}