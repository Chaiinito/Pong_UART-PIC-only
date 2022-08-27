//Hacer la prueba con button y ver si sirve con el portc 1

const code char SINGLEPLAYER[1024];
const code char MULTIPLAYER[1024];
const code chat COVER[1024];
unsigned short flag = 0;
unsigned short y = 0;
unsigned short turn = 0;
unsigned short score[] = {0,0};

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
	Glcd_V_Line(y, y+h, x, 1);	
}

void erase_player(unsigned short x, unsigned short y, unsigned short w, unsigned short h){
	Glcd_V_Line(y, y+h, x, 0);
}

void GameOver(){
	Glcd_Write_Text('GAME OVER',35, 4,1);
	Glcd_Write_Text('PRESS TO CONTINUE',32, 6,1);
	while(1){
		if(Button(&PORTC,1,1,1)){ //Quiero volver a la portada como si acabara de encender la consola
			Glcd_Fill(0x00);
			break;
		}	
	}
} 

/* void draw_score_Mult(){				No entiendo
     char *text;
     char text_1[5];
     ShortToStr(score[0],text_1);
     text = Ltrim(text_1);
     Glcd_Write_Text(text, 50, 0, 1);
     ShortToStr(score[1],text_1);
     text = Ltrim(text_1);
     Glcd_Write_Text(text,74 , 0, 1);
} */

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

void move_ball(){
	unsigned short i;
	unsigned short angle;
	unsigned short delay;
	
	if(delay == 2){
		delay = 0;
		Glcd_Dot(ball.x, ball.y, 0);
		
		ball.x += ball.dx;
		ball.y += ball.dy;
		
		if(ball.x < 3){ //bola entro a la porteria de la izquierda
			score[1] += 1;
			erase_player(paddle[0].x, paddle[0].y, paddle[0].w, paddle[0].h);
			erase_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);
			init();
		}
		if(ball.x > 125){//bola entro a la porteria de la derecha
			score[1] += 1;
			erase_player(paddle[0].x, paddle[0].y, paddle[0].w, paddle[0].h);
			erase_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);
			init();
		}
		if(ball.y <= 0 || ball.y >= 63){	// Choque con las paredes de arriba o abajo
			ball.dy = -ball.dy;
		}
		for(i = 0; i < 2; i++){
			if(check_collision(ball, paddle[i], i)){	//Si choca con algun paddle
				ball.dx = -ball.dx
				angle = (paddle[i].y + paddle[i].h)- ball.y) // donde impacta en el paddle
				
				switch(angle):
					case 0: ball.dy = 3;
					case 1: ball.dy = 3;
					case 2: ball.dy = 2;
					case 3: ball.dy = 2;
					case 4: ball.dy = 0;
					case 5: ball.dy = 0;
					case 6: ball.dy = -2;
					case 7: ball.dy = -2;
					case 8: ball.dy = -3;
					case 9: ball.dy = -3;
					
				if(ball.dx > 0){
					if(ball.x < 0){
						ball.x = 0;
					}
				}
				else{
					if(ball.x > 127){
						ball.x = 127;
						
					}
				}
			}
		}
		
	}
	else{
		delay ++;
	}
	
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

unsigned short check_winner(){
	unsigned short i;
	unsigned short j;
	for(i = 0; i < 2; i++){
		if(score[i] == 3){
			for(j = 0; j < 2; j++){
				score[j] = 0;
			}
			if (i == 0 ){
				return 1;
			}
			else{
				return 2;
			}
		}
	}
	return 0;
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
			Glcd_Fill(0x00); 
			break;
		}
	}	
}

void move_player(unsigned short i, unsigned short direction){
	if(direction == 0){							//Hacia abajo
		if(paddle[i].y >= 63 - paddle[i].h){	//No pasarse del limite de abajo
			paddle[i].y = 63 - paddle[i].h);
		}
		else{
			paddle[i].y +=2;
		}
	}
	if(direction == 1){							//Hacia arriba
		if(paddle[i].y <= 0){					//No pasarse del limite de arriba
            paddle[i].y = 0;
        }
        else{
            paddle[i].y -= 2;
        }	
	}
}

