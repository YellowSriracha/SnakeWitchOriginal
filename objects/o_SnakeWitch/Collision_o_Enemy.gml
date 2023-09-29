/// @description
if(!isInvulnerable && other.isAlive){
	global.hp-=other.touchDamage;
	isInvulnerable=true;
	hitstunFrames = hitStunMaxFrames;
	var _xdif = x- other.x;
	xVelocity += sign(_xdif)*4;
	yVelocity = -2;
	state = PSTATE.HITSTUN;
	audio_play_sound(sfx_got_hit,1,0)
}


