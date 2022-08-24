

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
