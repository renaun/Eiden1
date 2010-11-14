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
package com.renaun.brains
{
	import com.kaigames.core.ITimedExecute;
	import com.kaigames.core.ScreenUtils;
	import com.renaun.embeds.EmbedArmLeft;
	import com.renaun.embeds.EmbedArmRight;
	import com.renaun.embeds.EmbedBuildingGrey;
	import com.renaun.embeds.EmbedBuildingGrey2;
	import com.renaun.embeds.EmbedEnemyLeft;
	import com.renaun.embeds.EmbedEnemyLeft2;
	import com.renaun.embeds.EmbedEnemyLeft3;
	import com.renaun.embeds.EmbedEnemyRight;
	import com.renaun.embeds.EmbedEnemyRight2;
	import com.renaun.embeds.EmbedEnemyRight3;
	import com.renaun.embeds.EmbedGrassDark;
	import com.renaun.embeds.EmbedGrassLight;
	import com.renaun.embeds.EmbedGuyLeft1;
	import com.renaun.embeds.EmbedGuyRight1;
	import com.renaun.embeds.EmbedRoundWorld;
	import com.renaun.embeds.EmbedStars;
	import com.renaun.vo.AssetVO;
	import com.renaun.vo.EnemyVO;
	import com.renaun.vo.GuyVO;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.geom.Matrix;
	
	public class PeopleBrain implements ITimedExecute
	{
		public static const ENEMYLEFT_BITMAPDATA:BitmapData = new EmbedEnemyRight(87,110);
		public static const ENEMYLEFT2_BITMAPDATA:BitmapData = new EmbedEnemyRight2(87,110);
		public static const ENEMYLEFT3_BITMAPDATA:BitmapData = new EmbedEnemyRight3(87,110);
		public static const ENEMYLEFT_MATRIX:Matrix = new Matrix(1, 0, 0, 1, -43, -110);
		
		public static const ENEMYRIGHT_BITMAPDATA:BitmapData = new EmbedEnemyLeft(87,110);
		public static const ENEMYRIGHT2_BITMAPDATA:BitmapData = new EmbedEnemyLeft2(87,110);
		public static const ENEMYRIGHT3_BITMAPDATA:BitmapData = new EmbedEnemyLeft3(87,110);
		public static const ENEMYRIGHT_MATRIX:Matrix = new Matrix(1, 0, 0, 1, -43, -110);
		
		
		public static const GUY_MATRIX:Matrix = new Matrix(1, 0, 0, 1, -43, -110);
		public static const GUYLEFT1_BITMAPDATA:BitmapData = new EmbedGuyLeft1(87,110);
		public static const GUYRIGHT1_BITMAPDATA:BitmapData = new EmbedGuyRight1(87,110);
		public static const LEFTARM_BITMAPDATA:BitmapData = new EmbedArmLeft(31,57);
		public static const LEFTARM_MATRIX:Matrix = new Matrix(1, 0, 0, 1, -31, 0);
		public static const RIGHTARM_BITMAPDATA:BitmapData = new EmbedArmRight(31,57);
		
		public function PeopleBrain()
		{
		}
		
		public var direction:Number = 0;
		public var guy1VDirection:Number = 0;
		public var guy2VDirection:Number = 0;
		
		public var guy1HDirection:Number = 0;
		public var guy2HDirection:Number = 0;
		
		public var guy1Punch:Boolean = false;
		public var guy2Punch:Boolean = false;
		
		private var stars:Shape;
		private var land:Bitmap;
		public var guy1:GuyVO;
		public var guy2:GuyVO;
		
		private var enemysFlying:Vector.<EnemyVO> = new Vector.<EnemyVO>();
		private var enemysLeft:Vector.<EnemyVO> = new Vector.<EnemyVO>();
		private var poolEnemyLeft:Vector.<EnemyVO> = new Vector.<EnemyVO>();
		private var enemysRight:Vector.<EnemyVO> = new Vector.<EnemyVO>();
		private var poolEnemyRight:Vector.<EnemyVO> = new Vector.<EnemyVO>();

		private var midPoint:Number = 0;
		private var landHeight:Number = 0;
		private var yStart:Number = 0;
		private var container:Stage;
		
		public function createChildren(container:Stage):void
		{
			this.container = container;
			yStart = ((ScreenUtils.applicationHeight-480)/288) * 240 + 303;
			midPoint = ScreenUtils.applicationWidth/2;
			
			var assetVO:EnemyVO;
			var i:int;
			var total:int = (ScreenUtils.applicationWidth > 800) ? 8 : 6;
			for (i = 0; i < total; i++)
			{
				assetVO = createEnemy(PeopleBrain.ENEMYLEFT_BITMAPDATA, PeopleBrain.ENEMYLEFT_MATRIX);
				container.addChild(assetVO.bitmap);
				container.addChild(assetVO.bitmap2);
				container.addChild(assetVO.bitmap3);
				poolEnemyLeft.push(assetVO);
			}
			for (i = 0; i < total; i++)
			{
				assetVO = createEnemy(PeopleBrain.ENEMYRIGHT_BITMAPDATA, PeopleBrain.ENEMYRIGHT_MATRIX);
				container.addChild(assetVO.bitmap);
				container.addChild(assetVO.bitmap2);
				container.addChild(assetVO.bitmap3);
				poolEnemyRight.push(assetVO);
			}
			
			guy1 = new GuyVO();
			guy1.createShape(GUYLEFT1_BITMAPDATA, GUY_MATRIX);
			guy1.setValues(midPoint, yStart + 50);
			container.addChild(guy1.bitmap);
			container.addChild(guy1.arm);
			
			
			guy2 = new GuyVO();
			guy2.createShape(GUYRIGHT1_BITMAPDATA, GUY_MATRIX);
			guy2.setValues(midPoint, yStart + 100);
			container.addChild(guy2.bitmap);
			container.addChild(guy2.arm);
		}
		
		//----------------------------------
		//  ITimedExecute Methods
		//----------------------------------
		
		private var lastStart:int = 0;
		public function execute(frameSequence:int):void
		{
			var localDirection:Number = 0;
			var bitmap:Shape;
			var assetVO:EnemyVO;
			var absRot:Number;
			var y1:int;
			if (frameSequence == 100)
			{
				if (enemysLeft.length < 6)
					addAsset(true);
				if (enemysRight.length < 6)
					addAsset(false);
			}
			
			// Guys coming from the left
			for each (assetVO in enemysLeft)
			{
				bitmap = assetVO.bitmap;
				if (!assetVO.isHit)
				{
					bitmap.rotation += (assetVO.walkRate-direction)*5;
					absRot = Math.abs(bitmap.rotation);
					bitmap.x = midPoint + (midPoint * bitmap.rotation/30);
					setAssetY(bitmap, assetVO.offsetY);
				}
				else
				{
					bitmap.x += (bitmap.rotation * 10);
					bitmap.y -= 10;
				}
				
				assetVO.animate();
				// Check for hit
				if (bitmap.x - midPoint > -30
					&& bitmap.x -midPoint < 30)
				{
					y1 = guy1.bitmap.y - bitmap.y;
					if (guy1.isPunching && y1 > -20 && y1 < 20)
						assetVO.isHit = true;
					y1 = guy2.bitmap.y - bitmap.y;
					if (guy2.isPunching && y1 > -10 && y1 < 10)
						assetVO.isHit = true;
				}
				
				//if (bitmap.x < -50)
				//	assetVO.walkRate += 0.01
				if (bitmap.x > (midPoint * 2) + 50 || bitmap.y < 0)
					removeAsset(assetVO, true);
				
			}
			// Guys coming from the left
			for each (assetVO in enemysRight)
			{
				bitmap = assetVO.bitmap;
				if (!assetVO.isHit)
				{
					bitmap.rotation += (-assetVO.walkRate-direction)*5;
					absRot = Math.abs(bitmap.rotation);
					bitmap.x = midPoint + (midPoint * bitmap.rotation/30);
					setAssetY(bitmap, assetVO.offsetY);
				}
				else
				{
					bitmap.x += (bitmap.rotation * 10);
					bitmap.y -= 10;
				}
				
				assetVO.animate();
				// Check for hit
				if (bitmap.x - midPoint > -30
					&& bitmap.x -midPoint < 30)
				{
					y1 = guy1.bitmap.y - bitmap.y;
					if (guy1.isPunching && y1 > -20 && y1 < 20)
						assetVO.isHit = true;
					y1 = guy2.bitmap.y - bitmap.y;
					if (guy2.isPunching && y1 > -10 && y1 < 10)
						assetVO.isHit = true;
				}
				
				if (bitmap.x < -50 || bitmap.y < 0)
					removeAsset(assetVO, false);
				//if (bitmap.x > (midPoint * 2) + 50)
				//	assetVO.walkRate += 0.1;
				
			}
			
			guy1.animate(guy1Punch);
			if (!guy1.isPunching)
				guy1Punch = false;

			if (guy1VDirection != 0)
			{
				if (guy1.bitmap.y + guy1VDirection > yStart
					&& guy1.bitmap.y + guy1VDirection < ScreenUtils.applicationHeight)
					guy1.setValues(guy1.bitmap.x, guy1.bitmap.y + guy1VDirection);
			}
			if (guy1HDirection == 0)
				guy1.setValues(guy1.bitmap.x + (midPoint-guy1.bitmap.x)/4, guy1.bitmap.y);
			else if (guy1HDirection == -1 && guy1.bitmap.x > midPoint-60)
				guy1.setValues(guy1.bitmap.x - 1, guy1.bitmap.y);
			else if (guy1HDirection == 1 && guy1.bitmap.x < midPoint+60)
				guy1.setValues(guy1.bitmap.x + 1, guy1.bitmap.y);
			
			guy2.animate(guy2Punch);
			if (!guy2.isPunching)
				guy2Punch = false;
			if (guy2 && guy2VDirection != 0)
			{
				if (guy2.bitmap.y + guy2VDirection > yStart
					&& guy2.bitmap.y + guy2VDirection < ScreenUtils.applicationHeight)
					guy2.setValues(guy2.bitmap.x, guy2.bitmap.y + guy2VDirection);
			}
			if (guy2HDirection == 0)
				guy2.setValues(guy2.bitmap.x + (midPoint-guy2.bitmap.x)/4, guy2.bitmap.y);
			else if (guy2HDirection == -1 && guy2.bitmap.x > midPoint-60)
				guy2.setValues(guy2.bitmap.x - 1, guy2.bitmap.y);
			else if (guy2HDirection == 1 && guy2.bitmap.x < midPoint+60)
				guy2.setValues(guy2.bitmap.x + 1, guy2.bitmap.y);
		}
		
		//----------------------------------
		//  Building Helper Methods
		//----------------------------------
		
		private function setAssetY(bitmap:Shape, offset:int):void
		{
			var xFromCenter:Number = Math.abs(bitmap.x-midPoint);
			if (xFromCenter > 384)
				bitmap.y = yStart + offset + 71 + ((xFromCenter - 384)/128 * 88);
			else if (xFromCenter > 256)
				bitmap.y = yStart + offset + 31 + ((xFromCenter - 256)/128 * 40);
			else if (xFromCenter > 128)
				bitmap.y = yStart + offset + 14 + ((xFromCenter - 128)/128 * 17);
			else
				bitmap.y = yStart + offset + ((xFromCenter)/128 * 14);
		}
		
		private function addAsset(leftAdd:Boolean = true):void
		{
			var defaultWalkRate:Number = 0.025;
			var assetVO:EnemyVO;
			var i:int;
			if (leftAdd)
			{
				if (poolEnemyLeft.length == 0)
				{
					for (i = 0; i < 3; i++)
					{
						assetVO = createEnemy(ENEMYLEFT_BITMAPDATA, ENEMYLEFT_MATRIX);
						container.addChild(assetVO.bitmap);
						container.addChild(assetVO.bitmap2);
						container.addChild(assetVO.bitmap3);
						poolEnemyLeft.push(assetVO);
					}
				}
				assetVO = poolEnemyLeft.pop();
				assetVO.bitmap.x = -40;
				assetVO.bitmap.rotation = (assetVO.bitmap.x-midPoint) * 30 / midPoint;
				assetVO.walkRate = defaultWalkRate;
				assetVO.offsetY = (Math.random() * 120) + 10;
				setAssetY(assetVO.bitmap, assetVO.offsetY);
				enemysLeft.push(assetVO);
				//trace("Adding enemy Left: " + enemysLeft.length + " x/y: " + assetVO.bitmap.x + "/" + assetVO.bitmap.y);
			}
			else
			{
				if (poolEnemyRight.length == 0)
				{
					for (i = 0; i < 3; i++)
					{
						assetVO = createEnemy(ENEMYRIGHT_BITMAPDATA, ENEMYRIGHT_MATRIX);
						container.addChild(assetVO.bitmap);
						container.addChild(assetVO.bitmap2);
						container.addChild(assetVO.bitmap3);
						poolEnemyRight.push(assetVO);
					}
				}
				assetVO = poolEnemyRight.pop();
				assetVO.bitmap.x = (midPoint*2)+40;
				assetVO.bitmap.rotation = (assetVO.bitmap.x-midPoint) * 30 / midPoint;
				assetVO.walkRate = defaultWalkRate;
				assetVO.offsetY = (Math.random() * 120) + 10;
				setAssetY(assetVO.bitmap, assetVO.offsetY);
				enemysRight.push(assetVO);
				//trace("Adding enemy Right: " + enemysRight.length + " x/y: " + assetVO.bitmap.x + "/" + assetVO.bitmap.y);
			}
		}
		
		private function removeAsset(assetVO:EnemyVO, leftRemove:Boolean = true):void
		{
			//trace("Removing("+leftRemove+")): " + assetVO.bitmap.x + " - " + assetVO.bitmap.y);
			assetVO.bitmap.x = -200;
			assetVO.isHit = false;
			if (leftRemove)
			{
				poolEnemyLeft.push(assetVO);
				enemysLeft.splice(enemysLeft.indexOf(assetVO), 1);
			}
			else
			{
				poolEnemyRight.push(assetVO);
				enemysRight.splice(enemysRight.indexOf(assetVO), 1);
			}
		}
		
		private function createEnemy(bitmapData:BitmapData, matrix:Matrix):EnemyVO
		{
			var assetVO:EnemyVO = new EnemyVO();
			assetVO.createShape(bitmapData, matrix);
			assetVO.setValues(-200, ((Math.random() * 0.3)+0.7));
			return assetVO;
		}
	}
}