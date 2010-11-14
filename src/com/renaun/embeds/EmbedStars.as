package com.renaun.embeds
{
	import flash.display.BitmapData;

	[Embed(source="/assets_embed/stars.jpg")]
	public class EmbedStars extends BitmapData
	{
		public function EmbedStars(width:int, height:int, transparent:Boolean=true, fillColor:uint=4.294967295E9)
		{
			super(width, height, transparent, fillColor);
		}
	}
}