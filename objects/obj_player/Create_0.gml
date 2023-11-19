/// @description Where the magic happens
hSpeed = 0
vSpeed = 0
walkSpeed = 3
walkAcceleration = 1.5
hFrictionGround = 0.5
hFrictionAir = 0
jumpSpeed = 6
gravity_ = 0.2
hSpeedFraction = 0.0
vSpeedFraction = 0.0
state = pState.normal
grounded = true

//Grapple Declarations
grappleX = 0
grappleY = 0
ropeX = 0
ropeY = 0
ropeAngleVelocity = 0
ropeAngle = 0
ropeLength = 0

enum pState
{
	normal,
	swing,
	leap
}