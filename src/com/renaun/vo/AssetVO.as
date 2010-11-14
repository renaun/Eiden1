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
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;

	public class AssetVO
	{
		public static const cacheMatrix:Matrix = new Matrix();
		public var bitmap:Shape;
		public var walkRate:Number = 0.075;
		public var offsetY:Number = 15;
		
		public function createShape(bitmapData:BitmapData, bitmapMatrix:Matrix):void
		{
			bitmap = new Shape();
			bitmap.graphics.beginBitmapFill(bitmapData, bitmapMatrix, false, true);
			bitmap.graphics.drawRect(bitmapMatrix.tx, bitmapMatrix.ty, -bitmapMatrix.tx*2, -bitmapMatrix.ty+10);
			bitmap.graphics.endFill();
			/*
			bitmap.x = 121.6;
			bitmap.y = 623.4;
			bitmap.rotation = -22.875;
			*/
			bitmap.cacheAsBitmap = true;
			bitmap.cacheAsBitmapMatrix = AssetVO.cacheMatrix;
		}
	}
}