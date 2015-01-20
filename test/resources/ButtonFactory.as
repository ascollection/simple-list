package resources
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	
	public class ButtonFactory
	{
		public static function getInstance():ButtonFactory
		{
			return _instance ? _instance : _instance = new ButtonFactory();
		}
		
		public function ButtonFactory()
		{
		
		}
		
		public function getButton(type:String, option:Object):DisplayObject
		{
			var sprite:Sprite = new Sprite();
			
			var c:Class = mapping[type];
			var d:DisplayObject = new c();
			
			if (!c)
			{
				return sprite;
			}
			
			if (option && option.hasOwnProperty('width') && option.hasOwnProperty('height'))
			{
				var ww:Number = option.width;
				var hh:Number = option.height;
				var a:Number = ww / hh;
				var ola:Number = d.width / d.height;
				if (a > ola)
				{
					d.width = ola * hh;
					d.height = hh;
				}
				else
				{
					d.width = ww;
					d.height = ww / ola;
				}
				d.y = (hh - d.height) / 2;
				
				var bg:Shape = new Shape();
				bg.graphics.beginFill(0xff6600, 0);
				bg.graphics.drawRect(0, 0, ww, hh);
				bg.graphics.endFill();
				sprite.addChild(bg);
			}
			
			if (option && option.hasOwnProperty('color'))
			{
				var ct:ColorTransform = d.transform.colorTransform;
				ct.color = option.color;
				d.transform.colorTransform = ct;
			}
			sprite.addChild(d);
			return sprite;
		}
		
		private static var _instance:ButtonFactory;
		
		private var mapping:Object = {"add": ButtonIcons.AddButton, "addto": ButtonIcons.AddtoButton, "break": ButtonIcons.BreakButton, "break2": ButtonIcons.Break2Button, "fav": ButtonIcons.FavButton, "good": ButtonIcons.GoodButton, "play": ButtonIcons.PlayButton, "play2": ButtonIcons.Play2Button, "share": ButtonIcons.ShareButton};
	}

}