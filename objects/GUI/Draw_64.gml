/// @description
draw_set_color(c_black);
draw_rectangle(0,0,2*width,100,false);
draw_set_color(c_red);
var _boxPosition = 0;
for( i=0; i<global.hp;i+=20){
	draw_rectangle(_boxPosition+20,20,_boxPosition+40,60,false);	
	_boxPosition +=25;
}



draw_set_color(c_white);
draw_set_font(fnt_gui_1);
draw_set_halign(fa_right);
draw_set_valign(fa_middle);
draw_text(2*width-30,50,"Wallet:"+string(global.wallet));

//debug
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(20,80,"state"+string(o_SnakeWitch.state));