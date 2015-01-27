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
	import com.Game.overflow.BattlePhase.Attack;

	public class BattlePhase extends Sprite {

		public static const BATTLE_TURN_READY:String = 'turn ready';
		public static const BATTLE_TURN_ATTACK:String = 'turn attack';
		public static const BATTLE_TURN_ATTACK_FX:String = 'turn attack fx';
		public static const BATTLE_TURN_GET_DAMAGED:String = 'turn get damaged';
		public static const BATTLE_TURN_GET_DAMAGED_FX:String = 'turn get damaged fx';
		public static const BATTLE_TURN_LAST_TURN:String = 'turn last turn';

		public static const BATTLE_SELECTED_ACTION_NONE:String = 'battle selected action none';

		public static const BATTLE_SELECTED_ACTION_ATTACK:String = 'battle selected action attack';
		public static const BATTLE_SELECTED_ACTION_POWER_ATTACK:String = 'battle selected action power attack';
		public static const BATTLE_SELECTED_ACTION_CHECK:String = 'battle selected action check';
		public static const BATTLE_SELECTED_ACTION_PROVOKE:String = 'battle selected action provoke';
		public static const BATTLE_SELECTED_ACTION_DEFENCE:String = 'battle selected action defence';
		public static const BATTLE_SELECTED_ACTION_SURRENDER:String = 'battle selected action surrender';
		public static const BATTLE_SELECTED_ACTION_RUN:String = 'battle selected action run';
		public static const BATTLE_SELECTED_ACTION_SACRIFICE:String = 'battle selected action sacrifice';

		public static const BATTLE_INVOKE_EVENT:String = 'battle invoke event';
		public static const BATTLE_INVOKE_MOVE:String = 'battle invoke move';
		public static const BATTLE_INVOKE_GAME_OVER:String = 'battle invoke game over';



		public static const BATTLE_RESULT_WIN:String = 'battle result win';
		public static const BATTLE_RESULT_SURRENDER:String = 'battle result surrender';
		public static const BATTLE_RESULT_GAME_OVER:String = 'battle result game over';

		public static const BATTLE_COMPLETE:String = 'battle complete';

		private var commandable:Boolean = false;

		public function BattlePhase() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			ImagePopup.popImage('battlePhase', onBattle);

		}

		private function onBattle():void {

			commandable = true;

			CommandSet.commandSetEventDispatcher.removeEventListeners();

			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONBATTLE_ATTACK, command_attack);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONBATTLE_POWER_ATTACK, command_power_attack);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONBATTLE_CHECK, command_check);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONBATTLE_PROVOKE, command_provoke);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONBATTLE_DEFENSE, command_defense);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONBATTLE_SURRENDER, command_surrender);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONBATTLE_RUN, command_run);
			CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONBATTLE_SACRIFICE, command_sacrifice);

		}

		private function battleOver(battleResult:String):void {

			switch (battleResult) {
				case BATTLE_RESULT_WIN :
					//gather reward
					dispatchEventWith(BattlePhase.BATTLE_INVOKE_MOVE);
					break;

				case BATTLE_RESULT_SURRENDER :
					dispatchEventWith(BattlePhase.BATTLE_INVOKE_MOVE);
					break;

				case BATTLE_RESULT_GAME_OVER :
					dispatchEventWith(BattlePhase.BATTLE_INVOKE_GAME_OVER);
					break;
			}

			dispatchEventWith(BattlePhase.BATTLE_COMPLETE);

		}

		private function command_attack(e:Event = null):void {
			if (commandable) {

				commandable = false;
				addChild(new Attack(battleOver, CommandSetTemplate.COMMAND_ONBATTLE_ATTACK));
			}
		}

		private function command_power_attack(e:Event):void {
			command_attack();
		}

		private function command_check(e:Event):void {
			command_attack();
		}

		private function command_provoke(e:Event):void {
			command_attack();
		}

		private function command_defense(e:Event):void {
			command_attack();
		}

		private function command_surrender(e:Event = null):void {
			if (commandable) {
				commandable = false;
				Game.mobManager.setAnimationState_all(Mob.ANIMATION_STATE_WALK);

				var heroes:Array = new Array();
				heroes.push(Game.mobManager.getMob_bySlot(MobManager.HERO_SIDE,MobManager.LEFT_WING),
				            Game.mobManager.getMob_bySlot(MobManager.HERO_SIDE,MobManager.CENT_BACK),
				            Game.mobManager.getMob_bySlot(MobManager.HERO_SIDE,MobManager.RIGH_WING));

				for each (var thisMob:Mob in heroes) {
					if (thisMob != null) {
						thisMob.scaleX = -1;
						thisMob.setAnimationState(Mob.ANIMATION_STATE_WALK);
					}
				}

				Game.mobManager.purgeAntiMobs();
				Game.mapScrollEfficiency = -1.00;

				Starling.juggler.delayCall(function():void {
				   
				   Game.mobManager.setAnimationState_all(Mob.ANIMATION_STATE_IDLE);
				   Game.mapScrollEfficiency = 0.00;
				   
				}, 1.00);

				Starling.juggler.delayCall(function():void {
				   
				   for each (var thisMob:Mob in heroes) {
				      if (thisMob) {
				         thisMob.scaleX = 1;
				         thisMob.setAnimationState(Mob.ANIMATION_STATE_WALK);
				      }
				   }
				   Game.mapScrollEfficiency = 1.00;
				   
				}, 2.00);

				Starling.juggler.delayCall(function():void {
				   
				   dispatchEventWith(BattlePhase.BATTLE_INVOKE_MOVE);
				   dispatchEventWith(BattlePhase.BATTLE_COMPLETE);
				   removeFromParent(true);
				   
				}, 2.15);
			}

		}

		private function command_run(e:Event):void {
			command_surrender();

		}

		private function command_sacrifice(e:Event):void {
			command_surrender();

		}


	}

}