package com{

	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.events.Event;

	public class LevelDataParser {

		private var loader:URLLoader;
		private var parsedData:Array;
		private var headers:Array;

		private var onComplete:Function;

		public function LevelDataParser(urlRequest:URLRequest, onComplete:Function) {

			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loadComplete);
			loader.load(urlRequest);

			this.onComplete = onComplete;

		}

		private function loadComplete(e:Event):void {

			parsedData = new Array();
			headers = new Array();
			headers.push(
			 'levelName',
			 'party1','party2','party3','party4','party5','party6','party7','party8',
			 'concept'
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