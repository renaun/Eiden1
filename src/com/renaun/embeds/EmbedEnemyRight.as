package com.renaun.embeds
{
	import flash.display.BitmapData;
	
	[Embed(source="/assets_embed/EnemyRight.png")]
	public class EmbedEnemyRight extends BitmapData
	{
		public function EmbedEnemyRight(width:int, height:int, transparent:Boolean=true, fillColor:uint=4.294967295E9)
		{
			super(width, height, transparent, fillColor);
		}
	}
}