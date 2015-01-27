package com.sys_popup{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.TouchEvent;
	import flash.events.Event;

	import com.Main;

	public class Popup_AskExit extends Sprite {

		[Embed(source = "/system/askQuit.png")]
		private static const askQuitPNG:Class;

		[Embed(source = "/system/popup_yes.png")]
		private static const btn_yes_PNG:Class;
		[Embed(source = "/system/popup_no.png")]
		private static const btn_no_PNG:Class;

		public function Popup_AskExit() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			var pop:Bitmap = new askQuitPNG() as Bitmap;
			pop.x = Main.stageWidth * .50 - pop.width * .5;
			pop.y = Main.stageHeight * .45 - pop.height * .5;
			addChild(pop);

			var btn_yes:Sprite = new Sprite();
			btn_yes.addChild(new btn_yes_PNG() as Bitmap);
			btn_yes.x = Main.stageWidth * .40 - btn_yes.width * .5;
			btn_yes.y = Main.stageHeight * .65 - btn_yes.height * .5;
			addChild(btn_yes);

			btn_yes.addEventListener(TouchEvent.TOUCH_TAP, function (e:TouchEvent) {
			 dispatchEvent(new Event('yes'));
			});

			var btn_no:Sprite = new Sprite();
			btn_no.addChild(new btn_no_PNG() as Bitmap);
			btn_no.x = Main.stageWidth * .60 - btn_no.width * .5;
			btn_no.y = Main.stageHeight * .65 - btn_no.height * .5;
			addChild(btn_no);

			btn_no.addEventListener(TouchEvent.TOUCH_TAP, function (e:TouchEvent) {
			 dispatchEvent(new Event('no'));
			});
		}
	}

}