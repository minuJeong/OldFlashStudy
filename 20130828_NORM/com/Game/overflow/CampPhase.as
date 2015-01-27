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
	import com.commandSet.CommandSet;
	import com.commandSet.CommandSetTemplate;

	public class CampPhase extends Sprite {

		public static const CAMP_COMPLETE:String = 'camping end';

		public static const CAMP_INVOKE_MOVE:String = 'camp invoke move';
		public static const CAMP_INVOKE_EVENT:String = 'camp invoke event';


		private var image:Image;

		public function CampPhase() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			ImagePopup.popImage('campPhase', onCamp);
		}

		private function onCamp():void {

			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONCAMP_SNACK, snack);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONCAMP_SLEEP, sleep);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONCAMP_REPAIR, repair);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONCAMP_CONVERSE, converse);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONCAMP_MEAL, meal);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONCAMP_MEMORISE, memorise);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONCAMP_TRAIN, train);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONCAMP_HOBBY, hobby);

		}

		private function recoverAll():void {
			var mobs:Array = Game.mobManager.getMobs();
			for (var i:int = mobs.length - 1; i >= 0; i--) {
				trace('typeof mobs[i]: ' + typeof mobs[i]);
				var thisMob:Mob = mobs[i];
				trace(typeof thisMob);
				if (thisMob.side == MobManager.HERO_SIDE) {
					thisMob.dispatchEventWith(Mob.MOB_EVENT_RECOVER);
				}
			}
		}


		private function snack(e:Event = null):void {

			recoverAll();

			dispatchEventWith(CampPhase.CAMP_INVOKE_MOVE);
			dispatchEventWith(CampPhase.CAMP_COMPLETE);
			removeFromParent(true);
		}

		private function sleep(e:Event):void {
			snack();
		}

		private function repair(e:Event):void {
			snack();
		}

		private function converse(e:Event):void {
			snack();
		}

		private function meal(e:Event):void {
			snack();
		}

		private function memorise(e:Event):void {
			snack();
		}

		private function train(e:Event):void {
			snack();
		}

		private function hobby(e:Event):void {
			snack();
		}

	}

}