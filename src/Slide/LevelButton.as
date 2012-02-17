package Slide 
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Harry Boyes - 1101673
	 */
	public class LevelButton extends Sprite
	{
		[Embed(source="../../Images/LevelSelectLevelButton.png")]
		private var _levelButton:Class;
		
		private var _world:int;
		private var _level:int;
		
		
		public function LevelButton(lvl:int, world:int)
		{
			var buttonImage:Bitmap = new _levelButton();
			addChild(buttonImage);
			
			var text:TextField = new TextField();
			var format:TextFormat = new TextFormat("Verdana", 24, 0xff0000);
			text.mouseEnabled = false;
			text.text = lvl.toString();
			text.setTextFormat(format);
			text.x = 20 - text.textWidth / 2;
			text.y = 20 - text.textHeight / 2;
			addChild(text);
			
			x = lvl * 50 + 50;
			y = 50;
			
			_level = lvl;
			_world = world;
		}
		
		public function World():int
		{
			return _world;
		}
		
		public function Level():int
		{
			return _level;
		}
	}
}