/// @description Asks the player to restart after death
if (global.game_over)
{
	draw_set_halign(fa_center)
	draw_set_color(c_white)
	draw_text(room_width / 2, room_height / 2, "Game Over! Press ESC to restart.")
} else
{
	draw_set_color(c_white)
	draw_text(x, y, "Time left: " + string(showTime))
	draw_text(x, y + 20, "Score: " + string(score))
	if (funnyGameover) draw_text(x, y + 40, "Canon death enabled")
	if (timerCheat)  draw_text(x, y + 60, "Timer Paused")
}
