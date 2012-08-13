package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextLine;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
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
		
		private const WIDTH:int = 15;
		private const HEIGHT:int = 11;
		private const world:int = 0;
		private const level:int = 14;
		private var _tiles:Array;
		
		private var _tileWidth:Number;
		private var _tileHeight:Number;
		
		private var _currentTool:TileMC;
		
		private var _mapText:TextField;
		private var _buttonText:TextField;
		
		private var _buttons:Array;
		
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			DrawStage();
			
			_mapText = new TextField();
			addChild(_mapText);
			_mapText.text = "Hello";
			_mapText.x = 420;
			_mapText.y = 150;
			
			_buttons = new Array();
			
			var printAll:TileMC = new TileMC();
			printAll.x = 450;
			printAll.y = 0;
			printAll.stop();
			addChild(printAll);
			printAll.addEventListener(MouseEvent.CLICK, MapText);
			
			_currentTool = new TileMC();
			_currentTool.x = 450;
			_currentTool.y = 100;
			_currentTool.gotoAndStop(WALL_TILE + 1);
			_currentTool.addEventListener(MouseEvent.CLICK, function(me:MouseEvent):void { if (_currentTool.currentFrame < DOOR_TILE) _currentTool.nextFrame(); else _currentTool.gotoAndStop(1); } );
			addChild(_currentTool);
		}
		
		private function DrawStage():void
		{
			_tiles = new Array();
			
			_tileWidth = 400 / Math.max(HEIGHT, WIDTH);
			_tileHeight = _tileWidth;
			
			for (var i:int = 0; i < WIDTH; i++)
			{
				_tiles.push(new Array());
				for (var j:int = 0; j < HEIGHT; j++)
				{
					var tile:TileMC = new TileMC();
					if (i == 0 || i == WIDTH - 1 || j == 0 || j == HEIGHT - 1)
						tile.gotoAndStop(WALL_TILE + 1);
					else
						tile.gotoAndStop(PLAIN_TILE + 1);
					tile.x = i * _tileWidth;
					tile.y = j * _tileHeight;
					tile.width = _tileWidth;
					tile.height = _tileHeight;
					addChild(tile);
					tile.addEventListener(MouseEvent.MOUSE_DOWN, ClickTile);
					_tiles[i].push(tile);
				}
			}
		}
		
		private function ClickTile(me:MouseEvent):void
		{
			me.target.gotoAndStop(_currentTool.currentFrame);
			
			if (_currentTool.currentFrame == DOOR_TILE + 1)
			{
				_buttons[_buttons.length - 1].toX = Math.ceil(me.target.x / _tileWidth);
				_buttons[_buttons.length - 1].toY = Math.ceil(me.target.y / _tileHeight);
				_currentTool.gotoAndStop(1);
			}
			if (_currentTool.currentFrame == BUTTON_TILE + 1)
			{
				_buttons.push( { fromX: Math.ceil(me.target.x / _tileWidth), fromY: Math.ceil(me.target.y / _tileHeight) } );
				_currentTool.gotoAndStop(DOOR_TILE + 1);
			}
		}
		
		private function MapText(me:MouseEvent):void
		{
			var myMap:String = "\n\n\t\t\tlevels.push(new Level([";
			
			for (var i:int = 0; i < HEIGHT; i++)
			{
				myMap += "[";
				for (var j:int = 0; j < WIDTH; j++)
				{
					myMap += (_tiles[j][i].currentFrame - 1);
					if (j != WIDTH - 1)
						myMap += ", ";
				}
				myMap += "]";
				if (i != HEIGHT - 1)
				{
					myMap += ",\n\t\t\t\t\t\t\t\t  ";
					if (level > 9)
						myMap += " ";
				}
			}
			
			myMap += "],\n\t\t\t\t\t\t\t\t  [";
			
			for (i = 0; i < _buttons.length; i++)
			{
				myMap += "{ fromX:" + _buttons[i].fromX + ", fromY:" + _buttons[i].fromY + ", toX:" + _buttons[i].toX + ", toY:" + _buttons[i].toY + " }";
				if (i != _buttons.length - 1)
				{
					myMap += ",\n\t\t\t\t\t\t\t\t  "
					if (level > 9)
						myMap += " ";
				}
			}
			
			myMap += "],\n\t\t\t\t\t\t\t\t  0));";
			
			_mapText.text = myMap;
			trace(_buttons[0]);
		}
	}
}