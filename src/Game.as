package
{
	import flash.display.Sprite;

	import gamestates.GameStateManager;
	import gamestates.GameplayState;
	import gamestates.LooseState;
	import gamestates.SplashScreenState;

	import loaders.WordsLoader;
	import loaders.events.WordsLoaderEvent;

	[SWF(width="310", height="450", backgroundColor="#000000", frameRate="30")]
	public class Game extends Sprite
	{
		private var _view:GameMc;

		private var _gameStateManager:GameStateManager;

		public function Game()
		{
			loadWords();
			_view = new GameMc();
		}

		private function loadWords():void
		{
			var wordsLoader:WordsLoader = new WordsLoader();
			wordsLoader.addEventListener(WordsLoaderEvent.LOADING_COMPLETE, onWordsLoaded);
			wordsLoader.load("words.xml");
		}

		private function onWordsLoaded(event:WordsLoaderEvent):void
		{
			addChild(_view);

			_gameStateManager = new GameStateManager();
			_gameStateManager.registerState(new SplashScreenState(this));
			_gameStateManager.registerState(new GameplayState(this, event.words));
			_gameStateManager.registerState(new LooseState(this));

			_gameStateManager.setStateByName(SplashScreenState.NAME);
		}

		public function get view():GameMc
		{
			return _view;
		}
	}
}
