package com.piotrmajblat.games.hangman.gamestates
{
	import com.piotrmajblat.games.hangman.Game;

	import flash.events.MouseEvent;

	public class SplashScreenState extends GameState
	{
		public static const NAME:String = "splashScreenState";

		public function SplashScreenState(game:Game)
		{
			super(game);
		}

		override public function onEnter():void
		{
			gameView.hangManTextField.visible = true;
			gameView.rules.visible = true;
			gameView.playButton.visible = true;
			gameView.playButton.addEventListener(MouseEvent.CLICK, onMouseClick);
			gameView.playButton.buttonMode = true;
		}

		private function onMouseClick(event:MouseEvent):void
		{
			requestStateChange(GameplayState.NAME);
		}

		override public function onExit():void
		{
			gameView.rules.visible = false;
			gameView.playButton.visible = false;
			gameView.playButton.removeEventListener(MouseEvent.CLICK, onMouseClick);
			gameView.hangManTextField.visible = false;
		}

	}
}
