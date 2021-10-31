package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public var roarAnim:Character;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = FlxG.save.data.antialiasing;

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('GF_assets','shared',true);
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				loadOffsetFile(curCharacter);

				playAnim('danceRight');
			case 'gf-bw':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('gf-bw', 'shared', true);
				frames = tex;
				//animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				//animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				//animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				//animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				//animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				//animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				//animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				//animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				//animation.addByPrefix('scared', 'GF FEAR', 24);

				loadOffsetFile(curCharacter);

				playAnim('danceRight');

			case 'gf-christmas':
				tex = Paths.getSparrowAtlas('gfChristmas','shared',true);
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				loadOffsetFile(curCharacter);

				playAnim('danceRight');

			case 'gf-car':
				tex = Paths.getSparrowAtlas('gfCar','shared',true);
				frames = tex;
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);

				loadOffsetFile(curCharacter);

				playAnim('danceRight');

			case 'gf-pixel':
				tex = Paths.getSparrowAtlas('gfPixel','shared',true);
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				loadOffsetFile(curCharacter);

				playAnim('danceRight');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;

			case 'dad':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('DADDY_DEAREST','shared',true);
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24, false);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24, false);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'voodoo':
				tex = Paths.getSparrowAtlas('Voodoo_Doll', 'shared', true);
				frames = tex;
				animation.addByPrefix('idle', 'Voodoo Idle', 24, false);
				animation.addByPrefix('singUP', 'Voodoo Up', 24, false);
				animation.addByPrefix('singRIGHT', 'Voodoo Right', 24, false);
				animation.addByPrefix('singDOWN', 'Voodoo Down', 24, false);
				animation.addByPrefix('singLEFT', 'Voodoo Left', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'diablo':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('Diablo','shared',true);
				frames = tex;
				animation.addByPrefix('idle', 'Diablo Idle', 24, false);
				animation.addByPrefix('singUP', 'Diablo NOTE UP', 24, false);
				animation.addByPrefix('singRIGHT', 'Diablo NOTE RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'Diablo NOTE DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'Diablo NOTE LEFT', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'ezra':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('ezbruh_assets','shared',true);
				frames = tex;
				animation.addByPrefix('idle', 'ezra Idle', 24, false);
				animation.addByPrefix('singUP', 'ezra Up', 24, false);
				animation.addByPrefix('singRIGHT', 'ezra Right', 24, false);
				animation.addByPrefix('singDOWN', 'ezra Down', 24, false);
				animation.addByPrefix('singLEFT', 'ezra Left', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'battered':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('battered','shared',true);
				frames = tex;
				animation.addByPrefix('idle', 'Diablo Idle instance ', 24, false);
				animation.addByPrefix('singUP', 'Diablo Up instance ', 24, false);
				animation.addByPrefix('singRIGHT', 'Diablo Right instance ', 24, false);
				animation.addByPrefix('singDOWN', 'Diablo Down instance ', 24, false);
				animation.addByPrefix('singLEFT', 'Diablo Left instance ', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'ghoul':
				tex = Paths.getSparrowAtlas('Ghoul_Assets','shared',true);
				frames = tex;
				animation.addByPrefix('idle', 'Ghoul Idle Dance', 24, false);
				animation.addByPrefix('singUP', 'GHOUL NOTE UP', 24, false);
				animation.addByPrefix('singRIGHT', 'GHOUL NOTE RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'GHOUL NOTE DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'GHOUL NOTE LEFT', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'angryghoul':
				tex = Paths.getSparrowAtlas('Ghoul_Angy_Assets','shared',true);
				frames = tex;
				animation.addByPrefix('idle', 'Ghoul Pissed ALT Idle Dance', 24, false);
				animation.addByPrefix('singUP', 'GHOUL PISSED NOTE UP', 24, false);
				animation.addByPrefix('singRIGHT', 'GHOUL PISSED NOTE RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'GHOUL PISSED NOTE DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'GHOUL PISSED NOTE LEFT', 24, false);

				animation.addByPrefix('singUP-alt', 'GHOUL PISSED NOTE ALT UP', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'GHOUL PISSED NOTE ALT RIGHT', 24, false);
				animation.addByPrefix('singDOWN-alt', 'GHOUL PISSED NOTE ALT DOWN', 24, false);
				animation.addByPrefix('singLEFT-alt', 'GHOUL PISSED NOTE ALT LEFT', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'soulfire':
				tex = Paths.getSparrowAtlas('Ghoul_SoulFire','shared',true);
				frames = tex;
				animation.addByPrefix('idle', 'SoulFireGhoul Idle', 24, false);
				animation.addByPrefix('singUP', 'SoulFireGhoul UP', 24, false);
				animation.addByPrefix('singRIGHT', 'SoulFireGhoul RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'SoulFireGhoul DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'SoulFireGhoul LEFT', 24, false);

				//animation.addByPrefix('roar', 'SoulFireGhoul Roar', 24, false);

				roarAnim = new Character(100, 100, 'soulfire-roar');

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'soulfire-roar':
				tex = Paths.getSparrowAtlas('Da_Roar','shared',true);
				frames = tex;
				graphic.destroyOnNoUse = false;
				animation.addByPrefix('idle', 'SoulFireGhoul Roar', 24, false);
				addOffset('idle', 500, 800);
				//loadOffsetFile(curCharacter);
				//playAnim('idle');
			case 'susghoul':
				tex = Paths.getSparrowAtlas('GhoulHatesMogus_Assets', 'shared', true);

				animation.addByPrefix('idle', 'GHOULhatesmogus Idle Dance', 24, false);
				animation.addByPrefix('singUP', 'GHOULhatesmogus NOTE UP', 24, false);
				animation.addByPrefix('singLEFT', 'GHOULhatesmogus NOTE LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'GHOULhatesmogus NOTE RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'GHOULhatesmogus NOTE DOWN', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'spooky':
				tex = Paths.getSparrowAtlas('spooky_kids_assets','shared',true);
				frames = tex;
				animation.addByPrefix('singUP', 'spooky UP NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'spooky DOWN note', 24, false);
				animation.addByPrefix('singLEFT', 'note sing left', 24, false);
				animation.addByPrefix('singRIGHT', 'spooky sing right', 24, false);
				animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
				animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);

				loadOffsetFile(curCharacter);

				playAnim('danceRight');
			case 'mom':
				tex = Paths.getSparrowAtlas('Mom_Assets','shared',true);
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');

			case 'mom-car':
				tex = Paths.getSparrowAtlas('momCar','shared',true);
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);
				animation.addByIndices('idleHair', 'Mom Idle', [10, 11, 12, 13], "", 24, true);

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'monster':
				tex = Paths.getSparrowAtlas('Monster_Assets','shared',true);
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				loadOffsetFile(curCharacter);
				playAnim('idle');
			case 'monster-christmas':
				tex = Paths.getSparrowAtlas('monsterChristmas','shared',true);
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				loadOffsetFile(curCharacter);
				playAnim('idle');
			case 'pico':
				tex = Paths.getSparrowAtlas('Pico_FNF_assetss','shared',true);
				frames = tex;
				animation.addByPrefix('idle', "Pico Idle Dance", 24, false);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
				if (isPlayer)
				{
					animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico Note Right Miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico NOTE LEFT miss', 24, false);
				}
				else
				{
					// Need to be flipped! REDO THIS LATER!
					animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico NOTE LEFT miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico Note Right Miss', 24, false);
				}

				animation.addByPrefix('singUPmiss', 'pico Up note miss', 24);
				animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24);

				loadOffsetFile(curCharacter);

				playAnim('idle');

				flipX = true;

			case 'bf':
				var tex = Paths.getSparrowAtlas('BOYFRIEND','shared',true);
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('singSPACE', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singSPACEmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, false);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				loadOffsetFile(curCharacter);

				playAnim('idle');

				flipX = true;

			case 'bf-christmas':
				var tex = Paths.getSparrowAtlas('bfChristmas','shared',true);
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');

				flipX = true;
			case 'bf-car':
				var tex = Paths.getSparrowAtlas('bfCar','shared',true);
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByIndices('idleHair', 'BF idle dance', [10, 11, 12, 13], "", 24, true);

				loadOffsetFile(curCharacter);
				playAnim('idle');

				flipX = true;
			case 'bf-pixel':
				frames = Paths.getSparrowAtlas('bfPixel','shared',true);
				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				loadOffsetFile(curCharacter);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;
			case 'bf-pixel-dead':
				frames = Paths.getSparrowAtlas('bfPixelsDEAD','shared',true);
				animation.addByPrefix('singUP', "BF Dies pixel", 24, false);
				animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
				animation.addByPrefix('deathLoop', "Retry Loop", 24, false);
				animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);
				animation.play('firstDeath');

				loadOffsetFile(curCharacter);
				playAnim('firstDeath');
				// pixel bullshit
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				antialiasing = false;
				flipX = true;

			case 'senpai':
				frames = Paths.getSparrowAtlas('senpai','shared',true);
				animation.addByPrefix('idle', 'Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'SENPAI UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'SENPAI LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'SENPAI RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'SENPAI DOWN NOTE', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;
			case 'senpai-angry':
				frames = Paths.getSparrowAtlas('senpai','shared',true);
				animation.addByPrefix('idle', 'Angry Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'Angry Senpai UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'Angry Senpai LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'Angry Senpai RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'Angry Senpai DOWN NOTE', 24, false);

				loadOffsetFile(curCharacter);
				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'spirit':
				frames = Paths.getPackerAtlas('spirit','shared',true);
				animation.addByPrefix('idle', "idle spirit_", 24, false);
				animation.addByPrefix('singUP', "up_", 24, false);
				animation.addByPrefix('singRIGHT', "right_", 24, false);
				animation.addByPrefix('singLEFT', "left_", 24, false);
				animation.addByPrefix('singDOWN', "spirit down_", 24, false);

				loadOffsetFile(curCharacter);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				antialiasing = false;

			case 'parents-christmas':
				frames = Paths.getSparrowAtlas('mom_dad_christmas_assets','shared',true);
				animation.addByPrefix('idle', 'Parent Christmas Idle', 24, false);
				animation.addByPrefix('singUP', 'Parent Up Note Dad', 24, false);
				animation.addByPrefix('singDOWN', 'Parent Down Note Dad', 24, false);
				animation.addByPrefix('singLEFT', 'Parent Left Note Dad', 24, false);
				animation.addByPrefix('singRIGHT', 'Parent Right Note Dad', 24, false);

				animation.addByPrefix('singUP-alt', 'Parent Up Note Mom', 24, false);

				animation.addByPrefix('singDOWN-alt', 'Parent Down Note Mom', 24, false);
				animation.addByPrefix('singLEFT-alt', 'Parent Left Note Mom', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'Parent Right Note Mom', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'epsilon':
				frames = Paths.getSparrowAtlas('epsilon', 'shared', true);
				animation.addByPrefix('idle', 'Epsilon Idle', 24, false);
				animation.addByPrefix('singUP', 'Epsilon Up', 24, false);
				animation.addByPrefix('singDOWN', 'Epsilon Down', 24, false);
				animation.addByPrefix('singLEFT', 'Epsilon Left', 24, false);
				animation.addByPrefix('singRIGHT', 'Epsilon Right', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'gbw':
				frames = Paths.getSparrowAtlas('ghoul_bw', 'shared', true);
				animation.addByPrefix('idle', 'SoulFireGhoul Idle', 24, false);
				animation.addByPrefix('singUP', 'SoulFireGhoul UP', 24, false);
				animation.addByPrefix('singRIGHT', 'SoulFireGhoul RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'SoulFireGhoul DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'SoulFireGhoul LEFT', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'matt':
				frames = Paths.getSparrowAtlas('Diablo_Matt', 'shared', true);

				animation.addByPrefix('idle', 'Matt Diablo Idle', 24, false);
				animation.addByPrefix('singUP', 'Matt Diablo Up', 24, false);
				animation.addByPrefix('singRIGHT', 'Matt Diablo Right', 24, false);
				animation.addByPrefix('singDOWN', 'Matt Diablo Down', 24, false);
				animation.addByPrefix('singLEFT', 'Matt Diablo Left', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'sonic':
				frames = Paths.getSparrowAtlas('SonicAssets', 'shared', true);

				animation.addByPrefix('idle', 'SONICmoveIDLE', 24, false);
				animation.addByPrefix('singUP', 'SONICmoveUP', 24, false);
				animation.addByPrefix('singRIGHT', 'SONICmoveRIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'SONICmoveDOWN', 24, false);
				animation.addByPrefix('singLEFT', 'SONICmoveLEFT', 24, false);

				animation.addByPrefix('singDOWN-alt', 'SONIClaugh', 24, false);
				
				animation.addByPrefix('singLAUGH', 'SONIClaugh', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'jester':
				frames = Paths.getSparrowAtlas('jester', 'shared', true); //not finished yet

				animation.addByPrefix('idle', 'Jester Idle', 24, false);
				animation.addByPrefix('singUP', 'Jester Up', 24, false);
				animation.addByPrefix('singRIGHT', 'Jester Right', 24, false);
				animation.addByPrefix('singDOWN', 'Jester Down', 24, false);
				animation.addByPrefix('singLEFT', 'Jester Left', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'obama':
				frames = Paths.getSparrowAtlas('Obama_Boss', 'shared', true); //not finished yet

				animation.addByPrefix('idle', 'Obama Idle', 24, false);
				animation.addByPrefix('singUP', 'Obama Up', 24, false);
				animation.addByPrefix('singRIGHT', 'Obama Right', 24, false);
				animation.addByPrefix('singDOWN', 'Obama Down', 24, false);
				animation.addByPrefix('singLEFT', 'Obama Left', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');

		}

		dance();

		if (isPlayer && frames != null)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	public function loadOffsetFile(character:String, library:String = 'shared')
	{
		var offset:Array<String> = CoolUtil.coolTextFile(Paths.txt('images/characters/' + character + "Offsets", library));

		for (i in 0...offset.length)
		{
			var data:Array<String> = offset[i].split(' ');
			addOffset(data[0], Std.parseInt(data[1]), Std.parseInt(data[2]));
		}
	}

	public function addRoarAnim()
	{
		PlayState.staticVar.add(roarAnim);
		roarAnim.visible = false;
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			if (curCharacter.endsWith('-car') && !animation.curAnim.name.startsWith('sing') && animation.curAnim.finished && animation.getByName('idleHair') != null)
				playAnim('idleHair');

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			else if (curCharacter == 'gf')
				dadVar = 4.1; //fix double dances
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				if (curCharacter == 'gf')
					playAnim('danceLeft'); //overridden by dance correctly later
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
				{
					danced = true;
					playAnim('danceRight');
				}
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance(forced:Bool = false, altAnim:Bool = false)
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf' | 'gf-christmas' | 'gf-car' | 'gf-pixel':
					if (!animation.curAnim.name.startsWith('hair') && !animation.curAnim.name.startsWith('sing'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				case 'soulfire':
					if(!PlayState.eventExecution)
					{
						if (altAnim && animation.getByName('idle-alt') != null)
							playAnim('idle-alt', forced);
						else
							playAnim('idle', forced);
					}
				default:
					if (altAnim && animation.getByName('idle-alt') != null)
						playAnim('idle-alt', forced);
					else
						playAnim('idle', forced);
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{

		if (AnimName.endsWith('alt') && animation.getByName(AnimName) == null)
		{
			#if debug
			FlxG.log.warn(['Such alt animation doesnt exist: ' + AnimName]);
			#end
			AnimName = AnimName.split('-')[0];
		}
		
		if(roarAnim != null && PlayState.dad != null && PlayState.generatedMusic)
		{
			visible = false;

			roarAnim.visible = false;
			roarAnim.x = x;
			roarAnim.y = y;

			trace('we did it!!!!!');

			switch(AnimName)
			{
				case 'roar':
					trace('we did it AGAIN!!!!!');
					roarAnim.visible = true;
					roarAnim.playAnim('idle', true, Reversed, Frame);
				default:
					visible = true;
					//roarAnim.visible = false;

					animation.play(AnimName, Force, Reversed, Frame);

					var daOffset = animOffsets.get(AnimName);
					if (animOffsets.exists(AnimName))
						offset.set(daOffset[0], daOffset[1]);
					else
						offset.set(0, 0);
			}
		}
		else
		{
			animation.play(AnimName, Force, Reversed, Frame);

			var daOffset = animOffsets.get(AnimName);
			if (animOffsets.exists(AnimName))
			{
				offset.set(daOffset[0], daOffset[1]);
			}
			else
				offset.set(0, 0);
			
			if (curCharacter == 'gf')
			{
				if (AnimName == 'singLEFT')
				{
					danced = true;
				}
				else if (AnimName == 'singRIGHT')
				{
					danced = false;
				}
	
				if (AnimName == 'singUP' || AnimName == 'singDOWN')
				{
					danced = !danced;
				}
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
