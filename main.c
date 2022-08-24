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
case 2:   // PARA EL MODO MULTIJUGADOR
                  init();
                  draw_net();
                  //Glcd_Write_Text("Wait",0,0,1);
            while(1){      
                  if(UART1_Data_Ready()==0){
					 while(UART1_Data_Ready()==0):
						Glcd_Write_Text("Waiting for other player",0,0,1);
						UART1_Write('1');
                  }
                  else{										//detectó que se conecto el otro pic
					Glcd_Write_Text("Press to start",0,0,1);
					while(1){
						E_M = UART1_Read();
						if(Button(&PORTC,0,1,1){
							E_M = 1;
							UART1_Write('2');
							Player = 1;
						}
						else if(E_M == '2'){				//Llego la senal del boton del pic maestro
							Glcd_Write_Text("    ",0,0,1);
							Glcd_Write_Text("P2",115,0,1);
							Player = 2;
							break;
						}
					}
                  }
				break;
			}
