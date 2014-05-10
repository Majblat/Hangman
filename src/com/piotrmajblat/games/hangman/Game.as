package com.piotrmajblat.games.hangman
{
	import com.piotrmajblat.games.hangman.gamestates.GameStateManager;
	import com.piotrmajblat.games.hangman.gamestates.GameplayState;
	import com.piotrmajblat.games.hangman.gamestates.LooseState;
	import com.piotrmajblat.games.hangman.gamestates.SplashScreenState;
	import com.piotrmajblat.games.hangman.gamestates.WinState;
	import com.piotrmajblat.games.hangman.loaders.WordsLoader;
	import com.piotrmajblat.games.hangman.loaders.events.WordsLoaderEvent;
	import com.piotrmajblat.games.hangman.sound.SimpleSoundManager;

	import flash.display.Sprite;

	[SWF(width="310", height="450", backgroundColor="#000000", frameRate="30")]
	public class Game extends Sprite
	{
		private var _view:GameMc;

		private var _gameStateManager:GameStateManager;

		public function Game()
		{
			loadWords();
			loadSounds();
			_view = new GameMc();
		}

		private function loadSounds():void
		{
			SimpleSoundManager.addSoundFromFile("click", "sounds/click.mp3");
			SimpleSoundManager.addSoundFromFile("lose", "sounds/lose.mp3");
			SimpleSoundManager.addSoundFromFile("win", "sounds/win.mp3");
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
			_gameStateManager.registerState(new WinState(this));

			_gameStateManager.setStateByName(SplashScreenState.NAME);
		}

		public function get view():GameMc
		{
			return _view;
		}
	}
}
