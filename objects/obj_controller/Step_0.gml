var timeDecay = delta_time/1000000
if (timerCheat = 1) //pause timer if cheat is active
{
	if (timer > 0)
	{
		timer -= timeDecay
	} else timer = 0;
	showTime = ceil(timer)
}

//Cheat Codes
if (keyboard_check_pressed(ord("Z"))) room_restart()
if (keyboard_check_pressed(vk_escape)) game_restart()
if (keyboard_check_pressed(ord("T"))) timerCheat = 0 //freeze timer