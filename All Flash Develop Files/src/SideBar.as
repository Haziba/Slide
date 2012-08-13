package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Harry Boyes - 1101673
	 */
	public class SideBar extends MovieClip
	{
		private var _fishCount:int;
		private var _myTextField:TextField;
		
		private var _fish:Array;
		
		private var _worldText:TextField;
		private var _levelText:TextField;
		
		private var _currentMoves:TextField;
		private var _targetMoves:TextField;
		private var _bestMoves:TextField;
		
		private var _resetButton:ResetButtonMC;
		private var _levelSelectButton:LevelSelectButtonMC;
		private var _mainMenuButton:MainMenuInGameButtonMC;
		
		
		public function SideBar():void
		{
			_fish = new Array();
			
			var largerFormat:TextFormat = new TextFormat("! PEPSI !", 25, 0x000000);
			
			_worldText = new TextField();
			_worldText.defaultTextFormat = largerFormat;
			_worldText.x = 514;
			_worldText.y = 7;
			_worldText.height = 31.9;
			_worldText.width = 23.1;
			addChild(_worldText);
			
			_levelText = new TextField();
			_levelText.defaultTextFormat = largerFormat;
			_levelText.x = 514;
			_levelText.y = 58.3;
			_levelText.height = 31.9;
			_levelText.width = 30.1;
			addChild(_levelText);
			
			var smallerFormat:TextFormat = new TextFormat("! PEPSI !", 15, 0x000000);
			
			_currentMoves = new TextField();
			_currentMoves.defaultTextFormat = smallerFormat;
			_currentMoves.x = 483.3;
			_currentMoves.y = 119.8;
			_currentMoves.height = 20.8;
			_currentMoves.width = 60.7;
			addChild(_currentMoves);
			
			_targetMoves = new TextField();
			_targetMoves.defaultTextFormat = smallerFormat;
			_targetMoves.x = 483.3;
			_targetMoves.y = 136.8;
			_targetMoves.height = 20.8;
			_targetMoves.width = 60.7;
			addChild(_targetMoves);
			
			_bestMoves = new TextField();
			_bestMoves.defaultTextFormat = smallerFormat;
			_bestMoves.x = 483.3;
			_bestMoves.y = 153.1;
			_bestMoves.height = 20.8;
			_bestMoves.width = 60.7;
			addChild(_bestMoves);
			
			_resetButton = new ResetButtonMC();
			_resetButton.x = 406;
			_resetButton.y = 290;
			_resetButton.stop();
			addChild(_resetButton);
			
			_levelSelectButton = new LevelSelectButtonMC();
			_levelSelectButton.x = 406;
			_levelSelectButton.y = 326;
			_levelSelectButton.stop();
			addChild(_levelSelectButton);
			
			_mainMenuButton = new MainMenuInGameButtonMC();
			_mainMenuButton.x = 406;
			_mainMenuButton.y = 355;
			_mainMenuButton.stop();
			addChild(_mainMenuButton);
			
			_resetButton.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown);
			_resetButton.addEventListener(MouseEvent.MOUSE_OUT, MouseOut);
			_resetButton.addEventListener(MouseEvent.MOUSE_UP, MouseUpReset);
			_levelSelectButton.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown);
			_levelSelectButton.addEventListener(MouseEvent.MOUSE_OUT, MouseOut);
			_levelSelectButton.addEventListener(MouseEvent.MOUSE_UP, MouseUpLevelSelect);
			_mainMenuButton.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown);
			_mainMenuButton.addEventListener(MouseEvent.MOUSE_OUT, MouseOut);
			_mainMenuButton.addEventListener(MouseEvent.MOUSE_UP, MouseUpMenu);
			
			for (var i:int = 0; i < 3; i++)
			{
				var fish:FishMC = new FishMC();
				fish.x = i * 40 + 410;
				fish.y = 250;
				addChild(fish);
				fish.Hide();
				_fish.push(fish);
			}
		}
		
		private function MouseDown(me:MouseEvent):void
		{
			if (me.target.currentFrame == 1)
			{
				me.target.gotoAndStop(2);
				SoundController.ClickDown();
			}
		}
		
		private function MouseOut(me:MouseEvent):void
		{
			if (me.target.currentFrame == 2)
			{
				me.target.gotoAndStop(1);
				SoundController.ClickUp();
			}
		}
		
		private function MouseUpReset(me:MouseEvent):void
		{
			if (me.target.currentFrame == 2)
			{
				me.target.gotoAndStop(1);
				SoundController.ClickUp();
				dispatchEvent(new Event("RESET"));
			}
		}
		
		private function MouseUpLevelSelect(me:MouseEvent):void
		{
			if (me.target.currentFrame == 2)
			{
				me.target.gotoAndStop(1);
				SoundController.ClickUp();
				dispatchEvent(new Event("LEVEL_SELECT"));
			}
		}
		
		private function MouseUpMenu(me:MouseEvent):void
		{
			if (me.target.currentFrame == 2)
			{
				me.target.gotoAndStop(1);
				SoundController.ClickUp();
				dispatchEvent(new Event("MENU"));
			}
		}
		
		public function Reset(world:int, level:int):void
		{
			_worldText.text = (world + 1).toString();
			_levelText.text = (level + 1).toString();
			
			_currentMoves.text = "0";
			_targetMoves.text = Maps.Get(world, level).MinimumMoves().toString();
			if(SaveGame.NumMoves(world, level) > 0)
				_bestMoves.text = SaveGame.NumMoves(world, level).toString();
			else
				_bestMoves.text = "";
			
			_fishCount = 0;
			
			for each(var f:Fish in _fish)
				f.Reset();
		}
		
		public function UpdateMoves(moves:int):void
		{
			_currentMoves.text = moves.toString();
		}
		
		public function GetFish():void
		{
			_fish[_fishCount].Show();
			
			_fishCount++;
		}
		
		public function NumFish():int
		{
			return _fishCount;
		}
	}
}