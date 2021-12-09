extends StateMachine

func _ready():
	add_state("idle")
	add_state("walk")
	add_state("jump")
	add_state("fall")
	add_state("death")
	print(states)
	call_deferred("set_state", states.idle)
	parent.connect("death", self, "_set_death")
	print ("ready")

func _set_death():
	self.set_state(states.death)
	
func _state_logic(delta):
	parent._apply_movement()
	parent._apply_gravity(delta)

func _input(event):
	if state in [states.walk, states.idle]:
			if Input.is_action_just_pressed("jump"):
				parent.velocity.y = parent.max_jump_velocity
		
func _not_on_floor_state():
	if parent.velocity.y < 0:
		return states.jump
	elif parent.velocity.y >0:
		return states.fall		
	else:
		return null
		
func _get_transition(delta):
	match state:
		states.idle:
			if !parent.is_on_floor():
				return _not_on_floor_state()			
			elif parent.velocity.x != 0:
				return states.walk
		states.walk:
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y >0:
					return states.fall		
			elif parent.velocity.x == 0 || parent.velocity.x == -0:
				return states.idle
		states.jump:
			if parent.is_on_floor():
				return states.idle
			elif parent.velocity.y > 0:
				return states.fall
		states.fall:
			if parent.is_on_floor():
				return states.idle
			elif parent.velocity.y < 0:
				return states.jump
				
func _enter_state(new_state, old_state):
	print("entering " + str(new_state))
	match new_state:
		states.idle:
			parent.foot_snow.emitting = false
			parent.animated_sprite.play("idle")
		states.walk:
			parent.animated_sprite.play("walk")
			parent.animated_sprite.flip_h = parent.velocity.x > 0
			parent.foot_snow.emitting = true
		states.jump:
			parent.foot_snow.emitting = false
			parent.animated_sprite.flip_h = parent.velocity.x > 0
			parent.animated_sprite.play("jump")
		states.death:
			parent.velocity.x = 0.0
			parent.animated_sprite.play("death")

func _exit_state(old_state, new_state):
	match old_state:
		states.walk:
			parent.foot_snow.emitting = false
		states.idle:
			parent.foot_snow.emitting = false
