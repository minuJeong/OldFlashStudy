package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display3D.IndexBuffer3D;
	import flash.filters.BlurFilter;


	public class Main extends MovieClip {

		private var ball: Follower;

		private const friction: Number = .98;

		private var keys: Array;
		private var track: Sprite;
		private var followers: Array;

		public function Main() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e: Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			keys = new Array();

			ball = addChild(new Follower()) as Follower;
			ball.graphics.beginFill(0xb78670);
			ball.graphics.drawCircle(0, 0, 15);
			ball.graphics.endFill();
			ball.x = stage.stageWidth >> 1;
			ball.y = stage.stageWidth >> 1;


			// add Followers
			var numberOfFollowers: int = 30;
			followers = new Array();
			var fll_0: Follower = addChild(new Follower(ball, 1)) as Follower;
			followers.push(fll_0);

			for (var j: int = 0; j <= numberOfFollowers; j++) {
				var fll: Follower = addChild(new Follower(followers[j], j)) as Follower;
				followers.push(fll);
				fll.x = ball.x;
				fll.y = ball.y;
				numberOfFollowers--;
			}

			track = addChild(new Sprite()) as Sprite;

			addChild(ball);

			addEventListener(Event.ENTER_FRAME, update);

			stage.addEventListener(KeyboardEvent.KEY_DOWN, function (e: KeyboardEvent): void {
				purge(e.keyCode);
				keys.push(e.keyCode);
			});
			stage.addEventListener(KeyboardEvent.KEY_UP, function (e: KeyboardEvent): void {
				purge(e.keyCode);
			});

			function purge(n: int): void {
				for (var i: int = keys.length - 1; i >= 0; i--) {
					if (n == keys[i]) {
						keys.splice(i, 1);
					}
				}
			}

			filters = new Array(new BlurFilter(5, 1, 5));
		}

		private function update(e: Event): void {
			readKeys();
			wrapStage();
			drawTrack();

			ball.vy += .2;
		}

		private function drawTrack(): void {
			track.graphics.clear();
			track.graphics.lineStyle(3, 0xb90898);
			track.graphics.moveTo(ball.x, ball.y);
			var len: int = followers.length;
			for (var i: int = 0; i < len; i++) {
				track.graphics.lineTo(followers[i].x, followers[i].y);
			}
			track.graphics.endFill();
		}

		private function wrapStage(): void {
			if (ball.x - ball.width / 2 < 0) {
				ball.x = ball.width / 2;
				ball.vx *= -1;
			} else if (ball.x + ball.width / 2 > stage.stageWidth) {
				ball.x = stage.stageWidth - ball.width / 2;
				ball.vx *= -1;
			}

			if (ball.y - ball.height / 2 < 0) {
				ball.y = ball.height / 2;
				ball.vy *= -1;
			} else if (ball.y + ball.height / 2 > stage.stageHeight) {
				ball.y = stage.stageHeight - ball.height / 2;
				ball.vy *= -1;
			}

		}

		private function readKeys(): void {
			for (var i: int = keys.length - 1; i >= 0; i--) {
				switch (keys[i]) {
					case Keyboard.LEFT:
						ball.vx -= 3;
						break;

					case Keyboard.UP:
						ball.vy -= 3;
						break;

					case Keyboard.RIGHT:
						ball.vx += 3;
						break;

					case Keyboard.DOWN:
						ball.vy += 3;
						break;

				}
			}
		}
	}

}