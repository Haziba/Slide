package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Harry Boyes - 1101673
	 */
	public class MainMenu extends Sprite
	{
		private var _startButton:StartButtonMC;
		
		
		public function MainMenu()
		{}
		
		public function Initialise():void
		{
			_startButton = new StartButtonMC();
			_startButton.x = 300;
			_startButton.y = 230;
			_startButton.stop();
			addChild(_startButton);
			
			_startButton.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown);
			_startButton.addEventListener(MouseEvent.MOUSE_OUT, MouseOut);
			_startButton.addEventListener(MouseEvent.MOUSE_UP, MouseUp);
			
			addEventListener(KeyboardEvent.KEY_UP, KeyPress);
		}
		
		private function KeyPress(ke:KeyboardEvent):void
		{
			if (ke.keyCode == Keyboard.ENTER || ke.keyCode == Keyboard.SPACE)
				dispatchEvent(new Event("START"));
		}
		
		private function MouseDown(me:MouseEvent):void
		{
			if (_startButton.currentFrame == 1)
			{
				_startButton.gotoAndStop(2);
				SoundController.ClickDown();
			}
		}
		
		private function MouseOut(me:MouseEvent):void
		{
			if (_startButton.currentFrame == 2)
			{
				_startButton.gotoAndStop(1);
				SoundController.ClickUp();
			}
		}
		
		private function MouseUp(me:MouseEvent):void
		{
			if (_startButton.currentFrame == 2)
			{
				_startButton.gotoAndStop(1);
				SoundController.ClickUp();
				dispatchEvent(new Event("START"));
			}
		}
	}
}