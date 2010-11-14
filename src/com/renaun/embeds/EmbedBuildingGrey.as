package com.renaun.embeds
{
	import flash.display.BitmapData;

	[Embed(source="/assets_embed/BuildingGrey.png")]
	public class EmbedBuildingGrey extends BitmapData
	{
		public function EmbedBuildingGrey(width:int, height:int, transparent:Boolean=true, fillColor:uint=4.294967295E9)
		{
			super(width, height, transparent, fillColor);
		}
	}
}