package {
	import flash.display.Sprite;
	import flash.events.Event;

	public class Follower extends Sprite {

		private var follow_target: Sprite;
		private var rad: Number;

		public var vx: Number = 0;
		public var vy: Number = 0;

		private const friction: Number = .95;

		public function Follower(follow_target: Sprite = null, rad: int = 12) {
			if (follow_target) {
				this.follow_target = follow_target;
			}

			this.rad = rad;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e: Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			graphics.beginFill(0xc0a0a0);
			// graphics.drawCircle(0, 0, rad);

			addEventListener(Event.ENTER_FRAME, update);
		}

		private function update(e: Event): void {
			var dx: Number = follow_target.x - x;
			var dy: Number = follow_target.y - y;

			x += dx * .1;
			y += dy * .1;
			
			x += vx;
			y += vy;
			
			vx *= friction;
			vy *= friction;
		}

	}

}