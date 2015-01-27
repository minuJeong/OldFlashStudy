package com.Game.hud.portrait{
	import starling.display.Sprite;
	import starling.events.Event;
	import com.Game.mob.Mob;
	import starling.display.Image;
	import com.Game.Game;
	import starling.textures.TextureAtlas;
	import com.Game.hud.HUD;
	import starling.display.Quad;

	public class Portrait extends Sprite {

		private var targetMob:Mob;

		public static const PORTRAIT_WIDTH:Number = 64;
		public static const statusBarHeight:Number = 6;

		public function Portrait(targetMob:Mob) {

			this.targetMob = targetMob;

			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			var textureAtlas:TextureAtlas = Game.mAssets.getTextureAtlas('portraits');
			var portraitImage:Image = new Image(textureAtlas.getTexture(targetMob.mobName));
			addChild(portraitImage);

			portraitImage.width = Portrait.PORTRAIT_WIDTH;
			portraitImage.height = Portrait.PORTRAIT_WIDTH;

			var quadUnderPlate:Quad = new Quad(Portrait.PORTRAIT_WIDTH,statusBarHeight * 3,0x404040);
			quadUnderPlate.y = Portrait.PORTRAIT_WIDTH;
			addChild(quadUnderPlate);

			var quadHP:Quad = new Quad(Portrait.PORTRAIT_WIDTH,statusBarHeight,0xa02010);
			var quadMP:Quad = new Quad(Portrait.PORTRAIT_WIDTH,statusBarHeight,0x1020a0);
			var quadSP:Quad = new Quad(Portrait.PORTRAIT_WIDTH,statusBarHeight,0x20a010);

			quadHP.setVertexColor(1, 0xff5050);
			quadHP.setVertexColor(3, 0xff5050);

			quadMP.setVertexColor(1, 0x5050ff);
			quadMP.setVertexColor(3, 0x5050ff);

			quadSP.setVertexColor(1, 0x50ff50);
			quadSP.setVertexColor(3, 0x50ff50);


			quadHP.y = Portrait.PORTRAIT_WIDTH;
			quadMP.y = Portrait.PORTRAIT_WIDTH + quadHP.height;
			quadSP.y = Portrait.PORTRAIT_WIDTH + quadHP.height + quadMP.height;


			addChild(quadHP);
			addChild(quadMP);
			addChild(quadSP);

			Game.gameEventDispatcher.addEventListener(Game.GAME_ENTER_FRAME, function (e:Event):void {
			  var quadHPtargetScaleX:Number = Math.min(targetMob.vitalData.hp / targetMob.vitalData.maxHP,1);
			  var quadMPtargetScaleX:Number = Math.min(targetMob.vitalData.mp / targetMob.vitalData.maxMP,1);
			  var quadSPtargetScaleX:Number = Math.min(targetMob.vitalData.sp / targetMob.vitalData.maxSP,1);
			  
			  quadHP.scaleX += (quadHPtargetScaleX - quadHP.scaleX) * .1;
			  quadMP.scaleX += (quadMPtargetScaleX - quadMP.scaleX) * .1;
			  quadSP.scaleX += (quadSPtargetScaleX - quadSP.scaleX) * .1;
			});

		}

	}

}