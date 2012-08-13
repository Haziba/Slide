package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author 
	 */
	public class Moveables extends MovieClip
	{
		private var _objects:Array;
		
		private var _onX:int;
		private var _onY:int;
		
		private var _hitX:int;
		private var _hitY:int;
		
		
		public function Moveables() 
		{
			_objects = new Array();
		}
		
		public function NewMovable(x:int, y:int, xShift:int, yShift:int, tileWidth:int, tileHeight:int):void
		{
			var newObject:Moveable = new MoveableMC();
			newObject.Initialise(x, y, xShift, yShift, tileWidth, tileHeight);
			addChild(newObject);
			
			newObject.addEventListener("ON_NEW_TILE", OnNewTile);
			newObject.addEventListener("HIT_TILE", HitTile);
			
			_objects.push(newObject);
		}
		
		public function Reset():void
		{
			for (var i:int = 0; i < _objects.length; i++)
				removeChild(_objects[i]);
			_objects = new Array();
		}
		
		private function OnNewTile(e:Event):void
		{
			_onX = e.target.XLoc();
			_onY = e.target.YLoc();
			
			dispatchEvent(new Event("ON_NEW_TILE"));
		}
		
		private function HitTile(e:Event):void
		{
			_hitX = e.target.HitX();
			_hitY = e.target.HitY();
			_onX = e.target.XLoc();
			_onY = e.target.YLoc();
			
			dispatchEvent(new Event("HIT_TILE"));
		}
		
		public function Hit(xLoc:int, yLoc:int, toX:int, toY:int):void
		{
			if(xLoc != toX || yLoc != toY)
				for (var i:int = 0; i < _objects.length; i++)
					if (_objects[i].XLoc() == xLoc && _objects[i].YLoc() == yLoc)
					{
						_objects[i].Hit(toX, toY);
						dispatchEvent(new Event("CAT_CANT_MOVE"));
					}
		}
		
		public function Walkable(xLoc:int, yLoc:int):Boolean
		{
			for (var i:int = 0; i < _objects.length; i++)
				if (_objects[i].XLoc() == xLoc && _objects[i].YLoc() == yLoc)
					return false;
			return true;
		}
		
		public function OnX():int
		{
			return _onX;
		}
		
		public function OnY():int
		{
			return _onY;
		}
		
		public function HitX():int
		{
			return _hitX;
		}
		
		public function HitY():int
		{
			return _hitY;
		}
	}
}