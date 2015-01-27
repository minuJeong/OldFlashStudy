package com.commandSet{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.DisplayObject;
	import flash.events.TouchEvent;

	import com.Game.Game;
	import starling.events.Event;
	import flash.events.MouseEvent;

	public class CommandSetTemplate extends Sprite {

		public static const COMMAND_ONINCOUNTER_ATTACK:String = 'command onincounter attack';
		public static const COMMAND_ONINCOUNTER_DONOTHING:String = 'command onincounter donothing';
		public static const COMMAND_ONINCOUNTER_DIALOGUE:String = 'command onincounter dialogue';
		public static const COMMAND_ONINCOUNTER_WALKAWAY:String = 'command onincounter walkaway';
		public static const COMMAND_ONINCOUNTER_STEAL:String = 'command onincounter steal';
		public static const COMMAND_ONINCOUNTER_WATCH:String = 'command onincounter watch';
		public static const COMMAND_ONINCOUNTER_HIDE:String = 'command onincounter hide';
		public static const COMMAND_ONINCOUNTER_BRIBE:String = 'command onincounter bribe';

		public static const COMMAND_ONCAMP_SNACK:String = 'command oncamp snack';
		public static const COMMAND_ONCAMP_SLEEP:String = 'command oncamp sleep';
		public static const COMMAND_ONCAMP_REPAIR:String = 'command oncamp repair';
		public static const COMMAND_ONCAMP_CONVERSE:String = 'command oncamp converse';
		public static const COMMAND_ONCAMP_MEAL:String = 'command oncamp meal';
		public static const COMMAND_ONCAMP_MEMORISE:String = 'command oncamp memorise';
		public static const COMMAND_ONCAMP_TRAIN:String = 'command oncamp train';
		public static const COMMAND_ONCAMP_HOBBY:String = 'command oncamp hobby';

		public static const COMMAND_ONBATTLE_ATTACK:String = 'command onbattle attack';
		public static const COMMAND_ONBATTLE_POWER_ATTACK:String = 'command onbattle power attack';
		public static const COMMAND_ONBATTLE_CHECK:String = 'command onbattle check';
		public static const COMMAND_ONBATTLE_PROVOKE:String = 'command onbattle provoke';
		public static const COMMAND_ONBATTLE_DEFENSE:String = 'command onbattle defense';
		public static const COMMAND_ONBATTLE_SURRENDER:String = 'command onbattle surrender';
		public static const COMMAND_ONBATTLE_RUN:String = 'command onbattle run';
		public static const COMMAND_ONBATTLE_SACRIFICE:String = 'command onbattle sacrifice';

		public static const COMMAND_ONMOVE_FORMATION_1:String = 'command onmove formation 1';
		public static const COMMAND_ONMOVE_FORMATION_2:String = 'command onmove formation 2';
		public static const COMMAND_ONMOVE_FORMATION_3:String = 'command onmove formation 3';
		public static const COMMAND_ONMOVE_FORMATION_4:String = 'command onmove formation 4';
		public static const COMMAND_ONMOVE_SNEAK:String = 'command onmove sneak';
		public static const COMMAND_ONMOVE_PROVOKE:String = 'command onmove provoke';
		public static const COMMAND_ONMOVE_SEARCH:String = 'command onmove search';
		public static const COMMAND_ONMOVE_CAMP:String = 'command onmove camp';


		public var commandValue:String = 'template';

		private var targetScale:Number = 1.00;
		private var targetAlpha:Number = 0.50;
		private var scale:Number;

		public function CommandSetTemplate() {

			scale = 1.00;

		}

		private function gameEnterframe(e:starling.events.Event):void {

			var differenceScale:Number = targetScale - scale;
			scale +=  differenceScale * .1;
			scaleX = scaleY = scale;

			if (targetScale != 1.00 && scale >= 1.2) {
				targetScale = 1.00;
			}

			var differenceAlpha:Number = targetAlpha - alpha;
			alpha +=  differenceAlpha * .1;

			if (Math.abs(differenceAlpha) < .1) {
				targetAlpha = 0.50;
			}

		}

		public function on():void {
			addEventListener(TouchEvent.TOUCH_TAP, onTouch);
			addEventListener(TouchEvent.TOUCH_BEGIN, sizeTransite);

			addEventListener(MouseEvent.CLICK, onTouch);
			addEventListener(MouseEvent.MOUSE_DOWN, sizeTransite);

			Game.gameEventDispatcher.addEventListener(Game.GAME_ENTER_FRAME, gameEnterframe);
		}

		public function off():void {
			removeEventListener(TouchEvent.TOUCH_TAP, onTouch);
			removeEventListener(TouchEvent.TOUCH_BEGIN, sizeTransite);

			Game.gameEventDispatcher.removeEventListener(Game.GAME_ENTER_FRAME, gameEnterframe);
			scale = 1.00;
			scaleX = scaleY = 1.00;
		}

		private function onTouch(e:*):void {
			CommandSet.commandSetEventDispatcher.dispatchEventWith(commandValue);
		}

		private function sizeTransite(e:*):void {
			targetScale = 1.50;
			targetAlpha = 1.00;
		}

	}

}