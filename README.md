# Swing Timer on Health Bar for FlareUI

An unofficial add-on for FlareUI that adds a swing timer to the place you are already looking: a small spark that travels across your own health bar and shows exactly when your next weapon swing will land.

_Not made by, or affiliated with, FlareUI's author._

## What it does

Melee classes hit automatically every few seconds, and the base game gives no sign of when the next hit is coming. Knowing that timing matters: many abilities are best used right after a swing, not right before one.

With this addon, a bright spark crosses the health bar of FlareUI's player frame during each main-hand swing:

- The spark starts at one end of the bar the moment you swing.
- It travels across the bar at the speed of your weapon.
- Your next swing lands as it reaches the other end, and it starts again.

It follows your real swing speed, so a faster weapon or a haste effect makes the spark cross faster. It works the same way as FlareUI's Five-Second Rule spark on the mana bar, so the two look and feel alike.

## Examples

- **Warrior:** use Slam, or queue Heroic Strike, right after the spark finishes instead of delaying your next hit.
- **Paladin:** watch the spark to judge and re-apply your seal between swings.
- **Any melee class with a slow two-handed weapon:** see how long you have before the next hit, so you know when you can step away and back without losing it.

## How it changes your play

- You gain a swing timer without adding another bar to your screen. FlareUI already offers swing timers as separate bars; this is for players who would rather not add more bars and want the information on the health bar they watch anyway.
- You time abilities around your swings by sight instead of by guesswork.
- Your screen stays clean: the spark only appears while you are swinging and disappears when you stop attacking.

## Details

- **Main hand only.** Off-hand and ranged swings are not shown.
- **Only on FlareUI's player frame.** It needs FlareUI's unit frames to be enabled.
- **Very light.** It only does work while a swing is in progress.

## Options

The on/off switch appears inside FlareUI's own settings window, under Unit Frames. You can also type `/flareswing`, or open the game's Options > AddOns.

## Install

1. Download the latest zip from this project's [Releases](https://github.com/ronborens/FlareUI_SwingSpark/releases).
2. Extract it into your game's `Interface/AddOns` folder, so that `FlareUI_SwingSpark` sits beside `FlareUI`.
3. Restart the game.

To run it straight from the source, clone this repository into `Interface/AddOns` as `FlareUI_SwingSpark`.

## Problems and ideas

Please open an [issue](https://github.com/ronborens/FlareUI_SwingSpark/issues) and say which FlareUI version you have.

## Requirements

- [FlareUI](https://www.curseforge.com/wow/addons/flareui) must be installed and enabled.

This is an unofficial extension. It is not made or endorsed by the FlareUI authors, so please report problems here and not to them. MIT licensed.
