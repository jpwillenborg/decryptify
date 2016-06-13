package  {
	
	import starling.animation.Juggler;
	import starling.animation.Tween;
	import starling.core.Starling;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.PixelMaskDisplayObject;
	import starling.textures.TextureSmoothing;
	import starling.utils.deg2rad;
	import flash.geom.Point;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	
	
	public class Slider {
		
		static var sliderContainer:Sprite;
		static var sliderMask:Sprite;
		static var maskFiller:Image;
		static var maskedSlider:PixelMaskDisplayObject;
		static var frameContainer:Sprite;
		static var backContainer:Sprite;
		static var frameBack:Image;
		static var frameLeft:Image;
		static var frameMiddle:Image;
		static var frameRight:Image;
		static var framePointer:Image;
		static var symbolsContainer:Sprite;
		
		static var symbolsList:Array = [];
		static var touchList:Vector.<Touch>;
		static var lowBounds:int;
		static var highBounds:int;
		static var touchBegan:Boolean = false;
		static var origin:Point = new Point();
		static var point:Point = new Point();
		static var diffX:int;
		static var target:Image;
		static var initX:int;
		static var snapList:Array = [];
		static var gap:int;
		
		static var snapVal:Number;
		
		static var rate:Number;
		static var sliderTween:Tween;		
		static var sliderJuggler:Juggler;
		
		static var canSlide:Boolean = true;
		static var currentSymbol:int;
		
		
		static function create() {
			
			// RESUME PREVIOUS VALUES
			
			currentSymbol = Data.saveObj.currentSymbol;
			
			
			// SLIDER CONTAINER
			
			sliderContainer = new Sprite();
			Board.boardSprite.addChild(sliderContainer);
			
			// BACKGROUND
			
			backContainer = new Sprite();
			sliderContainer.addChild(backContainer);
			frameBack = Atlas.generate("filler");
			frameBack.color = 0x252525;
			frameBack.width = int(Scale.rectSprite.width*0.804);
			frameBack.height = int(Scale.rectSprite.height*0.14);
			backContainer.addChild(frameBack);
			backContainer.touchable = false;
			backContainer.flatten();
			
			
			// FRAME
			
			frameContainer = new Sprite();
			sliderContainer.addChild(frameContainer);
			
			frameLeft = Atlas.generate("frame left");
			frameLeft.smoothing = TextureSmoothing.BILINEAR;
			frameLeft.height = frameBack.height;
			frameLeft.scaleX = frameLeft.scaleY;
			frameLeft.width = int(frameLeft.width);
			frameContainer.addChild(frameLeft);
			
			frameRight = Atlas.generate("frame right");
			frameRight.smoothing = TextureSmoothing.BILINEAR;
			frameRight.height = frameBack.height;
			frameRight.scaleX = frameRight.scaleY;
			frameRight.width = int(frameRight.width);
			frameRight.x = int(frameBack.width - frameRight.width);
			frameContainer.addChild(frameRight);
			
			frameMiddle = Atlas.generate("frame middle");
			frameMiddle.height = frameLeft.height;
			frameMiddle.width = int(frameBack.width - frameRight.width - frameRight.width);
			frameMiddle.x = frameLeft.width;
			frameContainer.addChild(frameMiddle);
			
			framePointer = Atlas.generate("pointer on");
			framePointer.smoothing = TextureSmoothing.BILINEAR;
			frameContainer.addChild(framePointer);
			framePointer.scaleY = frameLeft.scaleY;
			framePointer.scaleX = framePointer.scaleY;
			framePointer.x = backContainer.width/2 - framePointer.width/2;
			framePointer.y = 0;			
			
			frameContainer.flatten();
			frameContainer.touchable = false;
			
			
			// MASKING
						
			sliderMask = new Sprite();
			maskFiller = Atlas.generate("filler");
			maskFiller.width = frameBack.width;
			maskFiller.height = frameBack.height;
			sliderMask.addChild(maskFiller);
			
			maskedSlider = new PixelMaskDisplayObject(/*-1, false*/);
			maskedSlider.addChild(sliderContainer);
			
			maskedSlider.mask = sliderMask;
			Board.boardSprite.addChild(maskedSlider);
			
			maskedSlider.x = int(Main.screenWidth/2 - sliderContainer.width/2);
			maskedSlider.y = int((Scale.rectSprite.height*0.460) + Scale.rectSprite.y);
			
			
			// SYMBOLS
			
			symbolsContainer = new Sprite();
			sliderContainer.addChildAt(symbolsContainer, 1);
			
			placeSymbols();
			symbolsContainer.flatten();
			
			
			// SNAPPING
			
			lowBounds = 0;
			highBounds = backContainer.width - symbolsContainer.width;
			
			gap = symbolsList[1].x - symbolsList[0].x - symbolsList[0].width;
			snapList[0] = 0 - symbolsList[0].width/2 - ((symbolsList[1].x - symbolsList[0].x - symbolsList[0].width)/2);
			for (var i:int = 1; i < 9; i++) {
				snapList[i] = snapList[i-1] - symbolsList[i].width - (symbolsList[i+1].x - symbolsList[i].x - symbolsList[i].width);
			}
			
			
			// ANIMATION
			
			sliderTween = new Tween(symbolsContainer, 0.25, "easeOutQuad");
			
			
			// LISTENERS
			
			symbolsContainer.addEventListener(TouchEvent.TOUCH, sliderHandler);
			Board.boardSprite.addEventListener(Event.ENTER_FRAME, animateSlider);
		}
		
		
		static function placeSymbols():void {
			
			symbolsContainer.addChild(Atlas.generate("filler"));
			symbolsContainer.getChildAt(0).alpha = 0.0;
			
			for (var i:int = 0; i < 10; i++) {
				
				symbolsList[i] = new Sprite();
				symbolsContainer.addChild(symbolsList[i]);
				
				symbolsList[i].addChild(Atlas.generate("symbol" + i));
				symbolsList[i].getChildAt(0).smoothing = TextureSmoothing.BILINEAR;
				symbolsList[i].getChildAt(0).width = int(Scale.rectSprite.width*0.15);
				symbolsList[i].getChildAt(0).height = symbolsList[i].getChildAt(0).width;
				
				symbolsList[i].x = int(((symbolsList[i].width + symbolsList[i].width*0.40) * i) + (backContainer.width/2 - symbolsList[i].width/2));
				symbolsList[i].y = backContainer.height/2 - symbolsList[i].height/2;
			}
			
			symbolsContainer.getChildAt(0).width = symbolsContainer.width + symbolsList[0].x;
			symbolsContainer.getChildAt(0).height = backContainer.height;
		}
		
		
		static function sliderHandler(evt:TouchEvent):void {
			touchList = evt.getTouches(Board.boardSprite);
			if (touchList.length > 0 && canSlide) {
				
				if (touchList[0].phase == TouchPhase.BEGAN) {
					
					point = touchList[0].getLocation(backContainer);
					
					if (backContainer.bounds.containsPoint(point)) {
						touchBegan = true;
						origin = touchList[0].getLocation(backContainer);
						initX = symbolsContainer.x;
					}
					
				}
				
				if (touchList[0].phase == TouchPhase.MOVED) {
					
					point = touchList[0].getLocation(backContainer);
					
					if (backContainer.bounds.containsPoint(point) && !touchBegan) {
						touchBegan = true;
						origin = touchList[0].getLocation(backContainer);
						initX = symbolsContainer.x;
					}
					
					if (touchBegan) {
						symbolsContainer.x = initX + point.x - origin.x;
						
						if (symbolsContainer.x > lowBounds) {
							symbolsContainer.x = lowBounds;
						}
						
						if (symbolsContainer.x < highBounds) {
							symbolsContainer.x = highBounds;
						}
					}
				}
				
				
				if (touchList[0].phase == TouchPhase.ENDED) {
					
					touchBegan = false;
					canSlide = false;
					
					snapSlider();
					
				}
			}
		}
		
		
		static function animateSlider(evt:EnterFrameEvent):void {
			Starling.juggler.advanceTime(evt.passedTime);
		}
		
		
		static function snapSlider():void {
			
			if (symbolsContainer.x > snapList[0]) {
				snapVal = 0;
				currentSymbol = 0;
			}
			
			for (var i:int = 0; i < 8; i++) {
				if (symbolsContainer.x <= snapList[i] && symbolsContainer.x > snapList[i+1]) {
					snapVal = snapList[i+1] + symbolsList[i].width/2 + gap/2;
					currentSymbol = i+1;
					break;
				}
			}
			
			if (symbolsContainer.x <= snapList[8]) {
				snapVal = snapList[8] - symbolsList[8].width/2 - gap/2;
				currentSymbol = 9;
			}			
			
			Data.saveObj.snapVal = snapVal;
			Data.saveObj.currentSymbol = currentSymbol;
			
			Starling.juggler.add(sliderTween);
			sliderTween.moveTo(snapVal, 0);
			sliderTween.onComplete = function() {		
				Starling.juggler.remove(sliderTween);
				sliderTween.reset(symbolsContainer, 0.25, "easeOutQuad");
				canSlide = true;
			};
		}
	}
}
