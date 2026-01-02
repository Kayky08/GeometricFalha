var _esc = random_range(0,0.02);

gpu_set_blendmode(bm_add);
draw_sprite_ext(spr_brilho_tocha, 0, x, y, 0.5 + _esc, 0.5 + _esc, 0, c_purple, 0.3);
gpu_set_blendmode(bm_normal);