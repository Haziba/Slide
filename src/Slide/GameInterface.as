package Slide 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Harry Boyes - 1101673
	 */
	public class GameInterface extends Sprite
	{
		public var _tileMap:TileMap;
		public var _sideBar:SideBar;
		public var _cat:Cat;
		
		public var _currentLevel:int;
		public var _currentWorld:int;
		
		public var _ready:Boolean;
		
		
		public function GameInterface() 
		{
			_tileMap = new TileMap(ShowLevel, NextLevel,   [function():void{},
															function():void{},
															function():void{},
															function():void{},
															function():void{_sideBar.GetFish();}]);
			_cat = new Cat();
			_sideBar = new SideBar();
			
			addChild(_tileMap);
			addChild(_cat);
			addChild(_sideBar);
			
			_currentLevel = 1;
			_currentWorld = 1;
			
			_ready = false;
		}
		
		public function Update():void
		{
			if(_ready)
			{
				_cat.Update();
				if(_cat.OnTile())
					_tileMap.Activate(_cat.XLoc(), _cat.YLoc());
			}
		}
		
		public function KeyDown(keyCode:int):void
		{
			switch(keyCode)
			{
				case 37:
					_cat.MoveX(_tileMap.NextLeft(_cat.XLoc(), _cat.YLoc()));
					break;
				case 38:
					_cat.MoveY(_tileMap.NextUp(_cat.XLoc(), _cat.YLoc()));
					break;
				case 39:
					_cat.MoveX(_tileMap.NextRight(_cat.XLoc(), _cat.YLoc()));
					break;
				case 40:
					_cat.MoveY(_tileMap.NextDown(_cat.XLoc(), _cat.YLoc()));
					break;
			}
		}
		
		public function Activate():void
		{
			_tileMap.LoadLevel(_currentWorld, _currentLevel);
			_sideBar.Reset();
		}
		
		public function NextLevel():void
		{
			_currentLevel++;
			Activate();
		}
		
		public function LoadLevel(currentWorld:int, currentLevel:int):void
		{
			_currentLevel = currentLevel;
			_currentWorld = currentWorld;
		}
		
		public function ShowLevel():void
		{
			_ready = true;
			_cat.PlaceAt(_tileMap.CatX(), _tileMap.CatY(), _tileMap.TileWidth(), _tileMap.TileHeight());
			setChildIndex(_cat, numChildren-1);
			_sideBar.x -= _tileMap.XShift();
			_sideBar.y -= _tileMap.YShift();
			x = _tileMap.XShift();
			y = _tileMap.YShift();
		}
		
	}

}