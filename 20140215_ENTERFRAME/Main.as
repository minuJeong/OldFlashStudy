package {

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;


	public class Main extends MovieClip {
		private var ball: Sprite;
		private var oldX: Number;
		private var speedX: Number;
		private var speedY: Number;

		public function Main() {
			ball = addChild(new Sprite()) as Sprite;
			ball.graphics.beginFill(0xff0000);
			ball.graphics.drawCircle(0, 0, 15);
			ball.graphics.endFill();
			ball.x = 100;
			ball.y = 100;
			speedX = 3.3;
			speedY = 3.3;
			ball.addEventListener(Event.ENTER_FRAME, ballani);

			trace(stage);
			trace(stage.stageWidth);
		}

		private function ballani(e) {
			oldX = x;

			x += speedX;
			y += speedY;

			if (x >=100 || x < 0) {
				speedX *= -1;
			}
			
			if (y >=100 || y < 0) {
				speedY *= -1;
			}


			trace(x);
			trace(y);
		}


	}
}