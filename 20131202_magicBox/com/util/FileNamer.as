package com.util{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class FileNamer {

		public static var fileNamerEventDispatcher:EventDispatcher = new EventDispatcher();

		private static var _PREFIX:String = "10_";
		public static function set PREFIX(prefix:String):void {
			if (_PREFIX != prefix) {
				fileNamerEventDispatcher.dispatchEvent(new Event(Event.CHANGE + "PREFIX"));
			}
			_PREFIX = prefix;
		}
		public static function get PREFIX():String {
			return _PREFIX;
		}

		private static var _CATEGORYFIX:String = "";
		public static function set CATEGORYFIX(categoryfix:String):void {
			if (_CATEGORYFIX != categoryfix) {
				fileNamerEventDispatcher.dispatchEvent(new Event(Event.CHANGE + "CATEGORYFIX"));
			}
			_CATEGORYFIX = categoryfix;
		}
		public static function get CATEGORYFIX():String {
			return _CATEGORYFIX;
		}



		public function FileNamer() {
		}

		public static function grabNameRule(fileName:String):String {
			var outputName:String = PREFIX + CATEGORYFIX;

			var regExp:RegExp = /\n/g;
			outputName.replace(regExp, "");

			trace("prefix: " + PREFIX);
			trace("categoryfix: " + CATEGORYFIX);
			return outputName;
		}

	}

}