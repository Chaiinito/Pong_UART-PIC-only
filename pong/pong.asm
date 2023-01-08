
_draw_player:

;pong.c,50 :: 		void draw_player(unsigned short x, unsigned short y, unsigned short w, unsigned short h){
;pong.c,51 :: 		Glcd_V_Line(y, y+h, x, 1);
	MOVF        FARG_draw_player_y+0, 0 
	MOVWF       FARG_Glcd_V_Line_y_start+0 
	MOVF        FARG_draw_player_h+0, 0 
	ADDWF       FARG_draw_player_y+0, 0 
	MOVWF       FARG_Glcd_V_Line_y_end+0 
	MOVF        FARG_draw_player_x+0, 0 
	MOVWF       FARG_Glcd_V_Line_x_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_V_Line_color+0 
	CALL        _Glcd_V_Line+0, 0
;pong.c,52 :: 		}
L_end_draw_player:
	RETURN      0
; end of _draw_player

_erase_player:

;pong.c,54 :: 		void erase_player(unsigned short x, unsigned short y, unsigned short w, unsigned short h){
;pong.c,55 :: 		Glcd_V_Line(y, y+h, x, 0);
	MOVF        FARG_erase_player_y+0, 0 
	MOVWF       FARG_Glcd_V_Line_y_start+0 
	MOVF        FARG_erase_player_h+0, 0 
	ADDWF       FARG_erase_player_y+0, 0 
	MOVWF       FARG_Glcd_V_Line_y_end+0 
	MOVF        FARG_erase_player_x+0, 0 
	MOVWF       FARG_Glcd_V_Line_x_pos+0 
	CLRF        FARG_Glcd_V_Line_color+0 
	CALL        _Glcd_V_Line+0, 0
;pong.c,56 :: 		}
L_end_erase_player:
	RETURN      0
; end of _erase_player

_DrawBall:

;pong.c,58 :: 		void DrawBall(unsigned short x, unsigned short y){
;pong.c,59 :: 		Glcd_Dot(x, y, 1);
	MOVF        FARG_DrawBall_x+0, 0 
	MOVWF       FARG_Glcd_Dot_x_pos+0 
	MOVF        FARG_DrawBall_y+0, 0 
	MOVWF       FARG_Glcd_Dot_y_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Dot_color+0 
	CALL        _Glcd_Dot+0, 0
;pong.c,60 :: 		}
L_end_DrawBall:
	RETURN      0
; end of _DrawBall

_init:

;pong.c,63 :: 		void init(){
;pong.c,65 :: 		paddle[0].x =  5;
	MOVLW       5
	MOVWF       _paddle+0 
;pong.c,66 :: 		paddle[0].y = 30;
	MOVLW       30
	MOVWF       _paddle+1 
;pong.c,67 :: 		paddle[0].w = 2;
	MOVLW       2
	MOVWF       _paddle+2 
;pong.c,68 :: 		paddle[0].h = 9;
	MOVLW       9
	MOVWF       _paddle+3 
;pong.c,70 :: 		paddle[1].x =  121;
	MOVLW       121
	MOVWF       _paddle+4 
;pong.c,71 :: 		paddle[1].y = 30;
	MOVLW       30
	MOVWF       _paddle+5 
;pong.c,72 :: 		paddle[1].w = 2;
	MOVLW       2
	MOVWF       _paddle+6 
;pong.c,73 :: 		paddle[1].h = 9;
	MOVLW       9
	MOVWF       _paddle+7 
;pong.c,75 :: 		ball.x = 64;
	MOVLW       64
	MOVWF       _ball+0 
;pong.c,76 :: 		ball.y = 32;
	MOVLW       32
	MOVWF       _ball+1 
;pong.c,77 :: 		ball.dx = 2;
	MOVLW       2
	MOVWF       _ball+2 
;pong.c,78 :: 		ball.dy = 2;
	MOVLW       2
	MOVWF       _ball+3 
;pong.c,80 :: 		draw_player(paddle[0].x, paddle[0].y, paddle[0].w, paddle[0].h);
	MOVLW       5
	MOVWF       FARG_draw_player_x+0 
	MOVLW       30
	MOVWF       FARG_draw_player_y+0 
	MOVLW       2
	MOVWF       FARG_draw_player_w+0 
	MOVLW       9
	MOVWF       FARG_draw_player_h+0 
	CALL        _draw_player+0, 0
;pong.c,81 :: 		draw_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);
	MOVF        _paddle+4, 0 
	MOVWF       FARG_draw_player_x+0 
	MOVF        _paddle+5, 0 
	MOVWF       FARG_draw_player_y+0 
	MOVF        _paddle+6, 0 
	MOVWF       FARG_draw_player_w+0 
	MOVF        _paddle+7, 0 
	MOVWF       FARG_draw_player_h+0 
	CALL        _draw_player+0, 0
;pong.c,82 :: 		DrawBall(ball.x, ball.y);
	MOVF        _ball+0, 0 
	MOVWF       FARG_DrawBall_x+0 
	MOVF        _ball+1, 0 
	MOVWF       FARG_DrawBall_y+0 
	CALL        _DrawBall+0, 0
;pong.c,83 :: 		}
L_end_init:
	RETURN      0
; end of _init

_check_collision:

;pong.c,85 :: 		short check_collision(paddles paleta, balls bola, unsigned short a){ //Retorna 1 si detecta colision / 0 si no
;pong.c,86 :: 		if(a == 1){
	MOVF        FARG_check_collision_a+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_check_collision0
;pong.c,88 :: 		if((bola.x+1 == paleta.x) && (bola.y >= paleta.y) && (bola.y <= (paleta.y + paleta.h))){ //check collision con el lado izquierdo
	MOVF        FARG_check_collision_bola+0, 0 
	ADDLW       1
	MOVWF       R1 
	CLRF        R2 
	MOVLW       0
	BTFSC       FARG_check_collision_bola+0, 7 
	MOVLW       255
	ADDWFC      R2, 1 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_collision223
	MOVF        FARG_check_collision_paleta+0, 0 
	XORWF       R1, 0 
L__check_collision223:
	BTFSS       STATUS+0, 2 
	GOTO        L_check_collision3
	MOVLW       128
	BTFSC       FARG_check_collision_bola+1, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_collision224
	MOVF        FARG_check_collision_paleta+1, 0 
	SUBWF       FARG_check_collision_bola+1, 0 
L__check_collision224:
	BTFSS       STATUS+0, 0 
	GOTO        L_check_collision3
	MOVF        FARG_check_collision_paleta+3, 0 
	ADDWF       FARG_check_collision_paleta+1, 0 
	MOVWF       R1 
	CLRF        R2 
	MOVLW       0
	ADDWFC      R2, 1 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	BTFSC       FARG_check_collision_bola+1, 7 
	MOVLW       127
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_collision225
	MOVF        FARG_check_collision_bola+1, 0 
	SUBWF       R1, 0 
L__check_collision225:
	BTFSS       STATUS+0, 0 
	GOTO        L_check_collision3
L__check_collision211:
;pong.c,89 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_check_collision
;pong.c,90 :: 		}
L_check_collision3:
;pong.c,92 :: 		return 0;
	CLRF        R0 
	GOTO        L_end_check_collision
;pong.c,94 :: 		}
L_check_collision0:
;pong.c,96 :: 		if((bola.x == paleta.x + 1) && (bola.y >= paleta.y) && (bola.y <= (paleta.y + paleta.h))){ // check collision con el lado derecho
	MOVF        FARG_check_collision_paleta+0, 0 
	ADDLW       1
	MOVWF       R1 
	CLRF        R2 
	MOVLW       0
	ADDWFC      R2, 1 
	MOVLW       0
	BTFSC       FARG_check_collision_bola+0, 7 
	MOVLW       255
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_collision226
	MOVF        R1, 0 
	XORWF       FARG_check_collision_bola+0, 0 
L__check_collision226:
	BTFSS       STATUS+0, 2 
	GOTO        L_check_collision8
	MOVLW       128
	BTFSC       FARG_check_collision_bola+1, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_collision227
	MOVF        FARG_check_collision_paleta+1, 0 
	SUBWF       FARG_check_collision_bola+1, 0 
L__check_collision227:
	BTFSS       STATUS+0, 0 
	GOTO        L_check_collision8
	MOVF        FARG_check_collision_paleta+3, 0 
	ADDWF       FARG_check_collision_paleta+1, 0 
	MOVWF       R1 
	CLRF        R2 
	MOVLW       0
	ADDWFC      R2, 1 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	BTFSC       FARG_check_collision_bola+1, 7 
	MOVLW       127
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_collision228
	MOVF        FARG_check_collision_bola+1, 0 
	SUBWF       R1, 0 
L__check_collision228:
	BTFSS       STATUS+0, 0 
	GOTO        L_check_collision8
L__check_collision210:
;pong.c,97 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_check_collision
;pong.c,98 :: 		}
L_check_collision8:
;pong.c,100 :: 		return 0;
	CLRF        R0 
;pong.c,103 :: 		}
L_end_check_collision:
	RETURN      0
; end of _check_collision

_move_ball:

