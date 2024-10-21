/// @description

moveTarget = {x:o_SnakeWitch.x, y:o_SnakeWitch.y-40};
isMoving = false;
maxSpeed = 1.5;
image_xscale=2;
image_yscale=2;
alarm[0] = game_get_speed(gamespeed_fps)*1;


function hit() {
	if isAlive {
		isAlive = false;
		sprite_index = sp_bat_dying;
		image_index = 0;
		audio_play_sound(sfx_bat_squeak,2,false,1,.7);
	}
}


