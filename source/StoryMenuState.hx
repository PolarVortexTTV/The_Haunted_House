package;

import flixel.input.gamepad.FlxGamepad;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;

#if desktop
import Discord.DiscordClient;
#end

using StringTools;

class StoryMenuState extends MusicBeatState
{
	var scoreText:FlxText;

	static function weekData():Array<Dynamic>
	{
		return [
			['Resist', 'Sweep', 'Escape'],
			['Glimpse', 'Decay', 'Cursed'],
			['Wraith', 'Dismiss', 'Agony'],
		];
	}
	var curDifficulty:Int = 1;

	public static var weekUnlocked:Array<Bool> = [];

	var weekCharacters:Array<Dynamic> = [
		['voodoo', 'bf', 'gf'],
		['diablo', 'bf', 'gf'],
		['ghoul', 'bf', 'gf'],
	];

	var weekNames:Array<String> = CoolUtil.coolTextFile(Paths.txt('data/weekNames'));

	var txtWeekTitle:FlxText;

	var curWeek:Int = 0;

	var txtTracklist:FlxText;

	var grpWeekText:FlxTypedGroup<MenuItem>;
	var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;

	var grpLocks:FlxTypedGroup<FlxSprite>;

	var purpletoredBG:FlxSprite;
	var redtogreenBG:FlxSprite;
	var greentopurpleBG:FlxSprite;

	var overlay:FlxSprite;
	var difficultySheet:FlxSprite;
	var partDisplay:FlxSprite;
	var weirdArrowthings:FlxSprite;
	var thecoolart:FlxSprite;

	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;

	function unlockWeeks():Array<Bool>
	{
		var weeks:Array<Bool> = [];
		#if debug
		for(i in 0...weekNames.length)
			weeks.push(true);
		return weeks;
		#end
		
		weeks.push(true);

		for(i in 0...FlxG.save.data.weekUnlocked)
			{
				weeks.push(true);
			}
		return weeks;
	}

