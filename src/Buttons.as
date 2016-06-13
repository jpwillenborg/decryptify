package  {
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	import flash.geom.Point;
	
	
	public class Buttons {
		
		static var point:Point = new Point();
		static var buttonTouchList:Vector.<Touch>;
		static var infoTouchList:Vector.<Touch>;
		static var buttonList:Array = [];
		static var colorList:Array = ["red","orange","yellow","green","blue"];
		static var buttonContainer:Sprite;
		static var infoButton:Image;
		static var infoPoint:Point = new Point();
		
		
		static function create() {
			buttonContainer = new Sprite();
			Board.boardSprite.addChild(buttonContainer);
			
			for (var j:int = 0; j < 5; j++) {
				buttonList[j] = new Button(Atlas.getTex("button " + colorList[j] + " up"), "", Atlas.getTex("button " + colorList[j] + " down"));
				buttonList[j].name = colorList[j];
				buttonList[j].width = int(Scale.rectSprite.width/6.4);
				buttonList[j].height = buttonList[j].width;
				buttonList[j].x = j * int(Scale.rectSprite.width*0.1875);
				buttonContainer.addChild(buttonList[j]);
				buttonList[j].addEventListener(TouchEvent.TOUCH, buttonHandler);
			}
			
			buttonContainer.x = int(Main.screenWidth/2 - buttonContainer.width/2);
			buttonContainer.y = int((Scale.rectSprite.height*0.6583) + Scale.rectSprite.y);
			
			
			infoButton = Atlas.generate("info icon");
			infoButton.width = int(Scale.rectSprite.width*0.118);
			infoButton.height = infoButton.width;
			infoButton.x = int((Scale.rectSprite.width * 0.8125) + Scale.rectSprite.x);
			infoButton.y = int((Scale.rectSprite.height * 0.890) + Scale.rectSprite.y);
			infoButton.smoothing = TextureSmoothing.BILINEAR;
			Board.boardSprite.addChild(infoButton);
			
			infoButton.addEventListener(TouchEvent.TOUCH, infoHandler);
		}
		
		
		static function buttonHandler(evt:TouchEvent):void {
			var tgt = evt.target;
			buttonTouchList = evt.getTouches(buttonContainer);
			if (buttonTouchList.length > 0) {
				point = buttonTouchList[0].getLocation(buttonContainer);
				if (tgt.bounds.containsPoint(point)) {
					if (buttonTouchList[0].phase == TouchPhase.BEGAN) {
						Audio.playClickSound();	
						Logic.check(tgt, Slider.currentSymbol);
					}
				}
			}
		}
		
		
		static function infoHandler(evt:TouchEvent):void {
			var tgt = evt.target;
			infoTouchList = evt.getTouches(Board.boardSprite);
			if (infoTouchList.length > 0) {
				infoPoint = infoTouchList[0].getLocation(Board.boardSprite);
				if (tgt.bounds.containsPoint(infoPoint)) {
					if (infoTouchList[0].phase == TouchPhase.BEGAN) {
						
						Board.boardSprite.visible = false;
						Info.infoSprite.visible = true;
						
					}
				}
			}
		}
	}
}
