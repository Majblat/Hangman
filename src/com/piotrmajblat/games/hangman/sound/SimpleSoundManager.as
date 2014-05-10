package com.piotrmajblat.games.hangman.sound
{
	import flash.media.Sound;
	import flash.net.URLRequest;

	public class SimpleSoundManager
	{
		private static var _soundsByIdMap:Object = {};

		public static function addSoundFromFile(soundId:String, filePath:String):void
		{
			var sound:Sound = new Sound();
			sound.load(new URLRequest(filePath));
			_soundsByIdMap[soundId] = sound;
		}

		public static function playSound(soundId:String):void
		{
			if (!_soundsByIdMap[soundId])
				throw new Error("Sound doesn't exist");

			Sound(_soundsByIdMap[soundId]).play();
		}
	}
}
