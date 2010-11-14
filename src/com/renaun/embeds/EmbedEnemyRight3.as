package com.renaun.embeds
{
	import flash.display.BitmapData;
	
	[Embed(source="/assets_embed/EnemyRight3.png")]
	public class EmbedEnemyRight3 extends BitmapData
	{
		public function EmbedEnemyRight3(width:int, height:int, transparent:Boolean=true, fillColor:uint=4.294967295E9)
		{
			super(width, height, transparent, fillColor);
		}
	}
}