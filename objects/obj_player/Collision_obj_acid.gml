/// @description Yowzas!
instance_create_layer(room_width / 2, room_height / 2, "Instances", obj_death)
instance_destroy()
audio_play_sound(snd_death, 10, false) //the old death sound is way funnier