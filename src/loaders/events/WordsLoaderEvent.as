package loaders.events
{
	import flash.events.Event;

	public class WordsLoaderEvent extends Event
	{
		public static const LOADING_COMPLETE:String = "loadingComplete";

		private var _words:Vector.<String>;

		public function WordsLoaderEvent(words:Vector.<String>)
		{
			super(LOADING_COMPLETE);
			_words = words;
		}

		public function get words():Vector.<String>
		{
			return _words;
		}
	}
}
