package com.renaun.embeds
{
	import flash.display.BitmapData;

	[Embed(source="/assets_embed/GrassLight.png")]
	public class EmbedGrassLight extends BitmapData
	{
		public function EmbedGrassLight(width:int, height:int, transparent:Boolean=true, fillColor:uint=4.294967295E9)
		{
			super(width, height, transparent, fillColor);
		}
	}
}