package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxBasic;
import flixel.group.FlxGroup;
import flixel.system.FlxSound;
import flixel.addons.effects.chainable.FlxWaveEffect;

class Stage
{
    public var curStage:String = '';
    public var halloweenLevel:Bool = false;
    public var camZoom:Float;
    public var hideLastBG:Bool = false; // True = hide last BG and show ones from slowBacks on certain step, False = Toggle Visibility of BGs from SlowBacks on certain step
    public var tweenDuration:Float = 2; // How long will it tween hiding/showing BGs, variable above must be set to True for tween to activate
    public var toAdd:Array<Dynamic> = []; // Add BGs on stage startup, load BG in by using "toAdd.push(bgVar);"
    // Layering algorithm for noobs: Everything loads by the method of "On Top", example: You load wall first(Every other added BG layers on it), then you load road(comes on top of wall and doesn't clip through it), then loading street lights(comes on top of wall and road)
    public var swagBacks:Map<String, Dynamic> = []; // Store BGs here to use them later in PlayState / with slowBacks / or to adjust position in stage position debug menu(press 8 while in PlayState)
    public var swagGroup:Map<String, FlxTypedGroup<Dynamic>> = []; //Store Groups
    public var animatedBacks:Array<FlxSprite> = []; // Store animated backgrounds and make them play animation(Animation must be named Idle!! Else use swagGroup)
    public var layInFront:Array<Array<FlxSprite>> = [[], [], []]; // BG layering, format: first [0] - in front of GF, second [1] - in front of opponent, third [2] - in front of boyfriend(and techincally also opponent since Haxe layering moment)
    public var slowBacks:Map<Int, Array<FlxSprite>> = []; // Change/add/remove backgrounds mid song! Format: "slowBacks[StepToBeActivated] = [Sprites,To,Be,Changed,Or,Added];"

