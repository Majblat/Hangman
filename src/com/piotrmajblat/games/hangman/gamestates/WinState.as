package com.piotrmajblat.games.hangman.gamestates
{
	import com.piotrmajblat.games.hangman.Game;
	import com.piotrmajblat.games.hangman.sound.SimpleSoundManager;

	import flash.events.MouseEvent;

	public class WinState extends GameState
	{
		public static const NAME:String = "winState";

		public function WinState(game:Game)
		{
			super(game);
		}

		override public function onEnter():void
		{
			gameView.congratulationsTextMc.visible = true;
			SimpleSoundManager.playSound("win");
			gameView.stage.addEventListener(MouseEvent.CLICK, onStageClicked);
			gameView.buttonMode = true;
		}

		private function onStageClicked(event:MouseEvent):void
		{
			requestStateChange(SplashScreenState.NAME);
		}

		override public function onExit():void
		{
			gameView.congratulationsTextMc.visible = false;
			gameView.stage.removeEventListener(MouseEvent.CLICK, onStageClicked);
			gameView.buttonMode = false;
		}
	}
}
