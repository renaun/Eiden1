package com.renaun.embeds
{
	import flash.display.BitmapData;

	[Embed(source="/assets_embed/Stars2.jpg")]
	public class EmbedStars2 extends BitmapData
	{
		public function EmbedStars2(width:int, height:int, transparent:Boolean=true, fillColor:uint=4.294967295E9)
		{
			super(width, height, transparent, fillColor);
		}
	}
}