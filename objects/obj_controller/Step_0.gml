var timerTick = delta_time/1000000
if (timerCheat = 1)
{
	if(myTime > 0)
	{
		myTime -= timerTick
	} else myTime = 0;
	showTime = ceil(myTime)
}

//Cheat Codes
if (keyboard_check_pressed(ord("Z"))) room_restart();
if (keyboard_check_pressed(vk_escape)) game_restart();
if (keyboard_check_pressed(ord("T"))) timerCheat = true; //freeze timer
if (keyboard_check_pressed(ord("F"))) funnyGameover = true;