package Slide 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Harry Boyes - 1101673
	 */
	public class MainMenu extends Sprite
	{
		[Embed(source = "../../Images/MainMenuStartButton.png")]
		private var _startImage:Class;
		private var _startButtonImage:Bitmap;
		private var _startButton:Sprite;
		
		[Embed(source = "../../Images/MainMenuSplash.png")]
		private var _splashImage:Class;
		private var _splash:Bitmap;
		
		
		public function MainMenu(UpdateGameState:Function) 
		{
			_splash = new _splashImage();
			addChild(_splash);
			
			_startButton = new Sprite();
			_startButton.x = 370;
			_startButton.y = 180;
			addChild(_startButton);
			
			_startButtonImage = new _startImage();
			_startButton.addChild(_startButtonImage);
			
			_startButton.addEventListener(MouseEvent.MOUSE_UP, function():void { UpdateGameState(GameState.LEVEL_SELECT); });
		}
	}
}