package Slide 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Harry Boyes - 1101673
	 */
	public class Cat extends Sprite
	{
		[Embed(source="../../Images/Cat.png")]
		public var _catImage:Class;
		
		public var _cat:Bitmap;
		
		public var _tileWidth:int;
		public var _tileHeight:int;
		
		public var _xTarget:int;
		public var _yTarget:int;
		
		
		public function Cat()
		{
			_cat = new _catImage();
			addChild(_cat);
		}
		
		public function Update():void
		{
			if(_xTarget * _tileWidth > x)
				x += _tileWidth / 5;
			if(_xTarget * _tileWidth < x)
				x -= _tileWidth / 5;
			if(_yTarget * _tileHeight > y)
				y += _tileHeight / 5;
			if(_yTarget * _tileHeight < y)
				y -= _tileHeight / 5;
		}
		
		public function PlaceAt(xLoc:int, yLoc:int, tileWidth:int, tileHeight:int):void
		{
			_tileWidth = tileWidth;
			_tileHeight = tileHeight;
			x = xLoc * tileWidth;
			y = yLoc * tileHeight;
			width = 40 * (tileWidth / 40);
			height = 40 * (tileHeight / 40);
			_xTarget = xLoc;
			_yTarget = yLoc;
		}
		
		public function XLoc():int
		{
			return Math.floor(Math.round(x) / _tileWidth);
		}
		
		public function YLoc():int
		{
			return Math.floor(Math.round(y) / _tileHeight);
		}
		
		public function OnTile():Boolean
		{
			return XLoc() * _tileWidth == x && YLoc() * _tileHeight == y;
		}
		
		public function MoveTo(xLoc:int, yLoc:int):void
		{
			if(Math.round(x) == _xTarget * _tileWidth && Math.round(y) == _yTarget * _tileHeight)
			{
				_xTarget = xLoc;
				_yTarget = yLoc;
			}
		}
		
		public function MoveX(xLoc:int):void
		{
			MoveTo(xLoc, _yTarget);
		}
		
		public function MoveY(yLoc:int):void
		{
			MoveTo(_xTarget, yLoc);
		}
	}

}