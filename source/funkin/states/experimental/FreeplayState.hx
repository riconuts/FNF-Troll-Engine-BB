package funkin.states.experimental;

class FreeplayState extends MusicBeatState {
    public var menuImage:FlxSprite;
    override function create(){
        super.create();
        var bg = new FlxSprite().loadGraphic('freeplay/cardBG');
        add(bg);

        var menuImage = new FlxSprite(1280).loadGraphic('freeplay/menu-dad');
        add(menuImage);
        menuImage.x-=menuImage.width;
    }
}