;pong.c,105 :: 		void move_ball(){
;pong.c,108 :: 		if((turno == 10 && flag == 1) ||(turno == 5 && flag == 2) ){
	MOVF        _turno+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ball215
	MOVF        _flag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ball215
	GOTO        L__move_ball213
L__move_ball215:
	MOVF        _turno+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ball214
	MOVF        _flag+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ball214
	GOTO        L__move_ball213
L__move_ball214:
	GOTO        L_move_ball16
L__move_ball213:
;pong.c,109 :: 		Glcd_Dot(ball.x, ball.y, 0);
	MOVF        _ball+0, 0 
	MOVWF       FARG_Glcd_Dot_x_pos+0 
	MOVF        _ball+1, 0 
	MOVWF       FARG_Glcd_Dot_y_pos+0 
	CLRF        FARG_Glcd_Dot_color+0 
	CALL        _Glcd_Dot+0, 0
;pong.c,110 :: 		ball.x += ball.dx;
	MOVF        _ball+2, 0 
	ADDWF       _ball+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _ball+0 
;pong.c,111 :: 		ball.y += ball.dy;
	MOVF        _ball+3, 0 
	ADDWF       _ball+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _ball+1 
;pong.c,112 :: 		if(ball.x < 3){ //bola entro a la porteria de la izquierda
	MOVLW       128
	XORWF       _ball+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ball17
;pong.c,113 :: 		score[1] += 1;
	INCF        _score+1, 1 
;pong.c,114 :: 		erase_player(paddle[0].x, paddle[0].y, paddle[0].w, paddle[0].h);
	MOVF        _paddle+0, 0 
	MOVWF       FARG_erase_player_x+0 
	MOVF        _paddle+1, 0 
	MOVWF       FARG_erase_player_y+0 
	MOVF        _paddle+2, 0 
	MOVWF       FARG_erase_player_w+0 
	MOVF        _paddle+3, 0 
	MOVWF       FARG_erase_player_h+0 
	CALL        _erase_player+0, 0
;pong.c,115 :: 		erase_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);
	MOVF        _paddle+4, 0 
	MOVWF       FARG_erase_player_x+0 
	MOVF        _paddle+5, 0 
	MOVWF       FARG_erase_player_y+0 
	MOVF        _paddle+6, 0 
	MOVWF       FARG_erase_player_w+0 
	MOVF        _paddle+7, 0 
	MOVWF       FARG_erase_player_h+0 
	CALL        _erase_player+0, 0
;pong.c,116 :: 		init();
	CALL        _init+0, 0
;pong.c,117 :: 		}
L_move_ball17:
;pong.c,118 :: 		if(ball.x > 125){//bola entro a la porteria de la derecha
	MOVLW       128
	XORLW       125
	MOVWF       R0 
	MOVLW       128
	XORWF       _ball+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ball18
;pong.c,119 :: 		score[0] += 1;
	INCF        _score+0, 1 
;pong.c,120 :: 		erase_player(paddle[0].x, paddle[0].y, paddle[0].w, paddle[0].h);
	MOVF        _paddle+0, 0 
	MOVWF       FARG_erase_player_x+0 
	MOVF        _paddle+1, 0 
	MOVWF       FARG_erase_player_y+0 
	MOVF        _paddle+2, 0 
	MOVWF       FARG_erase_player_w+0 
	MOVF        _paddle+3, 0 
	MOVWF       FARG_erase_player_h+0 
	CALL        _erase_player+0, 0
;pong.c,121 :: 		erase_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);
	MOVF        _paddle+4, 0 
	MOVWF       FARG_erase_player_x+0 
	MOVF        _paddle+5, 0 
	MOVWF       FARG_erase_player_y+0 
	MOVF        _paddle+6, 0 
	MOVWF       FARG_erase_player_w+0 
	MOVF        _paddle+7, 0 
	MOVWF       FARG_erase_player_h+0 
	CALL        _erase_player+0, 0
;pong.c,122 :: 		init();
	CALL        _init+0, 0
;pong.c,123 :: 		}
L_move_ball18:
;pong.c,124 :: 		if(ball.y <= 0 || ball.y >= 63){    // Choque con las paredes de arriba o abajo
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       _ball+1, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L__move_ball212
	MOVLW       128
	XORWF       _ball+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       63
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L__move_ball212
	GOTO        L_move_ball21
L__move_ball212:
;pong.c,125 :: 		ball.dy = -ball.dy;
	MOVF        _ball+3, 0 
	SUBLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _ball+3 
;pong.c,126 :: 		}
L_move_ball21:
;pong.c,127 :: 		for(i = 0; i < 2; i++){
	CLRF        move_ball_i_L0+0 
L_move_ball22:
	MOVLW       2
	SUBWF       move_ball_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ball23
;pong.c,128 :: 		if(check_collision(paddle[i],ball,i)){    //Si choca con algun paddle
	MOVF        move_ball_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _paddle+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_paddle+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_check_collision_paleta+0
	MOVWF       FSR1 
	MOVLW       hi_addr(FARG_check_collision_paleta+0)
	MOVWF       FSR1H 
L_move_ball25:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_ball25
	MOVLW       4
	MOVWF       R0 
	MOVLW       FARG_check_collision_bola+0
	MOVWF       FSR1 
	MOVLW       hi_addr(FARG_check_collision_bola+0)
	MOVWF       FSR1H 
	MOVLW       _ball+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_ball+0)
	MOVWF       FSR0H 
L_move_ball26:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_move_ball26
	MOVF        move_ball_i_L0+0, 0 
	MOVWF       FARG_check_collision_a+0 
	CALL        _check_collision+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_move_ball27
;pong.c,129 :: 		ball.dx = -ball.dx;
	MOVF        _ball+2, 0 
	SUBLW       0
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _ball+2 
;pong.c,130 :: 		angle = ((paddle[i].y + paddle[i].h)- ball.y); // donde impacta en el paddle
	MOVF        move_ball_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _paddle+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_paddle+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       POSTINC0+0, 0 
	MOVWF       move_ball_angle_L0+0 
	MOVF        _ball+1, 0 
	SUBWF       move_ball_angle_L0+0, 1 
;pong.c,131 :: 		switch(angle){
	GOTO        L_move_ball28
;pong.c,132 :: 		case 0:
L_move_ball30:
;pong.c,133 :: 		ball.dy = 3;
	MOVLW       3
	MOVWF       _ball+3 
;pong.c,134 :: 		break;
	GOTO        L_move_ball29
;pong.c,135 :: 		case 1:
L_move_ball31:
;pong.c,136 :: 		ball.dy = 3;
	MOVLW       3
	MOVWF       _ball+3 
;pong.c,137 :: 		break;
	GOTO        L_move_ball29
;pong.c,138 :: 		case 2:
L_move_ball32:
;pong.c,139 :: 		ball.dy = 2;
	MOVLW       2
	MOVWF       _ball+3 
;pong.c,140 :: 		break;
	GOTO        L_move_ball29
;pong.c,141 :: 		case 3:
L_move_ball33:
;pong.c,142 :: 		ball.dy = 2;
	MOVLW       2
	MOVWF       _ball+3 
;pong.c,143 :: 		break;
	GOTO        L_move_ball29
;pong.c,144 :: 		case 4:
L_move_ball34:
;pong.c,145 :: 		ball.dy = 0;
	CLRF        _ball+3 
;pong.c,146 :: 		break;
	GOTO        L_move_ball29
;pong.c,147 :: 		case 5:
L_move_ball35:
;pong.c,148 :: 		ball.dy = 0;
	CLRF        _ball+3 
;pong.c,149 :: 		break;
	GOTO        L_move_ball29
;pong.c,150 :: 		case 6:
L_move_ball36:
;pong.c,151 :: 		ball.dy = -2;
	MOVLW       254
	MOVWF       _ball+3 
;pong.c,152 :: 		break;
	GOTO        L_move_ball29
;pong.c,153 :: 		case 7:
L_move_ball37:
;pong.c,154 :: 		ball.dy = -2;
	MOVLW       254
	MOVWF       _ball+3 
;pong.c,155 :: 		break;
	GOTO        L_move_ball29
;pong.c,156 :: 		case 8:
L_move_ball38:
;pong.c,157 :: 		ball.dy = -3;
	MOVLW       253
	MOVWF       _ball+3 
;pong.c,158 :: 		break;
	GOTO        L_move_ball29
;pong.c,159 :: 		case 9:
L_move_ball39:
;pong.c,160 :: 		ball.dy = -3;
	MOVLW       253
	MOVWF       _ball+3 
;pong.c,161 :: 		break;
	GOTO        L_move_ball29
;pong.c,162 :: 		}
L_move_ball28:
	MOVF        move_ball_angle_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_move_ball30
	MOVF        move_ball_angle_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_move_ball31
	MOVF        move_ball_angle_L0+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_move_ball32
	MOVF        move_ball_angle_L0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_move_ball33
	MOVLW       0
	BTFSC       move_ball_angle_L0+0, 7 
	MOVLW       255
	MOVWF       R0 
	MOVLW       0
	XORWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ball230
	MOVLW       4
	XORWF       move_ball_angle_L0+0, 0 
L__move_ball230:
	BTFSC       STATUS+0, 2 
	GOTO        L_move_ball34
	MOVF        move_ball_angle_L0+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_move_ball35
	MOVF        move_ball_angle_L0+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_move_ball36
	MOVF        move_ball_angle_L0+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_move_ball37
	MOVF        move_ball_angle_L0+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_move_ball38
	MOVF        move_ball_angle_L0+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_move_ball39
L_move_ball29:
;pong.c,163 :: 		if(ball.dx > 0){
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       _ball+2, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ball40
;pong.c,164 :: 		if(ball.x < 0){
	MOVLW       128
	XORWF       _ball+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       0
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ball41
;pong.c,165 :: 		ball.x = 0;
	CLRF        _ball+0 
;pong.c,166 :: 		}
L_move_ball41:
;pong.c,167 :: 		}
	GOTO        L_move_ball42
L_move_ball40:
;pong.c,169 :: 		if(ball.x > 127){
	MOVLW       128
	XORLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       _ball+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ball43
;pong.c,170 :: 		ball.x = 127;
	MOVLW       127
	MOVWF       _ball+0 
;pong.c,171 :: 		}
L_move_ball43:
;pong.c,172 :: 		}
L_move_ball42:
;pong.c,173 :: 		}
L_move_ball27:
;pong.c,127 :: 		for(i = 0; i < 2; i++){
	INCF        move_ball_i_L0+0, 1 
;pong.c,174 :: 		}
	GOTO        L_move_ball22
L_move_ball23:
;pong.c,175 :: 		}
L_move_ball16:
;pong.c,176 :: 		}
L_end_move_ball:
	RETURN      0
; end of _move_ball

_draw_score:

