/// @description Yowzas!
instance_create_layer(x, y, "Instances", obj_death)
instance_destroy()
audio_play_sound(snd_death, 10, false) //the old death sound is way funnier