	override function create()
	{
		weekUnlocked = unlockWeeks();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Story Mode Menu", null);
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		if (FlxG.sound.music != null)
		{
			if (!FlxG.sound.music.playing)
			{
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
				Conductor.changeBPM(102);
			}
		}

		persistentUpdate = persistentDraw = true;

		/*scoreText = new FlxText(10, 10, 0, "SCORE: 49324858", 36);
		scoreText.setFormat("VCR OSD Mono", 32);*/

		/*txtWeekTitle = new FlxText(FlxG.width * 0.7, 10, 0, "", 32);
		txtWeekTitle.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT);
		txtWeekTitle.alpha = 0.7;*/

		/*var rankText:FlxText = new FlxText(0, 10);
		rankText.text = 'RANK: GREAT';
		rankText.setFormat(Paths.font("vcr.ttf"), 32);
		rankText.size = scoreText.size;
		rankText.screenCenter(X);*/

		grpWeekCharacters = new FlxTypedGroup<MenuCharacter>();

		trace("Line 70");

		trace("Line 96");

		trace("Line 124");

		trace("Line 150");

		//add(yellowBG);
		//add(grpWeekCharacters);

		/*txtTracklist = new FlxText(FlxG.width * 0.05, yellowBG.x + yellowBG.height + 100, 0, "Tracks", 32);
		txtTracklist.alignment = CENTER;
		txtTracklist.font = rankText.font;
		txtTracklist.color = 0xFFe55777;
		add(txtTracklist);
		// add(rankText);*/

		redtogreenBG = new FlxSprite(0, 0);
		redtogreenBG.frames = Paths.getSparrowAtlas('Story Menu BG Green', 'preload');
		redtogreenBG.animation.addByPrefix('toGreen', 'Story Mode BG to Green', 24, false);
		redtogreenBG.animation.addByPrefix('toRed', 'Story Mode BG to Red', 24, false);
		redtogreenBG.screenCenter();
		redtogreenBG.scale.set(0.7, 0.7);
		redtogreenBG.visible = false;

		greentopurpleBG = new FlxSprite(0, 0);
		greentopurpleBG.frames = Paths.getSparrowAtlas('Story Menu BG Purple', 'preload');
		greentopurpleBG.animation.addByPrefix('toPurple', 'Story Mode BG to Purple', 24, false);
		greentopurpleBG.animation.addByPrefix('toGreen', 'Story Mode BG to Green', 24, false);
		greentopurpleBG.screenCenter();
		greentopurpleBG.scale.set(0.7, 0.7);
		greentopurpleBG.visible = true;
		greentopurpleBG.animation.play('toPurple');

		purpletoredBG = new FlxSprite(0, 0);
		purpletoredBG.frames = Paths.getSparrowAtlas('Story Menu BG Red', 'preload');
		purpletoredBG.animation.addByPrefix('toRed', 'Story Mode BG to Red', 24, false);
		purpletoredBG.animation.addByPrefix('toPurple', 'Story Mode BG to Purple', 24, false);
		purpletoredBG.screenCenter();
		purpletoredBG.scale.set(0.7, 0.7);
		purpletoredBG.visible = false;

		thecoolart = new FlxSprite(0, 0);
		thecoolart.frames = Paths.getSparrowAtlas('Story Menu Card', 'preload');
		thecoolart.animation.addByPrefix('part1', 'Part 1 Card');
		thecoolart.animation.addByPrefix('part2', 'Part 2 Card');
		thecoolart.animation.addByPrefix('part3', 'Part 3 Card');
		thecoolart.animation.play('part1');
		thecoolart.screenCenter();
		thecoolart.y -= 100;
		thecoolart.scale.set(0.6, 0.6);

		overlay = new FlxSprite(0, 0).loadGraphic(Paths.image('Story Mode UI', 'preload'));
		overlay.screenCenter();
		overlay.setGraphicSize(Std.int(FlxG.width * 1.05), Std.int(FlxG.height * 1.05));

		weirdArrowthings = new FlxSprite(0, 0);
		weirdArrowthings.frames = Paths.getSparrowAtlas('Story Menu Arrows', 'preload');
		weirdArrowthings.animation.addByPrefix('idle', 'ZaArrows instance ');
		weirdArrowthings.animation.callback = function(name:String, frameNumber:Int, frameIndex:Int){
			if(weirdArrowthings.animation.finished)
				weirdArrowthings.animation.play('idle');
		};
		weirdArrowthings.animation.play('idle');
		weirdArrowthings.screenCenter();
		weirdArrowthings.x += 35;
		weirdArrowthings.y -= 35;
		weirdArrowthings.scale.set(0.65, 0.65);

		difficultySheet = new FlxSprite(0, 0);
		difficultySheet.frames = Paths.getSparrowAtlas('Story Menu Text', 'preload');
		difficultySheet.animation.addByPrefix('hard', 'Hard instance ');
		difficultySheet.animation.addByPrefix('easy', 'Easy instance ');
		difficultySheet.animation.addByPrefix('normal', 'Normal instance ');
		difficultySheet.animation.play('normal');
		difficultySheet.screenCenter();
		difficultySheet.x += 473;
		difficultySheet.y -= 294;
		difficultySheet.scale.set(0.65, 0.65);

		partDisplay = new FlxSprite(0, 0);
		partDisplay.frames = Paths.getSparrowAtlas('Story Menu Text', 'preload');
		partDisplay.animation.addByPrefix('week1', 'Part 1 instance ');
		partDisplay.animation.addByPrefix('week2', 'Part 2 instance ');
		partDisplay.animation.addByPrefix('week3', 'Part 3 instance ');
		partDisplay.animation.play('week1');
		partDisplay.screenCenter();
		partDisplay.x -= 425;
		partDisplay.y += 307;
		partDisplay.scale.set(0.6, 0.6);

		add(redtogreenBG);
		add(greentopurpleBG);
		add(purpletoredBG);

		add(thecoolart);
		add(overlay);
		add(weirdArrowthings);
		add(partDisplay);
		add(difficultySheet);

		//updateText();

		trace("Line 165");

		super.create();
	}

