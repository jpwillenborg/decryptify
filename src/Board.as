package  {
	
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.textures.TextureSmoothing;
	import starling.display.Button;
	import starling.events.Event;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import flash.geom.Point;
	import starling.display.Image;
	
	
	public class Board {
		
		static var boardSprite:Sprite;
		
		
		public static function setup(stage:Stage) {
			
			boardSprite = new Sprite();
			stage.addChild(boardSprite);
			
			Screen.create();
			Buttons.create();
			Lights.create();
			Slider.create();
			Vents.create();
			
			
			// RESUME CHECK
			
			if (Data.saveObj.resume) {
				
				// SYMBOLS
				
				Screen.screenContainer.unflatten();
				
				for (var i:int = 0; i < 5; i++) {
					if (Data.saveObj.symbols[i] > -1) {
						var id = Data.saveObj.symbols[i] - 1;
						if (id < 0) {
							id = 9;
						}
						Symbols.place(i, id, i);
						Logic["val" + i] = id + 1;
					}
				}
				
				Screen.screenContainer.flatten();
				
				
				// LIGHTS
				
				for (var j:int = 0; j < 5; j++) {
					if (Data.saveObj.lights[j] > 0) {
						Lights.turnOn(j,j);
					}
				}
				
				
				// SLIDER
				
				Slider.symbolsContainer.x = Data.saveObj.snapVal;
			}
		}
	}
}
