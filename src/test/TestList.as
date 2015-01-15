package test
{
	import flash.display.Sprite;
	import flash.events.Event;
	import listcomponent.List;
	
	public class TestList extends Sprite
	{
		private var list:List
		
		public function TestList()
		{
			addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		private function onStage(e:Event):void
		{
			list = new List();
			addChild(list);
			list.rowCount = 5;
			list.rowWidth = 636;
			list.rowHeight = 40;
			list.y = 100;
			list.render = ListItem;
			list.data = [{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}];
			list.addEventListener(ListItem.EVENT_ADD, onStatus, true);
			list.addEventListener(ListItem.EVENT_FAV, onStatus, true);
			list.addEventListener(ListItem.EVENT_GOOD, onStatus, true);
			list.addEventListener(ListItem.EVENT_ADDTO, onStatus, true);
			list.addEventListener(ListItem.EVENT_SHARE, onStatus, true);
			list.addEventListener(ListItem.EVENT_TOGGLE_PLAY, onStatus, true);
		}
		
		private function onStatus(e:Event):void
		{
			trace(e.type);
			var index:int = (e.target as ListItem).index;
			if (e.type == ListItem.EVENT_FAV)
			{
				if ((list.list[index] as ListItem).faving)
				{
					(list.list[index] as ListItem).faving = false;
				}
				else
				{
					(list.list[index] as ListItem).faving = true;
				}
			}
			else if (e.type == ListItem.EVENT_TOGGLE_PLAY)
			{
				if ((list.list[list.selectedIndex] as ListItem).playing)
				{
					(list.list[list.selectedIndex] as ListItem).playing = false;
				}
				else
				{
					(list.list[list.selectedIndex] as ListItem).playing = true;
				}
			}
		}
	}
}