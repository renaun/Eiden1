package com.renaun.embeds
{
	import flash.display.BitmapData;
	
	[Embed(source="/assets_embed/Enemy.png")]
	public class EmbedEnemyLeft extends BitmapData
	{
		public function EmbedEnemyLeft(width:int, height:int, transparent:Boolean=true, fillColor:uint=4.294967295E9)
		{
			super(width, height, transparent, fillColor);
		}
	}
}