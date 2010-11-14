package com.renaun.embeds
{
	import flash.display.BitmapData;
	
	[Embed(source="/assets_embed/RoundWorld2.png")]
	public class EmbedRoundWorld2 extends BitmapData
	{
		public function EmbedRoundWorld2(width:int, height:int, transparent:Boolean=true, fillColor:uint=4.294967295E9)
		{
			super(width, height, transparent, fillColor);
		}
	}
}