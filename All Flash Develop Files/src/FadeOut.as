package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author 
	 */
	public class FadeOut extends MovieClip
	{
		public static var TimeUntilMid:int = Math.floor(1000 / 3);
		
		
		public function FadeOut() 
		{
			gotoAndPlay(Math.floor(totalFrames / 2));
			trace(currentFrame);
			addEventListener(Event.ENTER_FRAME,
				function(e:Event):void {
					if (currentFrame == totalFrames)
						stop();
				});
		}
		
		public function Go(fromStart:Boolean = false):void
		{
			if(currentFrame >= totalFrames || fromStart)
				gotoAndPlay(1);
		}
		
	}

}