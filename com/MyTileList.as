package com 
{
	import fl.controls.TileList;
	
	/**
	 * ...
	 * @author zhangmc
	 */
	public class MyTileList extends TileList 
	{
		[Bindable] 
private var _verticalGap:Number = 0; 

[Bindable] 
private var _horizontalGap:Number = 0;

		public function MyTileList() 
		{
			super();
			
		}
		
		//============================= 
		// set and get 
		//============================= 
		public function set verticalGap(value:Number):void { 
		_verticalGap = value; 
		} 

		public function get verticalGap():Number { 
		return _verticalGap; 
		} 

		public function set horizontalGap(value:Number):void { 
		_horizontalGap = value; 
		} 

		public function get horizontalGap():Number { 
		return _horizontalGap; 
		} 
	}

}