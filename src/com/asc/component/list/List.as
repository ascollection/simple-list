package com.asc.component.list
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class List extends Sprite
	{
		private var viewport:Sprite;
		private var track:Sprite;
		private var thumb:Sprite;
		private var item_list:Vector.<DisplayObject>;
		
		private var _data:Array;
		private var _render:Class; //item class
		
		private var _rowCount:Number;
		private var _rowHeight:Number;
		private var _rowWidth:Number;
		
		private var _selectedIndex:int;
		
		public function List()
		{
			//viewport
			viewport = new Sprite();
			addChild(viewport);
			
			item_list = new Vector.<DisplayObject>;
			_selectedIndex = -1;
		}
		
		private function initView():void
		{
			if (!render || !data)
				return;
			
			for (var i:int = 0; i < data.length; i++)
			{
				var listitem:DisplayObject = new render(data[i]);
				listitem['index'] = i;
				listitem.addEventListener(Event.CHANGE, onChangeHlr);
				listitem.y = i * rowHeight
				viewport.addChild(listitem);
				
				item_list.push(listitem);
			}
			
			//vs
			track = new Sprite();
			track.addChild(getShape(8, rowCount * rowHeight, 0x333333, 0.1));
			track.x = rowWidth;
			track.visible = false;
			addChild(track);
			thumb = new Sprite();
			thumb.addChild(getShape(8, rowCount * rowHeight, 0x333333, 0.3));
			thumb.x = rowWidth;
			thumb.visible = false;
			addChild(thumb);
			
			var vs:VScrollbar = new VScrollbar(thumb, track, viewport);
			vs.setup(rowCount, data.length);
			vs.isVisible = data.length > rowCount;
			
			//mask
			var mask:Shape = getShape(rowWidth + thumb.width, track.height);
			addChild(mask);
			this.mask = mask;
		}
		
		private function onChangeHlr(e:Event):void
		{
			var index:int;
			if (e && e.currentTarget)
				index = e.currentTarget['index'];
			else
				index = 0;
			
			if (index == _selectedIndex)
				return;
			_selectedIndex = index;
			
			for (var i:int = 0; i < item_list.length; i++)
			{
				if (i == index)
					item_list[i]['selected'] = true;
				else
					item_list[i]['selected'] = false;
			}
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		private function getShape(w:Number = 100, h:Number = 100, color:uint = 0, alpha:Number = 1):Shape
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill(color, alpha);
			shape.graphics.drawRect(0, 0, w, h);
			shape.graphics.endFill();
			return shape;
		}
		
		public function get data():Array
		{
			return _data;
		}
		
		public function set data(value:Array):void
		{
			_data = value;
			
			initView();
		}
		
		public function get render():Class
		{
			return _render;
		}
		
		public function set render(value:Class):void
		{
			_render = value;
			
			initView();
		}
		
		public function get rowCount():Number
		{
			return _rowCount;
		}
		
		public function set rowCount(value:Number):void
		{
			_rowCount = value;
		}
		
		public function get rowHeight():Number
		{
			return _rowHeight;
		}
		
		public function set rowHeight(value:Number):void
		{
			_rowHeight = value;
		}
		
		public function get rowWidth():Number
		{
			return _rowWidth;
		}
		
		public function set rowWidth(value:Number):void
		{
			_rowWidth = value;
		}
		
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		
		public function set selectedIndex(value:int):void
		{
			if (_selectedIndex == value)
				return;
			_selectedIndex = value;
			
			for (var i:int = 0; i < item_list.length; i++)
			{
				if (i == _selectedIndex)
					item_list[i]['selected'] = true;
				else
					item_list[i]['selected'] = false;
			}
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get list():Vector.<DisplayObject>
		{
			return item_list;
		}
	}
}