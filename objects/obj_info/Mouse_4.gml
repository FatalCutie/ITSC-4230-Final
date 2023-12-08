/// @description Insert description here
// You can write your code in this editor



// Inherit the parent event
event_inherited();

if (instance_exists(obj_controls))
{
	instance_destroy(obj_controls);
}

else
{
	instance_create_layer(room_width *3/4 , room_height/2, "Instances", obj_controls);
}

y = ystart + 4;

alarm[0] = 10;