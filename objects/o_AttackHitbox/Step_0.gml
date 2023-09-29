/// @description
if(currentFrame == framesActive){
	instance_destroy();
}
currentFrame +=1;

var _newPos = {x:o_SnakeWitch.x,y:o_SnakeWitch.y}
var _xchange = _newPos.x-previousPlayerPos.x;
var _ychange = _newPos.y-previousPlayerPos.y;

if followPlayer{
	x+=_xchange;
	y+=_ychange;
}

previousPlayerPos =_newPos;