package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Harry Boyes - 1101673
	 */
	public class GameState extends Sprite
	{
		public static const MAIN_MENU:int = 1;
		public static const LEVEL_SELECT:int = 2;
		public static const IN_GAME:int = 3;
		public static const GAME_COMPLETE:int = 4;
		
		private var _state:int;
		
		
		public function GameState():void {}
		
		public function Initialise():void
		{
			_state = MAIN_MENU; // LEVEL_SELECT;
			dispatchEvent(new Event("STATE_CHANGE"));
		}
		
		public function Set(val:int):void
		{
			_state = val;
			dispatchEvent(new Event("STATE_CHANGE"));
		}
		
		public function Get():int
		{
			return _state;
		}
	}
}