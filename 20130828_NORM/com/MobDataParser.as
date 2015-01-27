package com{

	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.events.Event;

	public class MobDataParser {

		private var loader:URLLoader;
		private var parsedData:Array;
		private var headers:Array;

		private var onComplete:Function;

		public function MobDataParser(urlRequest:URLRequest, onComplete:Function) {

			loader = new URLLoader(urlRequest);
			loader.addEventListener(Event.COMPLETE, loadComplete);

			this.onComplete = onComplete;

		}

		private function loadComplete(e:Event):void {

			trace(loader.data.toString());

			parsedData = new Array();
			headers = new Array();
			headers.push(
			 'name','image',
			 'hp','mp','sp',
			 'atk','def','agi',
			 '1','2','3','4','5',
			 'hobby','faction','race',
			 'pros_hobby','pros_faction','pros_race'
			 );

			var dataLines:Array = loader.data.toString().split("\n");
			var iteration_dataLines:int = dataLines.length;
			for (var iterator_dataLines:int = 1; iterator_dataLines < iteration_dataLines; ++iterator_dataLines) {

				parsedData[iterator_dataLines] = new Array();

				var dataParts:Array = dataLines[iterator_dataLines].split(",");
				var iteration_dataParts:int = dataParts.length;
				for (var iterator_dataParts:int = 0; iterator_dataParts < iteration_dataParts; ++iterator_dataParts) {

					parsedData[iterator_dataLines][headers[iterator_dataParts]] = dataParts[iterator_dataParts];

				}

			}


			onComplete(parsedData);
		}
	}
}