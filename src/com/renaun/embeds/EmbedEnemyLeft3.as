package com.renaun.embeds
{
	import flash.display.BitmapData;
	
	[Embed(source="/assets_embed/EnemyLeft3.png")]
	public class EmbedEnemyLeft3 extends BitmapData
	{
		public function EmbedEnemyLeft3(width:int, height:int, transparent:Boolean=true, fillColor:uint=4.294967295E9)
		{
			super(width, height, transparent, fillColor);
		}
	}
}