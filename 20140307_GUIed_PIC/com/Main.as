package com {

	import flash.filesystem.File;

	import flash.display.MovieClip;
	import flash.display.InteractiveObject;

	import flash.events.Event;
	import flash.events.NativeDragEvent;

	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.desktop.NativeDragActions;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.StageScaleMode;
	import com.handles.Handle_DragWin;
	import flash.display.Sprite;

	public class Main extends MovieClip {

		public static var canvas: Sprite;
		public static var STAGE_WIDTH: Number = 0;
		public static var STAGE_HEIGHT: Number = 0;

		private var readImages: Array = [];

		public function Main() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e: Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			STAGE_WIDTH = stage.stageWidth;
			STAGE_HEIGHT = stage.stageHeight;

			stage.scaleMode = StageScaleMode.NO_SCALE;

			var appWin: AppWindow = addChild(new AppWindow()) as AppWindow;
			appWin.x = stage.stageWidth * .5 - appWin.width * .5;
			appWin.y = stage.stageHeight * .5 - appWin.height * .5;

			canvas = addChild(new Sprite()) as Sprite;

			appWin.addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER, dragIn);
			appWin.addEventListener(NativeDragEvent.NATIVE_DRAG_DROP, dragDrop);
		}

		private function dragIn(e: NativeDragEvent): void {
			if (e.clipboard.hasFormat(ClipboardFormats.FILE_LIST_FORMAT)) {
				NativeDragManager.acceptDragDrop(e.currentTarget as InteractiveObject);
			}
		}

		private function dragDrop(e: NativeDragEvent): void {
			NativeDragManager.dropAction = NativeDragActions.COPY;
			var data: Array = e.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
			processData(data);
		}

		private function processData(data: Array): void {
			for each(var file: File in data) {
				processDirectory(file);
			}
		}

		private function processDirectory(dir: File): void {
			if (!dir.isDirectory) {
				// dir is file.
				processFile(dir);
				return;
			}

			for each(var file: File in dir.getDirectoryListing()) {
				if (file.isDirectory) {
					processDirectory(file);
				} else {
					processFile(file);
				}
			}
		}

		private var loader: Loader;
		private function processFile(file: File): void {
			if (file.nativePath.search(".jpg") != -1 || file.nativePath.search(".png") != -1) {
				readImages.push(file);
			} else {
				trace("file is not jpg nor png");
			}

			if (readImages.length > 0) {
				for (var i: int = 0; i < readImages.length; i++) {
					addChild(new LocalImage(readImages[i].url));
				}
			}
		}
	}

}