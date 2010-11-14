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

	public final class EnemyVO extends AssetVO
	{
		public var bitmap2:Shape;
		public var bitmap3:Shape;
		public var isHit:Boolean = false;
		
		public override function createShape(bitmapData:BitmapData, bitmapMatrix:Matrix):void
		{
			bitmap = new Shape();
			bitmap.graphics.beginBitmapFill(bitmapData, bitmapMatrix, false, true);
			bitmap.graphics.drawRect(bitmapMatrix.tx, bitmapMatrix.ty, -bitmapMatrix.tx*2, -bitmapMatrix.ty);
			bitmap.graphics.endFill();
			bitmap.cacheAsBitmap = true;
			bitmap.cacheAsBitmapMatrix = AssetVO.cacheMatrix;
			var otherBD:BitmapData = (bitmapData == PeopleBrain.ENEMYLEFT_BITMAPDATA) ? PeopleBrain.ENEMYLEFT2_BITMAPDATA : PeopleBrain.ENEMYRIGHT2_BITMAPDATA;
			bitmap2 = new Shape();
			bitmap2.graphics.beginBitmapFill(otherBD, bitmapMatrix, false, true);
			bitmap2.graphics.drawRect(bitmapMatrix.tx, bitmapMatrix.ty, -bitmapMatrix.tx*2, -bitmapMatrix.ty);
			bitmap2.graphics.endFill();
			bitmap2.cacheAsBitmap = true;
			bitmap2.cacheAsBitmapMatrix = AssetVO.cacheMatrix;
			bitmap2.visible = false;
			
			otherBD = (bitmapData == PeopleBrain.ENEMYLEFT_BITMAPDATA) ? PeopleBrain.ENEMYLEFT3_BITMAPDATA : PeopleBrain.ENEMYRIGHT3_BITMAPDATA;
			bitmap3 = new Shape();
			bitmap3.graphics.beginBitmapFill(otherBD, bitmapMatrix, false, true);
			bitmap3.graphics.drawRect(bitmapMatrix.tx, bitmapMatrix.ty, -bitmapMatrix.tx*2, -bitmapMatrix.ty);
			bitmap3.graphics.endFill();
			bitmap3.cacheAsBitmap = true;
			bitmap3.cacheAsBitmapMatrix = AssetVO.cacheMatrix;
			bitmap3.visible = false;
			
			lastShape = bitmap;
		}
		
		private var frameCount:int = 0;
		private var lastShape:Shape;
		public function animate():void
		{
			var temp:Shape = (frameCount % 12 < 4) ? bitmap : ((frameCount % 12 < 8) ? bitmap2 : bitmap3);
			frameCount++;
			if (frameCount > 480)
				frameCount = 0;
			
			if (temp != bitmap)
			{
				//trace(">>:["+frameCount+"] " + (temp == bitmap) + ", " + (temp == bitmap2) + ", " + (temp == bitmap3));
				temp.x = bitmap.x
				temp.y = bitmap.y
				temp.rotation = bitmap.rotation;
			}
			if (temp == lastShape)
				return;
			
			//trace("1: " + (temp == bitmap) + ", " + (temp == bitmap2) + ", " + (temp == bitmap3));
			lastShape.visible = false;
			temp.visible = true;
			lastShape = temp;
		}
		
		public function setValues(x:int, scale:Number):void
		{
			bitmap.x = x;
			bitmap.scaleX = scale;
			bitmap.scaleY = scale;
			bitmap2.x = x;
			bitmap2.scaleX = scale;
			bitmap2.scaleY = scale;
			bitmap3.x = x;
			bitmap3.scaleX = scale;
			bitmap3.scaleY = scale;
		}
	}
}