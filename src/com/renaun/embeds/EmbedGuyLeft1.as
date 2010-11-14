package com.renaun.embeds
{
	import flash.display.BitmapData;
	
	[Embed(source="/assets_embed/GuyLeft1.png")]
	public class EmbedGuyLeft1 extends BitmapData
	{
		public function EmbedGuyLeft1(width:int, height:int, transparent:Boolean=true, fillColor:uint=4.294967295E9)
		{
			super(width, height, transparent, fillColor);
		}
	}
}