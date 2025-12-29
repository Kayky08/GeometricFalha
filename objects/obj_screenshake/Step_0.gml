if treme != 0.1{
	var _x = random_range(-treme, treme);
	var _y = random_range(-treme, treme);
	
	//alterando a posição X da viewport
	view_set_xport(view_current, _x);
	view_set_yport(view_current, _y);
}
else{
	//Chegando perto de zero, zera o valor do treme
	treme = 0
	
	//Garantindo que a posição da view é zerada
	view_set_xport(view_current,0);
	view_set_yport(view_current,0);
}

treme = lerp(treme,0,.1);