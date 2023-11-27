/// @description I always had a thing for artists
c_brown = make_color_rgb(160, 65, 13)
draw_set_color(c_brown)
if (state == pState.swing) draw_line_width(grappleX, grappleY, ropeX, ropeY, 2); //Draw the grapple
draw_self()
