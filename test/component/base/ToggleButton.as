package component.base
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ToggleButton extends Sprite
	{
		
		public function ToggleButton()
		{
			init();
		}
		
		protected function init():void
		{
			if (!oneChild || !twoChild)
				return;
			//若无hitTestState 为两个按钮添加响应区域
			if (!oneChild.hitTestState || !twoChild.hitTestState)
			{
				var hiteArea:Sprite = new Sprite();
				hiteArea.graphics.beginFill(0x000000);
				hiteArea.graphics.drawRect(0, 0, width, height);
				hiteArea.graphics.endFill();
				oneChild.hitTestState = twoChild.hitTestState = hiteArea;
			}
			//初始化状态
			oneChild.visible = true;
			twoChild.visible = false;
			if (!contains(oneChild))
				addChild(oneChild);
			if (!contains(twoChild))
				addChild(twoChild);
			
			isOneShowing = true;
			enabled = true;
		}
		
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
			
			mouseChildren = enabled;
			
			oneChild.enabled = enabled;
			twoChild.enabled = enabled;
		}
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		/**
		 * 设置第一态的显示
		 */
		public function set isShowing(value:Boolean):void
		{
			isOneShowing = value;
			updateBtnStatus();
		}
		
		/**
		 * 获取第一态是否正在显示
		 */
		public function get isShowing():Boolean
		{
			return isOneShowing;
		}
		
		/**
		 * 更新按钮的状态：visiable, enabled, eventListener
		 */
		protected function updateBtnStatus():void
		{
			if (!oneChild || !twoChild)
				return;
			
			oneChild.visible = isOneShowing ? visible : false;
			oneChild.enabled = isOneShowing ? enabled : false;
			twoChild.visible = isOneShowing ? false : visible;
			twoChild.enabled = isOneShowing ? false : enabled;
			
			updateBtnEventListener(oneChild, enabled && visible);
			updateBtnEventListener(twoChild, enabled && visible);
		}
		
		private function updateBtnEventListener(btn:SimpleButton, addListener:Boolean):void
		{
			if (null == btn)
				return;
			
			if (addListener)
			{
				btn.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				btn.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				
				btn.addEventListener(MouseEvent.CLICK, onMouseClick);
				btn.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				btn.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
			else
			{
				btn.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				btn.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				
				btn.removeEventListener(MouseEvent.CLICK, onMouseClick);
				btn.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				btn.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
		}
		
		protected function onMouseClick(e:MouseEvent):void
		{
			if (isOneShowing)
				isOneShowing = false;
			else
				isOneShowing = true;
			
			updateBtnStatus();
		}
		
		protected function onMouseOver(e:MouseEvent):void
		{
		}
		
		protected function onMouseOut(e:MouseEvent):void
		{
		}
		
		protected function onMouseDown(e:MouseEvent):void
		{
		}
		
		protected function onMouseUp(e:MouseEvent):void
		{
		}
		
		protected var oneChild:SimpleButton;
		protected var twoChild:SimpleButton;
		
		protected var oneAlt:String;
		protected var twoAlt:String;
		
		protected var isOneShowing:Boolean;
		
		private var _enabled:Boolean = true;
	}

}