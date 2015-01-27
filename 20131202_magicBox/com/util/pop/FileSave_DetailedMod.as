package com.util.pop{
	import flash.display.Sprite;
	import flash.filesystem.File;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	import flash.utils.ByteArray;
	import flash.display.Loader;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import com.util.FileNamer;
	import flash.errors.IOError;

	public class FileSave_DetailedMod extends Sprite {

		private var file:File;
		private var path:String;

		private var previewLayer:Sprite;
		private var toastLayer:Sprite;
		private var warnToast:FileExistsWarning;

		public function FileSave_DetailedMod(file:File, path:String) {
			this.file = file;
			this.path = path;

			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			previewLayer = addChild(new Sprite()) as Sprite;
			toastLayer = addChild(new Sprite()) as Sprite;

			warnToast = toastLayer.addChild(new FileExistsWarning()) as FileExistsWarning;
			warnToast.x = stage.stageWidth * .5;
			warnToast.y = stage.stageHeight * .5;

			var url:URLRequest = new URLRequest(file.url);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (e:Event):void {
			  var bitmap:Bitmap = e.target.content;
			  
			  bitmap.width = Math.min(bitmap.width, 170);
			  bitmap.height = Math.min(bitmap.height, 170);
			  
			  bitmap.scaleY = bitmap.scaleX = Math.min(bitmap.scaleX, bitmap.scaleY);
			  
			  bitmap.x = imagePreviewArea.x - bitmap.width * .5;
			  bitmap.y = imagePreviewArea.y - bitmap.height * .5;
			  
			  previewLayer.addChild(bitmap);
			  
			  stage.focus = t_addName;
			  t_addName.addEventListener(FocusEvent.FOCUS_OUT, function (e:FocusEvent):void {
			     stage.focus = t_addName;
			  });
			  
			  stage.addEventListener(KeyboardEvent.KEY_DOWN, function (e:KeyboardEvent):void {
			     if (e.keyCode == Keyboard.ENTER) {
			        saveToFile();
			     }
			   });
			});
			loader.load(url);
		}

		public function saveToFile():void {
			var newName:String = FileNamer.grabNameRule(file.name) + t_addName.text + ".png";
			var targetFile:File = new File(path + newName);
			if (targetFile.exists) {
				trace("file exists");
				warnToast.toast(120);
				return;
			}

			trace("saving file to: " + targetFile.name);
			try {
				file.moveTo(targetFile, true);
			} catch (e:IOError) {
				trace(e.message);
			}

			this.stage.nativeWindow.close();
		}

	}

}