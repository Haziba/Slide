package  
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author 
	 */
	public class BreakableFloor extends MovieClip
	{
		private const BREAKABLE_STEPS:int = 4;
		
		private var _activates:int;
		
		
		public function BreakableFloor() 
		{
			stop();
			_activates = 0;
		}
		
		public function Activate():void
		{
			_activates++;
			if (_activates <= BREAKABLE_STEPS)
				nextFrame();
		}
		
		public function Broken():Boolean
		{
			return _activates >= BREAKABLE_STEPS;
		}
	}
}