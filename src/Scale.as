package  {
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.Stage;
	
	
	public class Scale {

		public static var rectSprite:Sprite;
		public static var rectFiller:Image;
		public static var rectDiff:Number;
		public static var rectScale:Number;
		
		
		static function setup():void {
			rectSprite = new Sprite();
			Environment.stageRef.addChild(rectSprite);
			
			rectFiller = Atlas.generate("filler");
			rectFiller.visible = false;
			rectFiller.width = int(Main.screenWidth);
			rectFiller.height = int(Main.screenWidth * (960/640));
			
			if (rectFiller.height > Main.screenHeight) {
				rectDiff = rectFiller.height - Main.screenHeight;
				rectScale = Main.screenHeight/rectFiller.height;
				rectFiller.width = int(rectFiller.width * rectScale);
				rectFiller.height = int(rectFiller.height * rectScale);
			}
			
			rectSprite.addChild(rectFiller);
			
			rectSprite.x = int(Main.screenWidth/2 - rectSprite.width/2);
			if (rectSprite.height < Main.screenHeight) {
				rectSprite.y = int((Main.screenHeight - rectSprite.height)/2);
			}
			
			
			trace(rectSprite.y);
		}
	}
}
