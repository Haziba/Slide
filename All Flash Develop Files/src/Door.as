package  
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author 
	 */
	public class Door extends MovieClip
	{
		
		public function Door() 
		{
			stop();
		}
		
		public function Open():void
		{
			gotoAndStop(2);
		}
		
		public function Close():void
		{
			gotoAndStop(1);
		}
		
		public function Walkable():Boolean
		{
			return currentFrame == 2;
		}
		
	}

}