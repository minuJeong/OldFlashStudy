package com.sys_popup{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.TouchEvent;
	import flash.events.Event;

	import com.Main;

	public class Popup_Menu extends Sprite {

		[Embed(source = "/system/askMenu.png")]
		private static const askMenuPNG:Class;

		[Embed(source = "/system/menu1.png")]
		private static const menu1PNG:Class;
		[Embed(source = "/system/menu2.png")]
		private static const menu2PNG:Class;
		[Embed(source = "/system/menu3.png")]
		private static const menu3PNG:Class;

		public function Popup_Menu() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			var pop:Bitmap = new askMenuPNG() as Bitmap;
			pop.x = Main.stageWidth * .50 - pop.width * .5;
			pop.y = Main.stageHeight * .30 - pop.height * .5;
			addChild(pop);

			for (var i:int = 2; i >= 0; i--) {
				var btn_menuItem:Sprite = new Sprite();
				switch (i) {
					case 0 :
						btn_menuItem.addChild(new menu1PNG() as Bitmap);
						btn_menuItem.addEventListener(TouchEvent.TOUCH_TAP, function (e:TouchEvent) {
						    dispatchEvent(new Event('item1'));
						});
						break;

					case 1 :
						btn_menuItem.addChild(new menu2PNG() as Bitmap);
						btn_menuItem.addEventListener(TouchEvent.TOUCH_TAP, function (e:TouchEvent) {
						    dispatchEvent(new Event('item2'));
						});
						break;

					case 2 :
						btn_menuItem.addChild(new menu3PNG() as Bitmap);
						btn_menuItem.addEventListener(TouchEvent.TOUCH_TAP, function (e:TouchEvent) {
						    dispatchEvent(new Event('item3'));
						});
						break;
				}

				btn_menuItem.x = Main.stageWidth * .50 - btn_menuItem.width * .5;
				btn_menuItem.y = Main.stageHeight * .45 - btn_menuItem.height * .5;
				btn_menuItem.y +=  i * btn_menuItem.height * 1.2;
				addChild(btn_menuItem);
			}
		}

	}

}