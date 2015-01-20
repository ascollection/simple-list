package com.asc.component.list
{
	import com.gskinner.motion.GTween;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class VScrollbar
	{
		private static const DURATION:Number = 0.3;
		
		private var stage:Stage;
		private var thumb:Sprite;
		private var track:Sprite;
		private var viewport:Sprite;
		
		private var thumbRectangle:Rectangle;
		private var trackRectangle:Rectangle;
		
		private var offsetY:int;
		private var top:int;
		private var bottom:int;
		private var visible_count:uint;
		private var total_count:uint;
		private var scalar:Number;
		
		private var tween:GTween;
		private var position:Number;
		
		private var _isVisible:Boolean;
		
		public function VScrollbar(thumb:Sprite, track:Sprite, viewport:Sprite)
		{
			this.thumb = thumb;
			this.track = track;
			this.viewport = viewport;
			
			thumbRectangle = thumb.getRect(thumb);
			trackRectangle = track.getRect(track);
			
			tween = new GTween(thumb, DURATION, null, {onChange: onChange});
			
			_isVisible = false;
			thumb.visible = false;
			track.visible = false;
		}
		
		public function setup(visible_count:uint, total_count:uint):void
		{
			this.visible_count = visible_count;
			this.total_count = total_count;
			
			var proportion:Number = visible_count / total_count;
			thumb.scaleY = proportion;
			
			thumb.y = top = track.y + trackRectangle.top - (thumbRectangle.top * proportion);
			bottom = track.y + trackRectangle.bottom - (thumbRectangle.bottom * proportion);
			scalar = (total_count - visible_count) / (bottom - top);
		}
		
		public function get isVisible():Boolean
		{
			return _isVisible;
		}
		
		public function set isVisible(isVisible:Boolean):void
		{
			if (_isVisible == isVisible)
				return;
			
			_isVisible = isVisible;
			thumb.visible = isVisible;
			track.visible = isVisible;
			
			if (isVisible)
				addListeners();
			else
				removeListeners();
		}
		
		private function addListeners():void
		{
			thumb.useHandCursor = true;
			thumb.buttonMode = true;
			track.useHandCursor = true;
			track.buttonMode = true;
			
			stage = thumb.stage;
			thumb.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			track.addEventListener(MouseEvent.CLICK, ontrackMouseClick);
		}
		
		private function removeListeners():void
		{
			thumb.useHandCursor = false;
			thumb.buttonMode = false;
			track.useHandCursor = false;
			track.buttonMode = false;
			
			thumb.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			track.removeEventListener(MouseEvent.CLICK, ontrackMouseClick);
			if (stage)
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			if (stage)
				stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function ontrackMouseClick(event:MouseEvent):void
		{
			var y:int = event.localY;
			var halfh:Number = thumb.height / 2;
			y = y < top ? top : y > bottom + halfh ? bottom + halfh : y;
			y -= halfh;
			if (y < 0)
				y = 0;
			
			position = (y - top) * scalar;
			
			var target:int = (Math.round(position - 0.2) / scalar) + top;
			tween.setValue("y", target);
		}
		
		private function onMouseDown(event:MouseEvent):void
		{
			if (!stage)
				stage = thumb.stage;
			offsetY = thumb.y - stage.mouseY;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseMove(event:MouseEvent):void
		{
			if (!stage)
				stage = thumb.stage;
			var y:int = stage.mouseY + offsetY;
			y = y < top ? top : y > bottom ? bottom : y;
			thumb.y = y;
			
			position = (thumb.y - top) * scalar;
			dispatch(position);
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			if (!stage)
				stage = thumb.stage;
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			var target:int = (Math.round(position - 0.2) / scalar) + top;
			tween.setValue("y", target);
		}
		
		private function onChange(tween:GTween):void
		{
			position = (thumb.y - top) * scalar;
			dispatch(position);
		}
		
		private function dispatch(value:Number):void
		{
			viewport.y = -value * 40;
		}
	}
}
