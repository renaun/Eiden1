package com.renaun.embeds
{
	import flash.display.BitmapData;

	[Embed(source="/assets_embed/GrassDark.png")]
	public class EmbedGrassDark extends BitmapData
	{
		public function EmbedGrassDark(width:int, height:int, transparent:Boolean=true, fillColor:uint=4.294967295E9)
		{
			super(width, height, transparent, fillColor);
		}
	}
}