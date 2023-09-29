/// @description


for(i=0; i < array_length(positionQueue); i++){
	var _lastPos = positionQueue[i];
	
	draw_sprite_ext(_lastPos.sprite_index, _lastPos.image_index, _lastPos.x,  _lastPos.y,_lastPos.image_xscale,_lastPos.image_yscale,0,c_teal,_lastPos.alpha);
	_lastPos.alpha-=TRAILALPHA/45;
}

draw_set_alpha(1);

if(isInvulnerable && hitstunFrames%4 ==0){
		draw_sprite_ext(sprite_index, image_index, x, y,image_xscale,image_yscale,0,c_red,.8);
}else{
	draw_self();
}
