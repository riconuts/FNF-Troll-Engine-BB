package funkin.states.editors;

import flixel.text.FlxText;
import flixel.util.FlxColor;

class StateLoaderState extends FlxState {
    override function create()
	{
        var bg:FlxSprite = new FlxSprite(0, 0, Paths.image('menuDesat'));
		bg.scrollFactor.set();
		bg.screenCenter();
		add(bg);

        var text:FlxText = new FlxText(20,20,0, '', 16);
        add(text);
        this.create();
    }

    override function update(e:Float) {
        super.update(e);
    }
}