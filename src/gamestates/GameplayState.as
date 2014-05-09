package gamestates
{
	public class GameplayState extends GameState
	{
		public static const NAME:String = "gamePlayState";

		private var _words:Vector.<String>;

		private var _currentWordToGuess:String;

		public function GameplayState(game:Game, words:Vector.<String>)
		{
			super(game);
			_words = words;
		}

		override public function onEnter():void
		{
			gameView.guessedLetters.visible = true;
			gameView.letterCells.visible = true;
			gameView.virtualLetters.visible = true;

			//_currentWordToGuess = getRandomWord();
		}

//		private function getRandomWord():String
//		{
//			return _words[];
//		}

		override public function onExit():void
		{
			gameView.guessedLetters.visible = false;
			gameView.letterCells.visible = false;
			gameView.virtualLetters.visible = false;
		}
	}
}