	override function update(elapsed:Float)
	{
		// scoreText.setFormat('VCR OSD Mono', 32);
		//lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.5));

		//scoreText.text = "WEEK SCORE:" + lerpScore;

		//txtWeekTitle.text = weekNames[curWeek].toUpperCase();
		//txtWeekTitle.x = FlxG.width - (txtWeekTitle.width + 10);

		// FlxG.watch.addQuick('font', scoreText.font);

		//difficultySelectors.visible = weekUnlocked[curWeek];

		if (!movedBack)
		{
			if (!selectedWeek)
			{
				var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

				if (gamepad != null)
				{
					if (gamepad.justPressed.DPAD_UP)
					{
						changeWeek(-1);
					}
					if (gamepad.justPressed.DPAD_DOWN)
					{
						changeWeek(1);
					}

					/*if (gamepad.pressed.DPAD_RIGHT)
						rightArrow.animation.play('press')
					else
						rightArrow.animation.play('idle');
					if (gamepad.pressed.DPAD_LEFT)
						leftArrow.animation.play('press');
					else
						leftArrow.animation.play('idle');
					*/
					if (gamepad.justPressed.DPAD_RIGHT)
					{
						changeDifficulty(1);
					}
					if (gamepad.justPressed.DPAD_LEFT)
					{
						changeDifficulty(-1);
					}
				}

				if (FlxG.keys.justPressed.UP)
				{
					changeWeek(-1);
				}

				if (FlxG.keys.justPressed.DOWN)
				{
					changeWeek(1);
				}

				/*if (controls.RIGHT)
					rightArrow.animation.play('press')
				else
					rightArrow.animation.play('idle');

				if (controls.LEFT)
					leftArrow.animation.play('press');
				else
					leftArrow.animation.play('idle');
				*/
				if (controls.RIGHT_P)
					changeDifficulty(1);
				if (controls.LEFT_P)
					changeDifficulty(-1);
			}

			if (controls.ACCEPT)
			{
				selectWeek();
			}
		}

		if (controls.BACK && !movedBack && !selectedWeek)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			movedBack = true;
			FlxG.switchState(new MainMenuState());
		}

		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

