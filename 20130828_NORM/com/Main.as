package com{

	import flash.desktop.NativeApplication;
	import flash.filesystem.File;
	import flash.system.Capabilities;

	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.desktop.SystemIdleMode;
	import flash.display.DisplayObject;

	import flash.events.Event;
	import flash.events.KeyboardEvent;

	import flash.geom.Rectangle;

	import flash.ui.Keyboard;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;

	import flash.net.URLRequest;
	import flash.net.URLLoader;

	import starling.core.Starling;

	import starling.events.Event;

	import starling.utils.AssetManager;
	import starling.utils.RectangleUtil;
	import starling.utils.formatString;
	import starling.utils.ScaleMode;


	import com.Game.Game;

	import com.sys_popup.Popup_AskExit;
	import com.sys_popup.Popup_Menu;
	import com.commandSet.CommandSet;
	import com.Game.dataManager.DataManager;



	[SWF(width = 480,height = 800,frameRate = 30,backgroundColor = 0x202020)]
	public class Main extends Sprite {

		public static var mStarling:Starling;
		public static var stageWidth:Number = 480;
		public static var stageHeight:Number = 480;
		public static var mainStage:Stage;

		public static var flashSprite:Sprite;
		public static var box2DdebugDrawSprite:Sprite;

		public static var commandSet:CommandSet;

		private var mobDataParser:MobDataParser;
		private var levelDataParser:LevelDataParser;

		private var mobDataManager:DataManager;
		private var levelDataManager:DataManager;

		private var mobDataLoadingFlag:Boolean = false;
		private var levelDataLoadingFlag:Boolean = false;

		public function Main() {
			addEventListener(flash.events.Event.ADDED_TO_STAGE, loadData);
		}

		private function loadData(e:flash.events.Event = null):void {

			addEventListener(flash.events.Event.ENTER_FRAME, checkFlags);

			var urlReq:URLRequest;


			urlReq = new URLRequest("http://www.minuj.co.nf/data.txt");
			mobDataParser = new MobDataParser(urlReq,function(array:Array){
			   mobDataLoadingFlag = true;
			   mobDataManager = new DataManager(array);
			});



			urlReq= new URLRequest
			("https://docs.google.com/spreadsheet/pub?key=0ApCOYMZ7qCy3dFVCRUZRZEVjMG1ES3c2UDJ2ZWgxTkE&single=true&gid=7&output=csv");
			levelDataParser = new LevelDataParser(urlReq,function(array:Array){
			   levelDataLoadingFlag = true;
			   levelDataManager = new DataManager(array);  
			});

		}

		private function checkFlags(e:flash.events.Event):void {
			if (mobDataLoadingFlag && levelDataLoadingFlag) {
				init();
				removeEventListener(flash.events.Event.ENTER_FRAME, checkFlags);
			}
		}

		private function init():void {

			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			stage.align = StageAlign.TOP_LEFT;

			Starling.multitouchEnabled = true;
			Starling.handleLostContext = true;

			mainStage = stage;

			var viewPort:Rectangle = new Rectangle(0,0,stageWidth,stageHeight);

			var scaleFactor:Number = 2;
			var appDir:File = File.applicationDirectory;
			var assets:AssetManager = new AssetManager(scaleFactor);
			assets.verbose = Capabilities.isDebugger;
			assets.enqueue(
			                appDir.resolvePath(formatString("res/audio")),
			                appDir.resolvePath(formatString("res/textures/")),
			                appDir.resolvePath(formatString("res/fonts/")));

			mStarling = new Starling(Game,stage,viewPort);
			mStarling.showStats = true;
			mStarling.simulateMultitouch = true;
			mStarling.enableErrorChecking = true;
			mStarling.antiAliasing = 2;

			mStarling.addEventListener(starling.events.Event.ROOT_CREATED, function():void
			            {                
			               mStarling.start();
			               var game:Game = mStarling.root as Game;
			               game.start(assets, mobDataManager, levelDataManager);
			   
			               commandSet = new CommandSet();
			               commandSet.x = 240;
			               commandSet.y = 898;
			               addChild(commandSet);
			   
			   commandSet.visible = false;
			            });

			flashSprite = new Sprite();
			addChild(flashSprite);

			box2DdebugDrawSprite = new Sprite();
			addChild(box2DdebugDrawSprite);

			NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE, function(e:*) {
			 NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.NORMAL;
			mStarling.stop();
			 });

			NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, function(e:*) {
			 NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			mStarling.start();
			 });


			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

			var isPopup_quit:Boolean = false;
			var isPopup_menu:Boolean = false;

			var pop_quit:DisplayObject;
			var pop_menu:DisplayObject;

			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, function (e:KeyboardEvent) {
			     e.preventDefault();
			     e.stopImmediatePropagation();
			 
			     if (e.keyCode == Keyboard.BACK) {
			        if (isPopup_quit) {
			           return;
			        }
			
			        if (isPopup_menu) {
			           removeChild(pop_menu);
			           pop_menu = null;
			           isPopup_menu=false;
			   
			           return;
			        }
			
			        pop_quit = addChild(new Popup_AskExit());
			        isPopup_quit = true;
			
			        pop_quit.addEventListener('yes', function (e:*){NativeApplication.nativeApplication.exit();});
			        pop_quit.addEventListener('no', function (e:*){removeChild(pop_quit);pop_quit = null;isPopup_quit=false;});
			     }
			 
			     if (e.keyCode == Keyboard.MENU) {
			        if (isPopup_menu || isPopup_quit) {
			           return;
			        }
			
			        pop_menu = addChild(new Popup_Menu());
			        isPopup_menu = true;
			
			        pop_menu.addEventListener('item1', function (e:*){removeChild(pop_menu);pop_menu = null;isPopup_menu=false;});
			        pop_menu.addEventListener('item2', function (e:*){removeChild(pop_menu);pop_menu = null;isPopup_menu=false;});
			        pop_menu.addEventListener('item3', function (e:*){removeChild(pop_menu);pop_menu = null;isPopup_menu=false;});
			     }
			  });

		}
	}

}