var timerTick = delta_time/1000000
if (timerCheat = false)
{
	if(myTime > 0)
	{
		myTime -= timerTick
	} else myTime = 0;
	showTime = ceil(myTime)
}

//Cheat Codes
if (keyboard_check_pressed(ord("Z")))
{
	global.game_over = false
	room_restart(); //This screws with the UI text but my team didnt decide to update the game until AN HOUR
	//BEFORE THE DUE DATE SO UR JUST GONNA HAVE TO SUCK IT UP
}
if (keyboard_check_pressed(vk_escape))
{
	global.game_over = false
	score = 0
	game_restart();
}
if (keyboard_check_pressed(ord("T"))) timerCheat = true; //freeze timer
if (keyboard_check_pressed(ord("F"))) funnyGameover = true;
if (keyboard_check_pressed(ord("G"))) obj_player.hasTail = true