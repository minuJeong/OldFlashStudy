package com.Game.event{

	import starling.events.Event;
	import starling.display.Image;

	import com.Main;
	import com.Game.Game;
	import starling.display.Graphics;
	import starling.animation.Tween;
	import starling.animation.Transitions;
	import starling.core.Starling;
	import com.sys_popup.ImagePopup;
	import com.Game.overflow.EventPhase;

	public class EventType_ThiefGuild extends EventType {

		public function EventType_ThiefGuild(eventPhase:EventPhase) {

			super(eventPhase);

			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);


			ImagePopup.popImage('eventCutscene_thiefGuild', thiefGuild);
		}

		private function thiefGuild():void {

			eventPhase.dispatchEventWith(EventPhase.EVENT_INVOKE_MOVE);
			eventPhase.dispatchEventWith(EventPhase.EVENT_COMPLETE);

		}

	}

}