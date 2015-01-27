package com.handlers{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.util.pop.FileSave_DetailedMod;


	public class HandleSaveToFile extends Handle {


		public function HandleSaveToFile() {
			addEventListener(MouseEvent.CLICK, saveFile);
		}

		protected function saveFile(e:MouseEvent = null):void {
			if (parent) {
				var fileSavePage:FileSave_DetailedMod = parent as FileSave_DetailedMod;
				fileSavePage.saveToFile();
			}
		}
	}

}