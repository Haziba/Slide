package 
{
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.events.ContextMenuEvent;
	
	/**
	 * ...
	 * @author Harry Boyes - 1101673
	 */
	public class Main extends Sprite 
	{
		private var _gameState:GameState;
		
		private var _mainMenu:MainMenuMC;
		private var _levelSelect:LevelSelect;
		private var _gameInterface:GameInterfaceMC;
		private var _gameComplete:GameComplete;
		
		private var _fadeOut:FadeOut;
		
		
		public function Main():void 
		{
			if (stage) Init();
			else addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		private function Init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			
			var myMenu:ContextMenu = new ContextMenu();
			myMenu.hideBuiltInItems();
			
			var currentSound:int = 1;
			
			var menuItem1:ContextMenuItem = new ContextMenuItem("Mute/Unmute");
			menuItem1.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,
				function(e:ContextMenuEvent):void{
					currentSound = 1 - currentSound;
					SoundMixer.soundTransform = new SoundTransform(currentSound);
				});
			
			myMenu.customItems.push(menuItem1);
			
			this.contextMenu = myMenu;
			
			// entry point
			
			Maps.Initialise();
			SaveGame.Initialise();
			SoundController.Initialise();
			
			_gameState = new GameState();
			_gameState.addEventListener("STATE_CHANGE", StateChange);
			
			
			// Phases
			_mainMenu = new MainMenuMC();
			_mainMenu.Initialise();
			_mainMenu.addEventListener("START", function():void { _gameState.Set(GameState.LEVEL_SELECT); } );
			
			_levelSelect = new LevelSelectMC();
			_levelSelect.addEventListener("START_LEVEL", StartLevel);
			
			_gameInterface = new GameInterfaceMC();
			_gameInterface.addEventListener("GAME_COMPLETE", GameCompleted);
			_gameInterface.addEventListener("LEVEL_SELECT", function():void { _gameState.Set(GameState.LEVEL_SELECT); } );
			_gameInterface.addEventListener("MENU", function():void { _gameState.Set(GameState.MAIN_MENU); } );
			
			_gameComplete = new GameCompleteMC();
			_gameComplete.addEventListener("MAIN_MENU", function():void { _gameState.Set(GameState.MAIN_MENU); } );
			
			_fadeOut = new FadeOutMC();
			addChild(_fadeOut);
			
			_gameState.Initialise();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
		}
		
		private function KeyDown(ke:KeyboardEvent):void
		{
			if(_gameState.Get() == GameState.IN_GAME)
				_gameInterface.KeyDown(ke.keyCode);
		}
		
		private function StateChange(e:Event):void
		{
			var t:Timer = new Timer(FadeOut.TimeUntilMid);
			t.addEventListener(TimerEvent.TIMER,
				function(te:TimerEvent):void
				{
					Hide(_mainMenu);
					Hide(_levelSelect);
					Hide(_gameInterface);
					Hide(_gameComplete);
					switch(_gameState.Get())
					{
						case GameState.MAIN_MENU:
							Show(_mainMenu);
							break;
						case GameState.LEVEL_SELECT:
							Show(_levelSelect);
							_levelSelect.Refresh();
							break;
						case GameState.IN_GAME:
							_gameInterface.Activate();
							Show(_gameInterface);
							break;
						case GameState.GAME_COMPLETE:
							Show(_gameComplete);
					}
					t.stop();
					setChildIndex(_fadeOut, numChildren - 1);
				});
			t.start();
			
			_fadeOut.Go();
		}
		
		private function StartLevel(e:Event):void
		{
			_gameInterface.StartMap(e.target.Level(), e.target.World());
			_gameState.Set(GameState.IN_GAME);
		}
		
		private function GameCompleted(e:Event):void
		{
			_gameState.Set(GameState.GAME_COMPLETE);
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




































