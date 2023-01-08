# Pong MikroC
### Primer proyecto taller de sistemas embedidos
Se realiza el proyecto de la imitacion del juego "PONG" en C, el cual el usuario mediante un 
  - Microcontrolador PIC18F4550
  - Pantalla GLCD 128x64 
  - Joystick
Puede jugar en modo 1 jugador o multijugador. 

Para el modo un jugador, el usuario juega en contra de la computadora, la cual esta disenada para tomar desiciones en base a la posicion y direccion de la bola, 
empleando cada cierto tiempo movimientos aleatorios, los cuales se aprovechan para que el usuario tenga oportunidades de ganar.
Para el modo multijugador se emplea el protocolo de comunicacion UART. En el cual se empaquetan los datos, se envian y se desempaquetan utilizando librerias dadas por 
el IDE MikroC.

Comunicaciones posibles:
  - PIC18F4550 <-> PIC18F4550
  
# Pong MikroC
### First project embedded systems workshop
The project of the imitation of the game "PONG" in C is realized, which the user by means of a 
  - Microcontroller PIC18F4550
  - GLCD 128x64 screen 
  - Joystick
Can play in 1 player or multiplayer mode. 

For the single player mode, the user plays against the computer, which is designed to make decisions based on the position and direction of the ball, 
using random moves from time to time, which are used to give the user a chance to win.
For the multiplayer mode, the UART communication protocol is used. In which data is packaged, sent and unpacked using libraries provided by the MikroC IDE. 
the MikroC IDE.

Possible communications:
  - PIC18F4550 <-> PIC18F4550
