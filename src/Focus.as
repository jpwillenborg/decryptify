package  {
	
	import flash.desktop.NativeApplication;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.*;
	import starling.core.Starling;
	
	
	public class Focus {
		

		static function setup() {
			
			NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, onStageActive);
			NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE, onStageDeactivate);
			
			function onStageActive(evt:flash.events.Event):void {
				var delayInt:int = setInterval(delay, 500);
				function delay() {
					clearInterval(delayInt);
					
					Starling.current.start();				
				if (Data.saveObj.hasRated && !Data.saveObj.rateCheck) {
					Data.saveObj.rateCheck = true;
					Data.flushSave();
					Redux.rateRedux();
				}
				if (Hud.hudSprite) {
					Hud.unpauseHandler();
				}
				Audio.playBlank();
				}
			}
			
			function onStageDeactivate(evt:flash.events.Event):void {
				Starling.current.stop(true);
				if (Hud.hudSprite) {
					Hud.pauseHandler();
				}
			}
		}
	}
}
