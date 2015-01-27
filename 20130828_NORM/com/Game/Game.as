package com.Game{

	import starling.core.Starling;

	import starling.display.Sprite;
	import starling.display.Image;
	import starling.display.DisplayObject;

	import starling.utils.AssetManager;
	import starling.events.Event;
	import starling.events.EventDispatcher;

	import com.Main;

	import com.sys_popup.LoadingBar;

	import com.Game.overflow.BattlePhase;
	import com.Game.overflow.CampPhase;
	import com.Game.overflow.IncountPhase;
	import com.Game.overflow.MovePhase;
	import com.Game.overflow.EventPhase;
	import com.Game.overflow.GameoverPhase;

	import com.Game.map.Background;
	import com.Game.map.ScrollingMap;

	import com.Game.setupParty.SetupParty;
	import com.Game.setupParty.UserParty;

	import com.Game.mob.Mob;
	import com.Game.mob.MobManager;

	import com.Game.hud.HUD;

	import com.Game.statistics.PlayerStatistics;
	import com.Game.dataManager.DataManager;
	import com.Game.level.LevelManager;

	public class Game extends Sprite {

		public static const PHASE_CAMP:int = 0;
		public static const PHASE_INCOUNT:int = 1;
		public static const PHASE_EVENT:int = 2;
		public static const PHASE_BATTLE:int = 3;
		public static const PHASE_MOVE:int = 4;
		public static const PHASE_GAME_OVER:int = 5;

		public static const GAME_LOAD_COMPLETE:String = 'game load complete';
		public static const GAME_ENTER_FRAME:String = 'game enterframe';
		public static const GAME_INCOUNT:String = 'game incount';
		public static const GAME_START_MOVE:String = 'game start move';
		public static const GAME_START_EVENT:String = 'game start event';
		public static const GAME_START_BATTLE:String = 'game start battle';
		public static const GAME_START_CAMP:String = 'game start camp';
		public static const GAME_GAME_OVER:String = 'game game over';

		private const DEFAULT_USER_PARTY:UserParty = new UserParty(['guard','elfPed','guard']);

		public static var gameEventDispatcher:EventDispatcher;

		public static var mAssets:AssetManager;
		public static var mMobDatas:DataManager;
		public static var mLevelDatas:DataManager;
		public static var mobManager:MobManager;
		public static var levelManager:LevelManager;

		private var overflow:Sprite;

		public static var mapScrollEfficiency:Number = 1.00;

		public static var currentPhase:int = PHASE_MOVE;
		public static var currentPhase_elapsedFrame:uint = 0;

		private var incountProb:Number = 1.00;

		private var incountPhase:IncountPhase;
		private var movePhase:MovePhase;
		private var eventPhase:EventPhase;
		private var battlePhase:BattlePhase;
		private var campPhase:CampPhase;
		private var gameoverPhase:GameoverPhase;


		public static var hud:HUD;

		public static var graphicsLayer:Sprite;
		public static var imagePopLayer:Sprite;

		private var playerStatistics:PlayerStatistics;

		public function Game() {
		}

		private function completeLoad():void {
			gameEventDispatcher = new EventDispatcher();
			gameEventDispatcher.dispatchEventWith(GAME_LOAD_COMPLETE);

			initiateGame();
		}

		private function setupParty():void {
			var setupParty:SetupParty = addChild(new SetupParty()) as SetupParty;
			initiateGame(setupParty.userParty);
		}

		private function initiateGame(userParty:UserParty = null):void {

			if (! userParty) {
				userParty = DEFAULT_USER_PARTY;
			}

			Main.commandSet.start();

			playerStatistics = new PlayerStatistics();
			graphicsLayer = new Sprite();
			hud = new HUD();
			overflow = new Sprite();
			imagePopLayer = new Sprite();


			var bg:Background = addChild(new Background()) as Background;

			mobManager = addChild(new MobManager()) as MobManager;
			levelManager = addChild(new LevelManager(bg)) as LevelManager;

			for (var i:int = userParty.mobs.length - 1; i >= 0; i--) {

				mobManager.addMob(userParty.mobs[i], MobManager.HERO_SIDE, MobManager.ANON_POSITION);

			}

			addChild(overflow);
			addChild(hud);
			addChild(graphicsLayer);
			addChild(imagePopLayer);

			toMovePhase();

			addEventListener(Event.ENTER_FRAME, ef);
		}

		private function ef(e:Event = null):void {

			gameEventDispatcher.dispatchEventWith(GAME_ENTER_FRAME);
			currentPhase_elapsedFrame++;

		}


		private function toGameOver(e:Event = null):void {

			hud.dispatchEventWith(HUD.PHASE_EVENT);

			trace('gameoverPhase');

			currentPhase = PHASE_GAME_OVER;
			gameEventDispatcher.dispatchEventWith(Game.GAME_GAME_OVER);
			mapScrollEfficiency = 0.00;

			gameoverPhase = overflow.addChild(new GameoverPhase()) as GameoverPhase;

			gameoverPhase.addEventListener(GameoverPhase.GAMEOVER_INVOKE_MOVE, toMovePhase);

		}



		private function toIncounterPhase(e:Event = null):void {

			hud.dispatchEventWith(HUD.PHASE_INCOUNTER);

			trace('incounterPhase');

			currentPhase = PHASE_INCOUNT;
			gameEventDispatcher.dispatchEventWith(Game.GAME_INCOUNT, false, null);
			mobManager.setAnimationState_all(Mob.ANIMATION_STATE_IDLE);
			mapScrollEfficiency = 0.00;

			incountPhase = overflow.addChild(new IncountPhase()) as IncountPhase;
			incountPhase.addEventListener(IncountPhase.INCOUNT_COMPLETE, function (e:Event):void {
			   hud.dispatchEventWith(HUD.PHASE_INCOUNTER_END);
			   incountPhase.removeFromParent(true);
			});

			incountPhase.addEventListener(IncountPhase.INCOUNT_INVOKE_BATTLE, toBattlePhase);
			incountPhase.addEventListener(IncountPhase.INCOUNT_INVOKE_EVENT, toEventPhase);

		}

		private function toEventPhase(e:Event = null):void {

			hud.dispatchEventWith(HUD.PHASE_EVENT);

			trace('eventPhase');

			currentPhase = PHASE_EVENT;
			gameEventDispatcher.dispatchEventWith(Game.GAME_START_EVENT, false, e?e.data:null);
			mobManager.setAnimationState_all(Mob.ANIMATION_STATE_IDLE);
			mapScrollEfficiency = 0.00;

			eventPhase = overflow.addChild(new EventPhase(e ? e.data as Class:null)) as EventPhase;
			eventPhase.addEventListener(EventPhase.EVENT_COMPLETE, function (e:Event):void {
			   hud.dispatchEventWith(HUD.PHASE_EVENT_END);
			   eventPhase.removeFromParent(true);
			});

			eventPhase.addEventListener(EventPhase.EVENT_INVOKE_MOVE, function(e:Event):void {
			   toMovePhase();
			});

		}

		private function toBattlePhase(e:Event = null):void {

			hud.dispatchEventWith(HUD.PHASE_BATTLE);

			trace('battlePhase');

			currentPhase = PHASE_BATTLE;
			gameEventDispatcher.dispatchEventWith(Game.GAME_START_BATTLE, false, null);
			mobManager.setAnimationState_all(Mob.ANIMATION_STATE_IDLE);
			mapScrollEfficiency = 0.00;

			battlePhase = overflow.addChild(new BattlePhase()) as BattlePhase;

			battlePhase.addEventListener(BattlePhase.BATTLE_COMPLETE, function (e:Event):void {
			   hud.dispatchEventWith(HUD.PHASE_BATTLE_END);
			   battlePhase.removeFromParent(true);
			});

			battlePhase.addEventListener(BattlePhase.BATTLE_INVOKE_MOVE, function (e:Event):void {
			   toMovePhase();
			});
			battlePhase.addEventListener(BattlePhase.BATTLE_INVOKE_EVENT,  function (e:Event):void {
			   toEventPhase();
			});
			battlePhase.addEventListener(BattlePhase.BATTLE_INVOKE_GAME_OVER, function (e:Event):void {
			   toGameOver();
			});
		}


		private function toMovePhase(e:Event = null):void {

			hud.dispatchEventWith(HUD.PHASE_MOVE);

			trace('movePhase');

			mobManager.purgeAntiMobs();

			currentPhase = PHASE_MOVE;
			gameEventDispatcher.dispatchEventWith(Game.GAME_START_MOVE, false, null);
			mobManager.setAnimationState_all(Mob.ANIMATION_STATE_WALK);
			mapScrollEfficiency = 1.00;

			movePhase = overflow.addChild(new MovePhase()) as MovePhase;
			movePhase.addEventListener(MovePhase.MOVE_COMPLETE, function (e:Event):void {
			   hud.dispatchEventWith(HUD.PHASE_MOVE_END);
			   movePhase.removeFromParent(true);
			});

			movePhase.addEventListener(MovePhase.MOVE_INVOKE_INCOUNT, toIncounterPhase);
			movePhase.addEventListener(MovePhase.MOVE_INVOKE_CAMP, toCampPhase);

		}

		private function toCampPhase(e:Event = null):void {

			trace('campPhase');

			currentPhase = PHASE_CAMP;
			gameEventDispatcher.dispatchEventWith(Game.GAME_START_CAMP, false, null);
			mobManager.setAnimationState_all(Mob.ANIMATION_STATE_IDLE);
			mapScrollEfficiency = 0.00;

			campPhase = overflow.addChild(new CampPhase()) as CampPhase;
			campPhase.addEventListener(CampPhase.CAMP_COMPLETE, function (e:Event):void {
			   hud.dispatchEventWith(HUD.PHASE_CAMP_END);
			   campPhase.removeFromParent(true);
			});

			campPhase.addEventListener(CampPhase.CAMP_INVOKE_MOVE, toMovePhase);
			campPhase.addEventListener(CampPhase.CAMP_INVOKE_EVENT, toEventPhase);

		}



		public function start(assets:AssetManager, mobDatas:DataManager, levelDatas:DataManager):void {

			mMobDatas = mobDatas;
			mLevelDatas = levelDatas;
			mAssets = assets;

			var initX:Number = Main.stageWidth * .5;
			var initY:Number = Main.stageHeight * .5;
			var initWidth:Number = Main.stageWidth * .33;
			var initHeight:Number = Main.stageHeight * .03;
			var loadingBar:LoadingBar = new LoadingBar(initX,initY,initWidth,initHeight);
			addChild(loadingBar);

			mAssets.loadQueue(function (ratio:Number):void {
			     if (ratio >= 1) {
			        Starling.juggler.delayCall(function():void {
			           removeChild(loadingBar);
			           Main.commandSet.visible = true;
			           completeLoad();
			        }, 0.50);
			     } else {
			        loadingBar.ratio = ratio;
			     }
			  });
		}


	}

}