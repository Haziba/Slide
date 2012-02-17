package Slide 
{
	/**
	 * ...
	 * @author Harry Boyes - 1101673
	 */
	public class GameState 
	{
		public static const MAIN_MENU:int = 1;
		public static const LEVEL_SELECT:int = 2;
		public static const IN_GAME:int = 3;
		
		private var _state:int;
		
		private var StateChange:Function;
		
		
		public function GameState(stateChange:Function):void
		{
			StateChange = stateChange;
		}
		
		public function Initialise():void
		{
			_state = IN_GAME;
			StateChange(_state);
		}
		
		public function Set(val:int):void
		{
			_state = val;
			StateChange(_state);
		}
		
		public function Get():int
		{
			return _state;
		}
	}
}