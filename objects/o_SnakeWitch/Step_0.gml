/// @description

/// @description Insert description here
// You can write your code in this editor
if(global.inControl){
	
var _rkey = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _lkey = keyboard_check(vk_left) || keyboard_check(ord("A"));
var _dkey = keyboard_check(vk_down) || keyboard_check(ord("S"));
var _jkey = keyboard_check_pressed(vk_space) ||keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up);
var _akey = keyboard_check_pressed(ord("Z"));
var _onGround = ground_collision();

//Handle Collisions============================================================
if (!_onGround){
	yVelocity+=GV;
	if (checkcol(bbox_right-1,bbox_bottom+yVelocity)+ checkcol(bbox_left+1, bbox_bottom+yVelocity)!=0){
		while(!ground_collision()){
			y=floor(y+1);
		}
		_onGround = true;
		yVelocity=0; 
	}
} else if (yVelocity>=0){
	yVelocity=0;
}
jumpActive = _onGround;
if(_jkey && !_dkey && jumpActive){
			yVelocity -=JUMPSPEED;
			audio_play_sound(sfx_jump_flap,1,0,2,.15);
}

//Direction check================ =============================================

if (dir != _rkey-_lkey && _rkey!=_lkey) {
		dir = _rkey -_lkey;
}
if state == PSTATE.CROUCH {
	dirFacing=dir
}else if(state != PSTATE.ATTACKING&&abs(xVelocity)>=MAXSPEED&&_onGround) dirFacing=dir;
image_xscale = dirFacing;


//-1 Invulnerable frame
if(hitstunFrames<=0){
		isInvulnerable=false;
}else{
		hitstunFrames -=1;
}

//State check + horizontal speed ===============================================
switch(state){
	case PSTATE.GROUND:
		
	    if(_rkey-_lkey==0){
			xVelocity *= FRICTIONV;
		}else{
			xVelocity = xVelocity+.2*(dir);
			if(abs(xVelocity)>MAXSPEED){
				xVelocity=dir*MAXSPEED;
			}
		}
		if !_onGround {
			state = PSTATE.AIR;
			break;
		} else if _dkey{
			state=PSTATE.CROUCH;
			if _jkey xVelocity=dir*8;
			break;
		}break;	
		
	case PSTATE.AIR:
		if(_onGround && yVelocity>=0){
			state =PSTATE.GROUND;
			audio_play_sound(sfx_landing_thud,1,0);
			break;
		}
		jumpActive = false;
		if(_rkey-_lkey==0){
			xVelocity *= AIRRESISTV;
		}else{
			var _newspeed = xVelocity+.1*(dir);
			if (abs(_newspeed) <= MAXSPEED ){
				xVelocity = xVelocity+.1*(dir);
			}else{
				xVelocity = dir*MAXSPEED;
			}
		}break;
		
	case PSTATE.CROUCH:
		isCrouching=true;
		xVelocity *= FRICTIONV;
		if _jkey {
			xVelocity=dirFacing*8
			var _slidehitbox = instance_create_layer(x+image_xscale+0.5,y-30,"Hit_Boxes", o_AttackHitbox);
			with(_slidehitbox){
				framesActive=20;
				image_xscale = other.image_xscale;
				image_yscale = 1;
				followPlayer = true;
				visible = false;
			}
		} else if !_dkey {
			state = PSTATE.GROUND;
			isCrouching=false;
		}
		break;
	case PSTATE.HITSTUN:
		if(_onGround && yVelocity>=0){
			state =PSTATE.GROUND;
			audio_play_sound(sfx_landing_thud,1,0);
		}
		break;
	case PSTATE.ATTACKING:
	{
		if(_rkey-_lkey==0||_dkey){
			xVelocity *= FRICTIONV;
		}else {
			xVelocity = xVelocity+.2*(dir);
			if(abs(xVelocity)>MAXSPEED){
				xVelocity=dir*MAXSPEED;
			}
		}
		if(image_index == 2){
			var _hitBox1 = instance_create_layer(x+image_xscale*10,y-60,"Hit_Boxes", o_AttackHitbox);
			with(_hitBox1){
				framesActive=20;
				image_xscale = other.image_xscale*1.4;
				image_yscale = 3.5;
				followPlayer = true;
				visible = false;
			}
		}else if(image_index == 3){
			var _hitBox2 = instance_create_layer(x+image_xscale*32,y-50,"Hit_Boxes", o_AttackHitbox);	
			with(_hitBox2){
			framesActive=10;
			image_xscale = other.image_xscale*5;
			followPlayer = true;
			visible = false;
			}
		}else if(image_index >= image_number-1) {
			if _onGround &&_dkey{
				state=PSTATE.CROUCH;
			}
			else if _onGround{
				state=PSTATE.GROUND;
			} else {
				state = PSTATE.AIR;
			}
			isAttacking =false;
			audio_stop_sound(sfx_whip);
			audio_stop_sound(sfx_stickwoosh);
		}
		break;
	}
	default:
		throw("Player State Unknown");
} 

//Attack Check ======================================================================
if(_akey && state !=PSTATE.ATTACKING && state != PSTATE.CROUCH && state != PSTATE.HITSTUN){
	image_index = 0;
	if(!_onGround) dirFacing = dir;
	state=PSTATE.ATTACKING;
	audio_play_sound(sfx_whip,1,0,1,1.3);
	audio_play_sound(sfx_stickwoosh,2,0,1,.2);
}



right_collision();
left_collision();
x=x+xVelocity;

if(!top_collision()){
	y=floor(y+yVelocity);
}
assignPlayerSprite();


}//end of inControl if




