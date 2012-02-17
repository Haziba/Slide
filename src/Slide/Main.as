package Slide
{
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Harry Boyes - 1101673
	 */
	public class Main extends Sprite 
	{
		private var _gameState:GameState;
		
		private var _mainMenu:MainMenu;
		private var _levelSelect:LevelSelect;
		private var _gameInterface:GameInterface;
		
		
		public function Main():void 
		{
			if (stage) Init();
			else addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		private function Init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			// entry point
			
			_gameState = new GameState(StateChange);
			
			_mainMenu = new MainMenu(_gameState.Set);
			_levelSelect = new LevelSelect(StartLevel);
			_gameInterface = new GameInterface();
			
			_gameState.Initialise();
			
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
		}
		
		private function EnterFrame(e:Event):void
		{
			if(_gameState.Get() == GameState.IN_GAME)
				_gameInterface.Update();
		}
		
		private function KeyDown(ke:KeyboardEvent):void
		{
			if(_gameState.Get() == GameState.IN_GAME)
				_gameInterface.KeyDown(ke.keyCode);
		}
		
		private function StateChange(gState:int):void
		{
			Hide(_mainMenu);
			Hide(_levelSelect);
			Hide(_gameInterface);
			switch(gState)
			{
				case GameState.MAIN_MENU:
					Show(_mainMenu);
					break;
				case GameState.LEVEL_SELECT:
					Show(_levelSelect);
					break;
				case GameState.IN_GAME:
					_gameInterface.Activate();
					Show(_gameInterface);
					break;
			}
		}
		
		private function StartLevel(me:MouseEvent):void
		{
			_gameInterface.LoadLevel(me.target.World(), me.target.Level());
			Hide(_gameInterface);
			_gameState.Set(GameState.IN_GAME);
		}
		
		private function Show(clip:Sprite):void
		{
			if(!contains(clip))
				addChild(clip);
		}
		
		private function Hide(clip:Sprite):void
		{
			if(contains(clip))
				removeChild(clip);
		}
	}
}




































