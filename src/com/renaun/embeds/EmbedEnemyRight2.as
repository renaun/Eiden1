package com.renaun.embeds
{
	import flash.display.BitmapData;
	
	[Embed(source="/assets_embed/EnemyRight2.png")]
	public class EmbedEnemyRight2 extends BitmapData
	{
		public function EmbedEnemyRight2(width:int, height:int, transparent:Boolean=true, fillColor:uint=4.294967295E9)
		{
			super(width, height, transparent, fillColor);
		}
	}
}