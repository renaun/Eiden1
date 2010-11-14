/*
* Copyright 2010 (c) Renaun Erickson renaun.com
*
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without
* restriction, including without limitation the rights to use,
* copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the
* Software is furnished to do so, subject to the following
* conditions:
*
* The above copyright notice and this permission notice shall be
* included in all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
* OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
* HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
* OTHER DEALINGS IN THE SOFTWARE.
*/
package
{
	import com.kaigames.core.FrameBrain;
	import com.kaigames.core.ScreenUtils;
	import com.renaun.brains.BackgroundBrain;
	import com.renaun.brains.PeopleBrain;
	import com.renaun.embeds.EmbedArmLeft;
	import com.renaun.embeds.EmbedStars;
	
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Matrix;
	import flash.system.Capabilities;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	public class Eiden1 extends Sprite
	{
		
		public function Eiden1()
		{
			stage.frameRate = 30;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			if (Capabilities.screenDPI > 96)
				stage.addEventListener(Event.DEACTIVATE, deactivateHandler);
			
			frameBrain = new FrameBrain(stage, init);
		}
		
		protected var frameBrain:FrameBrain;
		protected var backgroundBrain:BackgroundBrain;
		protected var peopleBrain:PeopleBrain;
		protected var armLeft:Shape;
		protected var isStarted:Boolean = false;
		
		public function init():void
		{
			backgroundBrain = new BackgroundBrain();
			backgroundBrain.createChildren(stage);
			frameBrain.addExecutable(backgroundBrain);
			
			peopleBrain = new PeopleBrain();
			peopleBrain.createChildren(stage);
			
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
		}
		
		/**
		 * 	Mappings of the keycodes from 2 wiimotes on Android using
		 *  WiimoteController app/IME.
		 */
		private function keyDownHandler(event:KeyboardEvent):void
		{
			event.stopPropagation();
			if (event.keyCode == 37
				|| event.keyCode == 74) // Left
			{
				if (event.keyCode == 37)
					peopleBrain.guy1HDirection = -1;
				if (event.keyCode == 74)
					peopleBrain.guy2HDirection = -1;

				if (backgroundBrain.direction == 0)
				{
					backgroundBrain.direction += -0.075;
					peopleBrain.direction += -0.075;
				}
			}
			if (event.keyCode == 39
				|| event.keyCode == 79) // Right
			{
				if (event.keyCode == 39)
					peopleBrain.guy1HDirection = 1;
				if (event.keyCode == 79)
					peopleBrain.guy2HDirection = 1;
				
				if (backgroundBrain.direction == 0)
				{
					backgroundBrain.direction += 0.075;
					peopleBrain.direction += 0.075;
				}
			}
			if (event.keyCode == 38) // Up
				peopleBrain.guy1VDirection = -2;
			if (event.keyCode == 40) // Down
				peopleBrain.guy1VDirection = 2;
			if (event.keyCode == 73) // Up
				peopleBrain.guy2VDirection = -2;
			if (event.keyCode == 75) // Down
				peopleBrain.guy2VDirection = 2;
			if (event.keyCode == 49
				|| event.keyCode == 50) // Buttons 1&2 on Controller 1
			{
				peopleBrain.guy1Punch = true;
				// Don't add until ready to start guys coming
				if (!isStarted)
				{
					frameBrain.addExecutable(peopleBrain);
					isStarted = true;
				}
			}
			if (event.keyCode == 188
				|| event.keyCode == 190) // Buttons 1&2 on Controller 2
				peopleBrain.guy2Punch = true;
			//trace("Down: " + event.keyCode);
		}
		
		private function keyUpHandler(event:KeyboardEvent):void
		{
			event.stopPropagation();
			if (event.keyCode == 37
				|| event.keyCode == 74)
			{
				if (event.keyCode == 37)
					peopleBrain.guy1HDirection = 0;
				if (event.keyCode == 74)
					peopleBrain.guy2HDirection = 0;
				
				if (backgroundBrain.direction < 0)
				{
					backgroundBrain.direction += 0.075;
					peopleBrain.direction += 0.075;
				}
			}
			if (event.keyCode == 39
				|| event.keyCode == 79)
			{
				if (event.keyCode == 39)
					peopleBrain.guy1HDirection = 0;
				if (event.keyCode == 79)
					peopleBrain.guy2HDirection = 0;
				
				if (backgroundBrain.direction > 0)
				{
					backgroundBrain.direction += -0.075;
					peopleBrain.direction += -0.075;
				}
			}
			if (event.keyCode == 38
				|| event.keyCode == 40)
				peopleBrain.guy1VDirection = 0;
			
			if (event.keyCode == 73
				|| event.keyCode == 75)
				peopleBrain.guy2VDirection = 0;
		}
		
		protected function deactivateHandler(event:Event):void
		{
			// Decided to keep the app running
			//NativeApplication.nativeApplication.exit();
		}
		
	}
}