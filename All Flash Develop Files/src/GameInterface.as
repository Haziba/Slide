package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Harry Boyes - 1101673
	 */
	public class GameInterface extends MovieClip
	{
		private var _tileMap:TileMap;
		private var _sideBar:SideBarMC;
		private var _cat:CatMC;
		private var _mask:SquareMaskMC;
		
		private var _currentLevel:int;
		private var _currentWorld:int;
		
		private var _ready:Boolean;
		
		private var _level:Level;
		
		private var _fadeOut:FadeOut;
		
		
		public function GameInterface() 
		{
			_tileMap = new TileMap();
			_tileMap.addEventListener("SHOW_LEVEL", ShowLevel);
			_tileMap.addEventListener("NEXT_LEVEL", NextLevel);
			_tileMap.addEventListener("GET_FISH", GetFish);
			_tileMap.addEventListener("CAT_FALL", CatFall);
			_tileMap.addEventListener("CAT_CANT_MOVE", function(e:Event):void { _cat.CantMove(); } );
			_tileMap.addEventListener("CAT_CAN_MOVE", function(e:Event):void { _cat.AllowMove(); } );
			
			_cat = new CatMC();
			_cat.addEventListener("ON_NEW_TILE", CatOnNewTile);
			_cat.addEventListener("HIT_TILE", HitTile);
			_cat.addEventListener("MOVE", function(e:Event):void { _sideBar.UpdateMoves(_cat.TotalMoves()); } );
			
			_sideBar = new SideBarMC();
			_sideBar.addEventListener("RESET", Reset);
			_sideBar.addEventListener("LEVEL_SELECT", SelectLevel);
			_sideBar.addEventListener("MENU", Menu);
			
			_mask = new SquareMaskMC();
			
			addChild(_tileMap);
			addChild(_cat);
			addChild(_sideBar);
			
			_tileMap.mask = _mask;
			
			_currentLevel = 0;
			_currentWorld = 0;
			
			_fadeOut = new FadeOutMC();
			addChild(_fadeOut);
			
			_ready = false;
		}
		
		private function SelectLevel(e:Event):void
		{
			dispatchEvent(new Event("LEVEL_SELECT"));
		}
		
		private function Menu(e:Event):void
		{
			dispatchEvent(new Event("MENU"));
		}
		
		private function Reset(e:Event):void
		{
			_fadeOut.Go();
			setChildIndex(_fadeOut, numChildren - 1);
			
			
			var t:Timer = new Timer(FadeOut.TimeUntilMid);
			t.addEventListener(TimerEvent.TIMER,
				function(te:TimerEvent):void
				{
					ShowLevel(null);
					Activate();
					t.stop();
					setChildIndex(_fadeOut, numChildren - 1);
				});
			t.start();
		}
		
		public function CatOnNewTile(e:Event):void
		{
			_tileMap.Activate(_cat.XLoc(), _cat.YLoc());
			
			if (_tileMap.WaitingForNextLevel())
				_cat.Stop();
		}
		
		public function HitTile(e:Event):void
		{
			_tileMap.Hit(_cat.HitX(), _cat.HitY(), _cat.XLoc(), _cat.YLoc());
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
			_tileMap.StartMap(_level);
			_cat.ResetMoves();
			_sideBar.Reset(_currentWorld, _currentLevel);
			
			_mask = new SquareMaskMC();
			_mask.x = _tileMap.XShift() + (_tileMap.TileWidth() / 2);
			_mask.y = _tileMap.YShift() + (_tileMap.TileHeight() / 2);
			_mask.width = _tileMap.TileWidth() * (_level.Width() - 1);
			_mask.height = _tileMap.TileHeight() * (_level.Height() - 1);
			_tileMap.mask = _mask;
		}
		
		public function NextLevel(e:Event):void
		{
			SaveGame.CompleteLevel(_currentWorld, _currentLevel, _sideBar.NumFish(), _cat.TotalMoves());
			
			var moveOn:Boolean = false;
			
			if (Maps.NextLevelExists(_currentWorld, _currentLevel))
			{
				_currentLevel++;
				moveOn = true;
			}
			else if (Maps.NextWorldExists(_currentWorld))
			{
				_currentWorld++;
				_currentLevel = 0;
				moveOn = true;
			}
			
			if (moveOn)
			{
				_cat.CantMove();
				
				_fadeOut.Go();
				setChildIndex(_fadeOut, numChildren - 1);
				
				var t:Timer = new Timer(FadeOut.TimeUntilMid);
				t.addEventListener(TimerEvent.TIMER,
					function(te:TimerEvent):void
					{
						_level = Maps.Get(_currentWorld, _currentLevel);
						
						Activate();
						
						setChildIndex(_fadeOut, numChildren - 1);
						t.stop();
					});
				t.start();
			}
			else
				dispatchEvent(new Event("GAME_COMPLETE"));
		}
		
		public function StartMap(level:int, world:int):void
		{
			_currentLevel = level;
			_currentWorld = world;
			
			_level = Maps.Get(_currentWorld, _currentLevel);
			
			ShowLevel(null);
		}
		
		public function ShowLevel(e:Event):void
		{
			_ready = true;
			_cat.PlaceAt(_tileMap.CatX(), _tileMap.CatY(), _tileMap.TileWidth(), _tileMap.TileHeight(), _tileMap.XShift(), _tileMap.YShift());
			setChildIndex(_cat, numChildren-1);
		}
		
		public function GetFish(e:Event):void
		{
			_sideBar.GetFish();
		}
		
		public function CatFall(e:Event):void
		{
			_cat.Fall();
		}
		
	}

}