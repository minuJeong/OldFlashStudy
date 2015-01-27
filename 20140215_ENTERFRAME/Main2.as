package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Sprite;


	public class Main2 extends MovieClip {
		private var ball: Sprite;

		public function Main2() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e: Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			ball = addChild(new Sprite()) as Sprite;
			ball.graphics.beginFill(0xc71829);
			ball.graphics.lineStyle(5, 0x704050);
			ball.graphics.drawCircle(0, 0, 17);
			ball.graphics.endFill();
			
			ball.x = stage.stageWidth * .5;
			ball.y = stage.stageHeight * .5;

			addEventListener(Event.ENTER_FRAME, update);
		}

		private function update(e: Event): void {
			
		}
	}

}