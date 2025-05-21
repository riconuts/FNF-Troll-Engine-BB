package funkin.objects.cutscenes;

import funkin.objects.IndependentVideoSprite;
class VideoCutscene extends Cutscene {
	var video:IndependentVideoSprite;
	var videoId:String = '';

	public override function createCutscene() {
		video = new IndependentVideoSprite(0, 0);
		video.bitmap.onEndReached.add(() -> {
			onEnd.dispatch(false);
		});
		
		video.bitmap.onFormatSetup.add(()-> { 
			video.setGraphicSize(FlxG.width, FlxG.height);
			video.cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
			video.screenCenter(XY);
		});
		
		onEnd.addOnce((wasSkipped:Bool) -> {
			video.stop();
			remove(video);
			video.destroy();
		});
		
		video.load(Paths.video(videoId));
		video.play();

		video.bitmap.rate = Math.min(4, FlxG.timeScale); // above 4x the audio cuts out so just cap it at 4x
		add(video);
	}

	override public function pause(){
		video.pause();
	}

	override public function resume() {
		video.resume();
		video.bitmap.time = video.bitmap.time; // trust
	}

	override public function restart(){
		video.stop();
		video.bitmap.time = 0;
		video.play();
	}

	public function new(videoId:String = ''){
		super();
		this.videoId = videoId;
	}

}