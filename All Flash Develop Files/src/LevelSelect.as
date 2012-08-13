package  
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	/**
	 * ...
	 * @author Harry Boyes - 1101673
	 */
	public class LevelSelect extends MovieClip
	{
		private var _startLevel:Array;
		private var _startGame:Event;
		
		private var _world:int;
		private var _level:int;
		
		private var _leftArrow:LeftArrowMC;
		private var _rightArrow:RightArrowMC;
		
		
		public function LevelSelect()
		{
			_startLevel = new Array();
			
			
			for (var i:int = 0; i < 15; i++)
			{
				_startLevel.push(new LevelButtonMC());
				addChild(_startLevel[i]);
				_startLevel[i].Initialise(i, 0);
			}
			
			for each(var spr:LevelButton in _startLevel)
			{
				addChild(spr);
				spr.addEventListener("BUTTON_PRESS", StartLevel);
			}
			
			_world = 0;
			_level = 0;
			
			stop();
			
			_leftArrow = new LeftArrowMC();
			_rightArrow = new RightArrowMC();
			
			_leftArrow.x = 36;
			_leftArrow.y = 10.4;
			_leftArrow.stop();
			addChild(_leftArrow);
			
			_rightArrow.x = 454.1;
			_rightArrow.y = 10.4;
			_rightArrow.stop();
			addChild(_rightArrow);
			
			_leftArrow.addEventListener(MouseEvent.MOUSE_DOWN, MouseDownLeft);
			_leftArrow.addEventListener(MouseEvent.MOUSE_OUT, MouseOutLeft);
			_leftArrow.addEventListener(MouseEvent.MOUSE_UP, MouseUpLeft);
			
			_rightArrow.addEventListener(MouseEvent.MOUSE_DOWN, MouseDownRight);
			_rightArrow.addEventListener(MouseEvent.MOUSE_OUT, MouseOutRight);
			_rightArrow.addEventListener(MouseEvent.MOUSE_UP, MouseUpRight);
			
			// Debugging stuff
			//var j:int = setInterval(
			//function():void
			//{
				//clearInterval(j);
				//dispatchEvent(new Event("START_LEVEL"));
			//}, 100);
		}
		
		private function MouseDownLeft(me:MouseEvent):void
		{
			if (me.target.currentFrame == 1)
			{
				me.target.gotoAndStop(2);
				SoundController.ClickDown();
			}
		}
		
		private function MouseOutLeft(me:MouseEvent):void
		{
			if (me.target.currentFrame == 2 && _world > 0)
			{
				me.target.gotoAndStop(1);
				SoundController.ClickUp();
			}
		}
		
		private function MouseDownRight(me:MouseEvent):void
		{
			if (me.target.currentFrame == 1)
			{
				me.target.gotoAndStop(2);
				SoundController.ClickDown();
			}
		}
		
		private function MouseOutRight(me:MouseEvent):void
		{
			if (me.target.currentFrame == 2 && Maps.NextWorldExists(_world))
			{
				me.target.gotoAndStop(1);
				SoundController.ClickUp();
			}
		}
		
		private function MouseUpLeft(me:MouseEvent):void
		{
			if (_leftArrow.currentFrame == 2 && _world > 0)
			{
				_leftArrow.gotoAndStop(1);
				SoundController.ClickUp();
				_world--;
				Refresh();
			}
		}
		
		private function MouseUpRight(me:MouseEvent):void
		{
			if (_rightArrow.currentFrame == 2 && Maps.NextWorldExists(_world))
			{
				_rightArrow.gotoAndStop(1);
				SoundController.ClickUp();
				_world++;
				Refresh();
			}
		}
		
		public function Refresh():void
		{
			gotoAndStop(_world + 1);
			
			_leftArrow.gotoAndStop(1);
			_rightArrow.gotoAndStop(1);
			
			if (_world == 0)
				_leftArrow.gotoAndStop(2);
			if (!Maps.NextWorldExists(_world))
				_rightArrow.gotoAndStop(2);
			
			
			for each(var spr:LevelButton in _startLevel)
			{
				spr.Refresh(_world);
			}
		}
		
		private function StartLevel(e:Event):void
		{
			_world = e.target.World();
			_level = e.target.Level();
			dispatchEvent(new Event("START_LEVEL"));
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