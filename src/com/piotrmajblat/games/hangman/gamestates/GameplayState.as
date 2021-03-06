package com.piotrmajblat.games.hangman.gamestates
{
	import com.piotrmajblat.games.hangman.Game;
	import com.piotrmajblat.games.hangman.sound.SimpleSoundManager;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class GameplayState extends GameState
	{
		public static const NAME:String = "gamePlayState";

		private static const MISTAKES_TO_LOOSE:int = 7;

		private var _words:Vector.<String>;

		private var _currentWordToGuess:String;

		private var _alphabet:Vector.<String>;

		private var _mistakesCount:int;

		private var _winsCount:int = 0;

		private var _loseCount:int = 0;

		public function GameplayState(game:Game, words:Vector.<String>)
		{
			super(game);
			_words = words;
			_alphabet = Vector.<String>(
					["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
			);
			gameView.winAndLooseCountTextField.autoSize = TextFieldAutoSize.CENTER;
			updateWinsAndLoseCountTextField();
		}

		override public function onEnter():void
		{
			gameView.guessedLetters.visible = true;
			gameView.letterCells.visible = true;
			gameView.virtualLetters.visible = true;
			gameView.gibbet.visible = true;
			gameView.hangman.visible = true;

			_mistakesCount = 0;

			_currentWordToGuess = getRandomWord();
			hideAllLetters();
			hideGibbetElements();
			showLetterCells();
			showVirtualLetters();

			trace(_currentWordToGuess);
		}

		private function hideGibbetElements():void
		{
			for (var i:int = 1; i <= MISTAKES_TO_LOOSE; i++)
			{
				gameView.gibbet["gibbet_" + i].visible = false;
			}
		}

		private function showVirtualLetters():void
		{
			gameView.virtualLetters.x = 96;
			gameView.virtualLetters.y = 311;
			for each (var letter:String in _alphabet)
			{
				var letterMc:MovieClip = MovieClip(gameView.virtualLetters.getChildByName(letter));
				letterMc.visible = true;
				letterMc.buttonMode = true;
				letterMc.addEventListener(MouseEvent.CLICK, onLetterClicked);
			}
		}

		private function onLetterClicked(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			var chosenLetter:String = event.currentTarget.name;
			event.currentTarget.visible = false;

			SimpleSoundManager.playSound("click");

			if (_currentWordToGuess.indexOf(chosenLetter) != -1)
			{
				showMatchingLetters(chosenLetter);
				if (isGameWon())
				{
					_winsCount++;
					updateWinsAndLoseCountTextField();
					requestStateChange(WinState.NAME);
				}
			}
			else
			{
				handleMistake();
			}
		}

		private function updateWinsAndLoseCountTextField():void
		{
			gameView.winAndLooseCountTextField.text = "Won: " + _winsCount + " Lost: " + _loseCount;
		}

		private function isGameWon():Boolean
		{
			for (var i:int = 1; i <= _currentWordToGuess.length; i++)
			{
				if (!gameView.guessedLetters["letter_" + i].visible)
				{
					return false;
				}
			}
			return true;
		}

		private function handleMistake():void
		{
			_mistakesCount++;
			gameView.gibbet["gibbet_" + _mistakesCount].visible = true;

			if (_mistakesCount == MISTAKES_TO_LOOSE)
			{
				_loseCount++;
				updateWinsAndLoseCountTextField();
				requestStateChange(LooseState.NAME);
			}
		}

		private function showMatchingLetters(letter:String):void
		{
			for (var i:int = 0; i < _currentWordToGuess.length; i++)
			{
				var currentLetter:String = _currentWordToGuess.charAt(i);
				if (currentLetter == letter)
				{
					var textField:TextField = gameView.guessedLetters["letter_" + (i + 1)];
					textField.text = letter.toUpperCase();
					textField.visible = true;
				}
			}
		}

		private function hideAllLetters():void
		{
			for (var i:int = 1; i <= 10; i++)
			{
				gameView.guessedLetters["letter_" + i].visible = false;
			}
		}

		private function showLetterCells():void
		{
			var wordLength:int = _currentWordToGuess.length;
			for (var i:int = 1; i <= 10; i++)
			{
				gameView.letterCells["cell_" + i].visible = i <= wordLength;
			}
		}

		private function getRandomWord():String
		{
			return _words[int(Math.random() * _words.length)];
		}

		override public function onExit():void
		{
			gameView.guessedLetters.visible = false;
			gameView.letterCells.visible = false;
			gameView.virtualLetters.visible = false;
			gameView.gibbet.visible = false;
			gameView.hangman.visible = false;
		}
	}
}
