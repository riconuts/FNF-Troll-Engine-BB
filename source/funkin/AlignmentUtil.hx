package funkin;

import flixel.FlxG;
import flixel.util.FlxAxes;
import lime.math.Rectangle;
import flixel.FlxObject;


// Used to stop alignment headaches!
class AlignmentUtil {
    public static function centerObjectRectPercentage(obj:FlxObject, rect:Rectangle, axes:FlxAxes) {
        if (axes == X || axes == XY)
            obj.x = (FlxG.width * rect.x) + (((FlxG.width * rect.width) - obj.width) / 2);
        if (axes == Y || axes == XY)
            obj.y = (FlxG.width * rect.y) + (((FlxG.height * rect.height) - obj.height) / 2);
    }
    
    public static function centerObjectInRect(obj:FlxObject, rect:Rectangle, axes:FlxAxes) {
        if (axes == X || axes == XY)
            obj.x = (rect.x) + ((rect.width - obj.width) / 2);
        if (axes == Y || axes == XY)
            obj.y = (rect.y) + ((rect.height - obj.height) / 2);
    }
    public static function centerObjectInObject(obj:FlxObject, obj2:FlxObject, axes:FlxAxes) {
        if (axes == X || axes == XY)
            obj.x = (obj2.x) + ((obj2.width - obj.width) / 2);
        if (axes == Y || axes == XY)
            obj.y = (obj2.y) + ((obj2.height - obj.height) / 2);
    }
}