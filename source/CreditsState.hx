package;

import flixel.input.gamepad.FlxGamepad;
import Controls.KeyboardScheme;
import flixel.FlxBasic;
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

using StringTools;

class CreditsState extends MusicBeatState
{
    public var messageField:FlxText;

    override function create()
    {
        clean();

        if (!FlxG.sound.music.playing)
        {
            FlxG.sound.playMusic(Paths.music('freakyMenu'));
        }

        messageField = new FlxText(0, 0, 0, "ALL OF THESE PEOPLE ARE AMAZING, GO CHECK THEM OUT!!", 12);
        messageField.autoSize = false;
        messageField.alignment = 'center';
        messageField.text = "-Artists-\nZekuta - Animation/Art\nPHO - Assisting Animation/Art\nZinn - Animator/Artist\n\n-Coding-\nPolar Vortex - this dude a legend\n\n-Music-\nJellyfish - Week 3 Final Song\nBenlab Crimson - Week 3 music/Extras\nSPM - Week 2 music/Extras\nEzra - Week 1 music/Extras\nYala-YTM - Mimus\nMusical Sleep - Cutscene music\n\n-Gameplay Testing-\nDryAgedSprite - Lead gameplay tester\nStonemas - Rythm Gamer input\n\n-Charting-\nBenlab - Week 3 music\nLadWithTheHat - <= this dude went crazy, check the dude out\n\n-Concepts-\nDane - concept arts for all Bgs\nDoornaud - concepts for voodoo doll\nPanda - Concepts\nDryAgedSprite - Concepts";
        messageField.x = (FlxG.width / 2) - 225;
        messageField.y = (FlxG.height / 2) - 225;
        
        add(messageField);

        super.create();
    }

    override function update(elapsed:Float)
    {
        if (controls.BACK || controls.ACCEPT)
        {
            FlxG.switchState(new MainMenuState());
        }
        

        super.update(elapsed);
    }
}