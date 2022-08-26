//Hacer la prueba con button y ver si sirve con el portc 1

const code char SINGLEPLAYER[1024];
const code char MULTIPLAYER[1024];
const code chat COVER[1024];
unsigned short flag = 0;
unsigned short y = 0;

typedef struct players{
	unsigned short x;
    unsigned short y;
    unsigned short w;
    unsigned short h;	
}paddles;

typedef struct ball{
    signed short x;
    signed short y;
    signed short dx;
    signed short dy;
}balls;

paddles paddle [2];
balls ball;


paddles 
balls 


char GLCD_DataPort at PORTD;
sbit GLCD_CS1 at LATB0_bit;
sbit GLCD_CS2 at LATB1_bit;
sbit GLCD_RS  at LATB2_bit;
sbit GLCD_RW  at LATB3_bit;
sbit GLCD_EN  at LATB4_bit;
sbit GLCD_RST at LATB5_bit;

sbit GLCD_CS1_Direction at TRISB0_bit;
sbit GLCD_CS2_Direction at TRISB1_bit;
sbit GLCD_RS_Direction  at TRISB2_bit;
sbit GLCD_RW_Direction  at TRISB3_bit;
sbit GLCD_EN_Direction  at TRISB4_bit;
sbit GLCD_RST_Direction at TRISB5_bit;

void draw_player(unsigned short x, unsigned short y, unsigned short w, unsigned short h){
		
}

void erase_player(unsigned short x, unsigned short y, unsigned short w, unsigned short h){
	Glcd_V_Line(y, y+h, x, 0);
}

void GameOver(){
	Glcd_Write_Text('GAME OVER',35, 4,1);
	Glcd_Write_Text('PRESS TO CONTINUE',32, 6,1);
	while(1):
		if(Button(&PORTC,1,1,1)){ //Quiero volver a la portada como si acabara de encender la consola
		
		}	
}

void init(){
	//coordenadas de inicio del P1
	paddle[0].x =  5;
    paddle[0].y = 30;
    paddle[0].w = 2;
    paddle[0].h = 9;
	//coordenadas de inicio del P2
	paddle[1].x =  121;
    paddle[1].y = 30;
    paddle[1].w = 2;
    paddle[1].h = 9;
	
	ball.x = 64;
    ball.y = 32;
    ball.dx = 2;
    ball.dy = 2;
	
	draw_player(paddle[0].x, paddle[0].y, paddle[0].w, paddle[0].h);
    draw_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);
    draw_ball(ball.x, ball.y);
}

short check_collision(paddles Paddle, balls Ball, unsigned short x){ //Retorna 1 si detecta colision / 0 si no
	if(x == 1){
		if((Ball.y >= Paddle.y) && (Ball.y < (Paddle.y + Paddle.h)) && (Ball.x+1 == Paddle.x)){ //check collision con el lado izquierdo
			return x;
		}
		else{
			return 0;
		}
	}
	else{
		if((Ball.y >= Paddle.y) && (Ball.y < (Paddle.y + Paddle.h)) && (Ball.x == Paddle.x + 1)){ // check collision con el lado derecho
			return 1;
		}
		else{
			return 0;
		}
	}
} 

unsigned short 


void draw_score(unsigned short jugador, unsigned short posx){

       if (score[jugador] == 0){
          Glcd_Write_Char('0',posx,0,1);
       }
       else if(score[jugador] == 1){
            Glcd_Write_Char('1',posx,0,1);
       }
       else if(score[jugador] == 2){
            Glcd_Write_Char('2',posx,0,1);
       }
       else if(score[jugador] == 3){
            Glcd_Write_Char('3',posx,0,1);
       }
       else if(score[jugador] == 4){
            Glcd_Write_Char('4',posx,0,1);
       }
       else if(score[jugador] == 5){
            Glcd_Write_Char('5',posx,0,1);
       }
}




void DrawPlayer(unsigned short x, unsigned short y, unsigned short w, unsigned short h){
	Glcd_V_Line(y, y+h, x, 1);
}
void DrawBall(unsigned short x, unsigned short y){
	Glcd_Dot(x, y, 1);
}

void cover(){
	Glcd_Image(COVER);
	while(1){
		if(Button(&PORTC,1,1,1)){
			Glcd_Fill(0x00);                                     // Clear GLCD
			break;
		}
	}	
}

void main(){

	bool Master = false;


	Glcd_Init();	
	Glcd_Fill(0x00);
	
	TRISC.F0 = 1;	//Declarampos la entrada del joystick
	TRISC.F1 = 1; 	//Declaramos la entrada del boton

	UART1_Init(9600);
	Delay_ms(200);

	ADC_Init();

	cover();		//Imprimimos la portada hasta que se presiona

	while(1):
		switch(flag){
			case 0:			//Menu de inicio
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
					if( y >= 600){
						erase_player(paddle[1].x, paddle[1].y-2, paddle[1].w, paddle[1].h);
                        move_players(0,1);
                        draw_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);
					}
					if(y <= 100){
						erase_player(paddle[1].x, paddle[1].y+2, paddle[1].w, paddle[1].h);
                        move_players(0,1);
                        draw_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);	
					}
					
					move_ball();
					
					
			
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

