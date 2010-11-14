package com.renaun.embeds
{
	import flash.display.BitmapData;

	[Embed(source="/assets_embed/ArmLeft.png")]
	public class EmbedArmLeft extends BitmapData
	{
		public function EmbedArmLeft(width:int, height:int, transparent:Boolean=true, fillColor:uint=4.294967295E9)
		{
			super(width, height, transparent, fillColor);
		}
	}
}