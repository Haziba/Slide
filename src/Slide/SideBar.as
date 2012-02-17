package Slide 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Harry Boyes - 1101673
	 */
	public class SideBar extends Sprite
	{
		[Embed(source="../../Images/SideBarBackground.png")]
		private var _sideBarImage:Class;
		
		private var _fishCount:int;
		private var _myTextField:TextField;
		
		private var _fish:Array;
		
		
		public function SideBar():void
		{
			_fish = new Array();
			
			
			x = 400;
			
			addChild(new _sideBarImage());
			
			for (var i:int = 0; i < 3; i++)
			{
				var fish:Fish = new Fish();
				fish.x = i * 40 + 10;
				fish.y = 250;
				addChild(fish);
				fish.Hide();
				_fish.push(fish);
			}
			
			
			_myTextField = new TextField();
			_myTextField.text = "Yo";
			addChild(_myTextField);
			Reset();
		}
		
		public function Reset():void
		{
			_fishCount = 0;
			
			for each(var f:Fish in _fish)
				f.Reset();
		}
		
		public function GetFish():void
		{
			_fish[_fishCount].Activate();
			
			_fishCount++;
		}
	}
}