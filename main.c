const code char SINGLEPLAYER[1024];
const code char MULTIPLAYER[1024];
const code chat COVER[1024];
unsigned short flag = 0;
unsigned short y = 0;

void main(){

bool Master = false;


Glcd_Init();	
Glcd_Fill(0x00);


UART1_Init(9600);
Delay_ms(200);

ADC_Init();

Glcd_Image(COVER);
Delay_ms(3500);

	while(1):
		switch(flag){
			case 0:
				while(1):
					y = ADC_Read(0);
					if(y <= 100){
						Glcd_Image(SINGLEPLAYER);
						while(1):
							y = ADC_Read(0);
							if(Button(&PORTC,1,1,1)){
								flag = 1;
							}
							else if(y >= 600){
								break;
							}
					}
					else if(y >= 600){
						Glcd_Image(MULTIPLAYER);
						while(1):
							y = ADC_Read(0);
							if(Button(&PORTC,1,1,1)){
								flag = 2;
							}
							else if(y <= 100){
								break;
							}
					Glcd_Fill(0x00);
					break;
					}
		

			case 1:
				init();
				draw_net();
				while(1);
					y = ADC_Read(0);
					
			
			case 2:
			
				init();
				draw_net();
				
				while(1){
					if(UART1_Data_Ready()==0){
						while(UART1_Data_Ready()==0):
							Glcd_Write_Text("Waiting for other player",0,0,1);
							UART1_Write('1');
					}
					else{
						Glcd_Write_Text("Press to start",0,0,1);
						while(1){
							E_M = UART1_Read();
							if(Button(&PORTC,0,1,1){
								E_M = 1;
								UART1_Write('2');
								Master = 1;
							}
							else if(E_M == '2'){
								Glcd_Write_Text("    ",0,0,1);
								Glcd_Write_Text("P2",115,0,1);
								Master = 0;
								break;
							}
						}
					}
					break;
				}
			
			if(Master == true){//Si existe Master es porque este pic es el maestro
				while(1){
					y = ADC_Read(0);
					
					if(y >= 600){ //Mover hacia abajo
						
						
					}
					if(y <= 100){ //Mover hacia arriba
						
						
					}
					
					
				}
			}
			else{		//Si no existe Master es porque este pic es el esclavo
				while(1){
					y = ADC_Read(0);
					
					if(y >= 600){	//Mover hacia abajo
						
					}
					if(y <= 100){ 	//Mover hacia arriba
						
					}
					
					
				}
				
				
			}
		}
}
