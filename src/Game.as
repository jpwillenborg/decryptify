package {
	
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	
	
	public class Game extends Sprite {

		
		function Game() {
			addEventListener(Event.ADDED_TO_STAGE, start);
			function start(evt:Event):void {
				Environment.setup(stage);
				Info.setup();
				Board.setup(Environment.stageRef);
				Win.setup();
				
				if (!Data.saveObj.resume) {
					Info.infoSprite.visible = true;
					Board.boardSprite.visible = false;
					Win.winSprite.visible = false;
				} else {
					Info.infoSprite.visible = false;
					Board.boardSprite.visible = true;
					Win.winSprite.visible = false;
				}
				
				removeEventListener(Event.ADDED_TO_STAGE, start);
			}
		}
	}
}