    public function new(daStage:String)
    {
        this.curStage = daStage;
        camZoom = 1.05; // Don't change zoom here, unless you want to change zoom of every stage that doesn't have custom one
        halloweenLevel = false;

        switch(daStage)
        {
            case 'halloween':
					{
						halloweenLevel = true;

						var hallowTex = Paths.getSparrowAtlas('halloween_bg', 'week2');

						var halloweenBG = new FlxSprite(-200, -100);
						halloweenBG.frames = hallowTex;
						halloweenBG.animation.addByPrefix('idle', 'halloweem bg0');
						halloweenBG.animation.addByPrefix('lightning', 'halloweem bg lightning strike', 24, false);
						halloweenBG.animation.play('idle');
						halloweenBG.antialiasing = FlxG.save.data.antialiasing;
						swagBacks['halloweenBG'] = halloweenBG;
                        toAdd.push(halloweenBG);
					}
				case 'philly':
					{

						var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('philly/sky', 'week3'));
						bg.scrollFactor.set(0.1, 0.1);
						swagBacks['bg'] = bg;
                        toAdd.push(bg);

						var city:FlxSprite = new FlxSprite(-10).loadGraphic(Paths.image('philly/city', 'week3'));
						city.scrollFactor.set(0.3, 0.3);
						city.setGraphicSize(Std.int(city.width * 0.85));
						city.updateHitbox();
						swagBacks['city'] = city;
                        toAdd.push(city);

						var phillyCityLights = new FlxTypedGroup<FlxSprite>();
						if (FlxG.save.data.distractions)
						{
							swagGroup['phillyCityLights'] = phillyCityLights;
                            toAdd.push(phillyCityLights);
						}

						for (i in 0...5)
						{
							var light:FlxSprite = new FlxSprite(city.x).loadGraphic(Paths.image('philly/win' + i, 'week3'));
							light.scrollFactor.set(0.3, 0.3);
							light.visible = false;
							light.setGraphicSize(Std.int(light.width * 0.85));
							light.updateHitbox();
							light.antialiasing = FlxG.save.data.antialiasing;
							phillyCityLights.add(light);
						}

						var streetBehind:FlxSprite = new FlxSprite(-40, 50).loadGraphic(Paths.image('philly/behindTrain', 'week3'));
						swagBacks['streetBehind'] = streetBehind;
                        toAdd.push(streetBehind);

						var phillyTrain = new FlxSprite(2000, 360).loadGraphic(Paths.image('philly/train', 'week3'));
						if (FlxG.save.data.distractions)
						{
							swagBacks['phillyTrain'] = phillyTrain;
                            toAdd.push(phillyTrain);
						}

						PlayState.trainSound = new FlxSound().loadEmbedded(Paths.sound('train_passes', 'week3'));
						FlxG.sound.list.add(PlayState.trainSound);

						// var cityLights:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.win0.png);

						var street:FlxSprite = new FlxSprite(-40, streetBehind.y).loadGraphic(Paths.image('philly/street', 'week3'));
						swagBacks['street'] = street;
                        toAdd.push(street);
					}
				case 'limo':
					{
						camZoom = 0.90;

						var skyBG:FlxSprite = new FlxSprite(-120, -50).loadGraphic(Paths.image('limo/limoSunset', 'week4'));
						skyBG.scrollFactor.set(0.1, 0.1);
						skyBG.antialiasing = FlxG.save.data.antialiasing;
						swagBacks['skyBG'] = skyBG;
                        toAdd.push(skyBG);

						var bgLimo:FlxSprite = new FlxSprite(-200, 480);
						bgLimo.frames = Paths.getSparrowAtlas('limo/bgLimo', 'week4');
						bgLimo.animation.addByPrefix('drive', "background limo pink", 24);
						bgLimo.animation.play('drive');
						bgLimo.scrollFactor.set(0.4, 0.4);
						bgLimo.antialiasing = FlxG.save.data.antialiasing;
					    swagBacks['bgLimo'] = bgLimo;
                        toAdd.push(bgLimo);
                        
                        var fastCar:FlxSprite;
                        fastCar = new FlxSprite(-300, 160).loadGraphic(Paths.image('limo/fastCarLol', 'week4'));
						fastCar.antialiasing = FlxG.save.data.antialiasing;

						if (FlxG.save.data.distractions)
						{
							var grpLimoDancers = new FlxTypedGroup<BackgroundDancer>();
							swagGroup['grpLimoDancers'] = grpLimoDancers;
                            toAdd.push(grpLimoDancers);

							for (i in 0...5)
							{
								var dancer:BackgroundDancer = new BackgroundDancer((370 * i) + 130, bgLimo.y - 400);
								dancer.scrollFactor.set(0.4, 0.4);
								grpLimoDancers.add(dancer);
								swagBacks['dancer' + i] = dancer;
							}

                            swagBacks['fastCar'] = fastCar;
                            layInFront[2].push(fastCar);
						}

						var overlayShit:FlxSprite = new FlxSprite(-500, -600).loadGraphic(Paths.image('limo/limoOverlay', 'week4'));
						overlayShit.alpha = 0.5;
						// add(overlayShit);

						// var shaderBullshit = new BlendModeEffect(new OverlayShader(), FlxColor.RED);

						// FlxG.camera.setFilters([new ShaderFilter(cast shaderBullshit.shader)]);

						// overlayShit.shader = shaderBullshit;

						var limoTex = Paths.getSparrowAtlas('limo/limoDrive', 'week4');

						var limo = new FlxSprite(-120, 550);
						limo.frames = limoTex;
						limo.animation.addByPrefix('drive', "Limo stage", 24);
						limo.animation.play('drive');
						limo.antialiasing = FlxG.save.data.antialiasing;
						layInFront[0].push(limo);
                        swagBacks['limo'] = limo;

                        // Testing 
                        //
                        // hideLastBG = true;
                        // slowBacks[40] = [limo];
                        // slowBacks[120] = [limo, bgLimo, skyBG, fastCar];
					}
				case 'mall':
					{
						camZoom = 0.80;

						var bg:FlxSprite = new FlxSprite(-1000, -500).loadGraphic(Paths.image('christmas/bgWalls', 'week5'));
						bg.antialiasing = FlxG.save.data.antialiasing;
						bg.scrollFactor.set(0.2, 0.2);
						bg.active = false;
						bg.setGraphicSize(Std.int(bg.width * 0.8));
						bg.updateHitbox();
						swagBacks['bg'] = bg;
                        toAdd.push(bg);

						var upperBoppers = new FlxSprite(-240, -90);
						upperBoppers.frames = Paths.getSparrowAtlas('christmas/upperBop', 'week5');
						upperBoppers.animation.addByPrefix('idle', "Upper Crowd Bob", 24, false);
						upperBoppers.antialiasing = FlxG.save.data.antialiasing;
						upperBoppers.scrollFactor.set(0.33, 0.33);
						upperBoppers.setGraphicSize(Std.int(upperBoppers.width * 0.85));
						upperBoppers.updateHitbox();
						if (FlxG.save.data.distractions)
						{
							swagBacks['upperBoppers'] = upperBoppers;
                            toAdd.push(upperBoppers);
                            animatedBacks.push(upperBoppers);
						}

						var bgEscalator:FlxSprite = new FlxSprite(-1100, -600).loadGraphic(Paths.image('christmas/bgEscalator', 'week5'));
						bgEscalator.antialiasing = FlxG.save.data.antialiasing;
						bgEscalator.scrollFactor.set(0.3, 0.3);
						bgEscalator.active = false;
						bgEscalator.setGraphicSize(Std.int(bgEscalator.width * 0.9));
						bgEscalator.updateHitbox();
						swagBacks['bgEscalator'] = bgEscalator;
                        toAdd.push(bgEscalator);

						var tree:FlxSprite = new FlxSprite(370, -250).loadGraphic(Paths.image('christmas/christmasTree', 'week5'));
						tree.antialiasing = FlxG.save.data.antialiasing;
						tree.scrollFactor.set(0.40, 0.40);
						swagBacks['tree'] = tree;
                        toAdd.push(tree);

						var bottomBoppers = new FlxSprite(-300, 140);
						bottomBoppers.frames = Paths.getSparrowAtlas('christmas/bottomBop', 'week5');
						bottomBoppers.animation.addByPrefix('idle', 'Bottom Level Boppers', 24, false);
						bottomBoppers.antialiasing = FlxG.save.data.antialiasing;
						bottomBoppers.scrollFactor.set(0.9, 0.9);
						bottomBoppers.setGraphicSize(Std.int(bottomBoppers.width * 1));
						bottomBoppers.updateHitbox();
						if (FlxG.save.data.distractions)
						{
							swagBacks['bottomBoppers'] = bottomBoppers;
                            toAdd.push(bottomBoppers);
                            animatedBacks.push(bottomBoppers);
						}

						var fgSnow:FlxSprite = new FlxSprite(-600, 700).loadGraphic(Paths.image('christmas/fgSnow', 'week5'));
						fgSnow.active = false;
						fgSnow.antialiasing = FlxG.save.data.antialiasing;
						swagBacks['fgSnow'] = fgSnow;
                        toAdd.push(fgSnow);

						var santa = new FlxSprite(-840, 150);
						santa.frames = Paths.getSparrowAtlas('christmas/santa', 'week5');
						santa.animation.addByPrefix('idle', 'santa idle in fear', 24, false);
						santa.antialiasing = FlxG.save.data.antialiasing;
						if (FlxG.save.data.distractions)
						{
						    swagBacks['santa'] = santa;
                            toAdd.push(santa);
                            animatedBacks.push(santa);
						}
					}
				case 'mallEvil':
					{
						var bg:FlxSprite = new FlxSprite(-400, -500).loadGraphic(Paths.image('christmas/evilBG', 'week5'));
						bg.antialiasing = FlxG.save.data.antialiasing;
						bg.scrollFactor.set(0.2, 0.2);
						bg.active = false;
						bg.setGraphicSize(Std.int(bg.width * 0.8));
						bg.updateHitbox();
						swagBacks['bg'] = bg;
                        toAdd.push(bg);

						var evilTree:FlxSprite = new FlxSprite(300, -300).loadGraphic(Paths.image('christmas/evilTree', 'week5'));
						evilTree.antialiasing = FlxG.save.data.antialiasing;
						evilTree.scrollFactor.set(0.2, 0.2);
						swagBacks['evilTree'] = evilTree;
                        toAdd.push(evilTree);

						var evilSnow:FlxSprite = new FlxSprite(-200, 700).loadGraphic(Paths.image("christmas/evilSnow", 'week5'));
						evilSnow.antialiasing = FlxG.save.data.antialiasing;
						swagBacks['evilSnow'] = evilSnow;
                        toAdd.push(evilSnow);
					}
				case 'school':
					{
						// defaultCamZoom = 0.9;

						var bgSky = new FlxSprite().loadGraphic(Paths.image('weeb/weebSky', 'week6'));
						bgSky.scrollFactor.set(0.1, 0.1);
						swagBacks['bgSky'] = bgSky;
                        toAdd.push(bgSky);

						var repositionShit = -200;

						var bgSchool:FlxSprite = new FlxSprite(repositionShit, 0).loadGraphic(Paths.image('weeb/weebSchool', 'week6'));
						bgSchool.scrollFactor.set(0.6, 0.90);
						swagBacks['bgSchool'] = bgSchool;
                        toAdd.push(bgSchool);

						var bgStreet:FlxSprite = new FlxSprite(repositionShit).loadGraphic(Paths.image('weeb/weebStreet', 'week6'));
						bgStreet.scrollFactor.set(0.95, 0.95);
						swagBacks['bgStreet'] = bgStreet;
                        toAdd.push(bgStreet);

						var fgTrees:FlxSprite = new FlxSprite(repositionShit + 170, 130).loadGraphic(Paths.image('weeb/weebTreesBack', 'week6'));
						fgTrees.scrollFactor.set(0.9, 0.9);
						swagBacks['fgTrees'] = fgTrees;
                        toAdd.push(fgTrees);

						var bgTrees:FlxSprite = new FlxSprite(repositionShit - 380, -800);
						var treetex = Paths.getPackerAtlas('weeb/weebTrees', 'week6');
						bgTrees.frames = treetex;
						bgTrees.animation.add('treeLoop', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 12);
						bgTrees.animation.play('treeLoop');
						bgTrees.scrollFactor.set(0.85, 0.85);
						swagBacks['bgTrees'] = bgTrees;
                        toAdd.push(bgTrees);

						var treeLeaves:FlxSprite = new FlxSprite(repositionShit, -40);
						treeLeaves.frames = Paths.getSparrowAtlas('weeb/petals', 'week6');
						treeLeaves.animation.addByPrefix('leaves', 'PETALS ALL', 24, true);
						treeLeaves.animation.play('leaves');
						treeLeaves.scrollFactor.set(0.85, 0.85);
						swagBacks['treeLeaves'] = treeLeaves;
                        toAdd.push(treeLeaves);

						var widShit = Std.int(bgSky.width * 6);

						bgSky.setGraphicSize(widShit);
						bgSchool.setGraphicSize(widShit);
						bgStreet.setGraphicSize(widShit);
						bgTrees.setGraphicSize(Std.int(widShit * 1.4));
						fgTrees.setGraphicSize(Std.int(widShit * 0.8));
						treeLeaves.setGraphicSize(widShit);

						fgTrees.updateHitbox();
						bgSky.updateHitbox();
						bgSchool.updateHitbox();
						bgStreet.updateHitbox();
						bgTrees.updateHitbox();
						treeLeaves.updateHitbox();

						var bgGirls = new BackgroundGirls(-100, 190);
						bgGirls.scrollFactor.set(0.9, 0.9);

						if (PlayState.SONG.song.toLowerCase() == 'roses')
						{
							if (FlxG.save.data.distractions)
							{
								bgGirls.getScared();
							}
						}

						bgGirls.setGraphicSize(Std.int(bgGirls.width * PlayState.daPixelZoom));
						bgGirls.updateHitbox();
						if (FlxG.save.data.distractions)
						{
							swagBacks['bgGirls'] = bgGirls;
                            toAdd.push(bgGirls);
						}
					}
				case 'schoolEvil':
					{
						if (!PlayStateChangeables.Optimize)
						{
							var waveEffectBG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 3, 2);
							var waveEffectFG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 5, 2);
						}

