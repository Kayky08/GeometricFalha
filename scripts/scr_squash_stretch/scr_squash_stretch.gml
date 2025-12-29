function inicia_efeito_squash(){
	xscale = 1;
	yscale = 1;
}
function efeito_squash(_xscale = 1,_yscale = 1){
	xscale = _xscale;
	yscale = _yscale;
}
function retorna_squash(_qtd = .1){
	xscale = lerp(xscale,1,_qtd);
	yscale = lerp(yscale,1,_qtd);
}
function desenha_efeito_squash(){
	draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, image_angle, image_blend, 1);
}