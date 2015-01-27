package com.Game.overflow.BattlePhase{
	import starling.display.Sprite;
	import starling.events.Event;
	import com.Game.Game;
	import com.Game.mob.MobManager;
	import com.Game.mob.Mob;
	import starling.core.Starling;
	import com.Main;
	import com.commandSet.CommandSet;
	import com.commandSet.CommandSetTemplate;
	import starling.display.Image;
	import starling.animation.Tween;
	import starling.textures.TextureAtlas;
	import com.Game.overflow.BattlePhase;

	public class Attack extends Sprite {

		private var onComplete:Function;
		private var firstMove:String;

		private var heroes:Array;
		private var antis:Array;
		private var all:Array;

		private var nextTurnMobs:Array;

		private var onEngage:Boolean = false;


		private var turnIndicator:Sprite;
		private var mobIndicator:Sprite;

		public function Attack(onComplete:Function, firstMove:String) {

			this.onComplete = onComplete;
			this.firstMove = firstMove;

			addEventListener(Event.ADDED_TO_STAGE, init);

		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			onEngage = true;

			heroes = new Array();
			antis = new Array();
			all = new Array();
			nextTurnMobs = new Array();


			if (Game.mobManager.getMob_bySlot(MobManager.HERO_SIDE,MobManager.LEFT_WING) != null) {
				heroes.push(Game.mobManager.getMob_bySlot(MobManager.HERO_SIDE, MobManager.LEFT_WING));
			}

			if (Game.mobManager.getMob_bySlot(MobManager.HERO_SIDE,MobManager.CENT_BACK) != null) {
				heroes.push(Game.mobManager.getMob_bySlot(MobManager.HERO_SIDE, MobManager.CENT_BACK));
			}

			if (Game.mobManager.getMob_bySlot(MobManager.HERO_SIDE,MobManager.RIGH_WING) != null) {
				heroes.push(Game.mobManager.getMob_bySlot(MobManager.HERO_SIDE, MobManager.RIGH_WING));
			}


			if (Game.mobManager.getMob_bySlot(MobManager.ANTI_SIDE,MobManager.LEFT_WING) != null) {
				antis.push(Game.mobManager.getMob_bySlot(MobManager.ANTI_SIDE, MobManager.LEFT_WING));
			}

			if (Game.mobManager.getMob_bySlot(MobManager.ANTI_SIDE,MobManager.CENT_BACK) != null) {
				antis.push(Game.mobManager.getMob_bySlot(MobManager.ANTI_SIDE, MobManager.CENT_BACK));
			}

			if (Game.mobManager.getMob_bySlot(MobManager.ANTI_SIDE,MobManager.RIGH_WING) != null) {
				antis.push(Game.mobManager.getMob_bySlot(MobManager.ANTI_SIDE, MobManager.RIGH_WING));
			}

			all = all.concat(heroes,antis);
			all.sort(agilitySort);

			nextTurnMobs.concat(all);


			turnIndicator = new Sprite();
			var atlas:TextureAtlas = Game.mAssets.getTextureAtlas('turnIndicator');
			var image:Image = new Image(atlas.getTexture('sideArrow'));
			turnIndicator.addChild(image);
			turnIndicator.pivotX = turnIndicator.width >> 1;
			turnIndicator.pivotY = turnIndicator.height >> 1;
			turnIndicator.x = Main.stageWidth >> 1;
			turnIndicator.y = Main.stageHeight * .80;
			addChild(turnIndicator);

			mobIndicator = new Sprite();
			image = new Image(atlas.getTexture('mobIndicator'));
			mobIndicator.addChild(image);
			mobIndicator.pivotX = mobIndicator.width >> 1;
			mobIndicator.pivotY = mobIndicator.height >> 1;

			mobIndicator.x = -32;
			mobIndicator.y = -32;
			addChild(mobIndicator);

			var tween:Tween = new Tween(mobIndicator,0.30);
			tween.animate('alpha', 0.50);
			tween.reverse = true;
			tween.nextTween = tween;
			Starling.juggler.add(tween);


			turnIndicator.alpha = 0.00;



			initiate();
			CommandSet.commandSetEventDispatcher.dispatchEventWith(firstMove);

		}


		private function battleOver(battleResult:String):void {

			onComplete(battleResult);
			removeFromParent(true);

		}




		private function initiate():void {

			trace('initiate');

			if (heroes.length == 0 && onEngage) {
				onEngage = false;
				battleOver(BattlePhase.BATTLE_RESULT_GAME_OVER);
				return;
			}

			if (antis.length == 0 && onEngage) {
				onEngage = false;
				battleOver(BattlePhase.BATTLE_RESULT_WIN);
				return;
			}


			all = all.concat(nextTurnMobs);
			nextTurnMobs.length = 0;

			var attackerMob:Mob = all[0];
			var targetMob:Mob;

			if (attackerMob.side == MobManager.HERO_SIDE) {
				targetMob = getTarget(antis);
			} else {
				targetMob = getTarget(heroes);
			}


			var tween:Tween = new Tween(turnIndicator,0.20);
			if (attackerMob.side == MobManager.HERO_SIDE) {

				turnIndicator.scaleX = 0.80;
				turnIndicator.scaleY = 0.80;
				tween.animate('alpha', 1.00);
				tween.animate('scaleX', 1.00);
				tween.animate('scaleY', 1.00);

				CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONBATTLE_ATTACK, function(e:Event):void {
				    CommandSet.commandSetEventDispatcher.removeEventListeners(CommandSetTemplate.COMMAND_ONBATTLE_ATTACK);
				    processAttack(attackerMob, targetMob);
				});


				CommandSet.commandSetEventDispatcher.addEventListener(CommandSetTemplate.COMMAND_ONBATTLE_RUN, function(e:Event):void {
				    CommandSet.commandSetEventDispatcher.removeEventListeners(CommandSetTemplate.COMMAND_ONBATTLE_RUN);
				    battleOver(BattlePhase.BATTLE_RESULT_SURRENDER);
				});

			} else {

				turnIndicator.scaleX = -0.80;
				turnIndicator.scaleY = 0.80;
				tween.animate('alpha', 0.70);
				tween.animate('scaleX', - 1.00);
				tween.animate('scaleY', 1.00);

				processAttack(attackerMob, targetMob);
			}

			mobIndicator.x = attackerMob.x;
			mobIndicator.y = attackerMob.y - 128;

			Starling.juggler.add(tween);
		}

		private function processAttack(atkMob:Mob, defMob:Mob):void {

			trace('processAttack');

			atkMob.dispatchEventWith(Mob.MOB_EVENT_ATTACK);
			defMob.dispatchEventWith(Mob.MOB_EVENT_GET_HIT);

			atkMob.setAnimationState(Mob.ANIMATION_STATE_ATK);
			defMob.setAnimationState(Mob.ANIMATION_STATE_HIT);
			defMob.vitalData.hp -=  atkMob.vitalData.atk * 100 / (100 + defMob.vitalData.def);

			if (defMob.vitalData.hp <= 0) {
				defMob.dispatchEventWith(Mob.MOB_EVENT_DIE);
				removeMob(defMob);
			}

			var tween:Tween = new Tween(turnIndicator,0.20);
			tween.animate('alpha', 0.00);
			tween.animate('scaleX', turnIndicator.scaleX * 1.50);
			tween.animate('scaleY', 1.50);
			Starling.juggler.add(tween);


			Starling.juggler.delayCall(function():void {
			   nextTurnMobs.push(all.shift());
			   
			   initiate();
			}, 1.50);
		}

		private function removeMob(mob:Mob):void {
			for (var i:int = heroes.length - 1; i >= 0; i--) {
				var thisMob:Mob = heroes[i];
				if (thisMob == mob) {
					heroes.splice(i, 1);
				}
			}

			for (i = antis.length - 1; i >= 0; i--) {
				thisMob = antis[i];
				if (thisMob == mob) {
					antis.splice(i, 1);
				}
			}

			for (i = nextTurnMobs.length - 1; i >= 0; i--) {
				thisMob = nextTurnMobs[i];
				if (thisMob == mob) {
					nextTurnMobs.splice(i, 1);
				}
			}

			for (i = all.length - 1; i >= 0; i--) {
				thisMob = all[i];
				if (thisMob == mob) {
					all.splice(i, 1);
				}
			}
		}

		private function getTarget(arr:Array):Mob {
			if (arr.length > 0) {
				var i:int = Math.floor(Math.random() * arr.length);
			} else {
				return null;
			}

			return arr[i] as Mob;
		}

		private function agilitySort(mob_1:Mob, mob_2:Mob):int {
			if (mob_1.vitalData.agi < mob_2.vitalData.agi) {
				return -1;
			} else if (mob_1.vitalData.agi == mob_2.vitalData.agi) {
				if (Math.random() < .5) {
					return -1;
				} else {
					return 1;
				}
			} else if (mob_1.vitalData.agi < mob_2.vitalData.agi) {
				return 1;
			}

			return 0;
		}

	}

}