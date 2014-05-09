package gamestates.events
{
	import flash.events.Event;

	public class GameStateEvent extends Event
	{
		public static const REQUEST_STATE_CHANGE:String = "requestStateChange";

		private var _stateName:String;

		public function GameStateEvent(name:String, stateName:String)
		{
			super(name, REQUEST_STATE_CHANGE);
			_stateName = stateName;
		}

		public function get stateName():String
		{
			return _stateName;
		}
	}
}
