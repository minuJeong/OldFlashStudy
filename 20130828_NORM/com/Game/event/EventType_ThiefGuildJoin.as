package com.Game.event{

	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Graphics;
	import starling.events.Event;
	import starling.animation.Tween;
	import starling.animation.Transitions;

	import com.Main;
	import com.Game.Game;
	import com.Game.overflow.EventPhase;
	import com.sys_popup.ImagePopup;

	public class EventType_ThiefGuildJoin extends EventType {

		public function EventType_ThiefGuildJoin(eventPhase:EventPhase) {

			super(eventPhase);

			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			ImagePopup.popImage('eventCutscene_thiefGuildJoin', thiefGuild);
		}

		private function thiefGuild():void {



		}

	}

}