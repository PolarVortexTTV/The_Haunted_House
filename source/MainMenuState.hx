package;

import flixel.input.gamepad.FlxGamepad;
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;
import sys.FileSystem;
import sys.io.File;

#if desktop
import Discord.DiscordClient;
#end

using StringTools;

class MainMenuState extends MusicBeatState
{
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	#if !switch
	var optionShit:Array<String> = ['Story Mode', 'Freeplay', 'Extras', 'Options', 'Credits'];
	#else
	var optionShit:Array<String> = ['Story Mode', 'Freeplay'];
	#end

	var currentBGCOLOR:Int = 0;
	var bg:FlxSprite;

	var originalXPOS:Array<Float> = [0, 0, 0, 0, 0];
	var originalYPOS:Array<Float> = [0, 0, 0, 0, 0];

	var centerMenuIconsX:Float;
	var centerMenuIconsY:Float;
	var transition:FlxSprite;
	var iconTween:FlxTween;

	var newGaming:FlxText;
	var newGaming2:FlxText;
	public static var firstStart:Bool = true;

	public static var nightly:String = "";

	public static var kadeEngineVer:String = "1.7" + nightly;
	public static var gameVer:String = "0.2.7.1";

	var circleMenu:FlxSprite;
	var menuIcons:FlxSprite;
	var magenta:FlxSprite;
	var camFollow:FlxObject;
	public static var finishedFunnyMove:Bool = false;

	override function create()
	{
		clean();
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;

		bg = new FlxSprite(-100).loadGraphic(Paths.image('menuBG'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0; //was 0.10 but its nicer to just keep still and let its effect play out
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.scale.set(0.75,0.75);
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = FlxG.save.data.antialiasing;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0.10;
		magenta.setGraphicSize(Std.int(magenta.width * 1.1));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = FlxG.save.data.antialiasing;
		magenta.color = 0xFFfd719b;
		add(magenta);
		// magenta.scrollFactor.set();

		menuIcons = new FlxSprite(0);
		var iconsTex = Paths.getSparrowAtlas('Menu_Icons');
		menuIcons.frames = iconsTex;
		for(i in 0...optionShit.length)
		{
			menuIcons.animation.addByPrefix(optionShit[i], optionShit[i] + " MenuIcon", 24, false);
		}
		menuIcons.animation.play('Story Mode');
		menuIcons.updateHitbox();
		menuIcons.screenCenter();
		menuIcons.scale.set(0.65,0.65);
		menuIcons.visible = true;
		menuIcons.x -= 365;
		menuIcons.y -= 350;
		centerMenuIconsX = menuIcons.x;
		centerMenuIconsY = menuIcons.y;
		add(menuIcons);
		menuIcons.antialiasing = FlxG.save.data.antialiasing;

		circleMenu = new FlxSprite(0);
		var circleTex = Paths.getSparrowAtlas('Circle_Menu');
		circleMenu.frames = circleTex;
		for(i in 0...optionShit.length)
		{
			circleMenu.animation.addByPrefix(optionShit[i], "CircleMenu " + optionShit[i], 24, false);
		}
		circleMenu.animation.play('Story Mode');
		circleMenu.updateHitbox();
		circleMenu.screenCenter();
		circleMenu.scale.set(0.65,0.65);
		circleMenu.visible = true;
		circleMenu.x -= 365;
		circleMenu.y -= 350;
		add(circleMenu);
		circleMenu.antialiasing = FlxG.save.data.antialiasing;

		transition = new FlxSprite(0);
		var transFrames = Paths.getSparrowAtlas('Menu_Transition');
		transition.frames = transFrames;
		transition.animation.addByPrefix('load', "transition instance ", 24, false);
		transition.x = FlxG.width / 2;
		transition.y = FlxG.height / 2;
		transition.visible = true;
		add(transition);
		if(!finishedFunnyMove)
			transition.animation.play('load');

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var tex = Paths.getSparrowAtlas('HH_Main_Menu_Buttons');

		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(0, FlxG.height * 1.6);
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " Select", 24, false);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			//menuItem.screenCenter(X);
			menuItem.x = 45;
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = FlxG.save.data.antialiasing;

			switch(i)
			{
				case 0:
					menuItem.x += 50;
				case 1:
					menuItem.x += 10;
				case 2:
					menuItem.x += 0;
				case 3:
					menuItem.x += 10;
				case 4:
					menuItem.x += 50;
			}
			originalXPOS[i] = menuItem.x;
			menuItem.x = -800;

			menuItem.scale.set(0.60,0.60);

			if (firstStart)
			FlxTween.tween(menuItem,{x: originalXPOS[i]},1 + (i * 0.25) ,{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
			{ 
				finishedFunnyMove = true; 
				//originalXPOS[i] = menuItem.x;
				changeItem();
			}});
			else
				menuItem.x = originalXPOS[i];
			originalYPOS[i] = 50 + (i * 130);
		}

		firstStart = false;

		FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, gameVer +  (Main.watermarks ? " FNF - " + kadeEngineVer + " Kade Engine" : ""), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();


		if (FlxG.save.data.dfjk)
			controls.setKeyboardScheme(KeyboardScheme.Solo, true);
		else
			controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (!selectedSomethin)
		{
			var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

			if (gamepad != null)
			{
				if (gamepad.justPressed.DPAD_UP)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(-1);
				}
				if (gamepad.justPressed.DPAD_DOWN)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(1);
				}
			}

