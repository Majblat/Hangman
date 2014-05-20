package com.piotrmajblat.games.hangman.gamestates
{
	import avmplus.getQualifiedClassName;

	import com.piotrmajblat.games.hangman.Game;
	import com.piotrmajblat.games.hangman.gamestates.events.GameStateEvent;

	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;

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

		}

		public function onExit():void
		{

		}

		public function requestStateChange(newStateName:String):void
		{
			dispatchEvent(new GameStateEvent(GameStateEvent.REQUEST_STATE_CHANGE, newStateName));
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
