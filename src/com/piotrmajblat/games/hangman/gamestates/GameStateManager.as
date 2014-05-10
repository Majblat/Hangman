package com.piotrmajblat.games.hangman.gamestates
{
	import com.piotrmajblat.games.hangman.gamestates.events.GameStateEvent;

	public class GameStateManager
	{
		private var _states:Object;

		private var _currentState:GameState;

		public function GameStateManager()
		{
			_states = {};
		}

		public function registerState(gameState:GameState):void
		{
			_states[gameState.name] = gameState;
		}

		public function setStateByName(stateName:String):void
		{
			if (_currentState)
			{
				_currentState.onExit();
				_currentState.removeEventListener(GameStateEvent.REQUEST_STATE_CHANGE, onStateChangeRequested);
			}

			_currentState = _states[stateName];
			_currentState.addEventListener(GameStateEvent.REQUEST_STATE_CHANGE, onStateChangeRequested);
			_currentState.onEnter();
		}

		private function onStateChangeRequested(event:GameStateEvent):void
		{
			setStateByName(event.stateName);
		}
	}
}
