package com.util{

	public class RGBHSLConverter {

		public function RGBHSLConverter() {
		}

		public static function HSLtoRGB(hsl:Array):Array {
			var h:Number = hsl[0];
			var s:Number = hsl[1];
			var l:Number = hsl[2];

			h = h / 0xff;
			s = s / 0xff;
			l = l / 0xff;

			var r:Number = 0;
			var g:Number = 0;
			var b:Number = 0;

			if (s == 0) {
				// gray
				r = g = b = l;
				return new Array(r * 0xff, g * 0xff, b * 0xff);
			}

			var q:Number = l < .5 ? l * (1 + s):
			                        l * (1 - s) + s;
			var p:Number = 2 * l - q;

			r = hue2rgb(p,q,h + .33);
			g = hue2rgb(p,q,h);
			b = hue2rgb(p,q,h - .33);

			return new Array(r * 0xff, g * 0xff, b * 0xff);

		}

		public static function RGBtoHSL(rgb:Array):Array {
			var r:Number = rgb[0];
			var g:Number = rgb[1];
			var b:Number = rgb[2];

			r = r / 0xff;
			g = g / 0xff;
			b = b / 0xff;

			var max:Number = Math.max(r,g,b);
			var min:Number = Math.min(r,g,b);

			var l:Number = (max + min) / 2;

			var h:Number = 0;
			var s:Number = 0;

			if (max == min) {
				// gray
				h = s = 0;
				return new Array(h * 0xff, g * 0xff, b * 0xff);
			}

			var d:Number = max - min;
			s = l > .5 ? d / (2 - (max + min)) :
			             d / (max + min);

			switch (max) {
				case r :
					h = (g - b) / d + (g < b ? 6 : 0);
					break;

				case g :
					h = (b - r) / d + 2;
					break;

				case b :
					h = (r - g) / d + 4;
					break;
			}

			h /=  6;

			return new Array(h * 0xff, g * 0xff, b * 0xff);

		}


		// tool
		private static function hue2rgb(p,q,t):Number {
			if (t < 0) {
				t +=  1;
			}

			if (t > 1) {
				t -=  1;
			}


			if (t < (1 / 6)) {
				return p + (q - p) * t * 6;
			}

			if (t < (3 / 6)) {
				return q;
			}

			if (t < (4 / 6)) {
				return p + (q - p) * (4 / 6 - t) * 6;
			}

			return p;

			// concept
			// t:    0                                        1
			//       //////////////////////////////////////////
			// ret:   p+(q-p)*6t    q   p+(q-p)*(4/6-t)*6   p  
		}

	}

}