;pong.c,178 :: 		void draw_score(){
;pong.c,179 :: 		unsigned short posx = 0;
	CLRF        draw_score_posx_L0+0 
	CLRF        draw_score_jugador_L0+0 
;pong.c,181 :: 		for(jugador = 0;  jugador < 2; jugador ++){
	CLRF        draw_score_jugador_L0+0 
L_draw_score44:
	MOVLW       2
	SUBWF       draw_score_jugador_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_draw_score45
;pong.c,182 :: 		if(jugador == 0){
	MOVF        draw_score_jugador_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_score47
;pong.c,183 :: 		posx = 50;
	MOVLW       50
	MOVWF       draw_score_posx_L0+0 
;pong.c,184 :: 		}
L_draw_score47:
;pong.c,185 :: 		if(jugador == 1){
	MOVF        draw_score_jugador_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_score48
;pong.c,186 :: 		posx = 74;
	MOVLW       74
	MOVWF       draw_score_posx_L0+0 
;pong.c,187 :: 		}
L_draw_score48:
;pong.c,188 :: 		if (score[jugador] == 0){
	MOVLW       _score+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_score+0)
	MOVWF       FSR0H 
	MOVF        draw_score_jugador_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_score49
;pong.c,189 :: 		Glcd_Write_Char('0',posx,0,1);
	MOVLW       48
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVF        draw_score_posx_L0+0, 0 
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	CLRF        FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;pong.c,190 :: 		}
	GOTO        L_draw_score50
L_draw_score49:
;pong.c,191 :: 		else if(score[jugador] == 1){
	MOVLW       _score+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_score+0)
	MOVWF       FSR0H 
	MOVF        draw_score_jugador_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_score51
;pong.c,192 :: 		Glcd_Write_Char('1',posx,0,1);
	MOVLW       49
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVF        draw_score_posx_L0+0, 0 
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	CLRF        FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;pong.c,193 :: 		}
	GOTO        L_draw_score52
L_draw_score51:
;pong.c,194 :: 		else if(score[jugador] == 2){
	MOVLW       _score+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_score+0)
	MOVWF       FSR0H 
	MOVF        draw_score_jugador_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_score53
;pong.c,195 :: 		Glcd_Write_Char('2',posx,0,1);
	MOVLW       50
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVF        draw_score_posx_L0+0, 0 
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	CLRF        FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;pong.c,196 :: 		}
	GOTO        L_draw_score54
L_draw_score53:
;pong.c,197 :: 		else if(score[jugador] == 3){
	MOVLW       _score+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_score+0)
	MOVWF       FSR0H 
	MOVF        draw_score_jugador_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_score55
;pong.c,198 :: 		Glcd_Write_Char('3',posx,0,1);
	MOVLW       51
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVF        draw_score_posx_L0+0, 0 
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	CLRF        FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;pong.c,199 :: 		}
	GOTO        L_draw_score56
L_draw_score55:
;pong.c,200 :: 		else if(score[jugador] == 4){
	MOVLW       _score+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_score+0)
	MOVWF       FSR0H 
	MOVF        draw_score_jugador_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_score57
;pong.c,201 :: 		Glcd_Write_Char('4',posx,0,1);
	MOVLW       52
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVF        draw_score_posx_L0+0, 0 
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	CLRF        FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;pong.c,202 :: 		}
	GOTO        L_draw_score58
L_draw_score57:
;pong.c,203 :: 		else if(score[jugador] == 5){
	MOVLW       _score+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_score+0)
	MOVWF       FSR0H 
	MOVF        draw_score_jugador_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_draw_score59
;pong.c,204 :: 		Glcd_Write_Char('5',posx,0,1);
	MOVLW       53
	MOVWF       FARG_Glcd_Write_Char_chr+0 
	MOVF        draw_score_posx_L0+0, 0 
	MOVWF       FARG_Glcd_Write_Char_x_pos+0 
	CLRF        FARG_Glcd_Write_Char_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Char_color+0 
	CALL        _Glcd_Write_Char+0, 0
;pong.c,205 :: 		}
L_draw_score59:
L_draw_score58:
L_draw_score56:
L_draw_score54:
L_draw_score52:
L_draw_score50:
;pong.c,181 :: 		for(jugador = 0;  jugador < 2; jugador ++){
	INCF        draw_score_jugador_L0+0, 1 
;pong.c,206 :: 		}
	GOTO        L_draw_score44
L_draw_score45:
;pong.c,207 :: 		}
L_end_draw_score:
	RETURN      0
; end of _draw_score

_check_winner:

;pong.c,209 :: 		short check_winner(){
;pong.c,212 :: 		for(i = 0; i < 2; i++){
	CLRF        R1 
L_check_winner60:
	MOVLW       2
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_check_winner61
;pong.c,213 :: 		if(score[i] == 3){
	MOVLW       _score+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_score+0)
	MOVWF       FSR0H 
	MOVF        R1, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_check_winner63
;pong.c,214 :: 		for(j = 0; j < 2; j++){
	CLRF        R2 
L_check_winner64:
	MOVLW       2
	SUBWF       R2, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_check_winner65
;pong.c,215 :: 		score[j] = 0;
	MOVLW       _score+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_score+0)
	MOVWF       FSR1H 
	MOVF        R2, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;pong.c,214 :: 		for(j = 0; j < 2; j++){
	INCF        R2, 1 
;pong.c,216 :: 		}
	GOTO        L_check_winner64
L_check_winner65:
;pong.c,217 :: 		if (i == 0 ){
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_check_winner67
;pong.c,218 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_check_winner
;pong.c,219 :: 		}
L_check_winner67:
;pong.c,221 :: 		return 2;
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_check_winner
;pong.c,223 :: 		}
L_check_winner63:
;pong.c,212 :: 		for(i = 0; i < 2; i++){
	INCF        R1, 1 
;pong.c,224 :: 		}
	GOTO        L_check_winner60
L_check_winner61:
;pong.c,225 :: 		return 0;
	CLRF        R0 
;pong.c,226 :: 		}
L_end_check_winner:
	RETURN      0
; end of _check_winner

_DrawPlayer:

;pong.c,228 :: 		void DrawPlayer(unsigned short x, unsigned short y, unsigned short w, unsigned short h){
;pong.c,229 :: 		Glcd_V_Line(y, y+h, x, 1);
	MOVF        FARG_DrawPlayer_y+0, 0 
	MOVWF       FARG_Glcd_V_Line_y_start+0 
	MOVF        FARG_DrawPlayer_h+0, 0 
	ADDWF       FARG_DrawPlayer_y+0, 0 
	MOVWF       FARG_Glcd_V_Line_y_end+0 
	MOVF        FARG_DrawPlayer_x+0, 0 
	MOVWF       FARG_Glcd_V_Line_x_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_V_Line_color+0 
	CALL        _Glcd_V_Line+0, 0
;pong.c,230 :: 		}
L_end_DrawPlayer:
	RETURN      0
; end of _DrawPlayer

_cover:

;pong.c,233 :: 		void cover(){
;pong.c,234 :: 		Glcd_Image(portada);
	MOVLW       _Portada+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_Portada+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_Portada+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;pong.c,235 :: 		while(1){
L_cover69:
;pong.c,236 :: 		if(Button(&PORTC,1,1,0)){
	MOVLW       PORTC+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       1
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_cover71
;pong.c,237 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;pong.c,238 :: 		break;
	GOTO        L_cover70
;pong.c,239 :: 		}
L_cover71:
;pong.c,240 :: 		}
	GOTO        L_cover69
L_cover70:
;pong.c,241 :: 		}
L_end_cover:
	RETURN      0
; end of _cover

_move_ia:

