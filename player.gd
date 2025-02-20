extends CharacterBody2D

# Constantes para controlar a velocidade de movimento e a velocidade do pulo
const SPEED = 110.0  # A velocidade de movimento horizontal do personagem
const JUMP_VELOCITY = -480.0  # A velocidade do pulo (para cima, então é um valor negativo)
const MAX_Y = 308
const MIN_Y = 275
const Velocity = 9.0

func _physics_process(delta: float) -> void:
	
	# Movimentação horizontal
	var direction_horizontal := Input.get_axis("ui_left", "ui_right")
	if Input.is_action_pressed("correr"):
		#bloco de codigo rapido
		velocity.x = direction_horizontal * Velocity
		$AnimatedSprite2D.play("run")
	
	if direction_horizontal:
		# Direção positiva (movimento para a direita)
		if direction_horizontal > 0:
			velocity.x = direction_horizontal * SPEED
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("run")
		# Direção negativa (movimento para a esquerda)
		else:
			velocity.x = direction_horizontal * SPEED
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("run")
	else:
		# Se não há movimento horizontal, o personagem vai desacelerando até parar
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("idle")
			
	var direction_vertical := Input.get_axis("ui_up", "ui_down")
	if direction_vertical != 0:
		velocity.y = direction_vertical * SPEED 
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	#por pra correr
	
			#limitar a area de movimentação
	position.y = clamp(position.y + velocity.y * delta, MIN_Y, MAX_Y)
	# Aplica a física do movimento (gravidade, colisões, etc.)
	move_and_slide()
