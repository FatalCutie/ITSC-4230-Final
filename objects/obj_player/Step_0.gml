/// @description This came to me in a dream

grounded = (place_meeting(x,y+1,obj_wall))

var _keyLeft = keyboard_check(ord("A"))
var _keyRight = keyboard_check(ord("D"))
var _keyUp = keyboard_check(ord("W"))
var _keyDown = keyboard_check(ord("S"))
var _keyJump = keyboard_check_pressed(vk_space)

switch(state)
{
	case pState.normal:
	{
		
		var dir = _keyRight - _keyLeft
		hSpeed += dir * walkAcceleration
		
		if (dir == 0)
		{
			var hFriction = hFrictionGround
			if (!grounded) hFriction = hFrictionAir
			hSpeed = approach(hSpeed, 0, hFriction)
		}
		hSpeed = clamp(hSpeed, -walkSpeed, walkSpeed)
		
		vSpeed += gravity_
		
		
		if (_keyJump) && (grounded)
		{
			grounded = false
			vSpeedFraction = 0
			vSpeed = -jumpSpeed
		}
		
		/*
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
		*/
	} break;
	
	/*
	case pState.swing:
	{
		var _ropeAngleAcceleration = -0.2 * dcos(ropeAngle) //if you told me cos() was gonna be part of my game dev career I prolly would have believed you
		ropeAngleVelocity += _ropeAngleAcceleration
		ropeAngle += ropeAngleVelocity
		ropeAngleVelocity *= 0.99 //slowly reduce velocity
		
		ropeX = grappleX + lengthdir_x(ropeLength, ropeAngle)
		ropeY = grappleY + lengthdir_y(ropeLength, ropeAngle)
		
		hSpeed = ropeX - x
		vSpeed = ropeY - y
		
		if (_keyJump)
		{
			state = pState.normal
			vSpeedFraction = 0
			vSpeed = -jumpSpeed
		}
		
	}break;
	*/
}

hSpeed += hSpeedFraction
vSpeed += vSpeedFraction
hSpeedFraction = frac(hSpeed)
vSpeedFraction = frac(vSpeed)
hSpeed -= hSpeedFraction
vSpeed -= vSpeedFraction

//collision
if (place_meeting(x+hSpeed, y, obj_wall))
{
	var _hStep = sign(hSpeed)
	hSpeed = 0
	hSpeedFraction = 0
	while(!place_meeting(x+_hStep, y, obj_wall)) x+= _hStep;
	/*
	if(state == pState.swing)
	{
		ropeAngle = point_direction(grappleX, grappleY, x, y)
		ropeAngleVelocity = -ropeAngleVelocity //0?
	}
	*/
}
x =+ hSpeed

if (place_meeting(x, y + vSpeed, obj_wall))
{
	var _vStep = sign(vSpeed)
	vSpeed = 0
	vSpeedFraction = 0
	while(!place_meeting(x, y + _vStep, obj_wall)) y += _vStep;
	/*
	if(state == pState.swing)
	{
		ropeAngle = point_direction(grappleX, grappleY, x, y)
		ropeAngleVelocity = -ropeAngleVelocity //0?
	}
	*/
}
y += vSpeed