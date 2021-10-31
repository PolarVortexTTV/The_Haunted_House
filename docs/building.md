﻿# Building Friday Night Funkin': Kade Engine

**Please note** that these instructions are for compiling/building the game. If you just want to play Kade Engine, **play in your browser or download a build instead**: **[play in browser](https://funkin.puyo.xyz) ⋅ [latest stable release](https://github.com/KadeDev/Kade-Engine/releases/latest) ⋅ [latest development build (windows)](https://ci.appveyor.com/project/KadeDev/kade-engine-windows/build/artifacts) ⋅ [latest development build (macOS)](https://ci.appveyor.com/project/daniel11420/kade-engine-macos/build/artifacts) ⋅ [latest development build (linux)](https://ci.appveyor.com/project/daniel11420/kade-engine-linux/build/artifacts)**. If you want to build the game yourself, continue reading.

**Also note**: you should be familiar with the commandline. If not, read this [quick guide by ninjamuffin](https://ninjamuffin99.newgrounds.com/news/post/1090480).

**Also also note**: To build for *Windows*, you need to be on *Windows*. To build for *Linux*, you need to be on *Linux*. Same goes for macOS. You can build for html5/browsers on any platform.

## Dependencies
 1. [Install Haxe 4.1.5](https://haxe.org/download/version/4.1.5/). You should use 4.1.5 instead of the latest version because the latest version has some problems with Friday Night Funkin': Kade Engine.
 2. After installing Haxe, [Install HaxeFlixel](https://haxeflixel.com/documentation/install-haxeflixel/).
 3. Install `git`.
	 - Windows: install from the [git-scm](https://git-scm.com/downloads) website.
	 - Linux: install the `git` package: `sudo apt install git` (ubuntu), `sudo pacman -S git` (arch), etc... (you probably already have it)
 4. Install and set up the necessary libraries:
	 - `haxelib install lime 7.9.0`
	 - `haxelib install openfl`
	 - `haxelib install flixel`
	 - `haxelib run lime setup`
	 - `haxelib run lime setup flixel`
	 - `haxelib install flixel-tools`
	 - `haxelib run flixel-tools setup`
	 - `haxelib install flixel-addons`
	 - `haxelib install flixel-ui`
	 - `haxelib install hscript`
	 - `haxelib install newgrounds`
	 - `haxelib git linc_luajit https://github.com/nebulazorua/linc_luajit.git`
	 - `haxelib git hxvm-luajit https://github.com/nebulazorua/hxvm-luajit`
	 - `haxelib git faxe https://github.com/uhrobots/faxe`
	 - `haxelib git polymod https://github.com/larsiusprime/polymod.git`
	 - `haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc`
	 - `haxelib install actuate`
	 - `haxelib git extension-webm https://github.com/KadeDev/extension-webm`
	 - `lime rebuild extension-webm <ie. windows, macos, linux>`

### Windows-only dependencies (only for building *to* Windows. Building html5 on Windows does not require this)
If you are planning to build for Windows, you also need to install **Visual Studio 2019**. While installing it, *don't click on any of the options to install workloads*. Instead, go to the **individual components** tab and choose the following:

-   MSVC v142 - VS 2019 C++ x64/x86 build tools
-   Windows SDK (10.0.17763.0)

This will install about 4 GB of crap, but is necessary to build for Windows.

### macOS-only dependencies (these are required for building on macOS at all, including html5.)
If you are running macOS, you'll need to install Xcode. You can download it from the macOS App Store or from the [Xcode website](https://developer.apple.com/xcode/).

If you get an error telling you that you need a newer macOS version, you need to download an older version of Xcode from the [More Software Downloads](https://developer.apple.com/download/more/) section of the Apple Developer website. (You can check which version of Xcode you need for your macOS version on [Wikipedia's comparison table (in the `min macOS to run` column)](https://en.wikipedia.org/wiki/Xcode#Version_comparison_table).)

## Cloning the repository
Since you already installed `git` in a previous step, we'll use it to clone the repository.
1. `cd` to where you want to store the source code (i.e. `C:\Users\username\Desktop` or `~/Desktop`)
2. `git clone https://github.com/KadeDev/Kade-Engine.git`
3. `cd` into the source code: `cd Kade-Engine`
4. (optional) If you want to build a specific version of Kade Engine, you can use `git checkout` to switch to it (i.e. `git checkout 1.4-KE`) (remember that versions 1.4 and older cannot build to Linux or HTML5)
- You should **not** do this if you are planning to contribute, as you should always be developing on the latest version.

## Building
Finally, we are ready to build.

- Run `lime build <target>`, replacing `<target>` with the platform you want to build to (`windows`, `mac`, `linux`, `html5`) (i.e. `lime build windows`)
- The build will be in `Kade-Engine/export/release/<target>/bin`, with `<target>` being the target you built to in the previous step. (i.e. `Kade-Engine/export/release/windows/bin`)
- Incase you added the -debug flag the files will be inside `Kade-Engine/export/debug/<target>/bin`
- Only the `bin` folder is necessary to run the game. The other ones in `export/release/<target>` are not.

## Troubleshooting
If you are experiencing one of the common problems below, you can use the provided steps to fix the issue.

### Type not found : StatePointer

If you experience this problem, you may see lines like 

```
source/LuaClass.hx:33: characters 46-58 : Type not found : StatePointer
```

This problem occurs when running an old version of the libraries that power the Lua-based modcharting system. These libraries were replaced in Kade Engine v1.7.

To fix this issue, run the following commands to reinstall the proper versions:

```
haxelib remove linc_luajit
haxelib remove hxvm-luajit
haxelib git linc_luajit https://github.com/nebulazorua/linc_luajit.git
haxelib git hxvm-luajit https://github.com/nebulazorua/hxvm-luajit
```
