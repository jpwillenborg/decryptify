package  {
	
	import starling.animation.Transitions;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.Stage;
	
	
	public class Environment {
		
		[Embed(source="../assets/fonts/Font.otf", embedAsCFF="false", fontFamily="Font")]
		private static const GameFont:Class;
		public static var stageRef:Stage;
		static var invRatio:Number;
		
		
		static function setup(stage:Stage):void {
			
			// STAGE REF
			stageRef = stage;
			
			
			// SAVE FILE
			Data.setup();
			
			
			// TEXTURES
			Atlas.setup();
			
			
			// SCALE
			Scale.setup();
			
			
			// INIT AUDIO
			Audio.setup();
			
			
			// FOCUS
			/*if (CONFIG::AIR) {
				Focus.setup();
			}*/
			
			
			// TRANSITIONS
			
			Transitions.register("easeInQuad", registerEaseInQuad);
			Transitions.register("easeOutQuad", registerEaseOutQuad);
			
			function registerEaseInQuad(ratio:Number):Number {
				return ratio * ratio;
			}
			
			function registerEaseOutQuad(ratio:Number):Number {
				invRatio = ratio - 1.0;
				return 1 - (invRatio * invRatio);
			}
		}
	}
}
