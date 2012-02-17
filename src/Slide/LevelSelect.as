package Slide 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Harry Boyes - 1101673
	 */
	public class LevelSelect extends Sprite
	{
		private var _startLevel:Array;
		
		
		public function LevelSelect(buttonPress:Function)
		{
			_startLevel = [new LevelButton(1, 1),
						   new LevelButton(2, 1),
						   new LevelButton(3, 1)];
			
			for each(var spr:LevelButton in _startLevel)
			{
				addChild(spr);
				spr.addEventListener(MouseEvent.MOUSE_UP, buttonPress);
			}
		}
	}
}