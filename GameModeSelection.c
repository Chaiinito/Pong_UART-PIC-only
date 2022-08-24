
ADC_Init();
Delay_ms(200);
while(1):
	switch(estado){
		case 0:
			while(1):
				y = ADC_Read(0);
				if(y <= 100){
					Glcd_Image(player1); //Una imagen con el nombre de los dos modos pero con una flecha apuntando al modo singleplayer
					while(1):
						select1 = ADC_Read(0);
						if(boton == 1){
							estado = 1;	//Modo un jugador
						}
						else if(y >= 600){ //SI NO SE CONFIRMA LA ACCION
							break;
						}
				else if(y > = 600){
					Glcd_Image(player2);//Una imagen con el nombre de los dos modos pero con una flecha apuntando al modo multiplayer
					while(1):
						select2 = ADC_Read(0);
						if(boton == 1){
							estado = 2;	 //Modo 2 jugadores
						}
						else if(y <= 100){ //SI NO SE CONFIRMA LA ACCION
							break;
						}
				Glcd_Fill(0x00);
				break;
				}
		case 1: // SINGLEPLAYER
		
		case 2: // MULTIPLAYER
		
	}