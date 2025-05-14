package funkin.states.experimental;

import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.group.FlxSpriteGroup;

class SongCapsule extends FlxSpriteGroup {


    final capsuleScale:Float = 0.8;
    public var curIndex(default, set):Int = 0;

    public var capSprite:FlxSprite;

    public function set_curIndex(v:Int) {
        targetPos.set(intendedX(v), intendedY(v));
        curIndex = v;
        return v;
    }
    public var targetPos = new FlxPoint();
    public override function new(Song, DisplayName, Album, Difficulties) {
        super();


        capSprite = new FlxSprite(0,0);
        capSprite.frames = Paths.getSparrowAtlas('freeplay/freeplayCapsule');
        capSprite.animation.addByPrefix("selected", "mp3 capsule w backing SELECTED", 24, true);
		capSprite.animation.addByPrefix("deslected", "mp3 capsule w backing NOT SELECTED", 24, true);
		capSprite.origin.set(0, 0);
		capSprite.scale.set(capsuleScale, capsuleScale);
		capSprite.antialiasing = true;
        add(capSprite);

        capSprite.animation.play("deslected", true);
    }

    override function update(elapsed:Float):Void{
        x = FlxMath.lerp(x, targetPos.x, elapsed * 16);
        y = FlxMath.lerp(y, targetPos.y, elapsed * 16);

		super.update(elapsed);
	}

    public function intendedX(index:Int):Float {
		return (270 + (60 * (Math.sin(index+1)))) + 80;
	}

	public function intendedY(index:Int):Float {
		return (((index+1) * ((height * capsuleScale) + 10)) + 120) + 18 - (index < -1 ? 100 : 0);
	}
}