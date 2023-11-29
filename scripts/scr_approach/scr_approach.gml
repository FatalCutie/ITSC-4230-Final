//Hello TA's, I hope you're having a wonderful day/night
//I'm sure you're appreciating my programming wizardry AND world renound modesty
function approach(start, target, shift) 
{
    if (start < target) {
        return min(start+shift, target);
    } else {
        return max(start-shift, target);
    }
}