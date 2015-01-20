package component.btn 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import component.base.ExtendSimpleButton;
	import component.base.ToggleButton;
	import resources.ButtonFactory;
	
	public class ToggleFavButton extends ToggleButton 
	{
		
		public function ToggleFavButton() 
		{
			
		}
		
		override protected function init():void
		{
			//实例化按钮
			oneChild = new ExtendSimpleButton
					( ButtonFactory.getInstance().getButton('fav', {width:16, height:40, color:0x999999})
					, ButtonFactory.getInstance().getButton('fav', {width:16, height:40, color:0x00b9f2})
					, ButtonFactory.getInstance().getButton('fav', {width:16, height:40, color:0x00b9f2})
					, ButtonFactory.getInstance().getButton('fav', {width:16, height:40, color:0x999999})
					);
			twoChild = new ExtendSimpleButton
					( ButtonFactory.getInstance().getButton('fav', {width:16, height:40, color:0xff7f9a})
					, ButtonFactory.getInstance().getButton('fav', {width:16, height:40, color:0xff7f9a})
					, ButtonFactory.getInstance().getButton('fav', {width:16, height:40, color:0xff7f9a})
					, ButtonFactory.getInstance().getButton('fav', {width:16, height:40, color:0x999999})
					);
			
			super.init();
		}
		
		override protected function onMouseClick(e:MouseEvent):void 
		{
			//super.onMouseClick(e);
			//dispatch event
		}
		
		public function getButton():ExtendSimpleButton
		{
			if (isShowing)
				return oneChild as ExtendSimpleButton;
			else 
				return null;
		}
	}

}