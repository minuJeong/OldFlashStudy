package com.Game.mob{

	import flash.utils.ByteArray;

	import starling.display.Sprite;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.core.Starling;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureSmoothing;

	import com.Game.Game;
	import com.Main;

	public class Mob extends Sprite {

		public static const MOB_EVENT_ATTACK:String = 'mob event attack';
		public static const MOB_EVENT_GET_HIT:String = 'mob event get hit';
		public static const MOB_EVENT_RUN:String = 'mob event run';
		public static const MOB_EVENT_DIE:String = 'mob event die';
		public static const MOB_EVENT_RECOVER:String = 'mob event recover';

		public static const ANIMATION_STATE_WALK:String = 'walk_';
		public static const ANIMATION_STATE_IDLE:String = 'idle_';
		public static const ANIMATION_STATE_ATK:String = 'atk_';
		public static const ANIMATION_STATE_DOWN:String = 'down';
		public static const ANIMATION_STATE_HIT:String = 'hit';

		public var mobName:String;
		public var graphicsType:String;
		public var animationState:String;;

		protected var atlas:TextureAtlas;

		private var movieClip:MovieClip;

		public var vitalData:VitalData;
		public var side:int = MobManager.HERO_SIDE;
		public var position:int = MobManager.CENT_BACK;

		public function Mob(mobName:String = 'guard', initX:Number = 0, initY:Number = 0) {

			this.mobName = mobName;

			x = initX;
			y = initY;


			atlas = Game.mAssets.getTextureAtlas('mob_' + mobName);
			animationState = ANIMATION_STATE_WALK;

			vitalData = new VitalData(this);

			addEventListener(Event.ADDED_TO_STAGE, init);

			addEventListener(Mob.MOB_EVENT_ATTACK, onAttack);
			addEventListener(Mob.MOB_EVENT_GET_HIT, onGetHit);
			addEventListener(Mob.MOB_EVENT_RUN, onRun);
			addEventListener(Mob.MOB_EVENT_DIE, onDie);
			addEventListener(Mob.MOB_EVENT_RECOVER, onRecover);

		}


		public function onAttack():void {
		}
		public function onGetHit():void {
		}
		public function onRun():void {
		}

		public function onDie():void {

			setAnimationState(ANIMATION_STATE_DOWN);

			Starling.juggler.delayCall(function():void {
			   Game.mobManager.removeMob_bySlot(side, position);
			}, 1.00);

		}

		public function onRecover():void {

			vitalData.hp = vitalData.maxHP;
			vitalData.mp = vitalData.maxMP;
			vitalData.sp = vitalData.maxSP;

		}




		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			setImage();
		}

		public function setAnimationState(state:String):void {
			if (animationState == state) {
				return;
			}
			animationState = state;
			setImage();
		}

		protected function setImage():void {
			if (movieClip) {
				removeChild(movieClip);
				movieClip = null;
			}

			var textureName:String = animationState;
			movieClip = new MovieClip(atlas.getTextures(textureName),4);

			movieClip.scaleX = movieClip.scaleY = 2.00;
			movieClip.pivotX = 32;
			movieClip.pivotY = 55;
			movieClip.smoothing = TextureSmoothing.NONE;

			if (animationState == ANIMATION_STATE_HIT || animationState == ANIMATION_STATE_DOWN) {
				movieClip.fps = 1;
			}

			Starling.juggler.add(movieClip);
			addChild(movieClip);



			if (animationState == ANIMATION_STATE_ATK || animationState == ANIMATION_STATE_HIT || animationState == ANIMATION_STATE_DOWN) {

				movieClip.addEventListener(Event.COMPLETE,
				   function(e:Event):void {
				       movieClip.removeEventListeners(Event.COMPLETE);
				       animationState = ANIMATION_STATE_IDLE;
				       setImage();
				   });
			}
		}

	}

}