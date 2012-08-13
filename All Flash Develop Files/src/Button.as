package  
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author 
	 */
	public class Button extends MovieClip
	{
		private var _activateX:int;
		private var _activateY:int;
		
		
		public function Button() 
		{
			stop();
		}
		
		public function Set(activateX:int, activateY:int):void
		{
			_activateX = activateX;
			_activateY = activateY;
		}
		
		public function Activate():void
		{
			gotoAndStop(2);
		}
		
		public function ActivateX():int
		{
			return _activateX;
		}
		
		public function ActivateY():int
		{
			return _activateY;
		}
	}

}