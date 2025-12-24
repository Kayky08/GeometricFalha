#region variáveis

//Variaveis de movimentação
hspd     = 0;
max_hspd = 2;

vspd     = 0;
max_vspd = 5;
grav     = 0.2;

//Variaveis de level
chao = false;

//Variaveis de inputs
right = false;
left  = false;
jump  = false;

//Variaveis dos estados
estado = noone;

#endregion

#region métodos

pega_input = function (){
   right = keyboard_check(ord("D"));
   left  = keyboard_check(ord("A"));
   jump  = keyboard_check_pressed(vk_space);
}

troca_sprite = function (_sprite = spr_colisao) {
    //Verificando se a sprite é diferente
    if (sprite_index != _sprite) {
        //Trocando a sprite
    	sprite_index = _sprite;
        
        //Zerando a animação
        image_index = 0;
    }
}

//Metodo de movimentação
movimento = function () {
    //Usando o move and collide vertical
    move_and_collide(0, vspd, obj_colisao, 12);
    
    //Usando o move and collide horizontal
    move_and_collide(hspd, vspd, obj_colisao, 4);
}
aplica_velocidade = function (){
    //Aplicando as inputs no hspd
    hspd = (right - left) * max_hspd;
    
    //Aplicando a gravidade
    if (!chao) {
        vspd += grav
    }
    else {
    	vspd = 0
        
        //Arredondando a posição Y
        y = round(y)
        
        //Verificando se eu posso pular e pulando
        if (jump && chao) {
    	   vspd -= max_vspd
        }
    }
}
checa_chao = function (){
    //Verifcando se a mascara de colisão esta tocando o chão
    chao = place_meeting(x, y + 1, obj_colisao)
}

//Métodos dos estados
estado_parado = function () {
    //Definindo a sprite
    troca_sprite(spr_player_idle);
    
    //Verificando se o player esta se movendo
    if (left != right) {
        //Trocando o estado do player
    	estado = estado_movendo;
    }
    
    //Verificando se o player esta pulando
    if (jump) {
        //Trocando o estado do player
    	estado = estado_pulando;
    }
    
    if (!chao) {
    	estado = estado_pulando;
    }
}
estado_movendo = function () {
    aplica_velocidade()
    
    //Definindo a sprite
    troca_sprite(spr_player_run); 
    
    //Verificando se o player esta parado
    if (vspd == 0) {
        //Trocnado de estado
        estado = estado_parado;
    }
    
    if (jump) {
        //Trocando o estado do player
    	estado = estado_pulando;
    }
}
estado_pulando = function () { 
    aplica_velocidade()
    
    //Definindo a sprite
    if (vspd < 0){
        troca_sprite(spr_player_jump_up);
    }
    else {
    	troca_sprite(spr_player_jump_down)
    }
    
    //Verificando se o player esta no chao
    if (chao) {
        //Trocando de estado
    	estado = estado_parado;
    }
}
estado_powerup_inicio = function () {
    troca_sprite(spr_player_powerup_start)
    
    if (image_index >= image_number) {
    	estado = estado_powerup_meio;
    }
}
estado_powerup_meio = function () {
    troca_sprite(spr_player_powerup_middle)
}
estado_powerup_fim = function () {
    troca_sprite(spr_player_powerup_end)
}



#endregion

#region debug
roda_debug = function (){
    show_debug_overlay(1);
    
    //Criando uma view para as informações de debug
    view_player = dbg_view("view player", 1, 40, 100, 300, 400);
    
    //Vendo informações de debug
    dbg_watch(ref_create(id,"vspd"), "vertical speed");
    dbg_watch(ref_create(id,"hspd"), "horizontal speed");
    
    //Modificando variveis pelo debug
    dbg_slider(ref_create(id,"max_vspd"), 0, 10, "max vspd", .1);
    dbg_slider(ref_create(id,"grav"), 0.1, 1, "gravity", .1);
}
ativa_debug = function () {
    if (!DEBUG_MODE) return;
    
    if (keyboard_check_pressed(vk_tab)) {
        //Invertendo o valor da variavel debug
    	global.debug = !global.debug;
        
        //Verificando se o jogo esta no modo de debug
        if (global.debug) {
            //Rodando a funçao de debug
        	roda_debug();
        }
        else {
            //Desativando o debug overlay
            show_debug_overlay(0)
            
            //Verificando se existe a view do player
        	if dbg_view_exists(view_player){
                //Deletando a view do player
                dbg_view_delete(view_player);
            }
        }
    }
}

#endregion

estado = estado_powerup_inicio;