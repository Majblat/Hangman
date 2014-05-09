package gamestates
{
	import avmplus.getQualifiedClassName;

	import flash.events.EventDispatcher;

	import flash.utils.getDefinitionByName;

	import gamestates.events.GameStateEvent;

	public class GameState extends EventDispatcher
	{
		public static const NAME:String = "defaultName";

		private var _game:Game;

		public function GameState(game:Game)
		{
			_game = game;
		}

		public function onEnter():void
		{
			gameView.letterCells.visible = true;
			gameView.guessedLetters.visible = true;
		}

		public function onExit():void
		{
			gameView.letterCells.visible = false;
			gameView.guessedLetters.visible = false;
		}

		public function requestStateChange(newStateName:String):void
		{
			dispatchEvent(new GameStateEvent(GameStateEvent.REQUEST_STATE_CHANGE , newStateName));
		}

		public function get gameView():GameMc
		{
			return game.view;
		}

		protected function get game():Game
		{
			return _game;
		}

		public function get name():String
		{
			var _class:Class = Class(getDefinitionByName(getQualifiedClassName(this)));
			return _class["NAME"];
		}
	}
}
