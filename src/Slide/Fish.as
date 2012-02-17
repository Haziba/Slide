package Slide 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Harry Boyes - 1101673
	 */
	public class Fish extends Sprite
	{
		[Embed(source="../../Images/Fish.png")]
		private var _showFish:Class;
		[Embed(source="../../Images/GreyFish.png")]
		private var _hideFish:Class;
		
		private var _fish:Bitmap;
		
		
		public function Fish() 
		{
			_fish = new _showFish();
			addChild(_fish);
		}
		
		public function Hide():void
		{
			removeChild(_fish);
			_fish = new _hideFish();
			addChild(_fish);
		}
		
		public function Reset():void
		{
			removeChild(_fish);
			_fish = new _hideFish();
			addChild(_fish);
		}
		
		public function Activate():void
		{
			removeChild(_fish);
			_fish = new _showFish();
			addChild(_fish);
		}
	}
}