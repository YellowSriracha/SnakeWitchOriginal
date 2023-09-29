/// @description

/// @description Insert description here
// You can write your code in this editor

viewW = 640;
viewH =  360;
isHitstop = false;
hitstopFrames = 0;
directionBuffer =0;
currentDirection = 1;

playerx=o_SnakeWitch.x;
playery=o_SnakeWitch.y;
groundy = room_height-viewH-(32*2);
view_camera[0] = camera_create_view(0, groundy, viewW, viewH, 0, -1, -1, -1, 0, 0);


viewX = camera_get_view_x(view_camera[0]);
viewY = camera_get_view_y(view_camera[0]);

function hitstop(_frames=1){
	isHitstop = true;
	hitstopFrames = _frames;
	room_speed = 5;
}


