package com {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.adobe.photoshop.connection.PhotoshopConnection;
	import com.adobe.photoshop.events.PhotoshopEvent;
	import com.structuredlogs.targets.TraceTarget;
	import com.adobe.photoshop.dispatchers.MessageDispatcher;
	import com.adobe.photoshop.messages.TextMessage;
	import com.adobe.photoshop.subscriptions.SubscriptionManager;
	import com.adobe.photoshop.events.SubscriptionEvent;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import com.hurlant.crypto.symmetric.NullPad;
	import flash.geom.Rectangle;
	import flash.filters.BitmapFilter;
	import flash.filters.BlurFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.display.Sprite;
	
	
	public class Main extends MovieClip {
		
		private var photoshopConn:PhotoshopConnection;
		private var palette:Bitmap;
		
		public function Main() {
			
			SLog.isLogging = true;
			var tt:TraceTarget = new TraceTarget();
			tt.includeCategory = true;
			SLog.addTarget(tt);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			photoshopConn = new PhotoshopConnection();
			
			b_connect.addEventListener(MouseEvent.CLICK, connectToPhotoshop);
		}
		
		private function connectToPhotoshop(e:MouseEvent):void {
			b_connect.visible = false;
			
			t_output.appendText("Try encryption.. \n");
			
			photoshopConn.addEventListener(PhotoshopEvent.ENCRYPTION_SUCCESS, function(e:PhotoshopEvent):void {
				t_output.appendText("Encryption successful \n");
				t_output.appendText("Connecting: " + t_ipname.text + " \n");
				
				photoshopConn.connect(t_ipname.text);
			});
			
			photoshopConn.addEventListener(PhotoshopEvent.CONNECTED, function(e:PhotoshopEvent):void {				
					
				t_output.appendText("Connection successful \n");
				onConnect();
			});
			
			photoshopConn.addEventListener(PhotoshopEvent.DISCONNECTED, function(e:PhotoshopEvent):void{
				
				t_output.appendText("password wrong. \n");
				b_connect.visible = true;
			});
			
			photoshopConn.addEventListener(PhotoshopEvent.ERROR, function(e:PhotoshopEvent):void{
				
				t_output.appendText("error: " + e.data + "\n");				
				b_connect.visible = true;
			});
			
			photoshopConn.initEncryption(t_password.text);
			
		}
		
		private function onConnect():void {
			t_ipname.visible = false;
			t_password.visible = false;
			
			// var script:String = new JavaScriptAction().getScript();
			// t_output.appendText(script);
			// var command:TextMessage = MessageDispatcher.generateTextMessage(script);
			// photoshopConn.encryptAndSendData(command.toStream());
			
			palette = addChild(new Bitmap(new Palette())) as Bitmap;
			palette.y = 235;
			
			var subscriptionManager:SubscriptionManager = new SubscriptionManager(photoshopConn);
			subscriptionManager.addEventListener(SubscriptionEvent.FOREGROUND_COLOR_CHANGED_EVENT, function(e:SubscriptionEvent){
				trace("ForegroundChanage");
				var centerX:Number = palette.width * Math.random();
				var centerY:Number = palette.height * Math.random();
				
				var colorString:String = e.data;
				var red:uint = parseInt(colorString.charAt(0) + colorString.charAt(1), 16);
				var green:uint = parseInt(colorString.charAt(2) + colorString.charAt(3), 16);
				var blue:uint = parseInt(colorString.charAt(4) + colorString.charAt(5), 16);
				var color:uint = red << 16 | green << 8 | blue;
				
				for (var i:int = 10; i >= -10; i--) {
					for (var j:int = 10; j >= -10; j--) {
						palette.bitmapData.setPixel(centerX + i, centerY + j, color);
					}
				}
			});
			
			interactivatePalette();
			
		}
		
		private function interactivatePalette():void {
			var picColor:uint = 0;
			var finger:Sprite;
			var power:Number = 0;
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void {
				picColor = palette.bitmapData.getPixel(palette.mouseX, palette.mouseY);
				finger = addChild(new Sprite()) as Sprite;
				power = 0.5;
				
				finger.y = palette.y;

				finger.graphics.lineStyle(150, picColor);
				
				finger.graphics.moveTo(palette.mouseX, palette.mouseY);
				addEventListener(Event.ENTER_FRAME, smudgeUpdate);
			});
			
			stage.addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent):void {
				palette.bitmapData.draw(finger);
				finger.graphics.clear();
				removeChild(finger);
				finger = null;
				
				var fingerColor:uint = picColor;
				var paletteColor:uint = palette.bitmapData.getPixel(palette.mouseX, palette.mouseY);

				var red:Number = ( (fingerColor >> 16 & 0xff * power) + (paletteColor >> 16 & 0xff * (1 - power)) ) / 2;
				var green:Number = ( (fingerColor >> 8 & 0xff * power) + (paletteColor >> 8 & 0xff * (1 - power)) ) / 2;
				var blue:Number = ( (fingerColor & 0xff * power) + (paletteColor & 0xff * (1 - power)) ) / 2;
				var foreColor:String = (red << 16 | green << 8 | blue).toString(16);
				
				var script:String = 
				"var fc = new SolidColor(); \n" +
				"fc.rgb.red = 255; \n"
				"fc.rgb.green = 255; \n"
				"fc.rgb.blue = 255; \n"
				"alert('ddd'); \n" +
				"app.foregroundColor = foreColor; \n" + 
				"alert(app.foregroundColor.rgb.red);";
				var cmd:TextMessage = MessageDispatcher.generateTextMessage(script);
				photoshopConn.encryptAndSendData(cmd.toStream());
				
				removeEventListener(Event.ENTER_FRAME, smudgeUpdate);
			});
			
			function smudgeUpdate(e:Event):void {
				power *= .98;
				
				finger.graphics.lineStyle(150 * power, picColor, power);
				finger.graphics.lineTo(palette.mouseX, palette.mouseY);
			}
			
		}
	}
}
