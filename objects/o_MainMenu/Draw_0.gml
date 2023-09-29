/// @description

draw_set_halign(fa_center);
//draw_set_valign(fa_middle);
draw_set_font(font_menu);
var _gap = 100;

draw_sprite_ext(sp_menu_logo,0,room_width/2,.3*room_height,3,3,0,c_white,1);
for (var i = 0; i < array_length(menu[sub_menu]); i++;){
	draw_set_color(c_white);
	if i == index {
		draw_set_color(c_green);
		draw_sprite_ext(sp_snake_menu_select,0,room_width/2-200,.5*room_height+i*_gap,3,3,0,c_white,1);
	}
	draw_text(room_width/2,.5*room_height+i*_gap,menu[sub_menu,i]);
}