		super.update(elapsed);
	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	function selectWeek()
	{
		if (weekUnlocked[curWeek])
		{
			if (stopspamming == false)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				stopspamming = true;
			}

			PlayState.storyPlaylist = weekData()[curWeek];
			PlayState.isStoryMode = true;
			selectedWeek = true;
			PlayState.songMultiplier = 1;

			PlayState.storyDifficulty = curDifficulty;

			// adjusting the song name to be compatible
			var songFormat = StringTools.replace(PlayState.storyPlaylist[0], " ", "-");
			switch (songFormat) {
				case 'Dad-Battle': songFormat = 'Dadbattle';
				case 'Philly-Nice': songFormat = 'Philly';
			}

			var poop:String = Highscore.formatSong(songFormat, curDifficulty);
			PlayState.sicks = 0;
			PlayState.bads = 0;
			PlayState.shits = 0;
			PlayState.goods = 0;
			PlayState.campaignMisses = 0;
			PlayState.SONG = Song.conversionChecks(Song.loadFromJson(poop, PlayState.storyPlaylist[0]));
			PlayState.storyWeek = curWeek;
			PlayState.campaignScore = 0;
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState(), true);
			});
		}
	}

	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = 2;
		if (curDifficulty > 2)
			curDifficulty = 0;

		//sprDifficulty.offset.x = 0;
		FlxG.sound.play(Paths.sound('scrollMenu'));

		difficultySheet.screenCenter();
		difficultySheet.x += 473;
		difficultySheet.y -= 307;

		switch (curDifficulty)
		{
			case 0:
				difficultySheet.animation.play('easy');
				difficultySheet.scale.set(0.5, 0.5);
			case 1:
				difficultySheet.animation.play('normal');
				difficultySheet.scale.set(0.65, 0.65);
				difficultySheet.y += 13;
			case 2:
				difficultySheet.animation.play('hard');
				difficultySheet.scale.set(0.5, 0.5);
		}

		//sprDifficulty.alpha = 0;

		// USING THESE WEIRD VALUES SO THAT IT DOESNT FLOAT UP
		//sprDifficulty.y = leftArrow.y - 15;
		//intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);

		#if !switch
		//intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end

		//FlxTween.tween(sprDifficulty, {y: leftArrow.y + 15, alpha: 1}, 0.07);
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	function changeWeek(change:Int = 0):Void
	{
		var oldcurWeek:Int = curWeek;
		curWeek += change;

		if (curWeek >= weekData().length)
			curWeek = 0;
		if (curWeek < 0)
			curWeek = weekData().length - 1;

		var bullShit:Int = 0;


		switch(curWeek)
		{
			case 0: //voodoo
				switch(oldcurWeek)
				{
					case 1: //diablo
						redtogreenBG.visible = false;
						greentopurpleBG.visible = false;
						purpletoredBG.visible = true;

						purpletoredBG.animation.play('toPurple');
					case 2: //ghoul
						redtogreenBG.visible = false;
						greentopurpleBG.visible = true;
						purpletoredBG.visible = false;

						greentopurpleBG.animation.play('toPurple');
				}

				thecoolart.screenCenter();

				thecoolart.y -= 100;
			case 1: //diablo
				switch(oldcurWeek)
				{
					case 0: //voodoo
						redtogreenBG.visible = false;
						greentopurpleBG.visible = false;
						purpletoredBG.visible = true;

						purpletoredBG.animation.play('toRed');
					case 2: //ghoul
						redtogreenBG.visible = true;
						greentopurpleBG.visible = false;
						purpletoredBG.visible = false;

						redtogreenBG.animation.play('toRed');
				}
				thecoolart.screenCenter();
			case 2: //ghoul
				switch(oldcurWeek)
				{
					case 0: //voodoo
						redtogreenBG.visible = false;
						greentopurpleBG.visible = true;
						purpletoredBG.visible = false;

						greentopurpleBG.animation.play('toGreen');
					case 1: //diablo
						redtogreenBG.visible = true;
						greentopurpleBG.visible = false;
						purpletoredBG.visible = false;

						redtogreenBG.animation.play('toGreen');
				}
				
				thecoolart.screenCenter();

				thecoolart.x -= 180;
				thecoolart.y += 50;
			default:
				thecoolart.screenCenter();
		}

		thecoolart.animation.play('part' + (curWeek + 1));
		partDisplay.animation.play('week' + (curWeek + 1));

		FlxG.sound.play(Paths.sound('scrollMenu'));

		updateText();
	}

	function updateText()
	{
		/*grpWeekCharacters.members[0].setCharacter(weekCharacters[curWeek][0]);
		grpWeekCharacters.members[1].setCharacter(weekCharacters[curWeek][1]);
		grpWeekCharacters.members[2].setCharacter(weekCharacters[curWeek][2]);

		txtTracklist.text = "Tracks\n";
		var stringThing:Array<String> = weekData()[curWeek];

		for (i in stringThing)
			txtTracklist.text += "\n" + i;

		txtTracklist.text = txtTracklist.text.toUpperCase();

		txtTracklist.screenCenter(X);
		txtTracklist.x -= FlxG.width * 0.35;

		txtTracklist.text += "\n";

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end*/
	}

	public static function unlockNextWeek(week:Int):Void
	{
		if(week <= weekData().length - 1 && FlxG.save.data.weekUnlocked == week)
		{
			weekUnlocked.push(true);
			trace('Week ' + week + ' beat (Week ' + (week + 1) + ' unlocked)');
		}

		FlxG.save.data.weekUnlocked = weekUnlocked.length - 1;
		FlxG.save.flush();
	}

	override function beatHit()
	{
		super.beatHit();

		/*grpWeekCharacters.members[0].bopHead();
		grpWeekCharacters.members[1].bopHead();
		grpWeekCharacters.members[2].bopHead();*/
	}
}
