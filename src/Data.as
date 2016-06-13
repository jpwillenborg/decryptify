package {
	
	import flash.net.SharedObject;
	

	public class Data {
		
		static var mySave:SharedObject;
		static var saveObj:Object = {};
		
		
		static function setup() {
			mySave = SharedObject.getLocal("saveData");
			if (mySave.data.saveFile == undefined) {
				createSave();
			} else {
				restoreSave();
			}
		}
		
		
		static function createSave() {
			saveObj.resume = false;
			saveObj.winReset = false;
			saveObj.symbols = [-1,-1,-1,-1,-1];
			saveObj.lights = [0,0,0,0,0];
			saveObj.snapVal = 0;
			saveObj.currentSymbol = 0;
			saveObj.numWins = 0;
			flushSave();
		}
		
		
		static function restoreSave() {
			saveObj = mySave.data.saveFile;
			if (saveObj.winReset) {
				saveObj.resume = false;
				saveObj.winReset = false;
			} else {
				saveObj.resume = true;
			}
			
			flushSave();
		}
		
		
		static function flushSave() {
			mySave.data.saveFile = saveObj;
			mySave.flush();
		}
	}
}