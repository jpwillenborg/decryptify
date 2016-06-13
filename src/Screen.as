package  {
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	
	public class Screen {
		
		static var screenContainer:Sprite;
		static var topBar:Image;
		static var screen:Image;
		static var symbolsContainer0:Sprite;
		static var symbolsContainer1:Sprite;
		static var symbolsContainer2:Sprite;
		static var symbolsContainer3:Sprite;
		static var symbolsContainer4:Sprite;
		static var shine:Quad;
		static var bottomBar:Image;
		
		
		static function create() {
			
			screenContainer = new Sprite();
			Board.boardSprite.addChild(screenContainer);
			
			topBar = Atlas.generate("shaded bar");
			topBar.height = int(Scale.rectSprite.height*0.00625);
			topBar.width = Main.screenWidth + 10;
			screenContainer.addChild(topBar);
			
			screen = Atlas.generate("filler");
			screen.color = 0x1C1C1C;
			screen.width = Main.screenWidth + 10;
			screen.height = int(Scale.rectSprite.height*0.2125);
			screen.y = topBar.y + topBar.height
			screenContainer.addChild(screen);
			
			for (var i:int = 0; i < 5; i++) {
				Screen["symbolsContainer" + i] = new Sprite();
				Screen["symbolsContainer" + i].x = int(Scale.rectSprite.width*0.046 + i*int(Scale.rectSprite.width*0.187) + Scale.rectSprite.x);
				Screen["symbolsContainer" + i].y = int(Scale.rectSprite.height*0.05833);
				screenContainer.addChild(Screen["symbolsContainer" + i]);
			}
			
			
			var topColor:uint = 0x000000; // background
			var bottomColor:uint = 0xFFFFFF; // max shine
			 
			shine = new Quad(screen.width, screen.height/2);
			shine.setVertexColor(0, topColor);
			shine.setVertexColor(1, topColor);
			shine.setVertexColor(2, bottomColor);
			shine.setVertexColor(3, bottomColor);
			
			screenContainer.addChild(shine);
			shine.x = screen.x;
			shine.y = screen.y;
			
			shine.setVertexAlpha(0, 0.0);
			shine.setVertexAlpha(1, 0.0);
			shine.setVertexAlpha(2, 0.05);
			shine.setVertexAlpha(3, 0.05);
			
			
			bottomBar = Atlas.generate("shaded bar");
			bottomBar.height = int(Scale.rectSprite.height*0.00625);
			bottomBar.width = Main.screenWidth + 10;
			bottomBar.y = screen.y + screen.height - 1;
			screenContainer.addChild(bottomBar);
			
			screenContainer.y = int((Scale.rectSprite.height*0.1208) + Scale.rectSprite.y);
			screenContainer.flatten();
			
			Symbols.create();
		}
	}
}