;pong.c,243 :: 		void move_ia(){
;pong.c,244 :: 		unsigned short centro_ia = paddle[0].y + 4;
	MOVLW       4
	ADDWF       _paddle+1, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       move_ia_centro_ia_L0+0 
;pong.c,245 :: 		short ball_speed = ball.dy;
	MOVF        _ball+3, 0 
	MOVWF       move_ia_ball_speed_L0+0 
;pong.c,246 :: 		int contador = rand() % 3;
	CALL        _rand+0, 0
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       move_ia_contador_L0+0 
	MOVF        R1, 0 
	MOVWF       move_ia_contador_L0+1 
;pong.c,247 :: 		if(turno == 10){
	MOVF        _turno+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_move_ia72
;pong.c,248 :: 		erase_player(paddle[0].x, paddle[0].y, paddle[0].w, paddle[0].h);
	MOVF        _paddle+0, 0 
	MOVWF       FARG_erase_player_x+0 
	MOVF        _paddle+1, 0 
	MOVWF       FARG_erase_player_y+0 
	MOVF        _paddle+2, 0 
	MOVWF       FARG_erase_player_w+0 
	MOVF        _paddle+3, 0 
	MOVWF       FARG_erase_player_h+0 
	CALL        _erase_player+0, 0
;pong.c,249 :: 		if(ball_speed < 0){
	MOVLW       128
	XORWF       move_ia_ball_speed_L0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       0
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ia73
;pong.c,250 :: 		ball_speed = -ball_speed;
	MOVF        move_ia_ball_speed_L0+0, 0 
	SUBLW       0
	MOVWF       move_ia_ball_speed_L0+0 
;pong.c,251 :: 		}
L_move_ia73:
;pong.c,252 :: 		if(ball.dx > 0){    // Si la bola se mueve a la derecha la paleta ia se mueve aleatoriamente
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       _ball+2, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ia74
;pong.c,253 :: 		switch(contador){
	GOTO        L_move_ia75
;pong.c,254 :: 		case 0:
L_move_ia77:
;pong.c,255 :: 		paddle[0].y = paddle[0].y;
;pong.c,256 :: 		break;
	GOTO        L_move_ia76
;pong.c,257 :: 		case 1:
L_move_ia78:
;pong.c,258 :: 		paddle[0].y = paddle[0].y+2;
	MOVLW       2
	ADDWF       _paddle+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _paddle+1 
;pong.c,259 :: 		break;
	GOTO        L_move_ia76
;pong.c,260 :: 		case 2:
L_move_ia79:
;pong.c,261 :: 		paddle[0].y = paddle[0].y-2;
	MOVLW       2
	SUBWF       _paddle+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _paddle+1 
;pong.c,262 :: 		break;
	GOTO        L_move_ia76
;pong.c,263 :: 		}
L_move_ia75:
	MOVLW       0
	XORWF       move_ia_contador_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ia236
	MOVLW       0
	XORWF       move_ia_contador_L0+0, 0 
L__move_ia236:
	BTFSC       STATUS+0, 2 
	GOTO        L_move_ia77
	MOVLW       0
	XORWF       move_ia_contador_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ia237
	MOVLW       1
	XORWF       move_ia_contador_L0+0, 0 
L__move_ia237:
	BTFSC       STATUS+0, 2 
	GOTO        L_move_ia78
	MOVLW       0
	XORWF       move_ia_contador_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ia238
	MOVLW       2
	XORWF       move_ia_contador_L0+0, 0 
L__move_ia238:
	BTFSC       STATUS+0, 2 
	GOTO        L_move_ia79
L_move_ia76:
;pong.c,264 :: 		}
	GOTO        L_move_ia80
L_move_ia74:
;pong.c,266 :: 		if(ball.x < 64){
	MOVLW       128
	XORWF       _ball+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       64
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ia81
;pong.c,267 :: 		if(ball.dy > 0){
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       _ball+3, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ia82
;pong.c,268 :: 		if(ball.y > centro_ia){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	BTFSC       _ball+1, 7 
	MOVLW       127
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ia239
	MOVF        _ball+1, 0 
	SUBWF       move_ia_centro_ia_L0+0, 0 
L__move_ia239:
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ia83
;pong.c,269 :: 		if(paddle[0].y + ball_speed < 64){
	MOVF        move_ia_ball_speed_L0+0, 0 
	ADDWF       _paddle+1, 0 
	MOVWF       R1 
	CLRF        R2 
	MOVLW       0
	BTFSC       move_ia_ball_speed_L0+0, 7 
	MOVLW       255
	ADDWFC      R2, 1 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ia240
	MOVLW       64
	SUBWF       R1, 0 
L__move_ia240:
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ia84
;pong.c,270 :: 		paddle[0].y += (ball_speed);
	MOVF        move_ia_ball_speed_L0+0, 0 
	ADDWF       _paddle+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _paddle+1 
;pong.c,271 :: 		}
	GOTO        L_move_ia85
L_move_ia84:
;pong.c,273 :: 		paddle[0].y = 63 - paddle[0].h;
	MOVF        _paddle+3, 0 
	SUBLW       63
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _paddle+1 
;pong.c,274 :: 		}
L_move_ia85:
;pong.c,275 :: 		}
	GOTO        L_move_ia86
L_move_ia83:
;pong.c,277 :: 		if(paddle[0].y - ball_speed > 0){
	MOVF        move_ia_ball_speed_L0+0, 0 
	SUBWF       _paddle+1, 0 
	MOVWF       R1 
	CLRF        R2 
	MOVLW       0
	BTFSC       move_ia_ball_speed_L0+0, 7 
	MOVLW       255
	SUBWFB      R2, 1 
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ia241
	MOVF        R1, 0 
	SUBLW       0
L__move_ia241:
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ia87
;pong.c,278 :: 		paddle[0].y -= (ball_speed);
	MOVF        move_ia_ball_speed_L0+0, 0 
	SUBWF       _paddle+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _paddle+1 
;pong.c,279 :: 		}
	GOTO        L_move_ia88
L_move_ia87:
;pong.c,281 :: 		paddle[0].y = 0;
	CLRF        _paddle+1 
;pong.c,282 :: 		}
L_move_ia88:
;pong.c,283 :: 		}
L_move_ia86:
;pong.c,284 :: 		}
L_move_ia82:
;pong.c,285 :: 		if(ball.dy < 0){
	MOVLW       128
	XORWF       _ball+3, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       0
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ia89
;pong.c,286 :: 		if(ball.y < centro_ia){
	MOVLW       128
	BTFSC       _ball+1, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ia242
	MOVF        move_ia_centro_ia_L0+0, 0 
	SUBWF       _ball+1, 0 
L__move_ia242:
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ia90
;pong.c,287 :: 		if(paddle[0].y - ball_speed > 0){
	MOVF        move_ia_ball_speed_L0+0, 0 
	SUBWF       _paddle+1, 0 
	MOVWF       R1 
	CLRF        R2 
	MOVLW       0
	BTFSC       move_ia_ball_speed_L0+0, 7 
	MOVLW       255
	SUBWFB      R2, 1 
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ia243
	MOVF        R1, 0 
	SUBLW       0
L__move_ia243:
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ia91
;pong.c,288 :: 		paddle[0].y -= (ball_speed);
	MOVF        move_ia_ball_speed_L0+0, 0 
	SUBWF       _paddle+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _paddle+1 
;pong.c,289 :: 		}
	GOTO        L_move_ia92
L_move_ia91:
;pong.c,291 :: 		paddle[0].y = 0;
	CLRF        _paddle+1 
;pong.c,292 :: 		}
L_move_ia92:
;pong.c,293 :: 		}
	GOTO        L_move_ia93
L_move_ia90:
;pong.c,295 :: 		if(paddle[0].y < 64){
	MOVLW       64
	SUBWF       _paddle+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ia94
;pong.c,296 :: 		paddle[0].y += (ball_speed);
	MOVF        move_ia_ball_speed_L0+0, 0 
	ADDWF       _paddle+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _paddle+1 
;pong.c,297 :: 		}
	GOTO        L_move_ia95
L_move_ia94:
;pong.c,299 :: 		paddle[0].y = 63 - paddle[0].h;
	MOVF        _paddle+3, 0 
	SUBLW       63
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _paddle+1 
;pong.c,300 :: 		}
L_move_ia95:
;pong.c,301 :: 		}
L_move_ia93:
;pong.c,302 :: 		}
L_move_ia89:
;pong.c,303 :: 		if(ball.dy == 0){
	MOVF        _ball+3, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_move_ia96
;pong.c,304 :: 		if(ball.y < centro_ia){
	MOVLW       128
	BTFSC       _ball+1, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ia244
	MOVF        move_ia_centro_ia_L0+0, 0 
	SUBWF       _ball+1, 0 
L__move_ia244:
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ia97
;pong.c,305 :: 		paddle[0].y -= 3;
	MOVLW       3
	SUBWF       _paddle+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _paddle+1 
;pong.c,306 :: 		}
	GOTO        L_move_ia98
L_move_ia97:
;pong.c,308 :: 		paddle[0].y += 3;
	MOVLW       3
	ADDWF       _paddle+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _paddle+1 
;pong.c,309 :: 		}
L_move_ia98:
;pong.c,310 :: 		}
L_move_ia96:
;pong.c,311 :: 		}
L_move_ia81:
;pong.c,312 :: 		}
L_move_ia80:
;pong.c,313 :: 		}
L_move_ia72:
;pong.c,314 :: 		}
L_end_move_ia:
	RETURN      0
; end of _move_ia

_move_player:

;pong.c,316 :: 		void move_player(unsigned short i, unsigned short direction){
;pong.c,317 :: 		if (turno_paleta == 10){
	MOVF        _turno_paleta+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player99
;pong.c,318 :: 		if(direction == 0){                                                        //Hacia abajo
	MOVF        FARG_move_player_direction+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player100
;pong.c,319 :: 		if(paddle[i].y >= 63 - paddle[i].h){        //No pasarse del limite de abajo
	MOVF        FARG_move_player_i+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _paddle+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_paddle+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	SUBLW       63
	MOVWF       R1 
	CLRF        R2 
	MOVLW       0
	SUBWFB      R2, 1 
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_player246
	MOVF        R1, 0 
	SUBWF       R3, 0 
L__move_player246:
	BTFSS       STATUS+0, 0 
	GOTO        L_move_player101
;pong.c,320 :: 		paddle[i].y = (63 - paddle[i].h);
	MOVF        FARG_move_player_i+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _paddle+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_paddle+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	SUBLW       63
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;pong.c,321 :: 		}
	GOTO        L_move_player102
L_move_player101:
;pong.c,323 :: 		paddle[i].y +=2;
	MOVF        FARG_move_player_i+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _paddle+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_paddle+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVLW       2
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;pong.c,324 :: 		}
L_move_player102:
;pong.c,325 :: 		}
	GOTO        L_move_player103
L_move_player100:
;pong.c,326 :: 		else if(direction == 1){                                                        //Hacia arriba
	MOVF        FARG_move_player_direction+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_move_player104
;pong.c,327 :: 		if(paddle[i].y <= 0){                                        //No pasarse del limite de arriba
	MOVF        FARG_move_player_i+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _paddle+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_paddle+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	SUBLW       0
	BTFSS       STATUS+0, 0 
	GOTO        L_move_player105
;pong.c,328 :: 		paddle[i].y = 0;
	MOVF        FARG_move_player_i+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _paddle+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_paddle+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;pong.c,329 :: 		}
	GOTO        L_move_player106
L_move_player105:
;pong.c,331 :: 		paddle[i].y -= 2;
	MOVF        FARG_move_player_i+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _paddle+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_paddle+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVLW       2
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;pong.c,332 :: 		}
L_move_player106:
;pong.c,333 :: 		}
L_move_player104:
L_move_player103:
;pong.c,334 :: 		}
L_move_player99:
;pong.c,335 :: 		}
L_end_move_player:
	RETURN      0
; end of _move_player

_data_pack:

;pong.c,338 :: 		void data_pack() {  //Funcion para empaquetar datos a enviar
;pong.c,340 :: 		info[0] = ball.x + '0';
	MOVLW       48
	ADDWF       _ball+0, 0 
	MOVWF       _info+0 
;pong.c,341 :: 		info[1] = ball.y + '0';
	MOVLW       48
	ADDWF       _ball+1, 0 
	MOVWF       _info+1 
;pong.c,344 :: 		info[2] = score[0] + '0';
	MOVLW       48
	ADDWF       _score+0, 0 
	MOVWF       _info+2 
;pong.c,345 :: 		info[3] = score[1] + '0';
	MOVLW       48
	ADDWF       _score+1, 0 
	MOVWF       _info+3 
;pong.c,348 :: 		info[4] = paddle[0].y + '0';  //Maestro
	MOVLW       48
	ADDWF       _paddle+1, 0 
	MOVWF       _info+4 
;pong.c,349 :: 		info[5] = paddle[1].y + '0';  // Esclavo
	MOVLW       48
	ADDWF       _paddle+5, 0 
	MOVWF       _info+5 
;pong.c,352 :: 		info[6] = 'O';
	MOVLW       79
	MOVWF       _info+6 
;pong.c,353 :: 		info[7] = 'K';
	MOVLW       75
	MOVWF       _info+7 
;pong.c,354 :: 		info[8] = 0;
	CLRF        _info+8 
;pong.c,355 :: 		}
L_end_data_pack:
	RETURN      0
