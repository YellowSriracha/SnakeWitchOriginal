/// @description Insert description here
// You can write your code in this editor
event_inherited()
touchDamage = 20;
alarm[0] = game_get_speed(gamespeed_fps)*2;

function hit(){
	if isAlive {
		isAlive = false;
		sprite_index = sp_explode;
		image_index = 0;
		audio_play_sound(sfx_bat_squeak,2,false,1,.7);
	}
}


