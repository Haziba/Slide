package 
{
	import flash.display.MovieClip;
	import flash.net.*;
	import flash.events.Event;
	/**
	 * ...
	 * @author Harry Boyes - 1101673
	 */
	public class TileMap extends MovieClip
	{
		private var _tiles:Array;
		
		private var _tileWidth:int;
		private var _tileHeight:int;
		
		private var _catX:int;
		private var _catY:int;
		
		private var _yShift:int;
		private var _xShift:int;
		
		private var _moveables:Moveables;
		
		private var _waitForNextLevel:Boolean;
		
		
		public function TileMap()
		{
			_tiles = new Array();
			_moveables = new Moveables();
			addChild(_moveables);
			
			_moveables.addEventListener("ON_NEW_TILE", MoveableOnNewTile);
			_moveables.addEventListener("HIT_TILE", MoveableHitTile);
			_moveables.addEventListener("CAT_CANT_MOVE", function(e:Event):void { dispatchEvent(new Event("CAT_CANT_MOVE")); } );
		}
		
		public function NextLeft(xLoc:int, yLoc:int):int
		{
			for(var i:int = xLoc - 1; i >= 0; i--)
				if(!_tiles[i][yLoc].Walkable() || !_moveables.Walkable(i, yLoc))
					return i + 1;
			return xLoc;
		}
		
		public function NextRight(xLoc:int, yLoc:int):int
		{
			trace("Next right");
			for(var i:int = xLoc + 1; i < _tiles.length; i++)
				if(!_tiles[i][yLoc].Walkable() || !_moveables.Walkable(i, yLoc))
					return i - 1;
			return xLoc;
		}
		
		public function NextUp(xLoc:int, yLoc:int):int
		{
			for(var i:int = yLoc - 1; i >= 0; i--)
				if(!_tiles[xLoc][i].Walkable() || !_moveables.Walkable(xLoc, i))
					return i + 1;
			return yLoc;
		}
		
		public function NextDown(xLoc:int, yLoc:int):int
		{
			for(var i:int = yLoc + 1; i < _tiles[0].length; i++)
				if(!_tiles[xLoc][i].Walkable() || !_moveables.Walkable(xLoc, i))
					return i - 1;
			return yLoc;
		}
		
		public function Activate(xLoc:int, yLoc:int):void
		{
			_tiles[xLoc][yLoc].Activate();
			
			if (_tiles[xLoc][yLoc].Type() == 3)
			{
				dispatchEvent(new Event("NEXT_LEVEL"));
				_waitForNextLevel = true;
			}
		}
		
		public function WaitingForNextLevel():Boolean
		{
			return _waitForNextLevel;
		}
		
		public function Hit(xLoc:int, yLoc:int, fromX:int, fromY:int):void
		{
			_tiles[xLoc][yLoc].Hit();
			
			var toX:int = xLoc;
			var toY:int = yLoc;
			
			if (xLoc > fromX)
				toX = NextRight(xLoc, yLoc);
			if (xLoc < fromX)
				toX = NextLeft(xLoc, yLoc);
			if (yLoc > fromY)
				toY = NextDown(xLoc, yLoc);
			if (yLoc < fromY)
				toY = NextUp(xLoc, yLoc);
			_moveables.Hit(xLoc, yLoc, toX, toY);
		}
		
		public function StartMap(level:Level):void
		{
			_tileWidth = 400 / Math.max(level.Height(), level.Width());
			_tileHeight = 400 / Math.max(level.Height(), level.Width());
			
			_xShift = (400 - (_tileWidth * level.Width())) / 2;
			_yShift = (400 - (_tileHeight * level.Height())) / 2;
			
			for (var i:int = 0; i < _tiles.length; i++)
				for (var j:int = 0; j < _tiles[i].length; j++)
					if(contains(_tiles[i][j]))
						removeChild(_tiles[i][j]);
			_moveables.Reset();
			
			_tiles = new Array();
			
			for(i = 0; i < level.Width(); i++)
			{
				_tiles[i] = new Array();
				trace(level.Width(), level.Height());
				for(j = 0; j < level.Height(); j++)
				{
					if(level.TileAt(i, j) == Tile.START_TILE)
					{
						_catX = i;
						_catY = j;
					}
					_tiles[i].push(new TileMC());
					_tiles[i][j].Initialise(level.TileAt(i, j), i, j, _tileWidth, _tileHeight, _xShift, _yShift);
					if (level.TileAt(i, j) == Tile.BUTTON_TILE)
						_tiles[i][j].SetButton(level.ButtonToXFrom(i, j), level.ButtonToYFrom(i, j));
					_tiles[i][j].addEventListener("GET_FISH", function(e:Event):void { dispatchEvent(new Event("GET_FISH")); } );
					_tiles[i][j].addEventListener("CAT_FALL", function(e:Event):void { dispatchEvent(new Event("CAT_FALL")); } );
					_tiles[i][j].addEventListener("BUTTON_ACTIVATE", ButtonActivated);
					addChild(_tiles[i][j]);
					
					if (level.TileAt(i, j) == Tile.MOVEABLE_TILE)
						_moveables.NewMovable(i, j, _xShift, _yShift, _tileWidth, _tileHeight);
				}
			}
			
			trace(_tiles[_tiles.length-1][_tiles[_tiles.length-1].length-1]);
			
			setChildIndex(_moveables, numChildren - 1);
			_waitForNextLevel = false;
			
			dispatchEvent(new Event("SHOW_LEVEL"));
		}
		
		private function ButtonActivated(e:Event):void
		{
			_tiles[e.target.ButtonX()][e.target.ButtonY()].Activate();
		}
		
		private function MoveableOnNewTile(e:Event):void
		{
			_tiles[_moveables.OnX()][_moveables.OnY()].Activate();
		}
		
		private function MoveableHitTile(e:Event):void
		{
			dispatchEvent(new Event("CAT_CAN_MOVE"));
			Hit(_moveables.HitX(), _moveables.HitY(), _moveables.OnX(), _moveables.OnY());
		}
		
		public function TileWidth():int
		{
			return _tileWidth;
		}
		
		public function TileHeight():int
		{
			return _tileHeight;
		}
		
		public function XShift():int
		{
			return _xShift;
		}
		
		public function YShift():int
		{
			return _yShift;
		}
		
		public function CatX():int
		{
			return _catX;
		}
		
		public function CatY():int
		{
			return _catY;
		}
	}

}