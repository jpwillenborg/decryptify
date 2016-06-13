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
	import flash.utils.*;
	
	
	public class Win {
		
		static var winSprite;
		static var winList:Array = [];
		static var newWinList:Array = [];
		
		static var titleText:TextField;
		static var symbolSprite:Sprite;
		
		static var symbol0:Image;
		static var symbol1:Image;
		static var symbol2:Image;
		static var symbol3:Image;
		static var symbol4:Image;
		
		static var symbolText:TextField;
		static var bodyText:TextField;
		static var winText:TextField;
		static var startButton:Button;
		static var startText:TextField;
		static var hexColorList:Array = [0xD60100, 0xFF7415, 0xFFFF00, 0x31CD01, 0x0086E0, 0x333333];
		static var point:Point = new Point();
		static var buttonTouchList:Vector.<Touch>;
		
		
		static function setup() {
			winSprite = new Sprite();
			Environment.stageRef.addChild(winSprite);
			
			// TITLE
			
			titleText = new TextField(int(Main.screenWidth*0.83), int(Scale.rectSprite.height*0.1042), String("Congratulations"), "Font", int(Scale.rectSprite.height*0.067), 0xFFFFFF, false);
			titleText.hAlign = HAlign.CENTER;
			titleText.vAlign = VAlign.CENTER;
			titleText.x = int(Main.screenWidth/2 - titleText.width/2);
			titleText.y = int((Scale.rectSprite.height * 0.06) + Scale.rectSprite.y);
			titleText.touchable = false;
			winSprite.addChild(titleText);
			
			
			// SYMBOLS
			
			symbolSprite = new Sprite();
			winSprite.addChild(symbolSprite);
			
			for (var i:int = 0; i < 5; i++) {		
				Win["symbol" + i] = Atlas.generate("symbol9");
				Win["symbol" + i].color = hexColorList[i];
				Win["symbol" + i].smoothing = TextureSmoothing.BILINEAR;
				Win["symbol" + i].width = int(Scale.rectSprite.width*0.15);
				Win["symbol" + i].height = Win["symbol" + i].width;
				Win["symbol" + i].x = int(i * int(Scale.rectSprite.width*0.18));
				symbolSprite.addChild(Win["symbol" + i]);
			}
			
			symbolSprite.x = int(Main.screenWidth/2 - symbolSprite.width/2);
			symbolSprite.y = int((Scale.rectSprite.height*0.2167) + Scale.rectSprite.y);
			symbolSprite.touchable = false;
			
			
			// SYMBOL TEXT
			
			symbolText = new TextField(int(Main.screenWidth*0.86), int(Scale.rectSprite.height*0.053), String("This was your winning pattern"), "Font", int(Scale.rectSprite.height*0.03125), 0xFFFFFF, false);
			symbolText.hAlign = HAlign.CENTER;
			symbolText.vAlign = VAlign.TOP;
			symbolText.x = int(Main.screenWidth/2 - symbolText.width/2);
			symbolText.y = int((Scale.rectSprite.height * 0.33) + Scale.rectSprite.y);
			symbolText.touchable = false;
			winSprite.addChild(symbolText);
			
			
			// BODY
			
			symbolText = new TextField(int(Main.screenWidth*0.90), int(Scale.rectSprite.height*0.46875), String("Decryptify will change every time you play. It can be solved within minutes or even seconds...but not in hours."), "Font", int(Scale.rectSprite.height*0.03125), 0xFFFFFF, false);
			symbolText.hAlign = HAlign.CENTER;
			symbolText.vAlign = VAlign.TOP;
			symbolText.x = int(Main.screenWidth/2 - symbolText.width/2);
			symbolText.y = int((Scale.rectSprite.height * 0.45) + Scale.rectSprite.y);
			symbolText.touchable = false;
			winSprite.addChild(symbolText);
			
			
			// WIN TEXT
			
			winText = new TextField(int(Main.screenWidth*0.9), int(Scale.rectSprite.height*0.074), String("Total Solves: " + Data.saveObj.numWins), "Font", int(Scale.rectSprite.height*0.05), 0xFFFFFF, false);
			winText.hAlign = HAlign.CENTER;
			winText.vAlign = VAlign.TOP;
			winText.x = int(Main.screenWidth/2 - symbolText.width/2);
			winText.y = int((Scale.rectSprite.height * 0.64) + Scale.rectSprite.y);
			winText.touchable = false;
			winSprite.addChild(winText);
			
			
			// BUTTON
			
			startButton = new Button(Atlas.getTex("button red up"), "", Atlas.getTex("button red down"));
			startButton.width = int(Scale.rectSprite.width/6.4);
			startButton.height = startButton.width;
			startButton.x = int(Main.screenWidth/2 - startButton.width/2);
			startButton.y = int((Scale.rectSprite.height * 0.755) + Scale.rectSprite.y);
			winSprite.addChild(startButton);
			startButton.addEventListener(TouchEvent.TOUCH, buttonHandler);
			
			// BUTTON TEXT
			
			startText = new TextField(int(Main.screenWidth*0.625), int(Scale.rectSprite.height*0.1042), String("AGAIN"), "Font", int(Scale.rectSprite.height*0.05), 0xFFFFFF, false);
			startText.hAlign = HAlign.CENTER;
			startText.vAlign = VAlign.CENTER;
			startText.x = int(Main.screenWidth/2 - startText.width/2);
			startText.y = int((Scale.rectSprite.height * 0.86) + Scale.rectSprite.y);
			startText.touchable = false;
			winSprite.addChild(startText);
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
					if (buttonTouchList[0].phase == TouchPhase.ENDED) {
												
						Data.saveObj.resume = true;
						Data.saveObj.winReset = false;
						
						winSprite.visible = false;
						Board.boardSprite.visible = true;
						
						// ADD LISTENERS
			
						for each (var id2 in Buttons.buttonList) {
							id2.enabled = true;
							id2.addEventListener(TouchEvent.TOUCH, Buttons.buttonHandler);
						}
						
						Slider.symbolsContainer.addEventListener(TouchEvent.TOUCH, Slider.sliderHandler);
						Board.boardSprite.addEventListener(Event.ENTER_FRAME, Slider.animateSlider);
						Buttons.infoButton.addEventListener(TouchEvent.TOUCH, Buttons.infoHandler);
					}
				}
			}
		}
		
		
		static function show() {
			
			// UPDATE WIN COUNT
			
			Data.saveObj.numWins++;
			winText.text = String("Total Solves: " + Data.saveObj.numWins);
			
			
			// UPDATE SYMBOLS
			
			winList = [Logic.val0, Logic.val1, Logic.val2, Logic.val3, Logic.val4];
			for (var d:int = 0; d < 5; d++) {
				newWinList[d] = winList[d] - 1;
				if (newWinList[d] < 0) {
					newWinList[d] = 9;
				}
			}
			while(symbolSprite.numChildren > 0) {
				symbolSprite.removeChildAt(0);
			}
			for (var k:int = 0; k < 5; k++) {
				Win["symbol" + k] = null;
			}
			
			for (var i:int = 0; i < 5; i++) {
				Win["symbol" + i] = Atlas.generate("symbol" + newWinList[i]);
				Win["symbol" + i].color = hexColorList[i];
				Win["symbol" + i].smoothing = TextureSmoothing.BILINEAR;
				Win["symbol" + i].width = int(Scale.rectSprite.width*0.15);
				Win["symbol" + i].height = Win["symbol" + i].width;
				Win["symbol" + i].x = int(i * int(Scale.rectSprite.width*0.18));
				symbolSprite.addChild(Win["symbol" + i]);
			}
			
			
			// RESET VALUES
			
			Data.saveObj.resume = false;
			Data.saveObj.winReset = true;
			
			Data.saveObj.symbols = [-1,-1,-1,-1,-1];
			Data.saveObj.lights = [0,0,0,0,0];
			Data.saveObj.snapVal = 0;
			Data.saveObj.currentSymbol = 0;
			
			Logic.val0 = -1;
			Logic.val1 = -1;
			Logic.val2 = -1;
			Logic.val3 = -1;
			Logic.val4 = -1;
			Logic.checkList.length = 0;
			Logic.newList.length = 0;
			Logic.solveCount = 0;
			Logic.blinkNum = 0;
			
			Slider.symbolsContainer.x = 0;
			Slider.currentSymbol = 0;
			
			Screen.screenContainer.unflatten();
			for (var j:int = 0; j < 5; j++) {
				Lights.turnOff(j);
				while(Screen["symbolsContainer" + j].numChildren > 0) {
					Screen["symbolsContainer" + j].removeChildAt(0);
				}
			}
			Screen.screenContainer.flatten();
			
			Board.boardSprite.visible = false;
			winSprite.visible = true;
		}
	}
}
