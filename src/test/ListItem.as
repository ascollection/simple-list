package test
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import test.component.btn.AddButton;
	import test.component.btn.AddToButton;
	import test.component.btn.ToggleFavButton;
	import test.component.btn.GoodButton;
	import test.component.btn.TogglePauseButton;
	import test.component.btn.ShareButton;
	
	public class ListItem extends Sprite
	{
		public static const EVENT_ADD:String = "eventAdd";
		public static const EVENT_FAV:String = "eventFav";
		public static const EVENT_GOOD:String = "eventGood";
		public static const EVENT_ADDTO:String = "eventAddto";
		public static const EVENT_SHARE:String = "eventShare";
		public static const EVENT_TOGGLE_PLAY:String = "eventTogglePlay";
		
		public function ListItem(item:Object)
		{
			backgroud = new Sprite();
			backgroud.addEventListener(MouseEvent.CLICK, onBackgroudClick);
			addChild(backgroud);
			
			var shape:Shape = new Shape;
			shape.graphics.beginFill(0x000000, 1);
			shape.graphics.drawRect(0, 0, 636, 40);
			shape.graphics.endFill();
			shape.alpha = 0;
			backgroud.addChild(shape);
			
			title = new TextField();
			title.defaultTextFormat = getTextFormat(0x999999);
			title.selectable = false;
			title.mouseEnabled = false;
			title.text = "迈向崩毁黎明的时代";
			title.y = 15;
			addChild(title);
			
			author = new TextField();
			author.defaultTextFormat = getTextFormat(0x999999);
			author.selectable = false;
			author.mouseEnabled = false;
			author.text = "激情乐队";
			author.x = 225;
			author.y = 15;
			addChild(author);
			
			add = new AddButton;
			add.addEventListener(MouseEvent.CLICK, onAddHlr);
			add.x = 461;
			addChild(add);
			
			fav = new ToggleFavButton;
			fav.addEventListener(MouseEvent.CLICK, onFavHlr);
			fav.x = 491;
			addChild(fav);
			
			good = new GoodButton;
			good.addEventListener(MouseEvent.CLICK, onGoodHlr);
			good.x = 521;
			addChild(good);
			
			addto = new AddToButton;
			addto.addEventListener(MouseEvent.CLICK, onAddtoHlr);
			addto.x = 551;
			addChild(addto);
			
			share = new ShareButton;
			share.addEventListener(MouseEvent.CLICK, onShareHlr);
			share.x = 581;
			addChild(share);
			
			pause = new TogglePauseButton;
			pause.addEventListener(MouseEvent.CLICK, onPauseHlr);
			pause.x = 611;
			addChild(pause);
			
			graphics.lineStyle(1, 0xf2f2f2, 1);
			graphics.moveTo(0, 40);
			graphics.lineTo(636, 40);
			
			this.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			this.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			
			onRollOut(null);
			
			buttonMode = true;
			useHandCursor = true;
		}
		
		private function onAddHlr(e:MouseEvent):void
		{
			dispatchEvent(new Event(EVENT_ADD));
		}
		
		private function onFavHlr(e:MouseEvent):void
		{
			dispatchEvent(new Event(EVENT_FAV));
		}
		
		private function onGoodHlr(e:MouseEvent):void
		{
			dispatchEvent(new Event(EVENT_GOOD));
		}
		
		private function onAddtoHlr(e:MouseEvent):void
		{
			dispatchEvent(new Event(EVENT_ADDTO));
		}
		
		private function onShareHlr(e:MouseEvent):void
		{
			dispatchEvent(new Event(EVENT_SHARE));
		}
		
		private function onPauseHlr(e:MouseEvent):void
		{
			if (!_selected)
				onBackgroudClick(null);
			else
			{
				dispatchEvent(new Event(EVENT_TOGGLE_PLAY));
			}
		}
		
		private function onBackgroudClick(e:MouseEvent):void
		{
			if (_selected)
				return;
			dispatchEvent(new Event(Event.CHANGE));
			dispatchEvent(new Event(EVENT_TOGGLE_PLAY));
		}
		
		private function onRollOver(e:MouseEvent):void
		{
			if (selected)
				return;
			
			if (add.getButton())
				add.getButton().normal = false;
			if (fav.getButton())
				fav.getButton().normal = false;
			if (good.getButton())
				good.getButton().normal = false;
			if (addto.getButton())
				addto.getButton().normal = false;
			if (share.getButton())
				share.getButton().normal = false;
			
			title.setTextFormat(getTextFormat(0x00b9f2, true));
			author.setTextFormat(getTextFormat(0x00b9f2, true));
			
			add.visible = true;
			fav.visible = true;
			good.visible = true;
			addto.visible = true;
			share.visible = true;
		}
		
		private function onRollOut(e:MouseEvent):void
		{
			if (selected)
				return;
			add.visible = false;
			fav.visible = false;
			good.visible = false;
			addto.visible = false;
			share.visible = false;
			
			title.setTextFormat(getTextFormat(0x999999, false));
			author.setTextFormat(getTextFormat(0x999999, false));
		}
		
		private function getTextFormat(color:int, underline:Boolean = false):TextFormat
		{
			var textFormat:TextFormat = new TextFormat("宋体", "12", color, null, null, underline);
			return textFormat;
		}
		
		public function set selected(value:Boolean):void
		{
			_selected = value;
			
			if (value)
			{
				if (add.getButton())
					add.getButton().normal = true;
				if (fav.getButton())
					fav.getButton().normal = true;
				if (good.getButton())
					good.getButton().normal = true;
				if (addto.getButton())
					addto.getButton().normal = true;
				if (share.getButton())
					share.getButton().normal = true;
				
				title.setTextFormat(getTextFormat(0x00b9f2, false));
				author.setTextFormat(getTextFormat(0x00b9f2, false));
				
				add.visible = true;
				fav.visible = true;
				good.visible = true;
				addto.visible = true;
				share.visible = true;
				
				pause.isShowing = true;
			}
			else
			{
				add.visible = false;
				fav.visible = false;
				good.visible = false;
				addto.visible = false;
				share.visible = false;
				
				title.setTextFormat(getTextFormat(0x999999, false));
				author.setTextFormat(getTextFormat(0x999999, false));
				
				pause.isShowing = false;
			}
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function get index():int
		{
			return _index;
		}
		
		public function set index(value:int):void
		{
			_index = value;
		}
		
		public function get faving():Boolean
		{
			return _faving;
		}
		
		public function set faving(value:Boolean):void
		{
			_faving = value;
			
			if (value)
				fav.isShowing = false;
			else
				fav.isShowing = true;
		}
		
		public function get playing():Boolean
		{
			return _playing;
		}
		
		public function set playing(value:Boolean):void
		{
			_playing = value;
			
			if (value)
				pause.isShowing = true;
			else
				pause.isShowing = false;
		}
		
		private var _index:int;
		private var _selected:Boolean;
		private var _faving:Boolean;
		private var _playing:Boolean;
		
		private var backgroud:Sprite;
		private var title:TextField;
		private var author:TextField;
		private var add:AddButton;
		private var fav:ToggleFavButton;
		private var good:GoodButton;
		private var addto:AddToButton;
		private var share:ShareButton;
		private var pause:TogglePauseButton;
	}

}