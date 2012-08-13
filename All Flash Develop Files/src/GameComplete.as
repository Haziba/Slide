package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author 
	 */
	public class GameComplete extends MovieClip
	{
		private var _menuButton:MainMenuButton;
		private var _creditsButton:CreditsButton;
		
		private var _credits:CreditsMC;
		private var _backButton:BackButtonMC;
		
		
		public function GameComplete() 
		{
			_menuButton = new MainMenuButton();
			_menuButton.x = 35;
			_menuButton.y = 340
			_menuButton.stop();
			addChild(_menuButton);
			
			_creditsButton = new CreditsButton();
			_creditsButton.x = 370;
			_creditsButton.y = 340;
			_creditsButton.stop();
			addChild(_creditsButton);
			
			_credits = new CreditsMC();
			
			_backButton = new BackButtonMC();
			_backButton.x = 35;
			_backButton.y = 330;
			_backButton.stop();
			
			_menuButton.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown);
			_menuButton.addEventListener(MouseEvent.MOUSE_OUT, MouseOut);
			_menuButton.addEventListener(MouseEvent.MOUSE_UP, MouseUpMenu);
			
			_creditsButton.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown);
			_creditsButton.addEventListener(MouseEvent.MOUSE_OUT, MouseOut);
			_creditsButton.addEventListener(MouseEvent.MOUSE_UP, MouseUpCredits);
			
			_backButton.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown);
			_backButton.addEventListener(MouseEvent.MOUSE_OUT, MouseOut);
			_backButton.addEventListener(MouseEvent.MOUSE_UP, MouseUpBack);
		}
		
		private function MouseDown(me:MouseEvent):void
		{
			if (me.target.currentFrame == 1)
				SoundController.ClickDown();
			me.target.gotoAndStop(2);
		}
		
		private function MouseOut(me:MouseEvent):void
		{
			if (me.target.currentFrame == 2)
				SoundController.ClickUp();
			me.target.gotoAndStop(1);
		}
		
		private function MouseUpMenu(me:MouseEvent):void
		{
			if (me.target.currentFrame == 2)
			{
				SoundController.ClickUp();
				me.target.gotoAndStop(1);
				dispatchEvent(new Event("MAIN_MENU"));
			}
		}
		
		private function MouseUpCredits(me:MouseEvent):void
		{
			if (me.target.currentFrame == 2)
			{
				SoundController.ClickUp();
				me.target.gotoAndStop(1);
				ShowCredits();
			}
		}
		
		private function MouseUpBack(me:MouseEvent):void
		{
			if (me.target.currentFrame == 2)
			{
				SoundController.ClickUp();
				me.target.gotoAndStop(1);
				ShowComplete();
			}
		}
		
		private function ShowCredits():void
		{
			var fade:FadeOut = new FadeOutMC();
			addChild(fade);
			fade.Go(true);
			
			var t:Timer = new Timer(FadeOut.TimeUntilMid);
			t.addEventListener(TimerEvent.TIMER,
				function(te:TimerEvent):void
				{
					t.stop();
					addChild(_credits);
					addChild(_backButton);
					setChildIndex(fade, numChildren - 1);
				});
			t.start();
		}
		
		private function ShowComplete():void
		{
			var fade:FadeOut = new FadeOutMC();
			addChild(fade);
			fade.Go(true);
			
			var t:Timer = new Timer(FadeOut.TimeUntilMid);
			t.addEventListener(TimerEvent.TIMER,
				function(te:TimerEvent):void
				{
					t.stop();
					removeChild(_credits);
					removeChild(_backButton);
					setChildIndex(fade, numChildren - 1);
				});
			t.start();
		}
		
	}

}


















