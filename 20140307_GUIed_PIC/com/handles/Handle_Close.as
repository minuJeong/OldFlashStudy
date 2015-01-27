package com.handles {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;


	public class Handle_Close extends MovieClip {


		public function Handle_Close() {
			addEventListener(MouseEvent.CLICK, close);
		}

		private function close(e: MouseEvent): void {
			this.stage.nativeWindow.close();
		}
	}

}