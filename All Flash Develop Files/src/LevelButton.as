package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Harry Boyes - 1101673
	 */
	public class LevelButton extends MovieClip
	{
		private var _world:int;
		private var _level:int;
		
		private var _numFish:int;
		
		private var _text:TextField;
		
		
		public function LevelButton()
		{}
		
		public function Initialise(lvl:int, world:int):void
		{
			_text = new TextField();
			var format:TextFormat = new TextFormat("! PEPSI !", 48, 0x000000);
			_text.mouseEnabled = false;
			_text.text = (lvl + 1).toString();
			_text.setTextFormat(format);
			_text.x = width / 2 - (_text.textWidth + 5) / 2;
			_text.y = height / 2 - _text.textHeight / 2;
			_text.width = _text.textWidth + 5;
			_text.height = _text.textHeight;
			addChild(_text);
			
			x = (lvl % 5) * 92 + 52;
			y = (Math.floor(lvl / 5)) * 86 + 106;
			
			_numFish = SaveGame.NumFish(world, lvl);
			
			if (lvl == 0 || SaveGame.CompletedLevel(world, lvl - 1))
				gotoAndStop(1 + _numFish);
			else
				gotoAndStop(9);
			
			if (Maps.Get(world, lvl).MinimumMoves() >= SaveGame.NumMoves(world, lvl) && SaveGame.NumMoves(world, lvl) > 0)
				this["LevelComplete"].gotoAndStop(2);
			else
				this["LevelComplete"].gotoAndStop(1);
			
			setChildIndex(_text, numChildren - 1);
			
			_level = lvl;
			_world = world;
			
			addEventListener(MouseEvent.MOUSE_DOWN, MouseDown);
			addEventListener(MouseEvent.MOUSE_OUT, MouseOut);
			addEventListener(MouseEvent.MOUSE_UP, MouseUp);
		}
		
		public function Refresh(world:int):void
		{
			_world = world;
			
			
			_numFish = SaveGame.NumFish(_world, _level);
			
			if (_level == 0 || SaveGame.CompletedLevel(_world, _level - 1))
				gotoAndStop(1 + _numFish);
			else
				gotoAndStop(9);
			
			if (Maps.Get(_world, _level).MinimumMoves() >= SaveGame.NumMoves(_world, _level) && SaveGame.NumMoves(_world, _level) > 0)
				this["LevelComplete"].gotoAndStop(2);
			else
				this["LevelComplete"].gotoAndStop(1);
		}
		
		private function MouseDown(me:MouseEvent):void
		{
			if (currentFrame == 1 + _numFish)
			{
				gotoAndStop(5 + _numFish);
				SoundController.ClickDown();
			}
			
			setChildIndex(_text, numChildren - 1);
		}
		
		private function MouseOut(me:MouseEvent):void
		{
			if (currentFrame == 5 + _numFish)
			{
				gotoAndStop(1 + _numFish);
				SoundController.ClickUp();
			}
			
			setChildIndex(_text, numChildren - 1);
		}
		
		private function MouseUp(me:MouseEvent):void
		{
			if (currentFrame == 5 + _numFish)
			{
				dispatchEvent(new Event("BUTTON_PRESS"));
				SoundController.ClickUp();
				gotoAndStop(1 + _numFish);
			}
		}
		
		public function World():int
		{
			return _world;
		}
		
		public function Level():int
		{
			return _level;
		}
		
		public function Playable():Boolean
		{
			return currentFrame != 2;
		}
	}
}