package Slide 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Harry Boyes - 1101673
	 */
	public class Tile extends Sprite
	{
		[Embed(source="../../Images/BlankTile.png")]
		private var _blankTile:Class;
		[Embed(source="../../Images/BarrierTile.png")]
		private var _barrierTile:Class;
		[Embed(source="../../Images/GoalTile.png")]
		private var _goalTile:Class;
		
		private var _tile:Bitmap;
		private var _type:int;
		private var _fish:Fish;
		private var _activated:Boolean;
		private var _callbackFunc:Function;
		
		
		public function Tile(type:int, xLoc:int, yLoc:int, tileWidth:int, tileHeight:int, callbackFunc:Function)
		{
			_type = type;
			
			switch(_type)
			{
				case 0:
				case 1:
				case 4:
					_tile = new _blankTile();
					break;
				case 2:
					_tile = new _barrierTile();
					break;
				case 3:
					_tile = new _goalTile();
					break;
			}
			
			addChild(_tile);
			
			if (_type == 4)
			{
				_fish = new Fish();
				addChild(_fish);
			}
			
			x = xLoc * tileWidth;
			y = yLoc * tileHeight;
			width = tileWidth + 1;
			height = tileHeight + 1;
			
			_activated = false;
			
			_callbackFunc = callbackFunc;
		}
		
		public function Type():int
		{
			return _type;
		}
		
		public function Activate():void
		{
			if(_type == 4 && !_activated)
			{
				_activated = true;
				removeChild(_fish);
				_callbackFunc();
			}
		}
		
		public function Walkable():Boolean
		{
			return (_type == 0 || _type == 1 || _type == 3 || _type == 4);
		}
	}
}