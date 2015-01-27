package com.util.pop{
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.filesystem.File;

	public class PopWindow {

		public function PopWindow() {
			// constructor code
		}

		public static function popupWindow(INIT:Class, ... args):NativeWindow {
			var initOptions:NativeWindowInitOptions = new NativeWindowInitOptions();
			initOptions.maximizable = false;
			initOptions.minimizable = false;
			initOptions.resizable = false;
			initOptions.systemChrome = NativeWindowSystemChrome.NONE;
			initOptions.type = NativeWindowType.NORMAL;
			initOptions.transparent = true;

			var nativeWindow:NativeWindow = new NativeWindow(initOptions);
			nativeWindow.stage.scaleMode = StageScaleMode.NO_SCALE;
			nativeWindow.stage.align = StageAlign.TOP_LEFT;
			var child = new INIT();
			nativeWindow.width = child.width;
			nativeWindow.height = child.height;
			nativeWindow.stage.addChild(child);
			nativeWindow.activate();

			return nativeWindow;
		}

		public static function popupFileSaveDetailMod(file:File, path:String):NativeWindow {
			var initOptions:NativeWindowInitOptions = new NativeWindowInitOptions();
			initOptions.maximizable = false;
			initOptions.minimizable = false;
			initOptions.resizable = false;
			initOptions.systemChrome = NativeWindowSystemChrome.NONE;
			initOptions.type = NativeWindowType.NORMAL;
			initOptions.transparent = true;

			var nativeWindow:NativeWindow = new NativeWindow(initOptions);
			nativeWindow.title = "Detail Options";
			nativeWindow.stage.scaleMode = StageScaleMode.NO_SCALE;
			nativeWindow.stage.align = StageAlign.TOP_LEFT;
			var child:FileSave_DetailedMod = new FileSave_DetailedMod(file,path);
			nativeWindow.width = child.width + 2;
			nativeWindow.height = child.height + 2;
			nativeWindow.stage.addChild(child);
			nativeWindow.activate();

			return nativeWindow;
		}

	}

}