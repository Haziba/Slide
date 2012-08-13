package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	/**
	 * ...
	 * @author Harry Boyes - 1101673
	 */
	public class Cat extends MovieClip
	{
		private var _tileWidth:int;
		private var _tileHeight:int;
		
		private var _xTarget:int;
		private var _yTarget:int;
		
		private var _currentX:int;
		private var _currentY:int;
		
		private var _canMove:Boolean;
		
		private var _xDirec:int;
		private var _yDirec:int;
		
		private var _xShift:int;
		private var _yShift:int;
		
		private var _totalMoves:int;
		
		private var _almostStopped:Boolean;
		
		
		public function Cat()
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addEventListener(Event.ENTER_FRAME, Update);
			
			_almostStopped = false;
		}
		
		public function Update(e:Event):void
		{
			if (XLoc() != _currentX || YLoc() != _currentY)
			{
				_currentX = XLoc();
				_currentY = YLoc();
				
				_canMove = true;
				
				dispatchEvent(new Event("ON_NEW_TILE"));
				if (_currentX == _xTarget && _currentY == _yTarget)
					_almostStopped = true;
			}
			
			if (_almostStopped && Math.round(x) - _xShift == _xTarget * _tileWidth && Math.round(y) - _yShift == _yTarget * _tileHeight)
			{
				gotoAndStop("STAND");
				rotation = 0;
				dispatchEvent(new Event("HIT_TILE"));
				_almostStopped = false;
			}
		}
		
		public function PlaceAt(xLoc:int, yLoc:int, tileWidth:int, tileHeight:int, xShift:int, yShift:int):void
		{
			TweenLite.killTweensOf(this);
			_tileWidth = tileWidth;
			_tileHeight = tileHeight;
			_xShift = xShift + (tileWidth / 2);
			_yShift = yShift + (tileHeight / 2);
			x = xLoc * tileWidth + _xShift;
			y = yLoc * tileHeight + _yShift;
			width = 40 * (tileWidth / 40);
			height = 40 * (tileHeight / 40);
			_xTarget = xLoc;
			_yTarget = yLoc;
			_currentX = _xTarget;
			_currentY = _yTarget;
			_canMove = true;
			gotoAndStop("STAND");
			rotation = 0;
		}
		
		public function AllowMove():void
		{
			_canMove = true;
		}
		
		public function XLoc():int
		{
			return Math.floor(Math.round(x - _xShift) / _tileWidth);
		}
		
		public function YLoc():int
		{
			return Math.floor(Math.round(y - _yShift) / _tileHeight);
		}
		
		public function OnTile():Boolean
		{
			return XLoc() * _tileWidth == x && YLoc() * _tileHeight == y;
		}
		
		public function MoveTo(xLoc:int, yLoc:int):void
		{
			if(_canMove)
				if(Math.round(x) - _xShift == _xTarget * _tileWidth && Math.round(y) - _yShift == _yTarget * _tileHeight && !(xLoc == _xTarget && yLoc == _yTarget))
				{
					var delay:Number = (Math.abs(xLoc - XLoc()) * (1/7)) + (Math.abs(yLoc - YLoc()) * (1/7));
					TweenLite.to(this, delay, { x: xLoc * _tileWidth + _xShift, y: yLoc * _tileHeight + _yShift, ease: Quad.easeIn} );
					_xTarget = xLoc;
					_yTarget = yLoc;
					
					_xDirec = 0;
					_yDirec = 0;
					
					_totalMoves++;
					dispatchEvent(new Event("MOVE"));
					gotoAndStop("SLIDE");
					
					if(Math.abs(xLoc - XLoc()) + Math.abs(yLoc - YLoc()) > 4)
						SoundController.Slide();
					else
						SoundController.ShortSlide();
					
					if (xLoc > XLoc())
						_xDirec = 1;
					else if(xLoc < XLoc())
						_xDirec = -1;
					if (yLoc > YLoc())
						_yDirec = 1;
					else if(yLoc < YLoc())
						_yDirec = -1;
					
					if (_xDirec == 1)
						rotation = 0;
					if (_yDirec == 1)
						rotation = 90;
					if (_xDirec == -1)
						rotation = 180;
					if (_yDirec == -1)
						rotation = 270;
				}
		}
		
		public function ResetMoves():void
		{
			_totalMoves = 0;
		}
		
		public function TotalMoves():int
		{
			return _totalMoves;
		}
		
		public function Stop():void
		{
			TweenLite.killTweensOf(this);
			TweenLite.to(this, 0.2, { x: XLoc() * _tileWidth + _xShift, y: YLoc() * _tileHeight + _yShift } );
		}
		
		public function Fall():void
		{
			gotoAndStop("FALL");
			SoundController.CatFall();
			Stop();
		}
		
		public function CantMove():void
		{
			_canMove = false;
		}
		
		public function MoveX(xLoc:int):void
		{
			MoveTo(xLoc, _yTarget);
		}
		
		public function MoveY(yLoc:int):void
		{
			MoveTo(_xTarget, yLoc);
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