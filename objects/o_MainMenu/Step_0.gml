/// @description 

var _up = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
var _down = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
var _select = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("Z"));

var _move = _down-_up;

//Menu Scrolling
if _move != 0{
	index += _move;
	audio_play_sound(sfx_menu_beep,1,0);
	if index < 0 {
		index = 0;
	} else if (index >= array_length(menu[sub_menu])){
		index = array_length(menu[sub_menu])-1;
	}
}

//Menu Select
if(_select){
	audio_play_sound(sfx_menu_beep,1,0);
	switch(menu[sub_menu,index]){
		case "Start":
			room_goto(rm_Moon);
			break;
		case "Options":
			index = 0;
			sub_menu=1;
			break;
		case "Exit":
			game_end();
		case "Back":
			index = 0;
			sub_menu=0;
			break;
	}	
}
