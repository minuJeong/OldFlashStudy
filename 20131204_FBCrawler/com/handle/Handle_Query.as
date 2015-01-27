package com.handle {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	
	public class Handle_Query extends Handle {
		
		
		public function Handle_Query() {
			addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				dispatchEvent(new Event("query"));
			});
		}
	}
	
}
