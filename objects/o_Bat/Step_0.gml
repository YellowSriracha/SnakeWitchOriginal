/// @description

if (sprite_index == sp_bat_dying && image_index >= image_number - 1){
	instance_destroy();	
}

if(isAlive && isMoving){
	move_towards_point(moveTarget.x,moveTarget.y,maxSpeed);		
}else{
	move_towards_point(moveTarget.x,moveTarget.y,0);	
}