package com {

	import flash.display.MovieClip;
	import flash.events.Event;
	import com.buttons.RollDice;
	import com.units.Unit_Male;
	import com.units.Unit_Female;
	import com.units.Unit;
	import com.ui.ScorePlate;
	import com.buttons.AddPlayer;
	import com.buttons.ButtonBase;


	public class Main extends MovieClip {


		public function Main() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private var players: Array;
		private var current_turn_index: int = 0;
		private var score: ScorePlate;
		private function init(e: Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			players = [];
			players.push(addChild(new Unit_Male("Male") as Unit_Male));
			players.push(addChild(new Unit_Female("Female")) as Unit_Female);

			for each(var player: Unit in players) {
				player.targetX = player.x = stage.stageWidth * .15;
				player.y = stage.stageHeight * .7;
			}

			score = addChild(new ScorePlate(players)) as ScorePlate;

			var b_rollDice: RollDice = addChild(new RollDice()) as RollDice;
			b_rollDice.x = stage.stageWidth * .5;
			b_rollDice.y = stage.stageHeight * .3;
			b_rollDice.addEventListener(RollDice.ROLL, function (e: Event): void {
				player_move(rollDice(6));
				nextTurn();
			});

			var b_addPlayer: AddPlayer = addChild(new AddPlayer()) as AddPlayer;
			b_addPlayer.x = stage.stageWidth * .5;
			b_addPlayer.y = stage.stageHeight * .4;
			b_addPlayer.addEventListener(AddPlayer.ADD_PLAYER, function (e: Event): void {
				var newPlayer: Unit;
				if (Math.random() < .5) {
					newPlayer = addChild(new Unit_Male("newbie" + (players.length - 2))) as Unit_Male;
				} else {
					newPlayer = addChild(new Unit_Female("newbie" + (players.length - 2))) as Unit_Female;
				}
				players.push(newPlayer);
				newPlayer.targetX = newPlayer.x = stage.stageWidth * .15;
				newPlayer.y = stage.stageHeight * .7;
				score.update();
			});
		}

		private function player_move(n: int): void {
			var player: Unit = players[current_turn_index];
			player.targetX += 30 * n;
			player.targetX %= stage.stageWidth * .85;
			if (player.targetX < stage.stageWidth * .15) {
				player.targetX = stage.stageWidth * .15;
				player.score += 1;
				score.update();
			}
		}

		private function rollDice(n: int): int {
			return int(Math.random() * n) + 1;
		}

		private function nextTurn(): void {
			current_turn_index++;
			current_turn_index %= players.length;
		}

	}

}