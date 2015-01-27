package com.commandSet{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TouchEvent;

	import starling.events.EventDispatcher;

	import com.Game.Game;

	public class CommandSet extends Sprite {

		public static var commandSetEventDispatcher:EventDispatcher;

		private var commands:Array;

		private var currentPhase:int = Game.PHASE_MOVE;

		public function CommandSet() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			commands = new Array(5);
			commands.push(onCampSet);
			commands.push(onIncounterSet);
			commands.push(onEventSet);
			commands.push(onBattleSet);
			commands.push(onMoveSet);

			commandSetEventDispatcher = new EventDispatcher();

		}

		public function start():void {
			Game.gameEventDispatcher.addEventListener(Game.GAME_ENTER_FRAME, setCommandCoord);
		}

		private function setCommandCoord(e):void {
			var targetY:Number = y;
			switch (Game.currentPhase) {
				case Game.PHASE_CAMP :
					targetY = 223;
					onCampSet.on();
					onIncounterSet.off();
					onEventSet.off();
					onBattleSet.off();
					onMoveSet.off();
					break;

				case Game.PHASE_INCOUNT :
					targetY = 0;
					onCampSet.off();
					onIncounterSet.on();
					onEventSet.off();
					onBattleSet.off();
					onMoveSet.off();
					break;

				case Game.PHASE_EVENT :
					targetY = -223;
					onCampSet.off();
					onIncounterSet.off();
					onEventSet.on();
					onBattleSet.off();
					onMoveSet.off();
					break;

				case Game.PHASE_BATTLE :
					targetY = -446;
					onCampSet.off();
					onIncounterSet.off();
					onEventSet.off();
					onBattleSet.on();
					onMoveSet.off();
					break;

				case Game.PHASE_MOVE :
					targetY = -669;
					onCampSet.off();
					onIncounterSet.off();
					onEventSet.off();
					onBattleSet.off();
					onMoveSet.on();
					break;

				case Game.PHASE_GAME_OVER :
					targetY = -669;
					onCampSet.off();
					onIncounterSet.off();
					onEventSet.off();
					onBattleSet.off();
					onMoveSet.on();
					break;
			}

			var dy:Number = 0;

			dy = (targetY - 446) - onCampSet.y;
			onCampSet.y +=  dy * .2;

			dy = (targetY - 223) - onIncounterSet.y;
			onIncounterSet.y +=  dy * .2;

			dy = targetY - onEventSet.y;
			onEventSet.y +=  dy * .2;

			dy = (targetY + 223) - onBattleSet.y;
			onBattleSet.y +=  dy * .2;

			dy = (targetY + 446) - onMoveSet.y;
			onMoveSet.y +=  dy * .2;

		}

	}

}