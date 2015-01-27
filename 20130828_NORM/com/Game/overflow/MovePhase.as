package com.Game.overflow{

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;

	import com.Main;
	import com.Game.Game;
	import com.Game.mob.Mob;
	import com.Game.mob.MobManager;
	import com.sys_popup.ImagePopup;
	import com.commandSet.CommandSet;
	import com.commandSet.CommandSetTemplate;

	public class MovePhase extends Sprite {

		public static const MOVE_COMPLETE:String = 'move complete';

		public static const MOVE_INVOKE_INCOUNT:String = 'move invoke incount';
		public static const MOVE_INVOKE_CAMP:String = 'move invoke camp';

		private var commandable:Boolean = false;

		public function MovePhase() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			ImagePopup.popImage('movePhase', onMove);
		}

		private function onMove():void {

			commandable = true;

			CommandSet.commandSetEventDispatcher.removeEventListeners();

			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONMOVE_FORMATION_1, command_formation_1);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONMOVE_FORMATION_2, command_formation_2);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONMOVE_FORMATION_3, command_formation_3);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONMOVE_FORMATION_4, command_formation_4);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONMOVE_SNEAK, command_sneak);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONMOVE_PROVOKE, command_provoke);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONMOVE_SEARCH, command_search);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONMOVE_CAMP, command_camp);

		}

		private function command_formation_1(e:Event):void {

		}

		private function command_formation_2(e:Event):void {

		}

		private function command_formation_3(e:Event):void {

		}

		private function command_formation_4(e:Event):void {

		}

		private function command_sneak(e:Event):void {
			dispatchEventWith(MovePhase.MOVE_INVOKE_INCOUNT);
			dispatchEventWith(MovePhase.MOVE_COMPLETE);
			removeFromParent(true);
		}

		private function command_provoke(e:Event):void {
			dispatchEventWith(MovePhase.MOVE_INVOKE_INCOUNT);
			dispatchEventWith(MovePhase.MOVE_COMPLETE);
			removeFromParent(true);
		}

		private function command_search(e:Event):void {
			dispatchEventWith(MovePhase.MOVE_INVOKE_INCOUNT);
			dispatchEventWith(MovePhase.MOVE_COMPLETE);
			removeFromParent(true);
		}

		private function command_camp(e:Event):void {
			dispatchEventWith(MovePhase.MOVE_INVOKE_CAMP);
			dispatchEventWith(MovePhase.MOVE_COMPLETE);
			removeFromParent(true);
		}

	}

}