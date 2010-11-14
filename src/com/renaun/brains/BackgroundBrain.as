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
	import com.renaun.embeds.EmbedBuildingGrey;
	import com.renaun.embeds.EmbedBuildingGrey2;
	import com.renaun.embeds.EmbedGrassDark;
	import com.renaun.embeds.EmbedGrassLight;
	import com.renaun.embeds.EmbedRoundWorld2;
	import com.renaun.embeds.EmbedStars2;
	import com.renaun.vo.AssetVO;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.geom.Matrix;
	import flash.utils.getTimer;
	
	public class BackgroundBrain implements ITimedExecute
	{
		public static const BUILDING1_BITMAPDATA:BitmapData = new EmbedBuildingGrey(81,150);
		public static const BUILDING1_MATRIX:Matrix = new Matrix(1, 0, 0, 1, -40, -140);
		public static const BUILDING2_BITMAPDATA:BitmapData = new EmbedBuildingGrey2(49,150);
		public static const BUILDING2_MATRIX:Matrix = new Matrix(1, 0, 0, 1, -24, -140);
		
		public function BackgroundBrain()
		{
		}
		
		public var direction:Number = 0;
		private var stars:Bitmap;
		private var land:Bitmap;
		private var grassLight:Bitmap;
		private var grassDark:Bitmap;
		
		private var buildings:Vector.<AssetVO> = new Vector.<AssetVO>();
		private var poolBuildings:Vector.<AssetVO> = new Vector.<AssetVO>();
		private var midPoint:Number = 0;
		private var landHeight:Number = 0;
		private var yStart:Number = 0;
		private var initBuildings:Boolean = false;
		private var matrix:Matrix = new Matrix();
		
		public function createChildren(container:Stage):void
		{
			// Hard Code for Droid X, had plans to make it work on arbitrary size devices
			// but time ran out and this is just a demo
			
			yStart = 303;//((ScreenUtils.applicationHeight-480)/288) * 240 + 303;
			midPoint = ScreenUtils.applicationWidth/2;
			var sw:int = 854;
			var sh:int = 390;
			var starsBD:BitmapData = new EmbedStars2(sh, sw);
			stars = new Bitmap(starsBD);
			stars.cacheAsBitmap = true;
			container.addChild(stars);
			
			var assetVO:AssetVO;
			var i:int;
			var total:int = (ScreenUtils.applicationWidth > 800) ? 14 : 10;
			for (i = 0; i < total; i++)
			{
				var type:int = (Math.random() * 0xffffff) % 2;
				assetVO = createBuilding(type);
				container.addChild(assetVO.bitmap);
				poolBuildings.push(assetVO);
			}		
			
			
			land = new Bitmap(new EmbedRoundWorld2(854, 177));
			land.y = yStart;
			landHeight = ScreenUtils.applicationHeight - yStart;
			container.addChild(land);			
			
			grassLight = new Bitmap(new EmbedGrassLight(1024, 160));
			grassLight.x = ScreenUtils.applicationWidth/2 - grassLight.width/2;
			grassLight.y = yStart-13;
			container.addChild(grassLight);
			grassDark = new Bitmap(new EmbedGrassDark(1024, 160));
			grassDark.x = ScreenUtils.applicationWidth/2 - grassDark.width/2;
			grassDark.y = yStart-13;
			container.addChild(grassDark);
			
			initBuildings = true;
		}
		
		//----------------------------------
		//  ITimedExecute Methods
		//----------------------------------
		
		private var movement:int = 0;
		public function execute(frameSequence:int):void
		{
			var localDirection:Number = 0;
			var building:Shape;
			var assetVO:AssetVO;
			var absRot:Number;
			// Also Animation Grass
			if (frameSequence % 10 == 1)
			{
				var oldMovment:int = movement;
				movement = -movement-1;
				grassLight.x = grassLight.x - oldMovment + movement;
				grassDark.x = grassLight.x + oldMovment - movement;
			}
			
			// Left to Right Intro - assumes ends when it gets to the left x < 40
			if (initBuildings)
			{
				localDirection = -0.5;
				for each (assetVO in buildings)
				{
					building = assetVO.bitmap
					building.rotation += localDirection*5;
					absRot = Math.abs(building.rotation);
					building.x = midPoint + (midPoint * building.rotation/30);
					setBuildingY(building);
				}
				if (frameSequence % 4 == 0)
				{
					assetVO = getBuilding();
					building = assetVO.bitmap;
					// Calculate based on size of 
					building.x = midPoint*2;
					building.rotation = 30;
					setBuildingY(building);
					buildings.push(assetVO);
				}
				
				if (buildings[0].bitmap.x < 40)
				{
					initBuildings = false;
				}
				return;
			}
			// Actual Movement
			if (direction != 0)
			{
				//stars.rotation += direction;
				for each (assetVO in buildings)
				{
					building = assetVO.bitmap
					building.rotation += direction*5;
					absRot = Math.abs(building.rotation);
					building.x = midPoint + (midPoint * building.rotation/30);
					setBuildingY(building);

					if (direction < 0 && building.x < -50)
						removeBuilding(assetVO);
					if (direction > 0 && building.x > (midPoint * 2) + 50)
						removeBuilding(assetVO);
				}
				if (buildings[0].bitmap.x > 40)
					addBuilding(true);
				
				if (buildings[buildings.length-1].bitmap.x < (midPoint * 2) - 40)
					addBuilding(false);
			}
		}
		
		//----------------------------------
		//  Building Helper Methods
		//----------------------------------
		
		private function setBuildingY(building:Shape):void
		{
			var xFromCenter:Number = Math.abs(building.x-midPoint);
			if (xFromCenter > 384)
				building.y = yStart + 5 + 71 + ((xFromCenter - 384)/128 * 88);
			else if (xFromCenter > 256)
				building.y = yStart + 5 + 31 + ((xFromCenter - 256)/128 * 40);
			else if (xFromCenter > 128)
				building.y = yStart + 5 + 14 + ((xFromCenter - 128)/128 * 17);
			else
				building.y = yStart + 5 + ((xFromCenter)/128 * 14);
		}
		
		private function getBuilding():AssetVO
		{
			/*
			if (poolBuildings.length == 0)
			{
				var type:int = (Math.random() * 0xffffff) % 2;
				poolBuildings.push(createBuilding(type));
			}
			*/
			return poolBuildings.pop();
		}
		
		private function addBuilding(leftAdd:Boolean = true):void
		{
			var assetVO:AssetVO = getBuilding();
			if (leftAdd)
			{
				assetVO.bitmap.x = -40;
				assetVO.bitmap.rotation = (assetVO.bitmap.x-midPoint) * 30 / midPoint;
				setBuildingY(assetVO.bitmap);
				
				buildings.splice(0,0,assetVO);
			}
			else
			{
				assetVO.bitmap.x = (midPoint*2)+40;
				assetVO.bitmap.rotation = (assetVO.bitmap.x-midPoint) * 30 / midPoint;
				setBuildingY(assetVO.bitmap);
				
				buildings.push(assetVO);
			}
		}
		
		private function removeBuilding(assetVO:AssetVO):void
		{
			assetVO.bitmap.x = -200;
			poolBuildings.push(assetVO);
			buildings.splice(buildings.indexOf(assetVO), 1);
		}
		
		
		private function createBuilding(type:int):AssetVO
		{
			var assetVO:AssetVO = new AssetVO();
			if (type == 1)
				assetVO.createShape(BUILDING1_BITMAPDATA, BUILDING1_MATRIX);
			else
				assetVO.createShape(BUILDING2_BITMAPDATA, BUILDING2_MATRIX);
			assetVO.bitmap.x = -200;
			assetVO.bitmap.scaleX = ((Math.random() * 0.2)+0.8);
			assetVO.bitmap.scaleY = assetVO.bitmap.scaleX;
			return assetVO;
		}
	}
}