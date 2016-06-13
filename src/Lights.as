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
	
	
	public class Lights {
		
		static var lightsOffList:Array = [];
		static var lightsOnList:Array = [];
		static var dotsList:Array = [];
		static var colorList:Array = ["red","orange","yellow","green","blue"];
		static var hexColorList:Array = [0xD60100, 0xFF7415, 0xFFFF00, 0x31CD01, 0x0086E0, 0x333333];
		static var lightsContainer:Sprite;
		
		
		static function create() {
			lightsContainer = new Sprite();
			Board.boardSprite.addChild(lightsContainer);
			
			for (var j:int = 0; j < 5; j++) {				
				dotsList[j] = Atlas.generate("dot");
				dotsList[j].smoothing = TextureSmoothing.BILINEAR;
				dotsList[j].color = hexColorList[5];
				dotsList[j].width = int(Scale.rectSprite.width/22);
				dotsList[j].height = dotsList[j].width;
				dotsList[j].visible = false;
				lightsContainer.addChild(dotsList[j]);
				
				lightsOffList[j] = Atlas.generate("light off");
				//buttonList[j].name = colorList[j];
				lightsOffList[j].smoothing = TextureSmoothing.BILINEAR;
				lightsOffList[j].width = int(Scale.rectSprite.width/12.8);
				lightsOffList[j].height = lightsOffList[j].width;
				lightsOffList[j].x = j * int(Scale.rectSprite.width*0.1875);
				lightsContainer.addChild(lightsOffList[j]);
				
				lightsOnList[j] = Atlas.generate("light on");
				//buttonList[j].name = colorList[j];
				lightsOnList[j].smoothing = TextureSmoothing.BILINEAR;
				lightsOnList[j].width = int(Scale.rectSprite.width/12.8);
				lightsOnList[j].height = lightsOnList[j].width;
				lightsOnList[j].x = j * int(Scale.rectSprite.width*0.1875);
				lightsOnList[j].visible = false;
				lightsContainer.addChild(lightsOnList[j]);
				
				dotsList[j].x = lightsOffList[j].x + (lightsOffList[j].width - dotsList[j].width)/2;
				dotsList[j].y = lightsOffList[j].y + (lightsOffList[j].height - dotsList[j].height)/2;
			}
			
			lightsContainer.x = int(Main.screenWidth/2 - lightsContainer.width/2);
			lightsContainer.y = int((Scale.rectSprite.height*0.375) + Scale.rectSprite.y);
		}
		
		
		static function turnOn(id:int, color:int) {
			dotsList[id].color = hexColorList[color];
			dotsList[id].visible = true;
			lightsOffList[id].visible = false;
			lightsOnList[id].visible = true;
			Data.saveObj.lights[id] = 1;
		}
		
		
		static function turnOff(id:int) {
			dotsList[id].visible = false;
			lightsOffList[id].visible = true;
			lightsOnList[id].visible = false;
			Data.saveObj.lights[id] = 0;
		}
	}
}
