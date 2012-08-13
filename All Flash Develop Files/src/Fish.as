package  
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Harry Boyes - 1101673
	 */
	public class Fish extends MovieClip
	{
		private static const HIDDEN:int = 1;
		private static const SHOWN:int = 2;
		
		
		public function Fish() 
		{
			gotoAndStop(SHOWN);
		}
		
		public function Hide():void
		{
			gotoAndStop(HIDDEN);
		}
		
		public function Reset():void
		{
			gotoAndStop(HIDDEN);
		}
		
		public function Show():void
		{
			gotoAndStop(SHOWN);
		}
		
		public function Activate():void
		{
			play();
			addFrameScript(totalFrames - 1, function():void { stop(); } );
			SoundController.GetFish();
		}
	}
}