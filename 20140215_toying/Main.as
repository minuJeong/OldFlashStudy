package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.LoaderInfo;

	public class Main extends MovieClip {

		public function Main() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e: Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			var loader: Loader = new Loader();
			var req: URLRequest = new URLRequest();
			req.url = "https://31.media.tumblr.com/5c7af136146561f1d921ab5dfd64d3e2/tumblr_n0zyavasmX1r40y78o2_1280.jpg"
			loader.load(req);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (e: Event): void {
				addChild(LoaderInfo(e.target).content);
			});
		}
	}

}