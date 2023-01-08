#line 1 "C:/Users/Gabriel RP/Desktop/Taller embebidos/proyecto 1/Pong_tallerEmpotrados-main/pong.c"

const code char Portada[1024];
unsigned short flag = 0;
unsigned short y = 0;
unsigned short score[] = {0,0};
unsigned short turno = 0;
unsigned short turno_paleta = 0;

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
paddles send_paddles[2];
balls send_balls;

char info[9];
char fin[5];

char how[1];



char GLCD_DataPort at PORTD;
sbit GLCD_CS1 at LATB0_bit;
sbit GLCD_CS2 at LATB1_bit;
sbit GLCD_RS at LATB2_bit;
sbit GLCD_RW at LATB3_bit;
sbit GLCD_EN at LATB4_bit;
sbit GLCD_RST at LATB5_bit;

sbit GLCD_CS1_Direction at TRISB0_bit;
sbit GLCD_CS2_Direction at TRISB1_bit;
sbit GLCD_RS_Direction at TRISB2_bit;
sbit GLCD_RW_Direction at TRISB3_bit;
sbit GLCD_EN_Direction at TRISB4_bit;
sbit GLCD_RST_Direction at TRISB5_bit;

void draw_player(unsigned short x, unsigned short y, unsigned short w, unsigned short h){
 Glcd_V_Line(y, y+h, x, 1);
}

void erase_player(unsigned short x, unsigned short y, unsigned short w, unsigned short h){
 Glcd_V_Line(y, y+h, x, 0);
}

void DrawBall(unsigned short x, unsigned short y){
 Glcd_Dot(x, y, 1);
}


void init(){

 paddle[0].x = 5;
 paddle[0].y = 30;
 paddle[0].w = 2;
 paddle[0].h = 9;

 paddle[1].x = 121;
 paddle[1].y = 30;
 paddle[1].w = 2;
 paddle[1].h = 9;

 ball.x = 64;
 ball.y = 32;
 ball.dx = 2;
 ball.dy = 2;

 draw_player(paddle[0].x, paddle[0].y, paddle[0].w, paddle[0].h);
 draw_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);
 DrawBall(ball.x, ball.y);
}

short check_collision(paddles paleta, balls bola, unsigned short a){
 if(a == 1){

 if((bola.x+1 == paleta.x) && (bola.y >= paleta.y) && (bola.y <= (paleta.y + paleta.h))){
 return 1;
 }
 else{
 return 0;
 }
 }
 else{
 if((bola.x == paleta.x + 1) && (bola.y >= paleta.y) && (bola.y <= (paleta.y + paleta.h))){
 return 1;
 }
 else{
 return 0;
 }
 }
}

