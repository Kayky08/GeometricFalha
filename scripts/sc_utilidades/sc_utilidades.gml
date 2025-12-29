#macro DEBUG_MODE 0
#macro FPS game_get_speed(gamespeed_fps) 

//Criando configurações diferentes para cada tipo de jogo
#macro modo_normal:DEBUG_MODE 0 
#macro modo_debug:DEBUG_MODE 1

#region variveis globais

global.debug = false;

#endregion