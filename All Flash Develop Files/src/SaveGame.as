package  
{
	import flash.net.SharedObject;
	/**
	 * ...
	 * @author 
	 */
	public class SaveGame 
	{
		private static var save:SharedObject;
		
		
		public function SaveGame() { }
		
		public static function Initialise():void
		{
			save = SharedObject.getLocal("SlideSave");
		}
		
		public static function CompletedLevel(world:int, level:int):Boolean
		{
			return save.data["done" + world + "_" + level];
		}
		
		public static function CompleteLevel(world:int, level:int, fish:int, totalMoves:int):void
		{
			save.data["done" + world + "_" + level] = true;
			if (isNaN(save.data["fish" + world + "_" + level]))
				save.data["fish" + world + "_" + level] = fish;
			else
				save.data["fish" + world + "_" + level] = Math.max(fish, save.data["fish" + world + "_" + level]);
			if (isNaN(save.data["moves" + world + "_" + level]))
				save.data["moves" + world + "_" + level] = totalMoves;
			else
				save.data["moves" + world + "_" + level] = Math.min(totalMoves, save.data["moves" + world + "_" + level]);
			save.flush();
		}
		
		public static function NumFish(world:int, level:int):int
		{
			return save.data["fish" + world + "_" + level];
		}
		
		public static function NumMoves(world:int, level:int):int
		{
			if(save.data["moves" + world + "_" + level] > 0)
				return save.data["moves" + world + "_" + level];
			else
				return -1;
		}
		
	}

}