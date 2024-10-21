/// @description
var _damage = other.touchDamage;
if(!isInvulnerable && other.isAlive && _damage>0){
	hit(other.touchDamage, other.x, other.y);
}


