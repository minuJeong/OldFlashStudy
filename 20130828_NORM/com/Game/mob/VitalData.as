package com.Game.mob{
	import com.Game.Game;

	public class VitalData {

		public var targetMob:Mob;

		public var maxHP:Number;
		public var maxMP:Number;
		public var maxSP:Number;

		private var m_hp:Number;
		private var m_mp:Number;
		private var m_sp:Number;

		public var atk:Number;
		public var def:Number;
		public var agi:Number;

		public var hobby:String;
		public var faction:String;
		public var race:String;

		public var pros_hobby:String;
		public var pros_faction:String;
		public var pros_race:String;

		public var cons_hobby:String;
		public var cons_faction:String;
		public var cons_race:String;


		public function VitalData(targetMob:Mob) {
			this.targetMob = targetMob;

			setData();
		}

		public function setData():void {

			var iteration:int = Game.mMobDatas.data.length - 1;
			for (var i:int = iteration; i >= 0; i--) {
				if (Game.mMobDatas.data[i]['name'] == targetMob.mobName) {
					this.maxHP = Game.mMobDatas.data[i]['hp'];
					this.maxMP = Game.mMobDatas.data[i]['mp'];
					this.maxSP = Game.mMobDatas.data[i]['sp'];

					this.hp = Game.mMobDatas.data[i]['hp'];
					this.mp = Game.mMobDatas.data[i]['mp'];
					this.sp = Game.mMobDatas.data[i]['sp'];

					this.atk = Game.mMobDatas.data[i]['atk'];
					this.def = Game.mMobDatas.data[i]['def'];
					this.agi = Game.mMobDatas.data[i]['agi'];

					this.hobby = Game.mMobDatas.data[i]['hobby'];
					this.faction = Game.mMobDatas.data[i]['faction'];
					this.race = Game.mMobDatas.data[i]['race'];

					this.pros_hobby = Game.mMobDatas.data[i]['pros_hobby'];
					this.pros_faction = Game.mMobDatas.data[i]['pros_faction'];
					this.pros_race = Game.mMobDatas.data[i]['pros_race'];

					this.cons_hobby = Game.mMobDatas.data[i]['cons_hobby'];
					this.cons_faction = Game.mMobDatas.data[i]['cons_faction'];
					this.cons_race = Game.mMobDatas.data[i]['cons_race'];

					break;
				}
			}

		}

		public function set hp(n:Number):void {
			m_hp = n;
			if (m_hp < 0) {
				m_hp = 0;
			}
		}

		public function get hp():Number {
			return m_hp;
		}



		public function set mp(n:Number):void {
			m_mp = n;
			if (m_mp < 0) {
				m_mp = 0;
			}
		}

		public function get mp():Number {
			return m_mp;
		}



		public function set sp(n:Number):void {
			m_sp = n;
			if (m_sp < 0) {
				m_sp = 0;
			}
		}

		public function get sp():Number {
			return m_sp;
		}
	}

}