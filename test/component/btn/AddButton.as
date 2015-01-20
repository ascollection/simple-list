package component.btn 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import component.base.ExtendSimpleButton;
	import resources.ButtonFactory;
	
	public class AddButton extends Sprite 
	{
		
		public function AddButton() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		protected function onStage(evt:Event = null):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onStage);
			
			btn = new ExtendSimpleButton
					( ButtonFactory.getInstance().getButton('add', {width:16, height:40, color:0x999999})
					, ButtonFactory.getInstance().getButton('add', {width:16, height:40, color:0x00b9f2})
					, ButtonFactory.getInstance().getButton('add', {width:16, height:40, color:0x00b9f2})
					, ButtonFactory.getInstance().getButton('add', {width:16, height:40, color:0x999999})
					);
			btn.addEventListener(MouseEvent.CLICK, onClick);
			btn.enabled = true;
			addChild(btn);
		}
		
		private function onClick(e:MouseEvent):void
		{
			//disptach
		}
		
		public function getButton():ExtendSimpleButton
		{
			return btn;
		}
		
		private var btn:ExtendSimpleButton;
		
	}

}