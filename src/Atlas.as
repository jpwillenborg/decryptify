package  {
	
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureSmoothing;
	
	
	public class Atlas {
		
		[Embed(source="../assets/container.png")]
		public static const AtlasTexture:Class;
		[Embed(source="../assets/container.xml", mimeType="application/octet-stream")]
		public static const AtlasXml:Class;		
		public static var atlas:TextureAtlas;
		public static var texList:Object = {};

		
		static function setup():void {
			var texture:Texture = Texture.fromBitmap(new AtlasTexture(), false); // false = no mipmaps
			var xml:XML = XML(new AtlasXml());
			atlas = new TextureAtlas(texture, xml);
		}
		
		
		public static function getTex(id:String):Texture {
			id = id + "0000";
			if (texList[id] == undefined) {
				texList[id] = atlas.getTexture(id);
				return texList[id];
			} else {
				return texList[id];
			}
		}
		
		
		public static function generate(id:String):Image {
			id = id + "0000";
			if (texList[id] == undefined) {
				texList[id] = atlas.getTexture(id);
				var i:Image = new Image(texList[id]);
				i.smoothing = TextureSmoothing.NONE;
				return i;
			} else {
				var j:Image = new Image(texList[id]);
				j.smoothing = TextureSmoothing.NONE;
				return j;
			}
		}
	}
}
