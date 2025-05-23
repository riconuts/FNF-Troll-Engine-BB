package funkin.objects.hud;

import flixel.util.FlxStringUtil;
import flixel.util.FlxColor;
import flixel.text.FlxText;

class SignatureHUD extends CommonHUD {
    
    var scoreTxt:FlxText;
	var accuracyTxt:FlxText;
	var statsTxt:FlxText;

    public function new(iP1:String, iP2:String, songName:String, stats:Stats)
    {
        super(iP1, iP2, songName, stats);

        scoreTxt = new FlxText(healthBarBG.x + 32, healthBarBG.y + healthBarBG.height, healthBarBG.width - 32, "", 20);
		scoreTxt.setFormat(Paths.font("vcr.ttf"), 18, FlxColor.WHITE, RIGHT, OUTLINE, FlxColor.BLACK);
		scoreTxt.scrollFactor.set();
		scoreTxt.borderSize = 1;
		scoreTxt.antialiasing = true;

        add(healthBarBG);
        add(healthBar);
        add(iconP1);
		add(iconP2);

        add(scoreTxt);

        accuracyTxt = new FlxText(-8, 8, 1280, "100%", 32);
		accuracyTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT, OUTLINE, FlxColor.BLACK);
		accuracyTxt.scrollFactor.set();
		accuracyTxt.borderSize = 2;
		add(accuracyTxt);
		accuracyTxt.antialiasing = true;

        statsTxt = new FlxText(-8, accuracyTxt.y + accuracyTxt.height, 1280, "", 24);
		statsTxt.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, RIGHT, OUTLINE, FlxColor.BLACK);
		statsTxt.scrollFactor.set();
		statsTxt.borderSize = 2;
		add(statsTxt);
		statsTxt.antialiasing = true;
		updateHud();

		timeBarBG.makeGraphic(160, 12, 0xFF000000);
		timeBarBG.y = statsTxt.y + statsTxt.height;
		timeBarBG.x = FlxG.width - timeBarBG.width - 8;
		timeBar.barWidth = Std.int(timeBarBG.width - 4);
		timeBar.barHeight = Std.int(timeBarBG.height - 4);
		timeBar.x = timeBarBG.x + 2;
		timeBar.y = timeBarBG.y + 2;
		timeBar.createFilledBar(0xFF000000, 0xFFFFFFFF);
		timeTxt.x = timeBarBG.x + 4;
		timeTxt.y = timeBarBG.y - 1;
		timeTxt.width = 160;
		timeTxt.setFormat(Paths.font("vcr.ttf"), 12, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
		timeTxt.borderSize = 1;
    }

    var scoreString = Paths.getString("score");

	override function update(elapsed:Float){
		super.update(elapsed);
		updateHud();
	}

	override function changedOptions(changed:Array<String>)
	{
		healthBar.healthBarBG.y = FlxG.height * (ClientPrefs.downScroll ? 0.11 : 0.89);
		healthBar.y = healthBarBG.y + 5;
		healthBar.iconP1.y = healthBar.y + (healthBar.height - healthBar.iconP1.height) / 2;
		healthBar.iconP2.y = healthBar.y + (healthBar.height - healthBar.iconP2.height) / 2;
		healthBar.real_alpha = healthBar.real_alpha;

		botplayText.active = botplayText.visible = ClientPrefs.botplayMarker == 'Psych';
		useSubtleMark = ClientPrefs.botplayMarker == 'Subtle';

		updateTimeBarType();
	}

	override function updateTimeBarType()
	{
		// trace("time bar update", ClientPrefs.timeBarType); // the text size doesn't get updated sometimes idk why

		updateTime = (ClientPrefs.timeBarType != 'Disabled' && ClientPrefs.timeOpacity > 0);

		timeTxt.exists = updateTime;
		timeBarBG.exists = updateTime;
		timeBar.exists = updateTime;

		if (ClientPrefs.timeBarType == 'Song Name')
		{
			timeTxt.text = PlayState.SONG.song;
			timeTxt.offset.y = -3;
		}
		else
		{
			timeTxt.text = "";
			timeTxt.offset.y = 0;
		}
		updateTimeBarAlpha();
	}

	function updateHud() {
		var shownScore:Float = 0;
		if (ClientPrefs.showWifeScore)
			shownScore = Math.floor(stats.totalNotesHit * 100);
		else
			shownScore = stats.score;

		if (ClientPrefs.botplayMarker != 'Off' && PlayState.instance.cpuControlled)
			scoreTxt.text = 'Botplay Enabled';
		else
			scoreTxt.text = '$scoreString: ${FlxStringUtil.formatMoney(shownScore, false, true)}';

        accuracyTxt.text = '${Highscore.floorDecimal(ratingPercent * 100, 3)}%';
        statsTxt.text = 'Misses: ${stats.misses}\n${ratingFC} - ${grade}';
		AlignmentUtil.centerObjectInObject(timeTxt, timeBar, Y);
	}

    override function reloadHealthBarColors(dadColor:FlxColor, bfColor:FlxColor)
    {
        if (healthBar != null)
        {
            if (healthBar.isOpponentMode)
                healthBar.createFilledBar(bfColor, dadColor);
            else
                healthBar.createFilledBar(dadColor, bfColor);
            
            healthBar.updateBar();
        }
    }
}