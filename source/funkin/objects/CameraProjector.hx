package funkin.objects;


import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import openfl.geom.Matrix;

class CameraProjector extends FlxSprite {

    public var projectingCamera:FlxCamera = FlxG.camera;
    private var transformMatrix = new Matrix();
    public var frameRate:Float = 24;
    public var resScale:FlxPoint = new FlxPoint(1,1);

    public function setResScale(x:Float, y:Float) {
        resScale.set(x, y);
        makeGraphic(Std.int(width/x), Std.int(height/y));
        scale.set(x,y);
        updateHitbox();
    }
    public function setCamera(camera:FlxCamera) {
        projectingCamera = camera;
        makeGraphic(camera.width,camera.height, FlxColor.BLACK);
    }

    private var frameTimer:Float = 0.000;
    
    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        if (frameTimer >= 1.0/frameRate) {
            frameTimer = 0;
        } else {
            frameTimer += elapsed;
            return;
        }
        if (projectingCamera != null) {
            transformMatrix = new Matrix();
            transformMatrix.scale(projectingCamera.scaleX / resScale.x, projectingCamera.scaleY / resScale.y);
            @:privateAccess
            pixels.draw(projectingCamera._scrollRect, transformMatrix);
        }
    }
}