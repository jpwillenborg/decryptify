package  {
	
	import starling.display.Button;
	import starling.events.TouchEvent;
	import starling.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.*;
	
	
	public class Logic {
		
		static var val0:int = -1;
		static var val1:int = -1;
		static var val2:int = -1;
		static var val3:int = -1;
		static var val4:int = -1;
		
		static var currentTime:Date
		static var min:String;
		static var sec:String;
		static var checkList:Array = [];
		static var newList:Array = [];
		
		static var solveCount:int = 0;
		static var blinkTimer:Timer = new Timer(500);
		static var blinkNum:int = 0;
		
		
		static function check(tgt:Button, val:int) {
			
			// CHECK TIME
			
			currentTime = new Date();
			min = String(currentTime.getMinutes());
			sec = String(currentTime.getSeconds());
			
			if (min.length < 2) {
				min = "0" + min;
			}
			if (sec.length < 2) {
				sec = "0" + sec;
			}

			checkList[0] = int(min.substr(0,1));
			checkList[1] = int(min.substr(1,1));
			checkList[2] = int(sec.substr(0,1));
			checkList[3] = int(sec.substr(1,1));
			
			
			// CHANGE SYMBOLS
			
			for (var i:int = 0; i < 5; i++) {
				if (tgt.name == Lights.colorList[i]) {
					Symbols.place(i, val, i);
					Logic["val" + i] = val + 1;
					if (Logic["val" + i] == 10) {
						Logic["val" + i] = 0;
					}
					
					Data.saveObj.symbols[i] = Logic["val" + i];
					if (Data.saveObj.symbols[i] == 10) {
						Data.saveObj.symbols[i] = 0;
					}
				}
			}

			
			// UPDATE VALS
			
			for (var j:int = 0; j < checkList.length; j++) {
				if (checkList[j] != -1 && val4 != -1) {
					checkList[j] = checkList[j] + val4;
					if (checkList[j] > 9) {
						checkList[j] -= 10;
					}
				}
			}
			
			
			// LIGHTS
			
			solveCount = 0;
			blinkNum = 0;
			
			for (var n:int = 0; n < 4; n++) {
				if (checkList[n] == Logic["val" + n]) {
					Lights.turnOn(n,n);
					solveCount++;
					blinkNum++;
				} else {
					Lights.turnOff(n);
					solveCount--;
				}
			}
			
			if (Lights.lightsOnList[0].visible || Lights.lightsOnList[1].visible || Lights.lightsOnList[2].visible || Lights.lightsOnList[3].visible) {
				if (Screen.symbolsContainer4.numChildren > 0) {
					solveCount++;
					blinkNum++;
					Lights.turnOn(4,4);
				}
			} else {
				Lights.turnOff(4);
			}
			
			
			// PLAY BEEPS
			
			//Audio.playBeepSound(blinkNum);
			
			
			// CHECK FOR WIN
			
			if (solveCount == 5) {
				win();
			}
		}
		
		
		static function win() {
			
			// DISABLE BUTTONS AND SLIDER
			
			for each (var id in Buttons.buttonList) {
				id.alphaWhenDisabled = 1.0;
				id.enabled = false;
				id.removeEventListener(TouchEvent.TOUCH, Buttons.buttonHandler);
			}
			
			Slider.symbolsContainer.removeEventListener(TouchEvent.TOUCH, Slider.sliderHandler);
			Board.boardSprite.removeEventListener(Event.ENTER_FRAME, Slider.animateSlider);
			Buttons.infoButton.removeEventListener(TouchEvent.TOUCH, Buttons.infoHandler);
			
			
			// PLAY AUDIO
			
			Audio.playWinSound();
			
			
			// BLINK SYMBOLS
			
			blinkTimer.addEventListener(TimerEvent.TIMER, blink);
			blinkTimer.start();
		}
		
		
		static function blink(evt:TimerEvent) {
			
			blinkNum++;
			
			Screen.screenContainer.unflatten();
			if (Lights.lightsOnList[0].visible) {
				Symbols.symbolsContainer.visible = false;
				for (var i:int = 0; i < 5; i++) {
					Screen["symbolsContainer" + i].visible = false;
					Lights.turnOff(i);
				}
			} else {
				for (var j:int = 0; j < 5; j++) {
					Screen["symbolsContainer" + j].visible = true;
					Lights.turnOn(j, j);
				}
			}
			Screen.screenContainer.flatten();
			
			if (blinkNum > 12) {
				blinkTimer.stop();
				blinkTimer.reset();
				blinkTimer.removeEventListener(TimerEvent.TIMER, blink);
				
				var waitForScreen:int = setInterval(screenChange, 1750);
				function screenChange() {
					clearInterval(waitForScreen);
					
					Win.show();
				}
			}
		}
	}
}
