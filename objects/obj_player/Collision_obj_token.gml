/// @description Collect a banana, get other.pointValue points
instance_destroy(other)
score += other.pointValue
audio_play_sound(snd_pickup, 10, false)