if (timerCheat = 1)
{
timer += 1/room_speed //keeps track of time in level
}

//Cheat Codes
if (keyboard_check_pressed(ord("Z"))) room_restart()
if (keyboard_check_pressed(vk_escape)) game_restart()
if (keyboard_check_pressed(ord("T"))) timerCheat = 0 //freeze timer