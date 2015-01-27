package dropbox{
	import flash.display.Sprite;
	import flash.events.Event;

	public class DropBox extends Sprite {

		public function DropBox() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			
		}

	}

}