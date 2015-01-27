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
	import com.commandSet.CommandSet;
	import com.commandSet.CommandSetTemplate;
	import com.Game.event.EventType_ThiefGuild;
	import com.sys_popup.ImagePopup;
	import com.Game.mob.party.Party;

	public class IncountPhase extends Sprite {

		public static const INCOUNT_COMPLETE:String = 'incount complete';

		public static const INCOUNT_INVOKE_EVENT:String = 'incount invoke event';
		public static const INCOUNT_INVOKE_BATTLE:String = 'incount invoke battle';

		public static const INCOUNT_SELECTED_ACTION_NONE:String = 'incout selected action none';

		public static const INCOUNT_SELECTED_ACTION_ATTACK:String = 'incout selected action attack';
		public static const INCOUNT_SELECTED_ACTION_DO_NOTHING:String = 'incout selected action do nothing';
		public static const INCOUNT_SELECTED_ACTION_DIALOGUE:String = 'incout selected action dialogue';
		public static const INCOUNT_SELECTED_ACTION_WALK_AWAY:String = 'incout selected action walk away';
		public static const INCOUNT_SELECTED_ACTION_STEAL:String = 'incout selected action steal';
		public static const INCOUNT_SELECTED_ACTION_WATCH:String = 'incout selected action watch';
		public static const INCOUNT_SELECTED_ACTION_HIDE:String = 'incout selected action hide';
		public static const INCOUNT_SELECTED_ACTION_BRIBE:String = 'incout selected action bribe';


		private var commandable:Boolean = false;

		public function IncountPhase() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			ImagePopup.popImage('incountPhase', incount);
		}

		private function incount():void {

			var n:Number = Math.random();

			var partiesArray:Array = new Array();
			partiesArray.push('dwarfWarrior',
			                  'guard',
			                  'merchant',
			                  'mermaid',
			                  'fanatic',
			                  'mermaids');

			if (n < .20) {
				incountSingleMob('dwarfWarrior');
			} else if (n < .30) {
				incountSingleMob('guard');
			} else if (n < .40) {
				incountSingleMob('merchant');
			} else if (n < .50) {
				incountSingleMob('mermaid');
			} else if (n < 0.60) {
				incountSingleMob('fanatic');
			} else if (n < 1.00) {
				incountParty_byName('mermaids');
			}


		}

		private function incountSingleMob(mobName:String):void {

			var addedMob:Mob = Game.mobManager.addMob(mobName,MobManager.ANTI_SIDE,MobManager.CENT_BACK);
			addedMob.x +=  Main.stageWidth * .2;

			onIncount();

		}


		private function incountParty_byLocation(locationName:String):void {

		}


		private function incountParty_byName(partyName:String):void {

			var thisParty:Party = new Party(partyName);
			thisParty.incount();

			for (var i:int = thisParty.mobs.length - 1; i >= 0; i--) {
				var thisMob:Mob = thisParty.mobs[i];
				Game.mobManager.addMob(thisMob.mobName, MobManager.ANTI_SIDE, MobManager.ANON_POSITION);
			}

			onIncount();

		}



		private function onIncount():void {

			commandable = true;

			CommandSet.commandSetEventDispatcher.removeEventListeners();

			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONINCOUNTER_ATTACK, attack);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONINCOUNTER_DONOTHING, doNothing);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONINCOUNTER_DIALOGUE, dialogue);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONINCOUNTER_WALKAWAY, walkAway);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONINCOUNTER_STEAL, steal);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONINCOUNTER_WATCH, watch);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONINCOUNTER_HIDE, hide);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONINCOUNTER_BRIBE, bribe);
		}

		private function attack(e:Event = null):void {
			dispatchEventWith(IncountPhase.INCOUNT_INVOKE_BATTLE);
			dispatchEventWith(IncountPhase.INCOUNT_COMPLETE);
			removeFromParent(true);
		}

		private function doNothing(e:Event = null):void {
			dispatchEventWith(INCOUNT_INVOKE_EVENT);
		}

		private function dialogue(e:Event = null):void {
			dispatchEventWith(INCOUNT_INVOKE_EVENT);
		}

		private function walkAway(e:Event = null):void {
			dispatchEventWith(INCOUNT_INVOKE_EVENT);
		}

		private function steal(e:Event = null):void {
			dispatchEventWith(INCOUNT_INVOKE_EVENT, false, EventType_ThiefGuild);
		}

		private function watch(e:Event = null):void {
			dispatchEventWith(INCOUNT_INVOKE_EVENT);
		}

		private function hide(e:Event = null):void {
			dispatchEventWith(INCOUNT_INVOKE_EVENT);
		}

		private function bribe(e:Event = null):void {
			dispatchEventWith(INCOUNT_INVOKE_EVENT);
		}

	}

}