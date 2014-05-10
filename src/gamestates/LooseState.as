package gamestates
{
	import flash.events.MouseEvent;

	public class LooseState extends GameState
	{
		public static const NAME:String = "looseState";

		public function LooseState(game:Game)
		{
			super(game);
		}

		override public function onEnter():void
		{
			gameView.gibbet.visible = true;
			gameView.hangman.visible = true;
			gameView.stage.addEventListener(MouseEvent.CLICK, onStageClicked);
		}

		private function onStageClicked(event:MouseEvent):void
		{
			requestStateChange(SplashScreenState.NAME);
		}

		override public function onExit():void
		{
			gameView.gibbet.visible = false;
			gameView.hangman.visible = false;
			gameView.stage.removeEventListener(MouseEvent.CLICK, onStageClicked);
		}
	}
}
