package com.handlers{

	import flash.events.MouseEvent;

	public class Handle_Drag extends Handle {


		public function Handle_Drag() {
			addEventListener(MouseEvent.MOUSE_DOWN, shootDrag);
		}

		private function shootDrag(e:MouseEvent):void {
			this.stage.nativeWindow.startMove();
		}
	}

}