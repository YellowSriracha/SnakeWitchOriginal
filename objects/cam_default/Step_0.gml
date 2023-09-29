/// @description

/// @description Insert description here
// You can write your code in this editor

//playery = Obj_MainCharacter.y;
playerx = o_SnakeWitch.x;
playery= o_SnakeWitch.y;
var _previous_viewX = camera_get_view_x(view_camera[0]);
var _previous_viewY = camera_get_view_y(view_camera[0]);

//direction control
var _dir = o_SnakeWitch.dir;
directionBuffer+=_dir;
if(directionBuffer >= 30){
	currentDirection=1;
	directionBuffer=0;
} else if (directionBuffer <=-30){
	currentDirection=-1;
	directionBuffer=0;
}
playerx = playerx + currentDirection*60;

//findx
if(playerx-viewW/2 > 0 && playerx+viewW/2 < room_width){
	viewX = playerx-viewW/2;
} else if (playerx+viewW/2 < room_width){
	viewX = 0;
} else {
	viewX=room_width-viewW;
}

//findy
viewY = groundy;


camera_set_view_pos(view_camera[0], lerp(_previous_viewX, viewX,0.08), lerp(_previous_viewY,viewY,0.08));

//hitstop
if(isHitstop){
	hitstopFrames -= 1;
	if (hitstopFrames == 0){
		isHitstop = false;
		room_speed = 60;
	}
}

//background movement
//layer_background_stretch(layer_background_get_id("Background"), true);
layer_x("Background", camera_get_view_x(view_camera[0]));
layer_y("Background", camera_get_view_y(view_camera[0]));


