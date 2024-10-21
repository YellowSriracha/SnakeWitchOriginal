/// @description
/// @description Insert description here
// You can write your code in this editor

enum PSTATE{
	GROUND,
	AIR,
	CROUCH,
	HITSTUN,
	ATTACKING
}
TRAILALPHA =.4; 
alarm[0] = game_get_speed(gamespeed_fps)/4;

//pointers
layerID = layer_get_id("Tiles_Collision");
tilemapID = layer_tilemap_get_id(layerID);


//physics
MAXSPEED = 1.5;
JUMPSPEED = 4;
GV = .15;
FRICTIONV = .9;
AIRRESISTV =.8;

//state
state=PSTATE.GROUND;
isAttacking = false;
isCrouching = false;

//movement
xVelocity=0; yVelocity =0;
dir=1;
dirFacing=1;
takeoffBuffer=0;
landingBuffer=0;
jumpActive=1;

//hitstun
isInvulnerable=false;
hitStunMaxFrames = 100;
hitstunFrames = 0;


//position queue
//positionQueue = ds_queue_create();
var _pos = {x, y, image_xscale, image_yscale, sprite_index, image_index, alpha:TRAILALPHA};
positionQueueIndex = 0;
positionQueue=[_pos,_pos,_pos];


//keyboard variables
rkey=0;
lkey=0;
jkey = 0;


function assignPlayerSprite(){
	///Assign Sprites=============================================================
	if state != PSTATE.CROUCH mask_index=sp_bay_collision_box else mask_index=sp_bay_collision_box_low;
	switch(state){
		case PSTATE.CROUCH:
			if (abs(xVelocity)<0.5){
				
				sprite_index = sp_bay_crouch;
			} else {
				sprite_index =sp_bay_slide;
			}
			
			break;
		case PSTATE.ATTACKING:
			sprite_index = sp_bay_attack;
			break;
		case PSTATE.GROUND:
			if (abs(xVelocity)>0.5){
				sprite_index = sp_bay_walk;
			} else{
				sprite_index = sp_bay_idle
			}
			break;
		case PSTATE.HITSTUN:
			sprite_index = sp_bay_hitstun;
			break;
		case PSTATE.AIR:
			if (yVelocity < -1){
				sprite_index = sp_bay_goingup;	
			} else if yVelocity < 1{
				sprite_index = sp_bay_jumpapex;
			} else { 
				sprite_index = sp_bay_goingdown;
			}
			break;
		default:
			sprite_index = sp_bay_collision_box;
	}

}
//checks if x and y are colliding with the collision tileset
//xcheck, ycheck are cords to be checked
//returns true or false
function checkcol (_xcheck, _ycheck){
		return(tilemap_get_at_pixel(tilemapID ,_xcheck, _ycheck));

}

//check if the player is on the ground and adjust velocity/state accordingly
//returns if player is on the ground
function ground_collision(){
	return (checkcol(bbox_right-1,bbox_bottom)+ checkcol(bbox_left+1, bbox_bottom)!=0);
}
	
function top_collision(){
	if(yVelocity<0){
		if (checkcol(bbox_right-1, bbox_top+yVelocity)+checkcol(bbox_left+1, bbox_top+yVelocity)!=0){ 
			while (checkcol(bbox_right-1,bbox_top-1)+ checkcol(bbox_left+1, bbox_top-1)==0){
				y=floor(y-1);
			}
			return 1;
		}
	}
	return 0;
}

//check if the player is colliding with a wall to the right and adjust velocity/state accordingly
//returns if player is touching a wall to the right
function right_collision(){
	if(xVelocity>0){
		if (checkcol(bbox_right+xVelocity,bbox_bottom-1)+checkcol(bbox_right+xVelocity,bbox_top)!=0){ 
			while(checkcol(bbox_right+1,bbox_bottom-1)+checkcol(bbox_right+1,bbox_top)==0){ 
				x+=.2;
			}
			xVelocity=0;
			return 1;
		}
	}
	return 0;
}
	
//check if the player is colliding with a wall to the right and adjust velocity/state accordingly
//returns if player is touching a wall to the left
function left_collision(){
	if(xVelocity<0){
		if (checkcol(bbox_left+xVelocity,bbox_bottom-1)+checkcol(bbox_left+xVelocity,bbox_top)!=0){ 
			while(checkcol(bbox_left-1,bbox_bottom-1)+checkcol(bbox_left-1,bbox_top)==0){ 
				x-=.2;
			}
			xVelocity=0;
			return 1;
		}
	}
	return 0;
}

function hit(_damage,_otherx, _othery){
	audio_stop_sound(sfx_whip);
	audio_stop_sound(sfx_stickwoosh);
	if(!isInvulnerable){
		global.hp-=_damage;
		isInvulnerable=true;
		hitstunFrames = hitStunMaxFrames;
		var _xdif = x- _otherx;
		xVelocity = sign(_xdif)*4;
		yVelocity = -2;
		state = PSTATE.HITSTUN;
		audio_play_sound(sfx_got_hit,1,0)
	}
}

