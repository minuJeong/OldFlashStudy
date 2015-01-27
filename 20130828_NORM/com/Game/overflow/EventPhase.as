package com.Game.overflow{

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Image;
	import starling.display.Graphics;
	import starling.animation.Tween;
	import starling.animation.Transitions;

	import com.Main;
	import com.Game.Game;
	import com.Game.mob.Mob;
	import com.Game.mob.MobManager;
	import com.sys_popup.ImagePopup;

	public class EventPhase extends Sprite {

		public static const EVENT_COMPLETE:String = 'event complete';

		public static const EVENT_INVOKE_MOVE:String = 'event invoke move';

		private var commandable:Boolean = false;

		private var eventType:Class;

		public function EventPhase(eventType:Class = null) {

			if (eventType) {
				this.eventType = eventType;
			}

			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			ImagePopup.popImage('eventPhase', onEvent);
		}

		private function onEvent():void {
			if (eventType) {
				addChild(new eventType(this));
			}
		}

	}

}