void move_ball(){
 unsigned short i;
 signed short angle;
 if((turno == 10 && flag == 1) ||(turno == 5 && flag == 2) ){
 Glcd_Dot(ball.x, ball.y, 0);
 ball.x += ball.dx;
 ball.y += ball.dy;
 if(ball.x < 3){
 score[1] += 1;
 erase_player(paddle[0].x, paddle[0].y, paddle[0].w, paddle[0].h);
 erase_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);
 init();
 }
 if(ball.x > 125){
 score[0] += 1;
 erase_player(paddle[0].x, paddle[0].y, paddle[0].w, paddle[0].h);
 erase_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);
 init();
 }
 if(ball.y <= 0 || ball.y >= 63){
 ball.dy = -ball.dy;
 }
 for(i = 0; i < 2; i++){
 if(check_collision(paddle[i],ball,i)){
 ball.dx = -ball.dx;
 angle = ((paddle[i].y + paddle[i].h)- ball.y);
 switch(angle){
 case 0:
 ball.dy = 3;
 break;
 case 1:
 ball.dy = 3;
 break;
 case 2:
 ball.dy = 2;
 break;
 case 3:
 ball.dy = 2;
 break;
 case 4:
 ball.dy = 0;
 break;
 case 5:
 ball.dy = 0;
 break;
 case 6:
 ball.dy = -2;
 break;
 case 7:
 ball.dy = -2;
 break;
 case 8:
 ball.dy = -3;
 break;
 case 9:
 ball.dy = -3;
 break;
 }
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
}

void draw_score(){
 unsigned short posx = 0;
 unsigned short jugador = 0;
 for(jugador = 0; jugador < 2; jugador ++){
 if(jugador == 0){
 posx = 50;
 }
 if(jugador == 1){
 posx = 74;
 }
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
}

short check_winner(){
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


void cover(){
 Glcd_Image(portada);
 while(1){
 if(Button(&PORTC,1,1,0)){
 Glcd_Fill(0x00);
 break;
 }
 }
}

 void move_ia(){
 unsigned short centro_ia = paddle[0].y + 4;
 short ball_speed = ball.dy;
 int contador = rand() % 3;
 if(turno == 10){
 erase_player(paddle[0].x, paddle[0].y, paddle[0].w, paddle[0].h);
 if(ball_speed < 0){
 ball_speed = -ball_speed;
 }
 if(ball.dx > 0){
 switch(contador){
 case 0:
 paddle[0].y = paddle[0].y;
 break;
 case 1:
 paddle[0].y = paddle[0].y+2;
 break;
 case 2:
 paddle[0].y = paddle[0].y-2;
 break;
 }
 }
 else{
 if(ball.x < 64){
 if(ball.dy > 0){
 if(ball.y > centro_ia){
 if(paddle[0].y + ball_speed < 64){
 paddle[0].y += (ball_speed);
 }
 else{
 paddle[0].y = 63 - paddle[0].h;
 }
 }
 else{
 if(paddle[0].y - ball_speed > 0){
 paddle[0].y -= (ball_speed);
 }
 else{
 paddle[0].y = 0;
 }
 }
 }
 if(ball.dy < 0){
 if(ball.y < centro_ia){
 if(paddle[0].y - ball_speed > 0){
 paddle[0].y -= (ball_speed);
 }
 else{
 paddle[0].y = 0;
 }
 }
 else{
 if(paddle[0].y < 64){
 paddle[0].y += (ball_speed);
 }
 else{
 paddle[0].y = 63 - paddle[0].h;
 }
 }
 }
 if(ball.dy == 0){
 if(ball.y < centro_ia){
 paddle[0].y -= 3;
 }
 else {
 paddle[0].y += 3;
 }
 }
 }
 }
 }
}

void move_player(unsigned short i, unsigned short direction){
 if (turno_paleta == 10){
 if(direction == 0){
 if(paddle[i].y >= 63 - paddle[i].h){
 paddle[i].y = (63 - paddle[i].h);
 }
 else{
 paddle[i].y +=2;
 }
 }
 else if(direction == 1){
 if(paddle[i].y <= 0){
 paddle[i].y = 0;
 }
 else{
 paddle[i].y -= 2;
 }
 }
 }
}


void data_pack() {

 info[0] = ball.x + '0';
 info[1] = ball.y + '0';


 info[2] = score[0] + '0';
 info[3] = score[1] + '0';


 info[4] = paddle[0].y + '0';
 info[5] = paddle[1].y + '0';


 info[6] = 'O';
 info[7] = 'K';
 info[8] = 0;
}

void desdata_pack(){
 ball.x = info[0] - '0';
 ball.y = info[1] - '0';

 score[0] = info[2] - '0';
 score[1] = info[3] - '0';

 paddle[0].y = info[4] - '0';
 paddle[1].y = info[5] - '0';
}

void output_character(char charValue){
 while (UART1_Tx_Idle()!= 1);
 UART1_Write(charValue);
}

void input_character(char char_dir){
 while (UART1_Data_Ready() == 0);
 char_dir = UART1_Read();
}

void output_data(char *serial_dir){
 while (UART1_Tx_Idle()!= 1);
 UART1_Write_Text(serial_dir);
}

void input_data(char *text_dir){
 while(UART1_Data_Ready()==0);
 UART1_Read_Text(text_dir, "OK", 255);
}

void save_old_data(){
 send_paddles[0].y = paddle[0].y;
 send_paddles[1].y = paddle[1].y;

 send_balls.x = ball.x;
 send_balls.y = ball.y;
 send_balls.dx = ball.dx;
 send_balls.dy = ball.dy;
}


void main(){

 unsigned short Master = 0;
 unsigned short check;
 unsigned short tiempo;
 char Master_slave = '0';
 char move_other = 0;
 char msg = '3';

 PORTC = 0;
 TRISC.F0 = 1;
 TRISC.F1 = 1;


 Glcd_Init();
 Glcd_Fill(0x00);

 UART1_Init(9600);
 Delay_ms(200);

 ADC_Init();

 cover();
 delay_ms(1000);

 while(1){
 switch(flag){
 case 0:
 while(1){
 y = ADC_Read(0);
 if(y <= 20){
 Glcd_Write_Text("one player",15,0,1);
 delay_ms(1000);
 while(1){
 y = ADC_Read(0);

 if(Button(&PORTC,1,1,0)){
 flag = 1;
 break;
 }
 else if(y >= 200){
 break;
 }
 }Glcd_Fill(0x00);

 }
 else if(y >= 200){
 Glcd_Write_Text("multiplayer",15,0,1);
 delay_ms(1000);

 while(1){
 y = ADC_Read(0);
 if(Button(&PORTC,1,1,0)){
 flag = 2;
 Glcd_Fill(0x00);
 break ;
 }
 else if(y <= 20){
 Glcd_Fill(0x00);
 break;
 }
 }
 Glcd_Fill(0x00);
 }
 else if(flag == 1 || flag == 2){
 break;
 }
 }Master == 0;
 break;
 case 1:
 delay_ms(100);
 Glcd_Fill(0x00);
 init();
 while(1){
 y = ADC_Read(0);
 if(turno > 10){
 turno = 0;
 }
 if(turno_paleta > 10){
 turno_paleta = 0;
 }
 if( y >= 190){
 erase_player(paddle[1].x, paddle[1].y-2, paddle[1].w, paddle[1].h);
 move_player(1,0);
 draw_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);
 }
 else if(y <= 30){
 erase_player(paddle[1].x, paddle[1].y+2, paddle[1].w, paddle[1].h);
 move_player(1,1);
 draw_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);
 }

 move_ball();
 DrawBall(ball.x, ball.y);
 move_ia();

 draw_player(paddle[0].x, paddle[0].y, paddle[0].w, paddle[0].h);

 draw_score();

 check = check_winner();

 if(check != 0){
 if(check == 1){
 Glcd_Write_Text("PC WINS", 43, 4,1);
 delay_ms (10000);

 score[0] == 0;
 score[1] == 0;
 Glcd_Fill(0x00);
 flag = 0;
 break;
 }
 if(check == 2){
 Glcd_Write_Text("YOU WIN", 43, 4,1);
 delay_ms (10000);

 score[0] == 0;
 score[1] == 0;
 Glcd_Fill(0x00);
 flag = 0;
 break;
 }
 }
 turno ++;
 turno_paleta ++;
 }
 break;
 case 2:
 init();
 Glcd_Fill(0x00);
 delay_ms(1000);

 if(UART1_Data_Ready()==0){
 while(1){
 Glcd_Write_Text("Waiting for other player",0,0,1);
 UART1_Write('1');
 if(UART1_Data_Ready() ==1){
 break;
 }

 }
 Glcd_Fill(0x00);
 }
 else{
 for (tiempo = 0; tiempo < 200; tiempo ++){
 UART1_Write('1');

 }
 Glcd_Write_Text("Press to start",0,0,1);

 while(1){

 Master_slave = UART1_Read();
 if(Button(&PORTC,1,1,0)){
 UART1_Write('3');
 Master = 1;
 break;
 }
 else if(Master_slave == '3'){
 Master = 2;
 break;
 }
 }
 Master_slave == '0';
 Glcd_Fill(0x00);
 }
 delay_ms(500);

 if(Master == 1){
 while(1){
 y = ADC_Read(0);
 if(turno > 5){
 turno = 0;
 }
 if(turno_paleta > 10){
 turno_paleta = 0;
 }
 if(y >= 190){
 erase_player(paddle[0].x, paddle[0].y-2, paddle[0].w, paddle[0].h);
 move_player(0,0);
 draw_player(paddle[0].x, paddle[0].y, paddle[0].w, paddle[0].h);
 }
 else if(y <= 25){
 erase_player(paddle[0].x, paddle[0].y+2, paddle[0].w, paddle[0].h);
 move_player(0,1);
 draw_player(paddle[0].x, paddle[0].y, paddle[0].w, paddle[0].h);
 }

 while(UART1_Data_Ready()==0);

 if(UART1_Read() == '1'){
 erase_player(paddle[1].x, paddle[1].y-2, paddle[1].w, paddle[1].h);
 move_player(1,0);
 draw_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);
 }
 else if(UART1_Read() == '2'){
 erase_player(paddle[1].x, paddle[1].y+2, paddle[1].w, paddle[1].h);
 move_player(1,1);
 draw_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);
 }

 move_ball();
 DrawBall(ball.x, ball.y);
 draw_score();

 data_pack();
 output_data(info);

 while (UART1_Tx_Idle() != 1);

 check = check_winner();
 if(check != 0){
 if(check == 1){
 Glcd_Write_Text("P1 WINS", 43, 4,1);
 delay_ms(10000);

 Glcd_Fill(0x00);
 score[0] == 0;
 score[1] == 0;
 flag = 0;
 break;
 }
 if(check == 2){
 Glcd_Write_Text("P2 WIN", 43, 4,1);
 delay_ms(10000);
 UART1_Write_Text(fin);
 Glcd_Fill(0x00);
 score[0] == 0;
 score[1] == 0;
 flag = 0;
 break;
 }
 }
 turno ++;
 turno_paleta++;
 }
 }

 if (Master == 2){
 while(1){

 y = ADC_Read(1);
 save_old_data();

 if(y >= 190){
 move_other = '1';
 }
 else if(y <= 25){
 move_other = '2';
 }
 else{move_other = '0';}

 output_character(move_other);
 input_data(info);
 desdata_pack ();

 if(send_balls.x != ball.x || send_balls.y != ball.y){
 Glcd_Dot(send_balls.x, send_balls.y, 0);
 }
 if(send_paddles[0].y != paddle[0].y){
 erase_player(paddle[0].x, send_paddles[0].y, paddle[0].w, paddle[0].h);
 }
 if(send_paddles[1].y != paddle[1].y){
 erase_player(paddle[1].x, send_paddles[1].y, paddle[1].w, paddle[1].h);
 }

 draw_score();

 draw_player(paddle[0].x, paddle[0].y, paddle[0].w, paddle[0].h);
 draw_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);
 DrawBall(ball.x,ball.y);

 check = check_winner();
 if(check != 0){
 if(check == 1){
 Glcd_Write_Text("P1 WINS", 43, 4,1);
 delay_ms(10000);
 Glcd_Fill(0x00);
 score[0] == 0;
 score[1] == 0;
 flag = 0;
 break;
 }
 if(check == 2){
 Glcd_Write_Text("P2 WIN", 43, 4,1);
 delay_ms(10000);
 Glcd_Fill(0x00);
 score[0] == 0;
 score[1] == 0;
 flag = 0;
 break;
 }
 }
 }
 }
 break;

 }
 }
}