void main(){

	bool Master = false;
	unsigned short check;
	char Master_slave = '0';
	char move_other = '0';
	
	PORTC = 0;      	//Establecemos las entradas en 0 para evitar conflictos
	TRISC.F0 = 1;   //Entrada para el eje y
	TRISC.F1 = 1;	// Entrada para el boton del joystick


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
					if( y >= 600){		//Mover hacia abajo
						erase_player(paddle[1].x, paddle[1].y-2, paddle[1].w, paddle[1].h);
                        move_player(1,0);
                        draw_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);
					}
					if(y <= 200){		//Mover hacia arriba
						erase_player(paddle[1].x, paddle[1].y+2, paddle[1].w, paddle[1].h);
                        move_player(1,1);
                        draw_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);	
					}
					
					move_ball();
					draw_ball(ball.x, ball.y);
					
					move_ia();	//Falta hacer la funcion de mover ia
					draw_player(paddle[0].x, paddle[0].y, paddle[0].w, paddle[0].h);
					
					draw_score(0,50);
					draw_score(1,74);
					
					check = check_winner();
					
					if(check != 0){
						if(check == 1){
							Glcd_Write_Text("PC WINS", 43, 4,1);
							GameOver();
							
							Glcd_Fill(0x00);
							flag = 0;
							break;
						}
						if(check == 2){
							Glcd_Write_Text("YOU WIN", 43, 4,1);
							GameOver();
							
							Glcd_Fill(0x00);
							flag = 0;
							break;
						}
					}
			
			case 2:
				init();
				//draw_net();  Creo que no se necesita, es solo una linea punteada en el centro
				
				while(1){
					if(UART1_Data_Ready()==0){			//Espera a que se conecte la otra consola
						while(UART1_Data_Ready()==0):	//Manda constantemente un 1, siempre y cuando no detecte la otra consola
							Glcd_Write_Text("Waiting for other player",0,0,1);
							UART1_Write('1');
					}
					else{
						Glcd_Write_Text("Press to start",0,0,1);	//Una vez que se conecta,
						while(1){									// pide que se presione el joystick
							Master_slave = UART1_Read();			//Asi el primero que presione, sera el maestro
							if(Button(&PORTC,0,1,1){				//Y el que no presiono se le manda la senal para que 
								Master_slave = '1';					// sea el esclavo
								UART1_Write('2');
								Master = 1;
							}
							else if(Master_slave == '2'){
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
						erase_player(paddle[0].x, paddle[0].y-2, paddle[0].w, paddle[0].h);
						move_player(0,0);	//Jugador, direccion
						draw_player(paddle[0].x, paddle[0].y, paddle[0].w, paddle[0].h);
					}
					if(y <= 100){ //Mover hacia arriba
						erase_player(paddle[0].x, paddle[0].y+2, paddle[0].w, paddle[0].h);
						move_player(0,1);
						draw_player(paddle[0].x, paddle[0].y, paddle[0].w, paddle[0].h);
					}
				
					if(UART1_Read() == '1'){
						erase_player(paddle[1].x, paddle[1].y-2, paddle[1].w, paddle[1].h);
						move_player(1,0); //Jugador, direccion
						draw_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);
					}
					if(UART1_Read() == '2'){
						erase_player(paddle[1].x, paddle[1].y+2, paddle[1].w, paddle[1].h);
						move_player(1,1); //Jugador, direccion
						draw_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);
					}
					
					move_ball();
					draw_ball(ball.x, ball.y);
					draw_score(0,50);//Jugador, posx
					draw_score(1,74);
					
					//serial_pack_data();
					//send_pack_data(serial_data);
					while (UART1_Tx_Idle()!=1);
					
					check = check_winner;
					if(check != 0){
						if(check == 1){
							Glcd_Write_Text("PC WINS", 43, 4,1);
							GameOver();
							
							Glcd_Fill(0x00);
							flag = 0;
							break;
						}
						if(check == 2){
							Glcd_Write_Text("YOU WIN", 43, 4,1);
							GameOver();
							
							Glcd_Fill(0x00);
							flag = 0;
							break;
						}
					}
				}
			}
			else{		//Si no existe Master es porque este pic es el esclavo
				while(1){
					y = ADC_Read(0);
					
					if(y >= 600){	//Mover hacia abajo
						move_other = '1';
					}
					if(y <= 200){ 	//Mover hacia arriba
						move_other = '2';
					}
					else{move_other = '0';}
					send_char(move_other);
					
					//reciv_pack_data(serial_data);
                    //deserial_pack_data();
				
					
					draw_player(paddle[0].x, paddle[0].y, paddle[0].w, paddle[0].h);
                    draw_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);
                    draw_ball(ball.x,ball.y);
					
					check = check_winner;
					if(check != 0){
						if(check == 1){
							Glcd_Write_Text("PC WINS", 43, 4,1);
							GameOver();
							flag = 0;
							break;
						}
						if(check == 2){
							Glcd_Write_Text("YOU WIN", 43, 4,1);
							GameOver();
							flag = 0;
							break;
						}
					}
				}
				
				
			}
		}
}
