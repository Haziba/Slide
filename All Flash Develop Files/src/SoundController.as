package  
{
	/**
	 * ...
	 * @author 
	 */
	public class SoundController 
	{
		private static var _sounds:Object;
		private static var _playingSounds:Object;
		
		
		public function SoundController() 
		{}
		
		public static function Initialise():void
		{
			_sounds = new Object();
			_playingSounds = new Object();
			
			
			_sounds["StartMusic"] = new StartMusic();
			_sounds["ClickDown"] = new ClickDownSound();
			_sounds["ClickUp"] = new ClickUpSound();
			_sounds["Slide"] = new SlideSound();
			_sounds["ShortSlide"] = new ShortSlideSound();
			_sounds["CatFall"] = new CatFallSound();
			_sounds["GetFish"] = new GetFishSound();
			_sounds["Hit"] = new HitSound();
			_sounds["Break"] = new BreakSound();
			
			_playingSounds["StartMusic"] = _sounds["StartMusic"].play(0, int.MAX_VALUE);
		}
		
		public static function ClickDown():void
		{
			_playingSounds["ClickDown"] = _sounds["ClickDown"].play();
		}
		
		public static function ClickUp():void
		{
			_playingSounds["ClickUp"] = _sounds["ClickUp"].play();
		}
		
		public static function Slide():void
		{
			_playingSounds["Slide"] = _sounds["Slide"].play();
		}
		
		public static function ShortSlide():void
		{
			_playingSounds["ShortSlide"] = _sounds["ShortSlide"].play();
		}
		
		public static function CatFall():void
		{
			_playingSounds["CatFall"] = _sounds["CatFall"].play();
		}
		
		public static function GetFish():void
		{
			_playingSounds["GetFish"] = _sounds["GetFish"].play();
		}
		
		public static function Hit():void
		{
			_playingSounds["Hit"] = _sounds["Hit"].play();
		}
		
		public static function Break():void
		{
			_playingSounds["Break"] = _sounds["Break"].play();
		}
	}

}