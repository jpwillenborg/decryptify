package  {
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import starling.display.Button;
	import flash.geom.Point;
	
	
	public class Info {
		
		static var infoSprite:Sprite;
		static var titleText:TextField;
		static var lightSprite:Sprite;
		static var bodyText:TextField;
		static var startButton:Button;
		static var startText:TextField;
		static var lightsOnList:Array = [];
		static var dotsList:Array = [];
		static var colorList:Array = ["red","orange","yellow","green","blue"];
		static var hexColorList:Array = [0xD60100, 0xFF7415, 0xFFFF00, 0x31CD01, 0x0086E0, 0x333333];
		static var point:Point = new Point();
		static var buttonTouchList:Vector.<Touch>;
		
		
		static function setup() {
			
			infoSprite = new Sprite();
			Environment.stageRef.addChild(infoSprite);
			
			
			// TITLE
			
			titleText = new TextField(int(Main.screenWidth*0.625), int(Scale.rectSprite.height*0.1042), String("Decryptify"), "Font", int(Scale.rectSprite.height*0.075), 0xFFFFFF, false);
			titleText.hAlign = HAlign.CENTER;
			titleText.vAlign = VAlign.CENTER;
			titleText.x = int(Main.screenWidth/2 - titleText.width/2);
			titleText.y = int((Scale.rectSprite.height * 0.052) + Scale.rectSprite.y);
			titleText.touchable = false;
			infoSprite.addChild(titleText);
			
			
			// LIGHTS
			
			lightSprite = new Sprite();
			infoSprite.addChild(lightSprite);
			
			for (var j:int = 0; j < 5; j++) {				
				dotsList[j] = Atlas.generate("dot");
				dotsList[j].smoothing = TextureSmoothing.BILINEAR;
				dotsList[j].color = hexColorList[j];
				dotsList[j].width = int(Scale.rectSprite.width/22);
				dotsList[j].height = dotsList[j].width;
				lightSprite.addChild(dotsList[j]);
				
				lightsOnList[j] = Atlas.generate("light on");
				lightsOnList[j].smoothing = TextureSmoothing.BILINEAR;
				lightsOnList[j].width = int(Scale.rectSprite.width/12.8);
				lightsOnList[j].height = lightsOnList[j].width;
				lightsOnList[j].x = j * int(Scale.rectSprite.width*0.128);
				lightSprite.addChild(lightsOnList[j]);
				
				dotsList[j].x = lightsOnList[j].x + (lightsOnList[j].width - dotsList[j].width)/2;
				dotsList[j].y = lightsOnList[j].y + (lightsOnList[j].height - dotsList[j].height)/2;
			}
			
			lightSprite.x = int(Main.screenWidth/2 - lightSprite.width/2);
			lightSprite.y = int((Scale.rectSprite.height*0.175) + Scale.rectSprite.y);
			lightSprite.touchable = false;
			
			
			// BODY
			
			bodyText = new TextField(int(Main.screenWidth*0.86), int(Scale.rectSprite.height*0.46875), String("Move the slider to select a symbol.\n\nTap one of the five colored buttons to change its corresponding symbol on the panel above.\n\nEach correct symbol's indicator will light. Determine a correct pattern by lighting all five indicators at once.\n\nThere will always be a solution."), "Font", int(Scale.rectSprite.height*0.03125), 0xFFFFFF, false);
			bodyText.hAlign = HAlign.LEFT;
			bodyText.vAlign = VAlign.TOP;
			bodyText.x = int(Main.screenWidth/2 - bodyText.width/2);
			bodyText.y = int((Scale.rectSprite.height * 0.2760) + Scale.rectSprite.y);
			bodyText.touchable = false;
			infoSprite.addChild(bodyText);
			
			// BUTTON
			
			startButton = new Button(Atlas.getTex("button red up"), "", Atlas.getTex("button red down"));
			startButton.width = int(Scale.rectSprite.width/6.4);
			startButton.height = startButton.width;
			startButton.x = int(Main.screenWidth/2 - startButton.width/2);
			startButton.y = int((Scale.rectSprite.height * 0.755) + Scale.rectSprite.y);
			infoSprite.addChild(startButton);
			startButton.addEventListener(TouchEvent.TOUCH, buttonHandler);
			
			// BUTTON TEXT
			
			startText = new TextField(int(Main.screenWidth*0.625), int(Scale.rectSprite.height*0.1042), String("PLAY"), "Font", int(Scale.rectSprite.height*0.05), 0xFFFFFF, false);
			startText.hAlign = HAlign.CENTER;
			startText.vAlign = VAlign.CENTER;
			startText.x = int(Main.screenWidth/2 - startText.width/2);
			startText.y = int((Scale.rectSprite.height * 0.86) + Scale.rectSprite.y);
			startText.touchable = false;
			infoSprite.addChild(startText);
		}
		
		
		static function buttonHandler(evt:TouchEvent):void {
			var tgt = evt.target;
			buttonTouchList = evt.getTouches(Environment.stageRef);
			if (buttonTouchList.length > 0) {
				point = buttonTouchList[0].getLocation(Environment.stageRef);
				if (tgt.bounds.containsPoint(point)) {
					if (buttonTouchList[0].phase == TouchPhase.BEGAN) {
						Audio.playClickSound();	
					}
					if (buttonTouchList[0].phase == TouchPhase.ENDED && Slider.canSlide) {
												
						infoSprite.visible = false;
						Board.boardSprite.visible = true;
						Data.saveObj.resume = true;
						
					}
				}
			}
		}
	}
}
