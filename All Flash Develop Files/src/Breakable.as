package  
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author 
	 */
	public class Breakable extends MovieClip
	{
		private const BREAKABLE_STEPS:int = 3;
		
		private var _hits:int;
		
		
		public function Breakable() 
		{
			stop();
			_hits = 0;
		}
		
		public function Hit():void
		{
			_hits++;
			if (_hits <= BREAKABLE_STEPS)
			{
				nextFrame();
				if(currentFrame < totalFrames)
					SoundController.Hit();
				else
					SoundController.Break();
			}
		}
		
		public function Broken():Boolean
		{
			return _hits >= BREAKABLE_STEPS;
		}
	}

}