						var posX = 400;
						var posY = 200;

						var bg:FlxSprite = new FlxSprite(posX, posY);
						bg.frames = Paths.getSparrowAtlas('weeb/animatedEvilSchool', 'week6');
						bg.animation.addByPrefix('idle', 'background 2', 24);
						bg.animation.play('idle');
						bg.scrollFactor.set(0.8, 0.9);
						bg.scale.set(6, 6);
						swagBacks['bg'] = bg;
                        toAdd.push(bg);

						/* 
							var bg:FlxSprite = new FlxSprite(posX, posY).loadGraphic(Paths.image('weeb/evilSchoolBG'));
							bg.scale.set(6, 6);
							// bg.setGraphicSize(Std.int(bg.width * 6));
							// bg.updateHitbox();
							add(bg);
							var fg:FlxSprite = new FlxSprite(posX, posY).loadGraphic(Paths.image('weeb/evilSchoolFG'));
							fg.scale.set(6, 6);
							// fg.setGraphicSize(Std.int(fg.width * 6));
							// fg.updateHitbox();
							add(fg);
							wiggleShit.effectType = WiggleEffectType.DREAMY;
							wiggleShit.waveAmplitude = 0.01;
							wiggleShit.waveFrequency = 60;
							wiggleShit.waveSpeed = 0.8;
						 */

