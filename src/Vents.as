package  {
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	
	public class Vents {
		
		static var ventsContainer1:Sprite;
		static var ventsContainer2:Sprite;
		
		
		static function create() {
			
			// TOP VENTS
			
			ventsContainer1 = new Sprite();
			Board.boardSprite.addChild(ventsContainer1);
			
			ventsContainer1.x = int((Scale.rectSprite.width*0.0625) + Scale.rectSprite.x);
			//ventsContainer1.y = int((Scale.rectSprite.height*0.028125) + Scale.rectSprite.y);
			
			for (var i:int = 0; i < 3; i++) {
				ventsContainer1.addChild(Atlas.generate("vent"));
				ventsContainer1.getChildAt(i).width = int(Scale.rectSprite.width*0.3125);
				ventsContainer1.getChildAt(i).scaleY = ventsContainer1.getChildAt(i).scaleX;
				ventsContainer1.getChildAt(i).height = int(ventsContainer1.getChildAt(i).height);
				ventsContainer1.getChildAt(i).y = int(i * int(Scale.rectSprite.height*0.026));
			}
			
			ventsContainer1.y = int(Screen.screenContainer.y/2 - ventsContainer1.height/2);
			ventsContainer1.flatten();
			
			
			// BOTTOM VENTS
			
			ventsContainer2 = new Sprite();
			Board.boardSprite.addChild(ventsContainer2);
			
			ventsContainer2.x = int((Scale.rectSprite.width*0.0625) + Scale.rectSprite.x);
			//ventsContainer2.y = int((Scale.rectSprite.height*0.827) + Scale.rectSprite.y);
			
			for (var j:int = 0; j < 6; j++) {
				ventsContainer2.addChild(Atlas.generate("vent"));
				ventsContainer2.getChildAt(j).width = int(Scale.rectSprite.width*0.3125);
				ventsContainer2.getChildAt(j).scaleY = ventsContainer2.getChildAt(j).scaleX;
				ventsContainer2.getChildAt(j).height = int(ventsContainer2.getChildAt(j).height);
				ventsContainer2.getChildAt(j).y = int(j * int(Scale.rectSprite.height*0.026));
			}
			
			ventsContainer2.y = int((Buttons.buttonContainer.y + Buttons.buttonContainer.height + (Main.screenHeight - (Buttons.buttonContainer.y + Buttons.buttonContainer.height))/2) - ventsContainer2.height/2);
			ventsContainer2.flatten();
			
			
			// ADJUST INFO BUTTON Y
			
			Buttons.infoButton.y = int(ventsContainer2.y + ventsContainer2.height - Buttons.infoButton.height);
		}
	}
}