; end of _data_pack

_desdata_pack:

;pong.c,357 :: 		void desdata_pack(){   // Funcion para extraer datos del paquete recibido por esclavo
;pong.c,358 :: 		ball.x = info[0] - '0';
	MOVLW       48
	SUBWF       _info+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _ball+0 
;pong.c,359 :: 		ball.y = info[1] - '0';
	MOVLW       48
	SUBWF       _info+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _ball+1 
;pong.c,361 :: 		score[0] = info[2] - '0';
	MOVLW       48
	SUBWF       _info+2, 0 
	MOVWF       _score+0 
;pong.c,362 :: 		score[1] = info[3] - '0';
	MOVLW       48
	SUBWF       _info+3, 0 
	MOVWF       _score+1 
;pong.c,364 :: 		paddle[0].y = info[4] - '0';
	MOVLW       48
	SUBWF       _info+4, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _paddle+1 
;pong.c,365 :: 		paddle[1].y = info[5] - '0';
	MOVLW       48
	SUBWF       _info+5, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _paddle+5 
;pong.c,366 :: 		}
L_end_desdata_pack:
	RETURN      0
; end of _desdata_pack

_output_character:

;pong.c,368 :: 		void output_character(char charValue){
;pong.c,369 :: 		while (UART1_Tx_Idle()!= 1);
L_output_character107:
	CALL        _UART1_Tx_Idle+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_output_character108
	GOTO        L_output_character107
L_output_character108:
;pong.c,370 :: 		UART1_Write(charValue);
	MOVF        FARG_output_character_charValue+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;pong.c,371 :: 		}
L_end_output_character:
	RETURN      0
; end of _output_character

_input_character:

;pong.c,373 :: 		void input_character(char char_dir){
;pong.c,374 :: 		while (UART1_Data_Ready() == 0);
L_input_character109:
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_input_character110
	GOTO        L_input_character109
L_input_character110:
;pong.c,375 :: 		char_dir = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_input_character_char_dir+0 
;pong.c,376 :: 		}
L_end_input_character:
	RETURN      0
; end of _input_character

_output_data:

;pong.c,378 :: 		void output_data(char *serial_dir){
;pong.c,379 :: 		while (UART1_Tx_Idle()!= 1);
L_output_data111:
	CALL        _UART1_Tx_Idle+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_output_data112
	GOTO        L_output_data111
L_output_data112:
;pong.c,380 :: 		UART1_Write_Text(serial_dir);
	MOVF        FARG_output_data_serial_dir+0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVF        FARG_output_data_serial_dir+1, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;pong.c,381 :: 		}
L_end_output_data:
	RETURN      0
; end of _output_data

_input_data:

;pong.c,383 :: 		void input_data(char *text_dir){
;pong.c,384 :: 		while(UART1_Data_Ready()==0);
L_input_data113:
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_input_data114
	GOTO        L_input_data113
L_input_data114:
;pong.c,385 :: 		UART1_Read_Text(text_dir, "OK", 255);
	MOVF        FARG_input_data_text_dir+0, 0 
	MOVWF       FARG_UART1_Read_Text_Output+0 
	MOVF        FARG_input_data_text_dir+1, 0 
	MOVWF       FARG_UART1_Read_Text_Output+1 
	MOVLW       ?lstr1_pong+0
	MOVWF       FARG_UART1_Read_Text_Delimiter+0 
	MOVLW       hi_addr(?lstr1_pong+0)
	MOVWF       FARG_UART1_Read_Text_Delimiter+1 
	MOVLW       255
	MOVWF       FARG_UART1_Read_Text_Attempts+0 
	CALL        _UART1_Read_Text+0, 0
;pong.c,386 :: 		}
L_end_input_data:
	RETURN      0
; end of _input_data

_save_old_data:

;pong.c,388 :: 		void save_old_data(){
;pong.c,389 :: 		send_paddles[0].y = paddle[0].y;
	MOVF        _paddle+1, 0 
	MOVWF       _send_paddles+1 
;pong.c,390 :: 		send_paddles[1].y = paddle[1].y;
	MOVF        _paddle+5, 0 
	MOVWF       _send_paddles+5 
;pong.c,392 :: 		send_balls.x = ball.x;
	MOVF        _ball+0, 0 
	MOVWF       _send_balls+0 
;pong.c,393 :: 		send_balls.y = ball.y;
	MOVF        _ball+1, 0 
	MOVWF       _send_balls+1 
;pong.c,394 :: 		send_balls.dx = ball.dx;
	MOVF        _ball+2, 0 
	MOVWF       _send_balls+2 
;pong.c,395 :: 		send_balls.dy = ball.dy;
	MOVF        _ball+3, 0 
	MOVWF       _send_balls+3 
;pong.c,396 :: 		}
L_end_save_old_data:
	RETURN      0
; end of _save_old_data

_main:

;pong.c,399 :: 		void main(){
;pong.c,401 :: 		unsigned short Master = 0;
	CLRF        main_Master_L0+0 
	MOVLW       48
	MOVWF       main_Master_slave_L0+0 
	CLRF        main_move_other_L0+0 
;pong.c,408 :: 		PORTC = 0;              //Establecemos las entradas en 0 para evitar conflictos
	CLRF        PORTC+0 
;pong.c,409 :: 		TRISC.F0 = 1;   //Entrada para el eje y
	BSF         TRISC+0, 0 
;pong.c,410 :: 		TRISC.F1 = 1;        // Entrada para el boton del joystick
	BSF         TRISC+0, 1 
;pong.c,413 :: 		Glcd_Init();
	CALL        _Glcd_Init+0, 0
;pong.c,414 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;pong.c,416 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;pong.c,417 :: 		Delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main115:
	DECFSZ      R13, 1, 1
	BRA         L_main115
	DECFSZ      R12, 1, 1
	BRA         L_main115
	DECFSZ      R11, 1, 1
	BRA         L_main115
;pong.c,419 :: 		ADC_Init();
	CALL        _ADC_Init+0, 0
;pong.c,421 :: 		cover();                //Imprimimos la portada hasta que se presiona
	CALL        _cover+0, 0
;pong.c,422 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main116:
	DECFSZ      R13, 1, 1
	BRA         L_main116
	DECFSZ      R12, 1, 1
	BRA         L_main116
	DECFSZ      R11, 1, 1
	BRA         L_main116
	NOP
	NOP
;pong.c,424 :: 		while(1){
L_main117:
;pong.c,425 :: 		switch(flag){
	GOTO        L_main119
;pong.c,426 :: 		case 0:                        //Menu de inicio
L_main121:
;pong.c,427 :: 		while(1){
L_main122:
;pong.c,428 :: 		y = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _y+0 
;pong.c,429 :: 		if(y <= 20){
	MOVF        R0, 0 
	SUBLW       20
	BTFSS       STATUS+0, 0 
	GOTO        L_main124
;pong.c,430 :: 		Glcd_Write_Text("one player",15,0,1);
	MOVLW       ?lstr2_pong+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr2_pong+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       15
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	CLRF        FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;pong.c,431 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main125:
	DECFSZ      R13, 1, 1
	BRA         L_main125
	DECFSZ      R12, 1, 1
	BRA         L_main125
	DECFSZ      R11, 1, 1
	BRA         L_main125
	NOP
	NOP
;pong.c,432 :: 		while(1){
L_main126:
;pong.c,433 :: 		y = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _y+0 
;pong.c,435 :: 		if(Button(&PORTC,1,1,0)){
	MOVLW       PORTC+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       1
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main128
;pong.c,436 :: 		flag = 1;
	MOVLW       1
	MOVWF       _flag+0 
;pong.c,437 :: 		break;
	GOTO        L_main127
;pong.c,438 :: 		}
L_main128:
;pong.c,439 :: 		else if(y >= 200){
	MOVLW       200
	SUBWF       _y+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main130
;pong.c,440 :: 		break;
	GOTO        L_main127
;pong.c,441 :: 		}
L_main130:
;pong.c,442 :: 		}Glcd_Fill(0x00);
	GOTO        L_main126
L_main127:
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;pong.c,444 :: 		}
	GOTO        L_main131
L_main124:
;pong.c,445 :: 		else if(y >= 200){
	MOVLW       200
	SUBWF       _y+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main132
;pong.c,446 :: 		Glcd_Write_Text("multiplayer",15,0,1);
	MOVLW       ?lstr3_pong+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr3_pong+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       15
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	CLRF        FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;pong.c,447 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main133:
	DECFSZ      R13, 1, 1
	BRA         L_main133
	DECFSZ      R12, 1, 1
	BRA         L_main133
	DECFSZ      R11, 1, 1
	BRA         L_main133
	NOP
	NOP
;pong.c,449 :: 		while(1){
L_main134:
;pong.c,450 :: 		y = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _y+0 
;pong.c,451 :: 		if(Button(&PORTC,1,1,0)){
	MOVLW       PORTC+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       1
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main136
;pong.c,452 :: 		flag = 2;
	MOVLW       2
	MOVWF       _flag+0 
;pong.c,453 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;pong.c,454 :: 		break ;
	GOTO        L_main135
;pong.c,455 :: 		}
L_main136:
;pong.c,456 :: 		else if(y <= 20){
	MOVF        _y+0, 0 
	SUBLW       20
	BTFSS       STATUS+0, 0 
	GOTO        L_main138
;pong.c,457 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;pong.c,458 :: 		break;
	GOTO        L_main135
;pong.c,459 :: 		}
L_main138:
;pong.c,460 :: 		}
	GOTO        L_main134
L_main135:
;pong.c,461 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;pong.c,462 :: 		}
	GOTO        L_main139
L_main132:
;pong.c,463 :: 		else if(flag == 1 || flag == 2){
	MOVF        _flag+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__main217
	MOVF        _flag+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__main217
	GOTO        L_main142
L__main217:
;pong.c,464 :: 		break;
	GOTO        L_main123
;pong.c,465 :: 		}
L_main142:
L_main139:
L_main131:
;pong.c,466 :: 		}Master == 0;
	GOTO        L_main122
L_main123:
;pong.c,467 :: 		break;
	GOTO        L_main120
;pong.c,468 :: 		case 1:
L_main143:
;pong.c,469 :: 		delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main144:
	DECFSZ      R13, 1, 1
	BRA         L_main144
	DECFSZ      R12, 1, 1
	BRA         L_main144
	DECFSZ      R11, 1, 1
	BRA         L_main144
	NOP
;pong.c,470 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;pong.c,471 :: 		init();
	CALL        _init+0, 0
;pong.c,472 :: 		while(1){
L_main145:
;pong.c,473 :: 		y = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _y+0 
;pong.c,474 :: 		if(turno > 10){
	MOVF        _turno+0, 0 
	SUBLW       10
	BTFSC       STATUS+0, 0 
	GOTO        L_main147
;pong.c,475 :: 		turno = 0;
	CLRF        _turno+0 
;pong.c,476 :: 		}
L_main147:
;pong.c,477 :: 		if(turno_paleta > 10){
	MOVF        _turno_paleta+0, 0 
	SUBLW       10
	BTFSC       STATUS+0, 0 
	GOTO        L_main148
;pong.c,478 :: 		turno_paleta = 0;
	CLRF        _turno_paleta+0 
;pong.c,479 :: 		}
L_main148:
;pong.c,480 :: 		if( y >= 190){                //Mover hacia abajo
	MOVLW       190
	SUBWF       _y+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main149
;pong.c,481 :: 		erase_player(paddle[1].x, paddle[1].y-2, paddle[1].w, paddle[1].h);
	MOVF        _paddle+4, 0 
	MOVWF       FARG_erase_player_x+0 
	MOVLW       2
	SUBWF       _paddle+5, 0 
	MOVWF       FARG_erase_player_y+0 
	MOVF        _paddle+6, 0 
	MOVWF       FARG_erase_player_w+0 
	MOVF        _paddle+7, 0 
	MOVWF       FARG_erase_player_h+0 
	CALL        _erase_player+0, 0
;pong.c,482 :: 		move_player(1,0);
	MOVLW       1
	MOVWF       FARG_move_player_i+0 
	CLRF        FARG_move_player_direction+0 
	CALL        _move_player+0, 0
;pong.c,483 :: 		draw_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);
	MOVF        _paddle+4, 0 
	MOVWF       FARG_draw_player_x+0 
	MOVF        _paddle+5, 0 
	MOVWF       FARG_draw_player_y+0 
	MOVF        _paddle+6, 0 
	MOVWF       FARG_draw_player_w+0 
	MOVF        _paddle+7, 0 
	MOVWF       FARG_draw_player_h+0 
	CALL        _draw_player+0, 0
;pong.c,484 :: 		}
	GOTO        L_main150
L_main149:
;pong.c,485 :: 		else if(y <= 30){                //Mover hacia arriba
	MOVF        _y+0, 0 
	SUBLW       30
	BTFSS       STATUS+0, 0 
	GOTO        L_main151
;pong.c,486 :: 		erase_player(paddle[1].x, paddle[1].y+2, paddle[1].w, paddle[1].h);
	MOVF        _paddle+4, 0 
	MOVWF       FARG_erase_player_x+0 
	MOVLW       2
	ADDWF       _paddle+5, 0 
	MOVWF       FARG_erase_player_y+0 
	MOVF        _paddle+6, 0 
	MOVWF       FARG_erase_player_w+0 
	MOVF        _paddle+7, 0 
	MOVWF       FARG_erase_player_h+0 
	CALL        _erase_player+0, 0
;pong.c,487 :: 		move_player(1,1);
	MOVLW       1
	MOVWF       FARG_move_player_i+0 
	MOVLW       1
	MOVWF       FARG_move_player_direction+0 
	CALL        _move_player+0, 0
;pong.c,488 :: 		draw_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);
	MOVF        _paddle+4, 0 
	MOVWF       FARG_draw_player_x+0 
	MOVF        _paddle+5, 0 
	MOVWF       FARG_draw_player_y+0 
	MOVF        _paddle+6, 0 
	MOVWF       FARG_draw_player_w+0 
	MOVF        _paddle+7, 0 
	MOVWF       FARG_draw_player_h+0 
	CALL        _draw_player+0, 0
;pong.c,489 :: 		}
L_main151:
L_main150:
;pong.c,491 :: 		move_ball();
	CALL        _move_ball+0, 0
;pong.c,492 :: 		DrawBall(ball.x, ball.y);
	MOVF        _ball+0, 0 
	MOVWF       FARG_DrawBall_x+0 
	MOVF        _ball+1, 0 
	MOVWF       FARG_DrawBall_y+0 
	CALL        _DrawBall+0, 0
;pong.c,493 :: 		move_ia();     //Para que la paleta se mueva sola
	CALL        _move_ia+0, 0
;pong.c,495 :: 		draw_player(paddle[0].x, paddle[0].y, paddle[0].w, paddle[0].h);
	MOVF        _paddle+0, 0 
	MOVWF       FARG_draw_player_x+0 
	MOVF        _paddle+1, 0 
	MOVWF       FARG_draw_player_y+0 
	MOVF        _paddle+2, 0 
	MOVWF       FARG_draw_player_w+0 
	MOVF        _paddle+3, 0 
	MOVWF       FARG_draw_player_h+0 
	CALL        _draw_player+0, 0
;pong.c,497 :: 		draw_score();
	CALL        _draw_score+0, 0
;pong.c,499 :: 		check = check_winner();
	CALL        _check_winner+0, 0
	MOVF        R0, 0 
	MOVWF       main_check_L0+0 
;pong.c,501 :: 		if(check != 0){
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main152
;pong.c,502 :: 		if(check == 1){
	MOVF        main_check_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main153
;pong.c,503 :: 		Glcd_Write_Text("PC WINS", 43, 4,1);
	MOVLW       ?lstr4_pong+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr4_pong+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       43
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;pong.c,504 :: 		delay_ms (10000);
	MOVLW       102
	MOVWF       R11, 0
	MOVLW       118
	MOVWF       R12, 0
	MOVLW       193
	MOVWF       R13, 0
L_main154:
	DECFSZ      R13, 1, 1
	BRA         L_main154
	DECFSZ      R12, 1, 1
	BRA         L_main154
	DECFSZ      R11, 1, 1
	BRA         L_main154
;pong.c,508 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;pong.c,509 :: 		flag = 0;
	CLRF        _flag+0 
;pong.c,510 :: 		break;
	GOTO        L_main146
;pong.c,511 :: 		}
L_main153:
;pong.c,512 :: 		if(check == 2){
	MOVF        main_check_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main155
;pong.c,513 :: 		Glcd_Write_Text("YOU WIN", 43, 4,1);
	MOVLW       ?lstr5_pong+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr5_pong+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       43
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;pong.c,514 :: 		delay_ms (10000);
	MOVLW       102
	MOVWF       R11, 0
	MOVLW       118
	MOVWF       R12, 0
	MOVLW       193
	MOVWF       R13, 0
L_main156:
	DECFSZ      R13, 1, 1
	BRA         L_main156
	DECFSZ      R12, 1, 1
	BRA         L_main156
	DECFSZ      R11, 1, 1
	BRA         L_main156
;pong.c,518 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;pong.c,519 :: 		flag = 0;
	CLRF        _flag+0 
;pong.c,520 :: 		break;
	GOTO        L_main146
;pong.c,521 :: 		}
L_main155:
;pong.c,522 :: 		}
L_main152:
;pong.c,523 :: 		turno ++;
	INCF        _turno+0, 1 
;pong.c,524 :: 		turno_paleta ++;
	INCF        _turno_paleta+0, 1 
;pong.c,525 :: 		}
	GOTO        L_main145
L_main146:
;pong.c,526 :: 		break;
	GOTO        L_main120
;pong.c,527 :: 		case 2:
L_main157:
;pong.c,528 :: 		init();
	CALL        _init+0, 0
;pong.c,529 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;pong.c,530 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main158:
	DECFSZ      R13, 1, 1
	BRA         L_main158
	DECFSZ      R12, 1, 1
	BRA         L_main158
	DECFSZ      R11, 1, 1
	BRA         L_main158
	NOP
	NOP
;pong.c,532 :: 		if(UART1_Data_Ready()==0){//Espera a que se conecte la otra consola
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main159
;pong.c,533 :: 		while(1){        //Manda constantemente un 1, siempre y cuando no detecte la otra consola
L_main160:
;pong.c,534 :: 		Glcd_Write_Text("Waiting for other player",0,0,1);
	MOVLW       ?lstr6_pong+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr6_pong+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	CLRF        FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;pong.c,535 :: 		UART1_Write('1');
	MOVLW       49
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;pong.c,536 :: 		if(UART1_Data_Ready() ==1){
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main162
;pong.c,537 :: 		break;
	GOTO        L_main161
;pong.c,538 :: 		}
L_main162:
;pong.c,540 :: 		}
	GOTO        L_main160
L_main161:
;pong.c,541 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;pong.c,542 :: 		}
	GOTO        L_main163
L_main159:
;pong.c,544 :: 		for (tiempo = 0; tiempo < 200; tiempo ++){
	CLRF        main_tiempo_L0+0 
L_main164:
	MOVLW       200
	SUBWF       main_tiempo_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main165
;pong.c,545 :: 		UART1_Write('1');
	MOVLW       49
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;pong.c,544 :: 		for (tiempo = 0; tiempo < 200; tiempo ++){
	INCF        main_tiempo_L0+0, 1 
;pong.c,547 :: 		}
	GOTO        L_main164
L_main165:
;pong.c,548 :: 		Glcd_Write_Text("Press to start",0,0,1);        //Una vez que se conecta,
	MOVLW       ?lstr7_pong+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr7_pong+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	CLRF        FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;pong.c,550 :: 		while(1){
L_main167:
;pong.c,552 :: 		Master_slave = UART1_Read();                        //Asi el primero que presione, sera el maestro
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_Master_slave_L0+0 
;pong.c,553 :: 		if(Button(&PORTC,1,1,0)){                                //Y el que no presiono se le manda la senal para que
	MOVLW       PORTC+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       1
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main169
;pong.c,554 :: 		UART1_Write('3');
	MOVLW       51
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;pong.c,555 :: 		Master = 1;
	MOVLW       1
	MOVWF       main_Master_L0+0 
;pong.c,556 :: 		break;
	GOTO        L_main168
;pong.c,557 :: 		}
L_main169:
;pong.c,558 :: 		else if(Master_slave == '3'){
	MOVF        main_Master_slave_L0+0, 0 
	XORLW       51
	BTFSS       STATUS+0, 2 
	GOTO        L_main171
;pong.c,559 :: 		Master = 2;
	MOVLW       2
	MOVWF       main_Master_L0+0 
;pong.c,560 :: 		break;
	GOTO        L_main168
;pong.c,561 :: 		}
L_main171:
;pong.c,562 :: 		}
	GOTO        L_main167
L_main168:
;pong.c,564 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;pong.c,565 :: 		}
L_main163:
;pong.c,566 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main172:
	DECFSZ      R13, 1, 1
	BRA         L_main172
	DECFSZ      R12, 1, 1
	BRA         L_main172
	DECFSZ      R11, 1, 1
	BRA         L_main172
	NOP
	NOP
;pong.c,568 :: 		if(Master == 1){//Si existe Master es porque este pic es el maestro
	MOVF        main_Master_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main173
;pong.c,569 :: 		while(1){
L_main174:
;pong.c,570 :: 		y = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _y+0 
;pong.c,571 :: 		if(turno > 5){
	MOVF        _turno+0, 0 
	SUBLW       5
	BTFSC       STATUS+0, 0 
	GOTO        L_main176
;pong.c,572 :: 		turno = 0;
	CLRF        _turno+0 
;pong.c,573 :: 		}
L_main176:
;pong.c,574 :: 		if(turno_paleta > 10){
	MOVF        _turno_paleta+0, 0 
	SUBLW       10
	BTFSC       STATUS+0, 0 
	GOTO        L_main177
;pong.c,575 :: 		turno_paleta = 0;
	CLRF        _turno_paleta+0 
;pong.c,576 :: 		}
L_main177:
;pong.c,577 :: 		if(y >= 190){ //Mover hacia abajo
	MOVLW       190
	SUBWF       _y+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main178
;pong.c,578 :: 		erase_player(paddle[0].x, paddle[0].y-2, paddle[0].w, paddle[0].h);
	MOVF        _paddle+0, 0 
	MOVWF       FARG_erase_player_x+0 
	MOVLW       2
	SUBWF       _paddle+1, 0 
	MOVWF       FARG_erase_player_y+0 
	MOVF        _paddle+2, 0 
	MOVWF       FARG_erase_player_w+0 
	MOVF        _paddle+3, 0 
	MOVWF       FARG_erase_player_h+0 
	CALL        _erase_player+0, 0
;pong.c,579 :: 		move_player(0,0);        //Jugador, direccion
	CLRF        FARG_move_player_i+0 
	CLRF        FARG_move_player_direction+0 
	CALL        _move_player+0, 0
;pong.c,580 :: 		draw_player(paddle[0].x, paddle[0].y, paddle[0].w, paddle[0].h);
	MOVF        _paddle+0, 0 
	MOVWF       FARG_draw_player_x+0 
	MOVF        _paddle+1, 0 
	MOVWF       FARG_draw_player_y+0 
	MOVF        _paddle+2, 0 
	MOVWF       FARG_draw_player_w+0 
	MOVF        _paddle+3, 0 
	MOVWF       FARG_draw_player_h+0 
	CALL        _draw_player+0, 0
;pong.c,581 :: 		}
	GOTO        L_main179
L_main178:
;pong.c,582 :: 		else if(y <= 25){ //Mover hacia arriba
	MOVF        _y+0, 0 
	SUBLW       25
	BTFSS       STATUS+0, 0 
	GOTO        L_main180
;pong.c,583 :: 		erase_player(paddle[0].x, paddle[0].y+2, paddle[0].w, paddle[0].h);
	MOVF        _paddle+0, 0 
	MOVWF       FARG_erase_player_x+0 
	MOVLW       2
	ADDWF       _paddle+1, 0 
	MOVWF       FARG_erase_player_y+0 
	MOVF        _paddle+2, 0 
	MOVWF       FARG_erase_player_w+0 
	MOVF        _paddle+3, 0 
	MOVWF       FARG_erase_player_h+0 
	CALL        _erase_player+0, 0
;pong.c,584 :: 		move_player(0,1);
	CLRF        FARG_move_player_i+0 
	MOVLW       1
	MOVWF       FARG_move_player_direction+0 
	CALL        _move_player+0, 0
;pong.c,585 :: 		draw_player(paddle[0].x, paddle[0].y, paddle[0].w, paddle[0].h);
	MOVF        _paddle+0, 0 
	MOVWF       FARG_draw_player_x+0 
	MOVF        _paddle+1, 0 
	MOVWF       FARG_draw_player_y+0 
	MOVF        _paddle+2, 0 
	MOVWF       FARG_draw_player_w+0 
	MOVF        _paddle+3, 0 
	MOVWF       FARG_draw_player_h+0 
	CALL        _draw_player+0, 0
;pong.c,586 :: 		}
L_main180:
L_main179:
;pong.c,588 :: 		while(UART1_Data_Ready()==0);
L_main181:
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main182
	GOTO        L_main181
L_main182:
;pong.c,590 :: 		if(UART1_Read() == '1'){
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	XORLW       49
	BTFSS       STATUS+0, 2 
	GOTO        L_main183
;pong.c,591 :: 		erase_player(paddle[1].x, paddle[1].y-2, paddle[1].w, paddle[1].h);
	MOVF        _paddle+4, 0 
	MOVWF       FARG_erase_player_x+0 
	MOVLW       2
	SUBWF       _paddle+5, 0 
	MOVWF       FARG_erase_player_y+0 
	MOVF        _paddle+6, 0 
	MOVWF       FARG_erase_player_w+0 
	MOVF        _paddle+7, 0 
	MOVWF       FARG_erase_player_h+0 
	CALL        _erase_player+0, 0
;pong.c,592 :: 		move_player(1,0); //Jugador, direccion
	MOVLW       1
	MOVWF       FARG_move_player_i+0 
	CLRF        FARG_move_player_direction+0 
	CALL        _move_player+0, 0
;pong.c,593 :: 		draw_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);
	MOVF        _paddle+4, 0 
	MOVWF       FARG_draw_player_x+0 
	MOVF        _paddle+5, 0 
	MOVWF       FARG_draw_player_y+0 
	MOVF        _paddle+6, 0 
	MOVWF       FARG_draw_player_w+0 
	MOVF        _paddle+7, 0 
	MOVWF       FARG_draw_player_h+0 
	CALL        _draw_player+0, 0
;pong.c,594 :: 		}
	GOTO        L_main184
L_main183:
;pong.c,595 :: 		else if(UART1_Read() == '2'){
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	XORLW       50
	BTFSS       STATUS+0, 2 
	GOTO        L_main185
;pong.c,596 :: 		erase_player(paddle[1].x, paddle[1].y+2, paddle[1].w, paddle[1].h);
	MOVF        _paddle+4, 0 
	MOVWF       FARG_erase_player_x+0 
	MOVLW       2
	ADDWF       _paddle+5, 0 
	MOVWF       FARG_erase_player_y+0 
	MOVF        _paddle+6, 0 
	MOVWF       FARG_erase_player_w+0 
	MOVF        _paddle+7, 0 
	MOVWF       FARG_erase_player_h+0 
	CALL        _erase_player+0, 0
;pong.c,597 :: 		move_player(1,1); //Jugador, direccion
	MOVLW       1
	MOVWF       FARG_move_player_i+0 
	MOVLW       1
	MOVWF       FARG_move_player_direction+0 
	CALL        _move_player+0, 0
;pong.c,598 :: 		draw_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);
	MOVF        _paddle+4, 0 
	MOVWF       FARG_draw_player_x+0 
	MOVF        _paddle+5, 0 
	MOVWF       FARG_draw_player_y+0 
	MOVF        _paddle+6, 0 
	MOVWF       FARG_draw_player_w+0 
	MOVF        _paddle+7, 0 
	MOVWF       FARG_draw_player_h+0 
	CALL        _draw_player+0, 0
;pong.c,599 :: 		}
L_main185:
L_main184:
;pong.c,601 :: 		move_ball();
	CALL        _move_ball+0, 0
;pong.c,602 :: 		DrawBall(ball.x, ball.y);
	MOVF        _ball+0, 0 
	MOVWF       FARG_DrawBall_x+0 
	MOVF        _ball+1, 0 
	MOVWF       FARG_DrawBall_y+0 
	CALL        _DrawBall+0, 0
;pong.c,603 :: 		draw_score();
	CALL        _draw_score+0, 0
;pong.c,605 :: 		data_pack(); //serial_pack_data
	CALL        _data_pack+0, 0
;pong.c,606 :: 		output_data(info); //send_pack_data(serial_data);
	MOVLW       _info+0
	MOVWF       FARG_output_data_serial_dir+0 
	MOVLW       hi_addr(_info+0)
	MOVWF       FARG_output_data_serial_dir+1 
	CALL        _output_data+0, 0
;pong.c,608 :: 		while (UART1_Tx_Idle() != 1);
L_main186:
	CALL        _UART1_Tx_Idle+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main187
	GOTO        L_main186
L_main187:
;pong.c,610 :: 		check = check_winner();
	CALL        _check_winner+0, 0
	MOVF        R0, 0 
	MOVWF       main_check_L0+0 
;pong.c,611 :: 		if(check != 0){                        //Solamente si check es diferente a 0 entra
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main188
;pong.c,612 :: 		if(check == 1){
	MOVF        main_check_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main189
;pong.c,613 :: 		Glcd_Write_Text("P1 WINS", 43, 4,1);
	MOVLW       ?lstr8_pong+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr8_pong+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       43
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;pong.c,614 :: 		delay_ms(10000);
	MOVLW       102
	MOVWF       R11, 0
	MOVLW       118
	MOVWF       R12, 0
	MOVLW       193
	MOVWF       R13, 0
L_main190:
	DECFSZ      R13, 1, 1
	BRA         L_main190
	DECFSZ      R12, 1, 1
	BRA         L_main190
	DECFSZ      R11, 1, 1
	BRA         L_main190
;pong.c,616 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;pong.c,619 :: 		flag = 0;
	CLRF        _flag+0 
;pong.c,620 :: 		break;
	GOTO        L_main175
;pong.c,621 :: 		}
L_main189:
;pong.c,622 :: 		if(check == 2){
	MOVF        main_check_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main191
;pong.c,623 :: 		Glcd_Write_Text("P2 WIN", 43, 4,1);
	MOVLW       ?lstr9_pong+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr9_pong+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       43
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;pong.c,624 :: 		delay_ms(10000);
	MOVLW       102
	MOVWF       R11, 0
	MOVLW       118
	MOVWF       R12, 0
	MOVLW       193
	MOVWF       R13, 0
L_main192:
	DECFSZ      R13, 1, 1
	BRA         L_main192
	DECFSZ      R12, 1, 1
	BRA         L_main192
	DECFSZ      R11, 1, 1
	BRA         L_main192
;pong.c,625 :: 		UART1_Write_Text(fin);
	MOVLW       _fin+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_fin+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;pong.c,626 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;pong.c,629 :: 		flag = 0;
	CLRF        _flag+0 
;pong.c,630 :: 		break;
	GOTO        L_main175
;pong.c,631 :: 		}
L_main191:
;pong.c,632 :: 		}
L_main188:
;pong.c,633 :: 		turno ++;
	INCF        _turno+0, 1 
;pong.c,634 :: 		turno_paleta++;
	INCF        _turno_paleta+0, 1 
;pong.c,635 :: 		}
	GOTO        L_main174
