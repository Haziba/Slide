package  
{
	import flash.display.MovieClip;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	import flash.events.Event;
	/**
	 * ...
	 * @author 
	 */
	public class Moveable extends MovieClip
	{
		private var _xTarget:int;
		private var _yTarget:int;
		
		private var _xDirec:int;
		private var _yDirec:int;
		
		private var _tileWidth:int;
		private var _tileHeight:int;
		
		private var _currentX:int;
		private var _currentY:int;
		
		private var _xShift:int;
		private var _yShift:int;
		
		
		public function Moveable() 
		{
			addEventListener(Event.ENTER_FRAME, Update);
		}
		
		public function Update(e:Event):void
		{
			if (XLoc() != _currentX || YLoc() != _currentY)
			{
				_currentX = XLoc();
				_currentY = YLoc();
				
				dispatchEvent(new Event("ON_NEW_TILE"));
				
				if (_currentX == _xTarget && _currentY == _yTarget)
					dispatchEvent(new Event("HIT_TILE"));
			}
		}
		
		public function Initialise(xSet:int, ySet:int, xShift:int, yShift:int, tileWidth:int, tileHeight:int):void
		{
			x = xSet * tileWidth + xShift;
			y = ySet * tileHeight + yShift;
			_xShift = xShift;
			_yShift = yShift;
			_tileWidth = tileWidth;
			_tileHeight = tileHeight;
			width = _tileWidth;
			height = _tileHeight;
		}
		
		public function XLoc():int
		{
			return Math.floor(Math.round(x - _xShift) / _tileWidth);
		}
		
		public function YLoc():int
		{
			return Math.floor(Math.round(y - _yShift) / _tileHeight);
		}
		
		public function Hit(xLoc:int, yLoc:int):void
		{
			var delay:Number = (Math.abs(xLoc - XLoc()) * (1/7)) + (Math.abs(yLoc - YLoc()) * (1/7));
			TweenLite.to(this, delay, { x: xLoc * _tileWidth + _xShift, y: yLoc * _tileHeight + _yShift, ease: Quad.easeIn} );
			_xTarget = xLoc;
			_yTarget = yLoc;
			
			_xDirec = 0;
			_yDirec = 0;
			
			if (xLoc > XLoc())
				_xDirec = 1;
			else if(xLoc < XLoc())
				_xDirec = -1;
			if (yLoc > YLoc())
				_yDirec = 1;
			else if(yLoc < YLoc())
				_yDirec = -1;
		}
		
		public function HitX():int
		{
			return XLoc() + _xDirec;
		}
		
		public function HitY():int
		{
			return YLoc() + _yDirec;
		}
		
	}

}