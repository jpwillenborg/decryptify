package {
	
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.utils.*;
	
	
	public class Audio {
		
		[Embed(source="../assets/audio/click.mp3")]
		static const ClickSound:Class;
		static var clickSound:Sound;
		static var clickChannel:SoundChannel;
		static var clickTransform:SoundTransform;
		
		[Embed(source="../assets/audio/win.mp3")]
		static const WinSound:Class;
		static var winSound:Sound;
		static var winChannel:SoundChannel;
		static var winTransform:SoundTransform;
		
		
		static function setup() {
			clickSound = new ClickSound();
			clickChannel = new SoundChannel();
			
			winSound = new WinSound();
			winChannel = new SoundChannel();
		}
		
		
		static function playClickSound() {
			clickChannel = clickSound.play();
		}
		
		
		static function playWinSound() {
			clickChannel.stop();
			winChannel = winSound.play();
		}
		
		
		/*static function playBeepSound(num:int) {
			
			clearInterval(beepInt);
			beepChannel.stop();
			
			if (num > 0) {
				clickUpChannel.stop();
				beepChannel = beepSound.play();
			}
			
			beepCount = 0;
			
			beepInt = setInterval(beep, 100);
			function beep() {
				beepCount++;
				
				if (beepCount < num) {
					beepChannel = beepSound.play();
				} else {
					clearInterval(beepInt);
				}
			}
		}*/
	}
}