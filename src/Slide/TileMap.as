package Slide 
{
	import flash.display.Sprite;
	import flash.net.*;
	import flash.events.Event;
	/**
	 * ...
	 * @author Harry Boyes - 1101673
	 */
	public class TileMap extends Sprite
	{
		private var _tiles:Array;
		
		private var LoadComplete:Function;
		private var NextLevel:Function;
		
		private var _tileWidth:int;
		private var _tileHeight:int;
		
		private var _catX:int;
		private var _catY:int;
		
		private var _callbackFuncs:Array;
		
		private var _yShift:int;
		private var _xShift:int;
		
		
		public function TileMap(loadComplete:Function, nextLevel:Function, callbackFuncs:Array)
		{
			_tiles = new Array();
			LoadComplete = loadComplete;
			NextLevel = nextLevel;
			_callbackFuncs = callbackFuncs;
		}
		
		public function NextLeft(xLoc:int, yLoc:int):int
		{
			for(var i:int = xLoc; i >= 0; i--)
				if(!_tiles[i][yLoc].Walkable())
					return i + 1;
			return xLoc;
		}
		
		public function NextRight(xLoc:int, yLoc:int):int
		{
			for(var i:int = xLoc; i < _tiles.length; i++)
				if(!_tiles[i][yLoc].Walkable())
					return i - 1;
			return xLoc;
		}
		
		public function NextUp(xLoc:int, yLoc:int):int
		{
			for(var i:int = yLoc; i >= 0; i--)
				if(!_tiles[xLoc][i].Walkable())
					return i + 1;
			return yLoc;
		}
		
		public function NextDown(xLoc:int, yLoc:int):int
		{
			for(var i:int = yLoc; i < _tiles[0].length; i++)
				if(!_tiles[xLoc][i].Walkable())
					return i - 1;
			return yLoc;
		}
		
		public function Activate(xLoc:int, yLoc:int):void
		{
			_tiles[xLoc][yLoc].Activate();
			
			if(_tiles[xLoc][yLoc].Type() == 3)
				NextLevel();
		}
		
		public function LoadLevel(world:int, level:int):void
		{
			var myLoader:URLLoader = new URLLoader();
			
			var url:String = "Levels/";
			if(world < 10)
				url += "0";
			url += world.toString();
			if(level < 10)
				url += "0";
			url += level.toString() + ".txt";
			
			for(var i:int = 0; i < _tiles.length; i++)
				for(var j:int = 0; j < _tiles[i].length; j++)
					removeChild(_tiles[i][j]);
			
			myLoader.addEventListener(Event.COMPLETE, MapLoaded);
			
			myLoader.load(new URLRequest(url));
		}
		
		public function MapLoaded(e:Event):void
		{
			_tiles = new Array();
			
			var map:Array = new Array();
			var eachLine:Array = e.target.data.split(";");
			
			for(var i:int = 0; i < eachLine.length; i++)
			{
				if(eachLine[i].length > 0)
				{
					map[i] = new Array();
					for(var val:String in eachLine[i].split(""))
						if(int(eachLine[i].charAt(val)) > 0 || eachLine[i].charAt(val) == '0')
							map[i].push(eachLine[i].charAt(val));
				}
			}
			
			_tileWidth = 400 / Math.max(map.length, map[0].length);
			_tileHeight = 400 / Math.max(map.length, map[0].length);
			
			_xShift = (400 - (_tileWidth * map[0].length)) / 2;
			_yShift = (400 - (_tileHeight * map.length)) / 2;
			
			for(i = 0; i < map[0].length; i++)
			{
				_tiles[i] = new Array();
				for(var j:int = 0; j < map.length; j++)
				{
					if(map[j][i] == 0)
					{
						_catX = i;
						_catY = j;
					}
					_tiles[i].push(new Tile(map[j][i], i, j, _tileWidth, _tileHeight, _callbackFuncs[map[j][i]]));
					addChild(_tiles[i][j]);
				}
			}
			
			LoadComplete();
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