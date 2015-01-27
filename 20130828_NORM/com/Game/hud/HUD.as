package com.Game.hud{
	import starling.display.Sprite;
	import starling.events.Event;
	import com.Game.hud.portrait.Portrait;
	import com.Game.Game;
	import com.Game.mob.MobManager;
	import com.Game.mob.Mob;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.animation.Transitions;
	import com.Game.hud.minimap.Minimap;
	import com.Main;

	public class HUD extends Sprite {

		public static const PHASE_MOVE:String = 'phase move';
		public static const PHASE_CAMP:String = 'phase camp';
		public static const PHASE_EVENT:String = 'phase event';
		public static const PHASE_INCOUNTER:String = 'phase incounter';
		public static const PHASE_BATTLE:String = 'phase battle';


		public static const PHASE_MOVE_END:String = 'phase move end';
		public static const PHASE_CAMP_END:String = 'phase camp end';
		public static const PHASE_EVENT_END:String = 'phase event end';
		public static const PHASE_INCOUNTER_END:String = 'phase incounter end';
		public static const PHASE_BATTLE_END:String = 'phase battle end';

		private var minimapsSet:Sprite;
		private var backpacksSet:Sprite;
		private var abilitiesSet:Sprite;
		private var portraitsSet_hero:Sprite;
		private var portraitsSet_anti:Sprite;

		public function HUD() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			setupOnMoveSet();
			setupOnIncounterSet();
			setupOnCampSet();
			setupOnBattleSet();

			addEventListener(HUD.PHASE_MOVE, enterMove);
			addEventListener(HUD.PHASE_CAMP, enterCamp);
			addEventListener(HUD.PHASE_EVENT, enterEvent);
			addEventListener(HUD.PHASE_INCOUNTER, enterIncounter);
			addEventListener(HUD.PHASE_BATTLE, enterBattle);

			addEventListener(HUD.PHASE_MOVE_END, exitMove);
			addEventListener(HUD.PHASE_CAMP_END, exitCamp);
			addEventListener(HUD.PHASE_EVENT_END, exitEvent);
			addEventListener(HUD.PHASE_INCOUNTER_END, exitIncounter);
			addEventListener(HUD.PHASE_BATTLE_END, exitBattle);

		}


		//publics..
		public function enterMove(e:Event):void {

		}

		public function enterCamp(e:Event):void {

		}


		public function enterEvent(e:Event):void {

		}


		public function enterIncounter(e:Event):void {

		}


		public function enterBattle(e:Event):void {

			addPortraits();
			tweenIn(portraitsSet_hero);
			tweenIn(portraitsSet_anti);

		}


		public function exitMove(e:Event):void {

		}


		public function exitCamp(e:Event):void {

		}

		public function exitEvent(e:Event):void {

		}

		public function exitIncounter(e:Event):void {

		}

		public function exitBattle(e:Event):void {
			tweenOut_left(portraitsSet_hero);
			tweenOut_right(portraitsSet_anti);
			removePortraits();
		}






		//privates..
		private function addPortraits():void {

			portraitsSet_hero = new Sprite();
			portraitsSet_anti = new Sprite();

			addChild(portraitsSet_hero);
			addChild(portraitsSet_anti);

			var heroes:Array = new Array();
			heroes.push(Game.mobManager.getMob_bySlot(MobManager.HERO_SIDE, MobManager.CENT_BACK));
			heroes.push(Game.mobManager.getMob_bySlot(MobManager.HERO_SIDE, MobManager.LEFT_WING));
			heroes.push(Game.mobManager.getMob_bySlot(MobManager.HERO_SIDE, MobManager.RIGH_WING));


			var iteration:int = heroes.length;
			for (var i:int = 0; i < iteration; i++) {
				if (heroes[i]) {
					var portrait_hero:Portrait = new Portrait(heroes[i]);
					portrait_hero.x = i * Portrait.PORTRAIT_WIDTH;
					portraitsSet_hero.addChild(portrait_hero);
				}
			}

			portraitsSet_hero.x =  -  portraitsSet_hero.width;





			var antis:Array = new Array();
			antis.push(Game.mobManager.getMob_bySlot(MobManager.ANTI_SIDE, MobManager.CENT_BACK));
			antis.push(Game.mobManager.getMob_bySlot(MobManager.ANTI_SIDE, MobManager.LEFT_WING));
			antis.push(Game.mobManager.getMob_bySlot(MobManager.ANTI_SIDE, MobManager.RIGH_WING));


			iteration = antis.length;
			for (i = 0; i < iteration; i++) {
				if (antis[i]) {
					var portrait_anti:Portrait = new Portrait(antis[i]);
					portrait_anti.x = Main.stageWidth - (i + 1) * Portrait.PORTRAIT_WIDTH;
					portrait_anti.y = Main.stageHeight - Portrait.PORTRAIT_WIDTH - Portrait.statusBarHeight * 3;
					portraitsSet_anti.addChild(portrait_anti);
				}
			}

			portraitsSet_anti.x = Main.stageWidth + portraitsSet_anti.width;

		}

		private function removePortraits():void {
			if (portraitsSet_hero) {
				portraitsSet_hero.removeFromParent(true);
			}

			if (portraitsSet_anti) {
				portraitsSet_anti.removeFromParent(true);
			}
		}

		private function tweenIn(portraitsSet:Sprite):void {
			var tween:Tween = new Tween(portraitsSet,1.50,Transitions.EASE_OUT_BOUNCE);
			tween.moveTo(0, 0);

			Starling.juggler.add(tween);
		}



		private function tweenOut_left(portraitsSet:Sprite):void {
			var tween:Tween = new Tween(portraitsSet,0.30,Transitions.LINEAR);
			tween.moveTo(- portraitsSet.width, 0);

			Starling.juggler.add(tween);
		}

		private function tweenOut_right(portraitsSet:Sprite):void {
			var tween:Tween = new Tween(portraitsSet,0.30,Transitions.LINEAR);
			tween.moveTo(Main.stageWidth + portraitsSet.width, 0);

			Starling.juggler.add(tween);
		}







		//inits..
		private function setupOnMoveSet():void {
			minimapsSet = new Sprite();
			addChild(minimapsSet);

			minimapsSet.addChild(new Minimap());

		}


		private function setupOnIncounterSet():void {

		}


		private function setupOnCampSet():void {

		}


		private function setupOnBattleSet():void {

		}

	}

}