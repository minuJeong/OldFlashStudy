package com{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	
	import com.facebook.graph.FacebookDesktop;

	import com.toy.CharacterFromFacebook;

	import com.facebookObject.Feed;
	import com.facebookObject.feed.FeedContainer;
	
	import com.handle.Handle_Exit;
	import com.handle.Handle_Drag;
	import flash.events.KeyboardEvent;
	


	public class Main extends MovieClip {

		private static const applicstionId:String = "250484848441403";
		private static const scope:Array = [];
		
		private static var feedWin:NativeWindow;
		private static var feedsContainer:FeedContainer;

		public function Main() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			b_query.visible = false;

			FacebookDesktop.init(applicstionId, onInit);
		}

		private function onInit(result:Object, fail:Object):void {
			FacebookDesktop.login(onLogin, scope);
		}

		private function onLogin(result:Object, fail:Object):void {
			if (fail) {
				trace("Facebook login failed.");
				trace(fail["error"]["message"]);
				return;
			}
			
			b_query.visible = true;
			
			b_query.addEventListener("query", function(e:Event):void{
				if (feedWin) {
					feedWin.close();
					
					feedWin = null;
				}
				
				var id:String = t_specificID.text;
				FacebookDesktop.api(id + "/feed", onFacebookResult);
				
				b_query.visible = false;
			});
		}

		private function onFacebookResult(result:Object, fail:Object):void {
			if (fail) {
				trace("Facebook request failed.");
				trace(fail["error"]["message"]);
				return;
			}

			var outputText:String = "";
			
			var feedCount:int = 0;
			var totalFeedCount:int = result.length;
			
			var initOptions:NativeWindowInitOptions = new NativeWindowInitOptions();
			initOptions.systemChrome = NativeWindowSystemChrome.NONE;
			initOptions.transparent = true;
			feedWin = new NativeWindow(initOptions);
			feedWin.stage.scaleMode = StageScaleMode.NO_SCALE;
			feedWin.stage.align = StageAlign.TOP_LEFT;
			
			feedsContainer = feedWin.stage.addChild(new FeedContainer()) as FeedContainer;

			for each (var feed:Object in result) {
				var feedDisplay:Feed = feedsContainer.addChild(new Feed(feed)) as Feed;
				feedDisplay.showNumbering(feedCount + 1, totalFeedCount);
				
				feedDisplay.x = 1;
				feedDisplay.y = feedDisplay.height * 0.1 + feedCount * (feedDisplay.height + 5);
				feedCount++;
			}
			
			feedsContainer.maxY = 0;
			feedsContainer.minY = - (feedCount - 1) * (feedDisplay.height + 5);
			
			var dragger:Handle_Drag = feedWin.stage.addChild(new Handle_Drag()) as Handle_Drag;
			dragger.x = feedWin.width * .95 - dragger.width * .53;
			dragger.y = feedWin.height * .15;
			
			var exiter:Handle_Exit = feedWin.stage.addChild(new Handle_Exit()) as Handle_Exit;
			exiter.x = feedWin.width * .95 + exiter.width * .53;
			exiter.y = feedWin.height * .15;
			exiter.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				b_query.visible = true;
			});
			
			feedWin.width = feedDisplay.width + 2;
			feedWin.height = feedDisplay.height * 1.2;
			
			feedWin.stage.addEventListener(MouseEvent.MOUSE_WHEEL, onWheel);
			
			feedWin.activate();

			// addChild(new CharacterFromFacebook(t_specificID.text));
		}
		
		private function onWheel(e:MouseEvent):void {
			feedsContainer.y += e.delta * 5;
			
			if (feedsContainer.y < feedsContainer.minY) {
				feedsContainer.y = feedsContainer.minY;
			}
			
			if (feedsContainer.y > feedsContainer.maxY) {
				feedsContainer.y = feedsContainer.maxY;
			}
		}
	}
}