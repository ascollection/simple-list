package component.btn 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import component.base.ExtendSimpleButton;
	import component.base.ToggleButton;
	import resources.ButtonFactory;
	
	public class TogglePauseButton extends ToggleButton 
	{
		
		public function TogglePauseButton() 
		{
			
		}
		
		override protected function init():void
		{
			//实例化按钮
			oneChild = new ExtendSimpleButton
					( ButtonFactory.getInstance().getButton('break', {width:16, height:42, color:0x00b9f2})
					, ButtonFactory.getInstance().getButton('break2', {width:16, height:42, color:0x00b9f2})
					, ButtonFactory.getInstance().getButton('break2', {width:16, height:42, color:0x00b9f2})
					, ButtonFactory.getInstance().getButton('break', {width:16, height:42, color:0x999999})
					);
			twoChild = new ExtendSimpleButton
					( ButtonFactory.getInstance().getButton('play', {width:16, height:42, color:0x00b9f2})
					, ButtonFactory.getInstance().getButton('play2', {width:16, height:42, color:0x00b9f2})
					, ButtonFactory.getInstance().getButton('play2', {width:16, height:42, color:0x00b9f2})
					, ButtonFactory.getInstance().getButton('play', {width:16, height:42, color:0x999999})
					);
			
			super.init();
		}
		
		override protected function onMouseClick(e:MouseEvent):void 
		{
			//super.onMouseClick(e);
			//dispatch event
		}
		
	}

}