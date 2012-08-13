package  
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author Harry Boyes - 1101673
	 */
	public class Tile extends MovieClip
	{
		public static const START_TILE:int = 0;
		public static const PLAIN_TILE:int = 1;
		public static const WALL_TILE:int = 2;
		public static const END_TILE:int = 3;
		public static const FISH_TILE:int = 4;
		public static const BREAK_WALL_TILE:int = 5;
		public static const BREAK_FLOOR_TILE:int = 6;
		public static const MOVEABLE_TILE:int = 7;
		public static const BUTTON_TILE:int = 8;
		public static const DOOR_TILE:int = 9;
		
		private var _type:int;
		
		private var _fish:FishMC;
		private var _breakableWall:Breakable;
		private var _breakableFloor:BreakableFloor;
		private var _button:Button;
		private var _door:Door;
		
		private var _activated:Boolean;
		
		
		public function Tile(){}
		
		public function Initialise(type:int, xLoc:int, yLoc:int, tileWidth:int, tileHeight:int, xShift:int, yShift:int):void
		{
			_type = type;
			
			switch(_type)
			{
				case START_TILE:
				case PLAIN_TILE:
				case FISH_TILE:
				case BREAK_WALL_TILE:
				case BREAK_FLOOR_TILE:
				case MOVEABLE_TILE:
				case BUTTON_TILE:
				case DOOR_TILE:
					gotoAndStop(1);
					break;
				case WALL_TILE:
					gotoAndStop(2);
					break;
				case END_TILE:
					gotoAndStop(3);
					break;
			}
			
			if (_type == BUTTON_TILE)
			{
				_button = new ButtonMC();
				addChild(_button);
			}
			
			if (_type == DOOR_TILE)
			{
				_door = new DoorMC();
				addChild(_door);
			}
			
			if (_type == BREAK_WALL_TILE)
			{
				_breakableWall = new BreakableMC();
				addChild(_breakableWall);
			}
			
			if (_type == BREAK_FLOOR_TILE)
			{
				_breakableFloor = new BreakableFloorMC();
				addChild(_breakableFloor);
			}
			
			if (_type == FISH_TILE)
			{
				_fish = new FishMC();
				addChild(_fish);
			}
			
			x = xLoc * tileWidth + xShift;
			y = yLoc * tileHeight + yShift;
			width = tileWidth + 1;
			height = tileHeight + 1;
			
			_activated = false;
		}
		
		public function SetButton(xLoc:int, yLoc:int):void
		{
			_button.Set(xLoc, yLoc);
		}
		
		public function Type():int
		{
			return _type;
		}
		
		public function Activate():void
		{
			if(_type == FISH_TILE && !_activated)
			{
				_activated = true;
				_fish.Activate();
				dispatchEvent(new Event("GET_FISH"));
			}
			
			if (_type == BREAK_FLOOR_TILE)
			{
				if (_breakableFloor.Broken())
					dispatchEvent(new Event("CAT_FALL"));
				_breakableFloor.Activate();
			}
			if (_type == BUTTON_TILE)
			{
				_button.Activate();
				dispatchEvent(new Event("BUTTON_ACTIVATE"));
			}
			if (_type == DOOR_TILE)
				_door.Open();
		}
		
		public function ButtonX():int
		{
			return _button.ActivateX();
		}
		
		public function ButtonY():int
		{
			return _button.ActivateY();
		}
		
		public function Hit():void
		{
			if (_type == 5)
				_breakableWall.Hit();
		}
		
		public function Walkable():Boolean
		{
			return (_type == 0 || _type == 1 || _type == 3 || _type == 4 || (_type == 5 && _breakableWall.Broken()) || _type == 6 || _type == 7 || _type == 8 || (_type == 9 && _door.Walkable()));
		}
	}
}