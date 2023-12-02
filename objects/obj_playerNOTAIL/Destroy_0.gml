/// @description Sets gameover to true
global.game_over = true
if obj_controller.funnyGameover
{
	instance_create_layer(room_width / 2, room_height / 2, "Instances", obj_death)
	audio_play_sound(snd_oldDeath, 10, false) //the old death sound is way funnier
}