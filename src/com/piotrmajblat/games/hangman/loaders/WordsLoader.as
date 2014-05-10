package com.piotrmajblat.games.hangman.loaders
{
	import com.piotrmajblat.games.hangman.loaders.events.WordsLoaderEvent;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class WordsLoader extends EventDispatcher
	{
		private var _urlLoader:URLLoader;

		public function WordsLoader()
		{
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, onFileLoaded);
		}

		private function onFileLoaded(event:Event):void
		{
			var words:Vector.<String> = new Vector.<String>();

			var xml:XML = new XML(_urlLoader.data);

			for each (var word:XML in xml.children())
			{
				words.push(word.toString());
			}

			dispatchEvent(new WordsLoaderEvent(words));
		}

		public function load(filePath:String):void
		{
			_urlLoader.load(new URLRequest(filePath));
		}
	}
}