L_main175:
;pong.c,636 :: 		}
L_main173:
;pong.c,638 :: 		if (Master == 2){                //Si no existe Master es porque este pic es el esclavo
	MOVF        main_Master_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main193
;pong.c,639 :: 		while(1){
L_main194:
;pong.c,641 :: 		y = ADC_Read(1);
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _y+0 
;pong.c,642 :: 		save_old_data();
	CALL        _save_old_data+0, 0
;pong.c,644 :: 		if(y >= 190){        //Mover hacia abajo
	MOVLW       190
	SUBWF       _y+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main196
;pong.c,645 :: 		move_other = '1';
	MOVLW       49
	MOVWF       main_move_other_L0+0 
;pong.c,646 :: 		}
	GOTO        L_main197
L_main196:
;pong.c,647 :: 		else if(y <= 25){         //Mover hacia arriba
	MOVF        _y+0, 0 
	SUBLW       25
	BTFSS       STATUS+0, 0 
	GOTO        L_main198
;pong.c,648 :: 		move_other = '2';
	MOVLW       50
	MOVWF       main_move_other_L0+0 
;pong.c,649 :: 		}
	GOTO        L_main199
L_main198:
;pong.c,650 :: 		else{move_other = '0';}
	MOVLW       48
	MOVWF       main_move_other_L0+0 
L_main199:
L_main197:
;pong.c,652 :: 		output_character(move_other);
	MOVF        main_move_other_L0+0, 0 
	MOVWF       FARG_output_character_charValue+0 
	CALL        _output_character+0, 0
;pong.c,653 :: 		input_data(info);
	MOVLW       _info+0
	MOVWF       FARG_input_data_text_dir+0 
	MOVLW       hi_addr(_info+0)
	MOVWF       FARG_input_data_text_dir+1 
	CALL        _input_data+0, 0
;pong.c,654 :: 		desdata_pack ();
	CALL        _desdata_pack+0, 0
;pong.c,656 :: 		if(send_balls.x != ball.x || send_balls.y != ball.y){
	MOVF        _send_balls+0, 0 
	XORWF       _ball+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main216
	MOVF        _send_balls+1, 0 
	XORWF       _ball+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main216
	GOTO        L_main202
L__main216:
;pong.c,657 :: 		Glcd_Dot(send_balls.x, send_balls.y, 0);
	MOVF        _send_balls+0, 0 
	MOVWF       FARG_Glcd_Dot_x_pos+0 
	MOVF        _send_balls+1, 0 
	MOVWF       FARG_Glcd_Dot_y_pos+0 
	CLRF        FARG_Glcd_Dot_color+0 
	CALL        _Glcd_Dot+0, 0
;pong.c,658 :: 		}
L_main202:
;pong.c,659 :: 		if(send_paddles[0].y != paddle[0].y){
	MOVF        _send_paddles+1, 0 
	XORWF       _paddle+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main203
;pong.c,660 :: 		erase_player(paddle[0].x, send_paddles[0].y, paddle[0].w, paddle[0].h);
	MOVF        _paddle+0, 0 
	MOVWF       FARG_erase_player_x+0 
	MOVF        _send_paddles+1, 0 
	MOVWF       FARG_erase_player_y+0 
	MOVF        _paddle+2, 0 
	MOVWF       FARG_erase_player_w+0 
	MOVF        _paddle+3, 0 
	MOVWF       FARG_erase_player_h+0 
	CALL        _erase_player+0, 0
;pong.c,661 :: 		}
L_main203:
;pong.c,662 :: 		if(send_paddles[1].y != paddle[1].y){
	MOVF        _send_paddles+5, 0 
	XORWF       _paddle+5, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main204
;pong.c,663 :: 		erase_player(paddle[1].x, send_paddles[1].y, paddle[1].w, paddle[1].h);
	MOVF        _paddle+4, 0 
	MOVWF       FARG_erase_player_x+0 
	MOVF        _send_paddles+5, 0 
	MOVWF       FARG_erase_player_y+0 
	MOVF        _paddle+6, 0 
	MOVWF       FARG_erase_player_w+0 
	MOVF        _paddle+7, 0 
	MOVWF       FARG_erase_player_h+0 
	CALL        _erase_player+0, 0
;pong.c,664 :: 		}
L_main204:
;pong.c,666 :: 		draw_score();
	CALL        _draw_score+0, 0
;pong.c,668 :: 		draw_player(paddle[0].x, paddle[0].y, paddle[0].w, paddle[0].h);
	MOVF        _paddle+0, 0 
	MOVWF       FARG_draw_player_x+0 
	MOVF        _paddle+1, 0 
	MOVWF       FARG_draw_player_y+0 
	MOVF        _paddle+2, 0 
	MOVWF       FARG_draw_player_w+0 
	MOVF        _paddle+3, 0 
	MOVWF       FARG_draw_player_h+0 
	CALL        _draw_player+0, 0
;pong.c,669 :: 		draw_player(paddle[1].x, paddle[1].y, paddle[1].w, paddle[1].h);
	MOVF        _paddle+4, 0 
	MOVWF       FARG_draw_player_x+0 
	MOVF        _paddle+5, 0 
	MOVWF       FARG_draw_player_y+0 
	MOVF        _paddle+6, 0 
	MOVWF       FARG_draw_player_w+0 
	MOVF        _paddle+7, 0 
	MOVWF       FARG_draw_player_h+0 
	CALL        _draw_player+0, 0
;pong.c,670 :: 		DrawBall(ball.x,ball.y);
	MOVF        _ball+0, 0 
	MOVWF       FARG_DrawBall_x+0 
	MOVF        _ball+1, 0 
	MOVWF       FARG_DrawBall_y+0 
	CALL        _DrawBall+0, 0
;pong.c,672 :: 		check = check_winner();
	CALL        _check_winner+0, 0
	MOVF        R0, 0 
	MOVWF       main_check_L0+0 
;pong.c,673 :: 		if(check != 0){                        //Solamente si check es diferente a 0 entra
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main205
;pong.c,674 :: 		if(check == 1){
	MOVF        main_check_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main206
;pong.c,675 :: 		Glcd_Write_Text("P1 WINS", 43, 4,1);
	MOVLW       ?lstr10_pong+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr10_pong+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       43
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;pong.c,676 :: 		delay_ms(10000);
	MOVLW       102
	MOVWF       R11, 0
	MOVLW       118
	MOVWF       R12, 0
	MOVLW       193
	MOVWF       R13, 0
L_main207:
	DECFSZ      R13, 1, 1
	BRA         L_main207
	DECFSZ      R12, 1, 1
	BRA         L_main207
	DECFSZ      R11, 1, 1
	BRA         L_main207
;pong.c,677 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;pong.c,680 :: 		flag = 0;
	CLRF        _flag+0 
;pong.c,681 :: 		break;
	GOTO        L_main195
;pong.c,682 :: 		}
L_main206:
;pong.c,683 :: 		if(check == 2){
	MOVF        main_check_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main208
;pong.c,684 :: 		Glcd_Write_Text("P2 WIN", 43, 4,1);
	MOVLW       ?lstr11_pong+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr11_pong+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       43
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;pong.c,685 :: 		delay_ms(10000);
	MOVLW       102
	MOVWF       R11, 0
	MOVLW       118
	MOVWF       R12, 0
	MOVLW       193
	MOVWF       R13, 0
L_main209:
	DECFSZ      R13, 1, 1
	BRA         L_main209
	DECFSZ      R12, 1, 1
	BRA         L_main209
	DECFSZ      R11, 1, 1
	BRA         L_main209
;pong.c,686 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;pong.c,689 :: 		flag = 0;
	CLRF        _flag+0 
;pong.c,690 :: 		break;
	GOTO        L_main195
;pong.c,691 :: 		}
L_main208:
;pong.c,692 :: 		}
L_main205:
;pong.c,693 :: 		}
	GOTO        L_main194
L_main195:
;pong.c,694 :: 		}
L_main193:
;pong.c,695 :: 		break;
	GOTO        L_main120
;pong.c,697 :: 		}
L_main119:
	MOVF        _flag+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main121
	MOVF        _flag+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main143
	MOVF        _flag+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main157
L_main120:
;pong.c,698 :: 		}
	GOTO        L_main117
;pong.c,699 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
