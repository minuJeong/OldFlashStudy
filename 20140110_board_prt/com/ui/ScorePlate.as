package com.ui {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import com.units.Unit;

	public class ScorePlate extends Sprite {

		private const max_row: int = 4;
		private const max_col: int = 10;

		private var player_data: Array;

		public function ScorePlate(player_data: Array) {
			this.player_data = player_data;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e: Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			update();
		}

		public function update(): void {
			purge();
			for (var j: int = 0; j < max_col; j++) {
				for (var i: int = 0; i < max_row; i++) {
					var scoreSet: TextField = addChild(new TextField()) as TextField;
					scoreSet.x = i * 140;
					scoreSet.y = j * 30;
					var player: Unit = player_data[max_row * j + i];
					if (player) {
						scoreSet.appendText(player.unitName + ": " + player.score + "pt");
					}
				}
			}
		}

		private function purge(): void {
			for (var i: int = numChildren - 1; i >= 0; i--) {
				removeChild(getChildAt(i));
			}
		}

	}

}