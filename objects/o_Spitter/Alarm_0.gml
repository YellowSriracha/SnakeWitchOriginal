/// @description Launch projectile
if(isAlive){
	with(instance_create_layer(x,y-25,"Instances",o_projectile)){
		dir = other.dir;
	}
}

alarm[0] = game_get_speed(gamespeed_fps)*2;

