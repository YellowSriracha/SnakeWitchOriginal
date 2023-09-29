/// @description every 1/4 second, record sprite position and state to draw trail


positionQueue[positionQueueIndex] = {x, y, image_xscale, image_yscale, sprite_index, image_index,alpha:TRAILALPHA};
positionQueueIndex+=1;
if(positionQueueIndex>2) positionQueueIndex = 0;

alarm[0] = game_get_speed(gamespeed_fps)/4;


