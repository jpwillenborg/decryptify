package  {
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.utils.deg2rad;
	
	
	public class Symbols {
		
		static var symbolsContainer:Sprite;
		static var id:Image;
		static var hexColorList:Array = [0xD60100, 0xFF7415, 0xFFFF00, 0x31CD01, 0x0086E0];
		
		
		static function create() {
			var initList:Array = [];
			for (var i:int = 0; i < 10; i++) {
				initList[i] = Atlas.generate("symbol" + i);
			}
			initList.length = 0;
			initList = null;
		}
		
		
		static function place(contID:int, symID:int, colorID:int):void {
			
			Screen.screenContainer.unflatten();
			
			Data.saveObj.symbols[contID] = symID+1;
			
			symbolsContainer = Screen["symbolsContainer" + contID];
			
			while (symbolsContainer.numChildren > 0) {
				symbolsContainer.removeChildAt(0);
			}
			
			id = Atlas.generate("symbol" + symID);
			
			symbolsContainer.addChild(id);
			id.color = hexColorList[colorID];
			id.width = int(Scale.rectSprite.width*0.16927);
			id.height = id.width;
			
			Screen.screenContainer.flatten();
		}
	}	
}
