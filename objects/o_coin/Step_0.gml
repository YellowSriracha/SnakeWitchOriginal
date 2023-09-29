/// @description

if(isFalling){
	if (!onGround()){
		yVelocity+=1;
		y+=yVelocity;
	} else {
		isFalling=false;
		audio_play_sound(sfx_coin_fell,1,0,5);
	}
}


