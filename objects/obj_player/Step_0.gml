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
		if (hSpeed = 0) sprite_index = spr_player
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
		
		
		if (mouse_check_button(mb_left)) //Gets player into grapple state, stores necessary info
		{
			grappleX = mouse_x
			grappleY = mouse_y
			ropeX = x
			ropeY = y
			ropeAngleVelocity = 0
			ropeAngle = point_direction(grappleX, grappleY, x, y)
			ropeLength = point_distance(grappleX, grappleY, x, y)
			state = pState.swing
		}
		
	} break;
	
	
	case pState.swing:
	{
		sprite_index = spr_swing
		var _ropeAngleAcceleration = -0.2 * dcos(ropeAngle) //if you told me cos() was gonna be part of my game dev career I probably would have believed you
		ropeAngleVelocity += _ropeAngleAcceleration
		ropeAngle += ropeAngleVelocity
		ropeAngleVelocity *= 0.99 //slowly reduce velocity
		
		//Movement while grappled
		var dir = _keyRight - _keyLeft
		ropeAngleVelocity += dir * ropeAcceleration
		//TODO: Add clamp?
		if (dir == 0)
		{
			var hFriction = hFrictionAir
			ropeAngleVelocity = approach(ropeAngleVelocity, 0, hFriction)
		}
		
		ropeX = grappleX + lengthdir_x(ropeLength, ropeAngle)
		ropeY = grappleY + lengthdir_y(ropeLength, ropeAngle)
		
		hSpeed = ropeX - x
		vSpeed = ropeY - y
		
		if (_keyJump)
		{
			state = pState.leap
			vSpeedFraction = 0
			vSpeed = -jumpSpeed
		}
		
	}break;

	case pState.leap: //When a player jumps out of a grapple
	{
		if(grounded) state = pState.normal //player regains control when touching the gorund
		
		//Allows you to slow momentum in the air
		if (hSpeed > 0) //swinging right
		{
			if (_keyLeft) hSpeed -= walkAcceleration	
			//hSpeed = clamp(hSpeed, 0, 10000)
		}
		if (hSpeed < 0) //swinging left
		{
			if (_keyRight) hSpeed += walkAcceleration
			//hSpeed = clamp(hSpeed, 10000, 0)
		}
		
		vSpeed += gravity_ //gravity
		
		
		if (mouse_check_button(mb_left)) //Gets player into grapple state, stores necessary info
		{
			grappleX = mouse_x
			grappleY = mouse_y
			ropeX = x
			ropeY = y
			ropeAngleVelocity = 0
			ropeAngle = point_direction(grappleX, grappleY, x, y)
			ropeLength = point_distance(grappleX, grappleY, x, y)
			state = pState.swing
		}
		
	} break;

}

//Movement
if (state != pState.leap)
{
	hSpeed += hSpeedFraction
	vSpeed += vSpeedFraction
	hSpeedFraction = frac(hSpeed)
	vSpeedFraction = frac(vSpeed)
	hSpeed -= hSpeedFraction
	vSpeed -= vSpeedFraction
}

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
	if (state != pState.swing) sprite_index = spr_monkeyWalk; //walking animation when moving
	if (hSpeed < 0) image_xscale = -1;
	if (hSpeed > 0) image_xscale = 1;
	//code for monkey standing still is in pState.normal
}
