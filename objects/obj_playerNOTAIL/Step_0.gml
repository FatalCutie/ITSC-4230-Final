/// @description This came to me in a dream

grounded = (place_meeting(x,y+1,obj_wall)) //boolean for if on the ground or not

//make code a lil bit more readable
var _keyLeft = keyboard_check(ord("A"))
var _keyRight = keyboard_check(ord("D"))
var _keyUp = keyboard_check(ord("W"))
var _keyDown = keyboard_check(ord("S"))
var _keyJump = keyboard_check_pressed(vk_space)

switch(state)
{
	case pState.normal:
	{
		if (hSpeed = 0) sprite_index = spr_playerNOTAIL
		//Movement
		var dir = _keyRight - _keyLeft
		hSpeed += dir * walkAcceleration
		
		if (dir == 0)
		{
			var hFriction = hFrictionGround
			if (!grounded) hFriction = hFrictionAir
			hSpeed = approach(hSpeed, 0, hFriction)
		}
		
		hSpeed = clamp(hSpeed, -walkSpeed, walkSpeed) //clamp speed, unclamps when grappling
		
		vSpeed += gravity_ //gravity
		
		
		if (_keyJump) && (grounded) //jump
		{
			grounded = false
			vSpeedFraction = 0
			vSpeed = -jumpSpeed
		}
		
		//Removed all grapple info
		
	} break;

}

//Movement


//Keeps player inbounds
if (x <= 32) x = 32;
if (x >= room_width - 32) x = room_width - 32;
if (y <=32) y = 32;
if (y >= room_height - 32) y = room_height - 32


//Collision
if (place_meeting(x+hSpeed, y, obj_wall))
{
	var _hStep = sign(hSpeed)
	hSpeed = 0
	hSpeedFraction = 0
	while(!place_meeting(x+_hStep, y, obj_wall)) x+= _hStep;
	
	if(state == pState.swing)
	{
		ropeAngle = point_direction(grappleX, grappleY, x, y)
		ropeAngleVelocity = -ropeAngleVelocity //bounces off of walls
	}
	
}
x += hSpeed

if (place_meeting(x, y + vSpeed, obj_wall))
{
	var _vStep = sign(vSpeed)
	vSpeed = 0
	vSpeedFraction = 0
	while(!place_meeting(x, y + _vStep, obj_wall)) y += _vStep;
	
	if(state == pState.swing)
	{
		ropeAngle = point_direction(grappleX, grappleY, x, y)
		ropeAngleVelocity = 0 //stops when hitting the ground
	}
	
}
y += vSpeed

if (hSpeed != 0)
{
	if (state != pState.swing) sprite_index = spr_monkeyWalkNOTAIL; //walking animation when moving
	if (hSpeed < 0) image_xscale = -1;
	if (hSpeed > 0) image_xscale = 1;
	//code for monkey standing still is in pState.normal
}
