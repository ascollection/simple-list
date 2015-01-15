package test.component.base
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	
	public class ExtendSimpleButton extends SimpleButton
	{
		protected var enabledState1:DisplayObject;
		protected var overState1:DisplayObject;
		protected var disabledState1:DisplayObject;
		
		public function ExtendSimpleButton($upState:DisplayObject = null, $overState:DisplayObject = null, $downState:DisplayObject = null, $disabledState:DisplayObject = null)
		{
			enabledState1 = $upState;
			overState1 = $overState;
			disabledState1 = $disabledState;
			overState = $overState;
			downState = $downState;
			
			upState = enabledState1;
			hitTestState = upState;
		}
		
		/**
		 * 覆盖enabled属性的setter方法
		 * @param  value  Boolean 指定按钮是否处于启用状态
		 */
		override public function set enabled(value:Boolean):void
		{
			super.enabled = value;
			// 设置鼠标事件是否可用            
			this.mouseEnabled = enabled;
			// 按钮处于可用状态时，按钮弹起状态的显示对象不变，否则替换成不可用状态的显示对象， 
			upState = (enabled) ? enabledState1 : disabledState1;
		}
		
		public function set normal(value:Boolean):void
		{
			if (value)
			{
				upState = enabledState1;
			}
			else
			{
				upState = overState1;
			}
		}
	}

}