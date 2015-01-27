package com.handles {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;


	public class Handle_DragWin extends MovieClip {


		public function Handle_DragWin() {
			addEventListener(MouseEvent.MOUSE_DOWN, startDragWindow);

		}

		private function startDragWindow(e: MouseEvent): void {
			this.stage.nativeWindow.startMove();
		}
	}

}