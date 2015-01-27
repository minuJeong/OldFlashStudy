package com.handlers{
	import flash.events.NativeDragEvent;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.desktop.NativeDragManager;
	import flash.desktop.NativeDragActions;
	import flash.filesystem.File;
	import flash.net.FileReference;
	import flash.display.InteractiveObject;
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.errors.IOError;
	import com.util.FileNamer;
	import com.util.pop.PopWindow;
	import com.util.pop.FileSave_DetailedMod;

	public class HandleDropFile extends MovieClip {

		public function HandleDropFile() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			stop();

			addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER, acceptDrag);
			addEventListener(NativeDragEvent.NATIVE_DRAG_DROP, dropDrag);
		}

		private function acceptDrag(e:NativeDragEvent):void {
			if (e.clipboard.hasFormat(ClipboardFormats.FILE_LIST_FORMAT)) {
				gotoAndStop(2);
				NativeDragManager.acceptDragDrop(e.currentTarget as InteractiveObject);
			}
		}
		private function dropDrag(e:NativeDragEvent):void {
			gotoAndStop(1);

			NativeDragManager.dropAction = NativeDragActions.COPY;
			var files:Array = e.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
			solveDir(files);
		}

		private function solveDir(files:Array):void {

			var toSaveFiles:Array = new Array();

			for each (var file:File in files) {
				if (! file.isDirectory) {
					toSaveFiles.push(file);

				} else if (file.isDirectory) {
					var dir:Array = file.getDirectoryListing();
					solveDir(dir);
				}
			}

			for each (var toSaveFile:File in toSaveFiles) {
				var toSavePath:String = toSaveFile.nativePath.slice(0,toSaveFile.nativePath.lastIndexOf(toSaveFile.name));

				PopWindow.popupFileSaveDetailMod(toSaveFile, toSavePath);

				// toSaveFile.moveTo(new File(toSavePath + toSaveFileName), false);

			}
		}
	}

}