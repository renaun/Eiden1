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
package com.renaun.vo
{
	import com.renaun.brains.PeopleBrain;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;

	public final class GuyVO extends AssetVO
	{
		public var arm:Shape;
		public var isPunching:Boolean = false;
		private var armYOffset:int = 81;
		private var armXOffset:int = 16;
		private var isFacingLeft:Boolean = false; // not implemented
		
		public override function createShape(bitmapData:BitmapData, bitmapMatrix:Matrix):void
		{
			bitmap = new Shape();
			bitmap.graphics.beginBitmapFill(bitmapData, bitmapMatrix, false, true);
			bitmap.graphics.drawRect(bitmapMatrix.tx, bitmapMatrix.ty, -bitmapMatrix.tx*2, -bitmapMatrix.ty);
			bitmap.graphics.endFill();
			bitmap.cacheAsBitmap = true;
			bitmap.cacheAsBitmapMatrix = AssetVO.cacheMatrix;
			isFacingLeft = (bitmapData != PeopleBrain.GUYLEFT1_BITMAPDATA);
			var otherBD:BitmapData = (isFacingLeft) ? PeopleBrain.LEFTARM_BITMAPDATA : PeopleBrain.RIGHTARM_BITMAPDATA;
			bitmapMatrix = (isFacingLeft) ? PeopleBrain.LEFTARM_MATRIX : AssetVO.cacheMatrix;
			arm = new Shape();
			arm.graphics.beginBitmapFill(otherBD, bitmapMatrix, false, true);
			if (isFacingLeft)
				arm.graphics.drawRect(-31, 0, 31, 57);
			else
				arm.graphics.drawRect(0, 0, 31, 57);
			arm.graphics.endFill();
			arm.cacheAsBitmap = true;
			arm.cacheAsBitmapMatrix = AssetVO.cacheMatrix;
		}
		
		private var frameCount:int = 0;
		public function animate(isPunch:Boolean):void
		{
			frameCount++;
			if (frameCount > 480)
				frameCount = 0;
			
			if (isPunch)
			{
				isPunching = true;
				arm.rotation += (isFacingLeft) ? -30 : 30;
				if (arm.rotation % 360 == 0)
				{
					arm.rotation = 0;
					isPunching = false;
				}
			}
		}
		
		public function setValues(x:int, y:int):void
		{
			bitmap.x = x;
			bitmap.y = y;
			arm.y = y - ((isFacingLeft) ? armYOffset+1 : armYOffset);
			arm.x = x + ((isFacingLeft) ? -armXOffset+2 : armXOffset);
		}
	}
}