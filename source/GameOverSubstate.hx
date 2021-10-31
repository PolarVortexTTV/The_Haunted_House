package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class GameOverSubstate extends MusicBeatSubstate
{
	var bf:Boyfriend;
	var camFollow:FlxObject;
	var ghoulDeath:FlxSprite;

	var stageSuffix:String = "";

	public function new(x:Float, y:Float)
	{
		var daStage = PlayState.Stage.curStage;
		var daBf:String = '';
		switch (PlayState.boyfriend.curCharacter)
		{
			case 'gbw':
				daBf = 'bf';
			case 'bf-pixel':
				stageSuffix = '-pixel';
				daBf = 'bf-pixel-dead';
			default:
				daBf = 'bf';
		}

		super();

		Conductor.songPosition = 0;

		bf = new Boyfriend(x, y, daBf);
		add(bf);

		ghoulDeath = new FlxSprite(x, y);
		ghoulDeath.frames = Paths.getSparrowAtlas('ghoul_game_over', 'shared', true);
		ghoulDeath.animation.addByPrefix('firstDeath', 'ghoul firstded', 24, false);
		ghoulDeath.animation.addByPrefix('deathLoop', 'ghoul ded', 24, false);
		ghoulDeath.animation.addByPrefix('deathConfirm', 'ghoul live', 24, false);

		ghoulDeath.scale.set(1.5, 1.5);

		add(ghoulDeath);

		if(PlayState.boyfriend.curCharacter == 'gbw' || PlayState.boyfriend.curCharacter == 'soulfire')
		{
			ghoulDeath.visible = true;
			bf.visible = false;
			camFollow = new FlxObject(ghoulDeath.getGraphicMidpoint().x, ghoulDeath.getGraphicMidpoint().y, 1, 1);
		}
		else	
		{
			bf.visible = true;
			ghoulDeath.visible = false;
			camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y, 1, 1);
		}
		add(camFollow);

		FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix));
		Conductor.changeBPM(100);

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		ghoulDeath.animation.play('firstDeath', true);
		bf.playAnim('firstDeath');
	}

	var startVibin:Bool = false;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if(FlxG.save.data.InstantRespawn)
		{
			LoadingState.loadAndSwitchState(new PlayState());
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();

			if (PlayState.isStoryMode)
				FlxG.switchState(new StoryMenuState());
			else
				if(PlayState.isExtraMode)
					FlxG.switchState(new ExtraState());
				else
					FlxG.switchState(new FreeplayState());
			PlayState.loadRep = false;
			PlayState.stageTesting = false;
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.curFrame == 12)
		{
			FlxG.camera.follow(camFollow, LOCKON, 0.01);
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished)
		{
			FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix));
			startVibin = true;
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
	}

	override function beatHit()
	{
		super.beatHit();

		if (startVibin && !isEnding)
		{
			ghoulDeath.animation.play('deathLoop', true);
			bf.playAnim('deathLoop', true);
		}
		FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			PlayState.startTime = 0;
			isEnding = true;
			ghoulDeath.animation.play('deathConfirm', true);
			bf.playAnim('deathConfirm', true);
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix));
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			});
		}
	}
}
