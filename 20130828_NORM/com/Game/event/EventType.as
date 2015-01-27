package com.Game.event{

	import starling.display.Sprite;
	import starling.display.Image;
	import starling.events.Event;

	import com.Main;
	import com.Game.Game;
	import com.Game.overflow.EventPhase;

	public class EventType extends Sprite {

		public var eventPhase:EventPhase;

		public function EventType(eventPhase:EventPhase) {
			this.eventPhase = eventPhase;
		}

	}

}