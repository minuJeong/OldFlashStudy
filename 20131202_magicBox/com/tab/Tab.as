package com.tab{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.Main;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import com.util.FileNamer;
	import com.util.radio.Radio;


	public class Tab extends MovieClip {

		private static const TAB_ARTWORKS:int = 1;
		private static const TAB_RESOURCES:int = 2;
		private static const TAB_ANIMFX:int = 3;
		private static const TAB_EVENTGOODS:int = 4;
		private static const TAB_SCREENSHOTS:int = 5;
		private static const TAB_CUSTOM:int = 6;

		private var isCustomTab:Boolean = false;

		public function Tab() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			stop();

			b_tapTo_artworks.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {changetab(1);});
			b_tapTo_resources.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {changetab(2);});
			b_tapTo_animEfx.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {changetab(3);});
			b_tapTo_eventGoods.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {changetab(4);});
			b_tapTo_screenShots.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {changetab(5);});
			b_tapTo_custom.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {changetab(6);});


			Main.MAIN_STAGE.addEventListener(KeyboardEvent.KEY_DOWN, function(e:KeyboardEvent):void {
			    if (isCustomTab) {
			       return;
			    }
			 
			   switch (e.keyCode) {
			      case Keyboard.NUMBER_1 :
			         changetab(1);
			         break;
			 
			      case Keyboard.NUMBER_2 :
			         changetab(2);
			         break;
			 
			      case Keyboard.NUMBER_3 :
			         changetab(3);
			         break;
			 
			      case Keyboard.NUMBER_4 :
			         changetab(4);
			         break;
			 
			      case Keyboard.NUMBER_5 :
			         changetab(5);
			         break;
			 
			      case Keyboard.NUMBER_6 :
			         changetab(6);
			         break;
			   }
			});

			setEventListeners("artworks");

		}

		private function setEventListeners(scope:String):void {
			switch (scope) {
				case "artworks" :
					// observe switch change event
					swit_isIllust.addEventListener(Event.CHANGE, function (e:Event):void {
					   optionSet_artworks.changeSet();
					   if (swit_isIllust.isOn) {
					      FileNamer.PREFIX = "11_";
					   } else {
					      FileNamer.PREFIX = "10_";
					   }
					});

					// observe radios;
					optionSet_artworks.optionSet_artworks_radios.radio_mainMenu.addEventListener(Event.CHANGE, function (e:Event):void {
					   var radio:Radio = optionSet_artworks.optionSet_artworks_radios.radio_mainMenu;
					   if (radio.isOn) {
					      FileNamer.CATEGORYFIX = "MA_";
					   }
					});

					optionSet_artworks.optionSet_artworks_radios.radio_notice.addEventListener(Event.CHANGE, function (e:Event):void {
					   var radio:Radio = optionSet_artworks.optionSet_artworks_radios.radio_notice;
					   if (radio.isOn) {
					      FileNamer.CATEGORYFIX = "NT_";
					   }
					});

					optionSet_artworks.optionSet_artworks_radios.radio_guild.addEventListener(Event.CHANGE, function (e:Event):void {
					   var radio:Radio = optionSet_artworks.optionSet_artworks_radios.radio_guild;
					   if (radio.isOn) {
					      FileNamer.CATEGORYFIX = "GL_";
					   }
					});

					optionSet_artworks.optionSet_artworks_radios.radio_shop.addEventListener(Event.CHANGE, function (e:Event):void {
					   var radio:Radio = optionSet_artworks.optionSet_artworks_radios.radio_shop;
					   if (radio.isOn) {
					      FileNamer.CATEGORYFIX = "SP_";
					   }
					});

					optionSet_artworks.optionSet_artworks_radios.radio_dungeon.addEventListener(Event.CHANGE, function (e:Event):void {
					   var radio:Radio = optionSet_artworks.optionSet_artworks_radios.radio_dungeon;
					   if (radio.isOn) {
					      FileNamer.CATEGORYFIX = "DG_";
					   }
					});

					optionSet_artworks.optionSet_artworks_radios.radio_puzzle.addEventListener(Event.CHANGE, function (e:Event):void {
					   var radio:Radio = optionSet_artworks.optionSet_artworks_radios.radio_puzzle;
					   if (radio.isOn) {
					      FileNamer.CATEGORYFIX = "PZ_";
					   }
					});

					optionSet_artworks.optionSet_artworks_radios.radio_result.addEventListener(Event.CHANGE, function (e:Event):void {
					   var radio:Radio = optionSet_artworks.optionSet_artworks_radios.radio_result;
					   if (radio.isOn) {
					      FileNamer.CATEGORYFIX = "RS_";
					   }
					});

					optionSet_artworks.optionSet_artworks_radios.radio_character.addEventListener(Event.CHANGE, function (e:Event):void {
					   var radio:Radio = optionSet_artworks.optionSet_artworks_radios.radio_character;
					   if (radio.isOn) {
					      FileNamer.CATEGORYFIX = "CH_";
					   }
					});

					optionSet_artworks.optionSet_artworks_radios.radio_showOut.addEventListener(Event.CHANGE, function (e:Event):void {
					   var radio:Radio = optionSet_artworks.optionSet_artworks_radios.radio_showOut;
					   if (radio.isOn) {
					      FileNamer.CATEGORYFIX = "IL_";
					   }
					});

					optionSet_artworks.optionSet_artworks_radios.radio_concept.addEventListener(Event.CHANGE, function (e:Event):void {
					   var radio:Radio = optionSet_artworks.optionSet_artworks_radios.radio_concept;
					   if (radio.isOn) {
					      FileNamer.CATEGORYFIX = "CP_";
					   }
					});

					isCustomTab = false;

					break;


				case "resources" :

					isCustomTab = false;

					break;


				case "animfx" :

					isCustomTab = false;

					break;


				case "eventgoods" :

					isCustomTab = false;

					break;


				case "screenshots" :

					isCustomTab = false;

					break;


				case "custom" :
					// init FileNamer for custom tab
					FileNamer.PREFIX = t_customPrefix.text;
					t_customPrefix.addEventListener(Event.CHANGE, function (e:Event):void {
					   FileNamer.PREFIX = t_customPrefix.text;
					});

					stage.focus = t_customPrefix;

					isCustomTab = true;
					break;
			}
		}

		private function changetab(to:int) {
			gotoAndStop(to);
			FileNamer.PREFIX = "";
			FileNamer.CATEGORYFIX = "";

			switch (to) {
				case TAB_ARTWORKS :
					setEventListeners("artworks");
					break;

				case TAB_RESOURCES :
					setEventListeners("resources");
					break;

				case TAB_ANIMFX :
					setEventListeners("animfx");
					break;

				case TAB_EVENTGOODS :
					setEventListeners("eventgoods");
					break;

				case TAB_SCREENSHOTS :
					setEventListeners("screenshots");
					break;

				case TAB_CUSTOM :
					setEventListeners("custom");
					break;
			}
		}
	}
}