package  
{
	/**
	 * ...
	 * @author 
	 */
	public class Level 
	{
		private var _map:Array;
		private var _buttons:Array;
		private var _targetMoves:int;
		
		
		public function Level(map:Array, buttons:Array, targetMoves:int)
		{
			_map = map;
			_buttons = buttons;
			_targetMoves = targetMoves;
		}
		
		public function Width():int
		{
			return _map[0].length;
		}
		
		public function Height():int
		{
			return _map.length;
		}
		
		public function ButtonCount():int
		{
			return _buttons.length;
		}
		
		public function ButtonToXFrom(fromX:int, fromY:int):int
		{
			trace(fromX, fromY);
			trace(_buttons[0].FromX, _buttons[0].FromY);
			for (var i:int = 0; i < ButtonCount(); i++)
				if (_buttons[i].fromX == fromX && _buttons[i].fromY == fromY)
					return _buttons[i].toX;
			return -1;
		}
		
		public function ButtonToYFrom(fromX:int, fromY:int):int
		{
			for (var i:int = 0; i < ButtonCount(); i++)
				if (_buttons[i].fromX == fromX && _buttons[i].fromY == fromY)
					return _buttons[i].toY;
			return -1;
		}
		
		public function TileAt(tileX:int, tileY:int):int
		{
			return _map[tileY][tileX];
		}
		
		public function MinimumMoves():int
		{
			return _targetMoves;
		}
		
	}

}