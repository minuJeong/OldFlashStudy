package com.Game.mob{

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.DisplayObject;
	import flash.geom.Point;
	import starling.animation.Tween;
	import starling.animation.Transitions;
	import com.Main;
	import starling.core.Starling;

	public class MobManager extends Sprite {

		public static const HERO_SIDE:int = 0;
		public static const ANTI_SIDE:int = 1;
		public static const SIDE_LENGTH:int = 2;


		public static const ANON_POSITION:int = -1;

		public static const LEFT_WING:int = 0;
		public static const CENT_BACK:int = 1;
		public static const RIGH_WING:int = 2;
		public static const POSITION_LENGTH:int = 3;


		private var slots:Array;
		private var mobs:Array;

		public function MobManager() {

			slots = [[],[]];
			slots[HERO_SIDE][LEFT_WING] = new Point(120,270);
			slots[HERO_SIDE][CENT_BACK] = new Point(60,300);
			slots[HERO_SIDE][RIGH_WING] = new Point(160,330);

			slots[ANTI_SIDE][LEFT_WING] = new Point(320,270);
			slots[ANTI_SIDE][CENT_BACK] = new Point(400,300);
			slots[ANTI_SIDE][RIGH_WING] = new Point(360,330);

			mobs = [[],[]];

		}

		public function addMob(textureName, side:int, position:int):Mob {

			if (side >= SIDE_LENGTH || position >= POSITION_LENGTH) {
				trace('out of postion count');
				return null;
			}

			if (mobs[side][position]) {
				trace('mob already exists');
				return mobs[side][position];
			}

			if (position == ANON_POSITION) {
				var availablePositions:Array = new Array();

				if (! getMob_bySlot(side,RIGH_WING)) {
					availablePositions.push(RIGH_WING);
				}
				if (! getMob_bySlot(side,CENT_BACK)) {
					availablePositions.push(CENT_BACK);
				}
				if (! getMob_bySlot(side,LEFT_WING)) {
					availablePositions.push(LEFT_WING);
				}

				if (availablePositions.length <= 0) {
					trace('none position left, and called anon-position');
					return null;
				}

				var n:int = Math.floor(Math.random() * availablePositions.length);
				position = availablePositions[n];

			}

			var initX:Number = slots[side][position].x;
			var initY:Number = slots[side][position].y;
			mobs[side][position] = addChild(new Mob(textureName,initX,initY)) as Mob;
			mobs[side][position].side = side;
			mobs[side][position].position = position;
			if (side == ANTI_SIDE) {
				mobs[side][position].scaleX = -1;
			}
			y_sort();




			var tween:Tween = new Tween(mobs[side][position],1.00,Transitions.LINEAR);
			mobs[side][position].setAnimationState(Mob.ANIMATION_STATE_WALK);

			tween.moveTo(mobs[side][position].x, mobs[side][position].y);

			if (side == MobManager.HERO_SIDE) {
				mobs[side][position].x -=  Main.stageWidth * .2;
			} else if (side == MobManager.ANTI_SIDE) {
				mobs[side][position].x +=  Main.stageWidth * .2;
			}

			Starling.juggler.add(tween);


			if (side == MobManager.ANTI_SIDE) {
				tween.onComplete = function():void {
				   mobs[side][position].setAnimationState(Mob.ANIMATION_STATE_IDLE);
				};
			}

			return mobs[side][position];
		}

		public function removeMob_bySlot(side:int, position:int):void {

			if (mobs[side][position] == null) {
				return;
			}

			var thisMob:Mob = mobs[side][position];
			thisMob.removeFromParent(true);

			mobs[side][position] = null;

		}

		public function y_sort():void {
			sortChildren(function (a:DisplayObject, b:DisplayObject):int {
			   if (a is Mob && b is Mob){
			       if (a.y > b.y) {
			          return 1;
			       } else if (a.y < b.y) {
			          return -1;
			       } else {
			          return 0;
			       }
			   } else {
			      return 0;
			   }
			 });
		}




		public function setAnimationState_all(animationState:String):void {
			var length:int = numChildren;
			for (var i:int = 0; i < length; i++) {
				var thisMob:Mob = getChildAt(i) as Mob;
				thisMob.setAnimationState(animationState);
			}
		}

		public function setAnimationState_bySlot(animationState:String, side:int, position:int):void {
			if (mobs[side][position]) {
				var targetMob:Mob = mobs[side][position];
				targetMob.setAnimationState(animationState);
			}
		}

		public function getMobs():Array {
			return mobs;
		}

		public function getMob_bySlot(side:int, position:int):Mob {
			return mobs[side][position];
		}


		public function isHeroSideSurvive():Boolean {
			if (getMob_bySlot(MobManager.HERO_SIDE, MobManager.LEFT_WING) ||
			    getMob_bySlot(MobManager.HERO_SIDE, MobManager.CENT_BACK) ||
			    getMob_bySlot(MobManager.HERO_SIDE, MobManager.RIGH_WING) ) {

				return true;
			}

			return false;
		}


		public function purgeAntiMobs():void {

			retreatMob_bySlot(MobManager.ANTI_SIDE, MobManager.LEFT_WING);
			retreatMob_bySlot(MobManager.ANTI_SIDE, MobManager.CENT_BACK);
			retreatMob_bySlot(MobManager.ANTI_SIDE, MobManager.RIGH_WING);

		}

		public function retreatMob_bySlot(side:int, position:int):Mob {

			var mob:Mob = getMob_bySlot(side,position);
			if (mob) {
				mob.scaleX = side == MobManager.HERO_SIDE ? -1.00:1.00;
				mob.setAnimationState(Mob.ANIMATION_STATE_WALK);
				var tween:Tween = new Tween(mob,1.0,Transitions.LINEAR);
				tween.moveTo(side == MobManager.HERO_SIDE ? mob.x - Main.stageWidth * .3 : mob.x + Main.stageWidth * .3, mob.y);
				Starling.juggler.add(tween);

				tween.onComplete = function ():void {
				   removeMob_bySlot(side, position);
				   mob.removeFromParent(true);
				};
			}

			return mob;
		}

	}

}