						// bg.shader = wiggleShit.shader;
						// fg.shader = wiggleShit.shader;

						/* 
							var waveSprite = new FlxEffectSprite(bg, [waveEffectBG]);
							var waveSpriteFG = new FlxEffectSprite(fg, [waveEffectFG]);
							// Using scale since setGraphicSize() doesnt work???
							waveSprite.scale.set(6, 6);
							waveSpriteFG.scale.set(6, 6);
							waveSprite.setPosition(posX, posY);
							waveSpriteFG.setPosition(posX, posY);
							waveSprite.scrollFactor.set(0.7, 0.8);
							waveSpriteFG.scrollFactor.set(0.9, 0.8);
							// waveSprite.setGraphicSize(Std.int(waveSprite.width * 6));
							// waveSprite.updateHitbox();
							// waveSpriteFG.setGraphicSize(Std.int(fg.width * 6));
							// waveSpriteFG.updateHitbox();
							add(waveSprite);
							add(waveSpriteFG);
						 */
					}
				case 'mansion':
				{
					camZoom = 0.5;
					var bg:FlxSprite = new FlxSprite(-742, 46).loadGraphic(Paths.image('ghoul/Mansion', 'shared'));
					bg.antialiasing = FlxG.save.data.antialiasing;
					bg.scrollFactor.set(1, 1);
					bg.scale.set(2, 2);
					bg.active = false;
					swagBacks['bg'] = bg;
					toAdd.push(bg);

					var chandeller:FlxSprite = new FlxSprite(89, -516);
					chandeller.frames = Paths.getSparrowAtlas('ghoul/Chandeller');
					chandeller.animation.addByPrefix('idle', "Chandeller Swinging", 24);
					chandeller.animation.play('idle');
					chandeller.antialiasing = FlxG.save.data.antialiasing;
					chandeller.scrollFactor.set(0.9, 0.9);
					//chandeller.active = false;
					swagBacks['chandeller'] = chandeller;
					toAdd.push(chandeller);
				}
				case 'epsilon':
				{
					camZoom = 0.4;
					curStage = 'epsilon';

					var bg:FlxSprite = new FlxSprite(-1950, -1200).loadGraphic(Paths.image('epsilon/sky', 'week3'));
					bg.scale.set(0.9, 0.9);
					bg.scrollFactor.set(0.7, 0.7);
					toAdd.push(bg);

					var bgcity:FlxSprite = new FlxSprite(-850, -450).loadGraphic(Paths.image('epsilon/bgcity', 'week3'));
					bgcity.scrollFactor.set(0.75, 0.75);
					bgcity.setGraphicSize(Std.int(bgcity.width * 1));
					bgcity.scale.set(2.25, 2.25);
					bgcity.updateHitbox();
					bgcity.antialiasing = true;
					toAdd.push(bgcity);

					var city:FlxSprite = new FlxSprite(-1950, -1200).loadGraphic(Paths.image('epsilon/city', 'week3'));
					city.scrollFactor.set(1, 1);
					city.setGraphicSize(Std.int(city.width * 1));
					city.scale.set(0.9, 0.8);
					city.updateHitbox();
					city.antialiasing = true;
					toAdd.push(city);

					var streetBehind:FlxSprite = new FlxSprite(-40, 50).loadGraphic(Paths.image('epsilon/behindTrain', 'week3'));
					toAdd.push(streetBehind);

					var street:FlxSprite = new FlxSprite(-675, 600).loadGraphic(Paths.image('epsilon/street','week3'));
					street.scale.set(1, 1);
					toAdd.push(street);
				}
				case 'mansion-evil':
				{
					camZoom = 0.55;

					var wall:FlxSprite = new FlxSprite(-1228, -654).loadGraphic(Paths.image('ghoul/DaWall', 'shared'));
					wall.antialiasing = FlxG.save.data.antialiasing;
					wall.scrollFactor.set(1, 1);
					wall.scale.set(1.15, 1.15);
					wall.active = FlxG.save.data.agonyAnimations;
					swagBacks['wall'] = wall;
					toAdd.push(wall);
					
					var window1:FlxSprite = new FlxSprite(-1265, 244);
					window1.frames = Paths.getSparrowAtlas('ghoul/DaWindow1', 'shared');
					window1.animation.addByPrefix('idle', 'Window1', 24, true);
					window1.animation.play('idle', false, false, 1);
					window1.antialiasing = FlxG.save.data.antialiasing;
					window1.scrollFactor.set(1, 1);
					window1.scale.set(1.15, 1.15);
					window1.active = FlxG.save.data.agonyAnimations;
					swagBacks['window1'] = window1;
					toAdd.push(window1);

					var window2:FlxSprite = new FlxSprite(1934, 239);
					window2.frames = Paths.getSparrowAtlas('ghoul/DaWindow2', 'shared');
					window2.animation.addByPrefix('idle', 'Window 2', 24, true);
					window2.animation.play('idle', false, false, 1);
					window2.antialiasing = FlxG.save.data.antialiasing;
					window2.scrollFactor.set(1, 1);
					window2.scale.set(1.15, 1.15);
					window2.active = FlxG.save.data.agonyAnimations;
					swagBacks['window2'] = window2;
					toAdd.push(window2);

					var window3:FlxSprite = new FlxSprite(-845, -615);
					window3.frames = Paths.getSparrowAtlas('ghoul/DaWindow3', 'shared');
					window3.animation.addByPrefix('idle', 'Window 3', 24, true);
					window3.animation.play('idle', false, false, 1);
					window3.antialiasing = FlxG.save.data.antialiasing;
					window3.scrollFactor.set(1, 1);
					window3.scale.set(1.15, 1.15);
					window3.active = FlxG.save.data.agonyAnimations;
					swagBacks['window3'] = window3;
					toAdd.push(window3);

					var window4:FlxSprite = new FlxSprite(1969, -610);
					window4.frames = Paths.getSparrowAtlas('ghoul/DaWindow3', 'shared');
					window4.animation.addByPrefix('idle', 'Window 3', 24, true);
					window4.animation.play('idle', false, false, 1);
					window4.antialiasing = FlxG.save.data.antialiasing;
					window4.scrollFactor.set(1, 1);
					window4.scale.set(1.15, 1.15);
					window4.active = FlxG.save.data.agonyAnimations;
					swagBacks['window4'] = window4;
					toAdd.push(window4);

					var groundback:FlxSprite = new FlxSprite(-1420, 675);
					groundback.frames = Paths.getSparrowAtlas('ghoul/GroundBack', 'shared');
					groundback.animation.addByPrefix('idle', 'Ground1 instance ', 24, true);
					groundback.animation.play('idle', false, false, 1);
					groundback.antialiasing = FlxG.save.data.antialiasing;
					groundback.scrollFactor.set(1, 1);
					groundback.scale.set(1.15, 1.15);
					groundback.active = FlxG.save.data.agonyAnimations;
					swagBacks['groundback'] = groundback;
					toAdd.push(groundback);

					var staircase:FlxSprite = new FlxSprite(-1236, -184).loadGraphic(Paths.image('ghoul/Staircase', 'shared'));
					staircase.antialiasing = FlxG.save.data.antialiasing;
					staircase.scrollFactor.set(1, 1);
					staircase.scale.set(1.15, 1.15);
					staircase.active = FlxG.save.data.agonyAnimations;
					swagBacks['staircase'] = staircase;
					toAdd.push(staircase);

					var groundfront:FlxSprite = new FlxSprite(-820, 930);
					groundfront.frames = Paths.getSparrowAtlas('ghoul/GroundFront', 'shared');
					groundfront.animation.addByPrefix('idle', 'Ground2 instance ', 24, true);
					groundfront.animation.play('idle', false, false, 1);
					groundfront.antialiasing = FlxG.save.data.antialiasing;
					groundfront.scrollFactor.set(.9, .9);
					groundfront.scale.set(1.15, 1.15);
					groundfront.active = FlxG.save.data.agonyAnimations;
					swagBacks['groundfront'] = groundfront;
					toAdd.push(groundfront);

					var chandeller:FlxSprite = new FlxSprite(529, -567);
					chandeller.frames = Paths.getSparrowAtlas('ghoul/Chandeller', 'shared');
					chandeller.animation.addByPrefix('idle', "Chandeller Swinging", 24);
					chandeller.animation.play('idle');
					chandeller.antialiasing = FlxG.save.data.antialiasing;
					chandeller.scrollFactor.set(0.9, 0.9);
					chandeller.scale.set(1.25, 1.25);
					chandeller.active = FlxG.save.data.agonyAnimations;
					swagBacks['chandeller'] = chandeller;
					toAdd.push(chandeller);
				}
				case 'fireplace':
				{
					camZoom = 0.7; //0.7
					var bg:FlxSprite = new FlxSprite(-710, -377).loadGraphic(Paths.image('diablo/Stage2BG', 'shared'));
					bg.antialiasing = FlxG.save.data.antialiasing;
					bg.scrollFactor.set(0.9, 0.9);
					bg.active = false;
					swagBacks['bg'] = bg;
					toAdd.push(bg);

					var chimney:FlxSprite = new FlxSprite(403, -412);
					chimney.frames = Paths.getSparrowAtlas('diablo/Chimney', 'shared');
					chimney.animation.addByPrefix('idle', 'chimney', 24);
					chimney.animation.play('idle');
					chimney.antialiasing = FlxG.save.data.antialiasing;
					chimney.scrollFactor.set(0.9, 0.9);
					swagBacks['chimney'] = chimney;
					toAdd.push(chimney);

					var candletable:FlxSprite = new FlxSprite(1496, 497);
					candletable.frames = Paths.getSparrowAtlas('diablo/CandleTable', 'shared');
					candletable.animation.addByPrefix('idle', 'candle stand', 24);
					candletable.animation.play('idle');
					candletable.antialiasing = FlxG.save.data.antialiasing;
					candletable.scrollFactor.set(0.9, 0.9);
					swagBacks['candletable'] = candletable;
					toAdd.push(candletable);

					var candletable2:FlxSprite = new FlxSprite(-383, 514);
					candletable2.frames = Paths.getSparrowAtlas('diablo/CandleTable', 'shared');
					candletable2.animation.addByPrefix('idle', 'candle stand', 24);
					candletable2.animation.play('idle');
					candletable2.antialiasing = FlxG.save.data.antialiasing;
					candletable2.scrollFactor.set(0.9, 0.9);
					swagBacks['candletable2'] = candletable2;
					toAdd.push(candletable2);

					var chair:FlxSprite = new FlxSprite(1680, 497).loadGraphic(Paths.image('diablo/chair', 'shared'));
					chair.antialiasing = FlxG.save.data.antialiasing;
					chair.scrollFactor.set(0.85, 0.85);
					chair.active = false;
					swagBacks['chair'] = chair;
					toAdd.push(chair);

				}
				case 'soulpurgation':
				{
					camZoom = 0.6;
					var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('other/soulpurgation', 'shared'));
					bg.antialiasing = FlxG.save.data.antialiasing;
					bg.scale.set(2.5, 2.5);
					bg.scrollFactor.set(0.9, 0.9);
					bg.active = false;
					swagBacks['bg'] = bg;
					toAdd.push(bg);
				}
				case 'last-stand':
				{
					camZoom = 0.2;
					var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('other/obama/bluebg', 'shared'));
					bg.antialiasing = FlxG.save.data.antialiasing;
					bg.scrollFactor.set(0.6, 0.6);
					bg.scale.set(2, 2);
					bg.active = false;
					swagBacks['bg'] = bg;
					toAdd.push(bg);

					var bg2:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('other/obama/redfg', 'shared'));
					bg2.antialiasing = FlxG.save.data.antialiasing;
					bg2.scrollFactor.set(0.7, 0.7);
					bg2.scale.set(2, 2);
					bg2.active = false;
					swagBacks['bg2'] = bg2;
					toAdd.push(bg2);

					var rocks2:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('other/obama/rocks2', 'shared'));
					rocks2.antialiasing = FlxG.save.data.antialiasing;
					rocks2.scrollFactor.set(0.8, 0.8);
					rocks2.scale.set(2, 2);
					rocks2.active = false;
					swagBacks['rocks2'] = rocks2;
					toAdd.push(rocks2);

					var rocks1:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('other/obama/rocks1', 'shared'));
					rocks1.antialiasing = FlxG.save.data.antialiasing;
					rocks1.scrollFactor.set(0.9, 0.9);
					rocks1.scale.set(2, 2);
					rocks1.active = false;
					swagBacks['rocks1'] = rocks1;
					toAdd.push(rocks1);
				}
				case 'shadowboxing':
				{
					camZoom = 0.55;
					var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('other/shadowboxing', 'shared'));
					bg.antialiasing = FlxG.save.data.antialiasing;
					bg.scrollFactor.set(0.9, 0.9);
					bg.scale.set(1.5, 1.5);
					bg.active = false;
					swagBacks['bg'] = bg;
					toAdd.push(bg);
				}
				case 'battleground':
				{
					camZoom = 0.4;
					var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('other/geist', 'shared'));
					bg.antialiasing = FlxG.save.data.antialiasing;
					bg.scrollFactor.set(1, 1);
					bg.scale.set(3, 3);
					bg.active = false;
					swagBacks['bg'] = bg;
					toAdd.push(bg);
				}
				case 'ezrastand':
				{
					camZoom = 0.6;
					var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('other/ezraSTAGE', 'shared'));
					bg.antialiasing = FlxG.save.data.antialiasing;
					bg.scrollFactor.set(0.9, 0.9);
					bg.scale.set(1.5, 1.5);
					bg.active = false;
					swagBacks['bg'] = bg;
					toAdd.push(bg);
				}
				case 'attic':
				{
					camZoom = 0.9;
					var atticbg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('voodoo/Attic', 'shared'));
					atticbg.antialiasing = FlxG.save.data.antialiasing;
					atticbg.scrollFactor.set(0.9, 0.9);
					//atticbg.scale.set(1.5, 1.5);
					atticbg.active = false;
					swagBacks['atticbg'] = atticbg;
					toAdd.push(atticbg);
					
					var fuckingcat:FlxSprite = new FlxSprite(163, 141);
					fuckingcat.frames = Paths.getSparrowAtlas('voodoo/fucking cat', 'shared');
					fuckingcat.animation.addByPrefix('idle', '0w0', 24);
					fuckingcat.scrollFactor.set(0.9, 0.9);
					fuckingcat.animation.play('idle');
					fuckingcat.antialiasing = FlxG.save.data.antialiasing;
					//fuckingcat.scale.set(1.5, 1.5);
					swagBacks['fuckingcat'] = fuckingcat;
					toAdd.push(fuckingcat);

					var chair:FlxSprite = new FlxSprite(-404, 319);
					chair.frames = Paths.getSparrowAtlas('voodoo/The Chair', 'shared');
					chair.animation.addByPrefix('idle', 'Rocking Chair', 24);
					chair.scrollFactor.set(0.9, 0.9);
					chair.animation.play('idle');
					chair.antialiasing = FlxG.save.data.antialiasing;
					//chair.scale.set(1.5, 1.5);
					swagBacks['chair'] = chair;
					toAdd.push(chair);
				}
				case 'jesterstage':
				{
					camZoom = 0.8;
					var circus:FlxSprite = new FlxSprite(-600, -200);
					circus.frames = Paths.getSparrowAtlas('other/jester/Circus', 'shared');
					circus.animation.addByPrefix('idle', 'Symbol 32 instance 1');
					circus.animation.play('idle');
					circus.scale.set(1.2, 1.2);
					circus.scrollFactor.set(0.9, 0.9);
					circus.antialiasing = FlxG.save.data.antialiasing;
					swagBacks['circus'] = circus;
					toAdd.push(circus);

					var ghoul:FlxSprite = new FlxSprite(768, 751);
					ghoul.frames = Paths.getSparrowAtlas('other/jester/Bri ish Ghoul', 'shared');
					ghoul.animation.addByPrefix('idle', 'Ghoul Bop');
					ghoul.animation.play('idle');
					ghoul.scrollFactor.set(0.9, 0.9);
					ghoul.antialiasing = FlxG.save.data.antialiasing;
					swagBacks['ghoul'] = ghoul;
					toAdd.push(ghoul);

					var tiky:FlxSprite = new FlxSprite(1142, 562);
					tiky.frames = Paths.getSparrowAtlas('other/jester/Tiky', 'shared');
					tiky.animation.addByPrefix('idle', 'Tiky Bop');
					tiky.animation.play('idle');
					tiky.scrollFactor.set(0.9, 0.9);
					tiky.antialiasing = FlxG.save.data.antialiasing;
					swagBacks['tiky'] = tiky;
					toAdd.push(tiky);

					var hoodZekuta:FlxSprite = new FlxSprite(-567, 800);
					hoodZekuta.frames = Paths.getSparrowAtlas('other/jester/HoodandZekuta', 'shared');
					hoodZekuta.animation.addByPrefix('idle', 'BG Boppers instance 1');
					hoodZekuta.animation.play('idle');
					hoodZekuta.scrollFactor.set(0.9, 0.9);
					hoodZekuta.antialiasing = FlxG.save.data.antialiasing;
					swagBacks['hoodZekuta'] = hoodZekuta;
					toAdd.push(hoodZekuta);
				}
				default:
				{
					camZoom = 0.9;
					curStage = 'stage';
					var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback'));
					bg.antialiasing = FlxG.save.data.antialiasing;
					bg.scrollFactor.set(0.9, 0.9);
					bg.active = false;
					swagBacks['bg'] = bg;
					toAdd.push(bg);

					var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
					stageFront.updateHitbox();
					stageFront.antialiasing = FlxG.save.data.antialiasing;
					stageFront.scrollFactor.set(0.9, 0.9);
					stageFront.active = false;
					swagBacks['stageFront'] = stageFront;
					toAdd.push(stageFront);

					var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
					stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
					stageCurtains.updateHitbox();
					stageCurtains.antialiasing = FlxG.save.data.antialiasing;
					stageCurtains.scrollFactor.set(1.3, 1.3);
					stageCurtains.active = false;

					swagBacks['stageCurtains'] = stageCurtains;
					toAdd.push(stageCurtains);
				}
        }
    }
}