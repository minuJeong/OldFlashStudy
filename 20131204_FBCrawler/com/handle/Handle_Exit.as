package com.handle{

	import flash.events.MouseEvent;

	public class Handle_Exit extends Handle {


		public function Handle_Exit() {
			addEventListener(MouseEvent.CLICK, shootExit);
		}

		private function shootExit(e:MouseEvent):void {
			this.stage.nativeWindow.close();
		}
	}

}