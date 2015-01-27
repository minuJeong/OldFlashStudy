package com.Game.overflow{
	import starling.display.Sprite;
	import starling.events.Event;
	import com.sys_popup.ImagePopup;

	public class GameoverPhase extends Sprite {

		public static const GAMEOVER_INVOKE_MOVE:String = 'gameover invoke move';

		public function GameoverPhase() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			ImagePopup.popImage('gameoverPhase', gameOverPhase);
		}

		private function gameOverPhase():void {

			dispatchEventWith(GameoverPhase.GAMEOVER_INVOKE_MOVE);

		}

	}

}