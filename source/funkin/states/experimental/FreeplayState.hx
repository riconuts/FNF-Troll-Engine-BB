package funkin.states.experimental;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.ui.FlxButton.FlxTypedButton;

class FreeplayState extends MusicBeatState {

    /**
     * It’s basically taking all of the hard work of the actual game’s programmers and giving it the middle finger 
     * + watering down the gameplay experience. 
     * Also, it’s on psych, so engine possibilities are so much more limited. 
     * It’s basically normalizing playing a worse, fanmade version
     */

    public var grpCapsules:FlxTypedGroup<SongCapsule>;

    public var menuImage:FlxSprite;
    override function create(){
        super.create();
        var bg = new FlxSprite().loadGraphic('freeplay/cardBG');
        add(bg);

        var menuImage = new FlxSprite(1280).loadGraphic('freeplay/menu-dad');
        add(menuImage);
        menuImage.x-=menuImage.width;

        grpCapsules = new FlxTypedGroup<SongCapsule>();
        add(grpCapsules);

        for (i in 0...5) {
            var cap = new SongCapsule('wiener', 'wiener', 'wiener', 'wiener');
            grpCapsules.add(cap);
            cap.curIndex = i;
        }
    }
}