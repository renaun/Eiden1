package com.renaun.embeds
{
	import flash.display.BitmapData;

	[Embed(source="/assets_embed/ArmRight.png")]
	public class EmbedArmRight extends BitmapData
	{
		public function EmbedArmRight(width:int, height:int, transparent:Boolean=true, fillColor:uint=4.294967295E9)
		{
			super(width, height, transparent, fillColor);
		}
	}
}