			if (FlxG.keys.justPressed.UP)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (FlxG.keys.justPressed.DOWN)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				FlxG.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));
					
					//if (FlxG.save.data.flashing)
					//	FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 1.3, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							if (FlxG.save.data.flashing)
							{
								FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
								{
									goToState();
								});
							}
							else
							{
								new FlxTimer().start(1, function(tmr:FlxTimer)
								{
									goToState();
								});
							}
						}
					});
			}
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			//spr.screenCenter(X);
		});
	}
	
	function goToState()
	{
		var daChoice:String = optionShit[curSelected];

		switch (daChoice)
		{
			case 'Story Mode':
				FlxG.switchState(new StoryMenuState());
				trace("Story Menu Selected");
			case 'Freeplay':
				FlxG.switchState(new FreeplayState());

				trace("Freeplay Menu Selected");
			case 'Extras':
				FlxG.switchState(new ExtraState());
				
				trace("Extra Menu Selected");
			case 'Options':
				FlxG.switchState(new OptionsMenu());
			case 'Credits':
				FlxG.switchState(new CreditsState());
				trace("Credits Menu Selected");
		}
	}

	function changeItem(huh:Int = 0)
	{
		if (finishedFunnyMove)
		{
			if(iconTween != null)
				iconTween.cancel();
			menuIcons.scale.set(0.55, 0.55);
			iconTween = FlxTween.tween(menuIcons.scale, {x: 0.65, y: 0.65}, 0.3, {type: FlxTweenType.PERSIST, ease: FlxEase.quadOut});

			curSelected += huh;

			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;

		}
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			
			if (spr.ID == curSelected && finishedFunnyMove)
			{
				spr.animation.play('selected');
				circleMenu.animation.play(optionShit[spr.ID]);
				menuIcons.animation.play(optionShit[spr.ID]);
				switch(spr.ID)
				{
					case 3:
						menuIcons.x = centerMenuIconsX - 35;
						menuIcons.y = centerMenuIconsY - 85;
					case 4:
						menuIcons.x = centerMenuIconsX - 15;
						menuIcons.y = centerMenuIconsY - 25;
					default:
						menuIcons.x = centerMenuIconsX;
						menuIcons.y = centerMenuIconsY;
				}
				//camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);

				spr.x = originalXPOS[spr.ID] - 20;
				spr.y = originalYPOS[spr.ID] - 15;
			}
			else
			{
				if(finishedFunnyMove)
					spr.x = originalXPOS[spr.ID];
					spr.y = originalYPOS[spr.ID];
			}

			spr.updateHitbox();

		});
	}
}
