/// @description

layerID = layer_get_id("Tiles_Collision");
tilemapID = layer_tilemap_get_id(layerID);
isFalling = true;
yVelocity = 0;

function onGround(){
	var _onGround = tilemap_get_at_pixel(tilemapID ,x,bbox_bottom+1);
	while(tilemap_get_at_pixel(tilemapID ,x,bbox_bottom+yVelocity)&&!_onGround){
		y+=1;
		_onGround = tilemap_get_at_pixel(tilemapID ,x,bbox_bottom+1);
	}
	return _onGround;
}