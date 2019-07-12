extends Node2D

onready var Levels = preload("res://scenes/levels_s.tscn")
onready var player_died_popup = preload("res://scenes/player_died.tscn")
onready var pickup_coins = preload("res://scenes/PickupCoins.tscn")
onready var start = get_node("Start")
onready var camera = get_node("level_movement")
onready var camera_tween = get_node("smoth_camera_movement")
onready var top = get_node("top")
onready var player = get_node("player2")
var spawn = Vector2(0,1333)
var camera_start_position = Vector2()
var max_levels = 100
var camera_move = Vector2(0,0)
var popup

func _ready():
	Global.set_player_dead(false)
	Global.set_send_player_dead_signal(false)
	print(Global.connect("player_dead", self, "_on_Global_player_dead"))
	start.add_to_group("base")
	player.side_move = true
	randomize()
	
	var start = self.spawn_levels()
	camera_start_position = camera.get_position()
	start.chain()

func random_speeds(level):
	var speeds = [1,1.5,2,2.5,3]
	var vel = speeds[round(rand_range(0,4))]
	level.correct_color(vel-1)#assigning color based on speed
	level.set_left_vel(vel)
	level.set_right_vel(vel)

# used to spawn pickup coinds in a given range determined by how many levels are spawned.
func spawn_pickup_coins(spawn_position):  
	var new_pickup_coin = pickup_coins.instance()
	add_child_below_node(top , new_pickup_coin)
	var spawn_pos = spawn_position
	new_pickup_coin.position = spawn_pos
		
	
func spawn_levels():
	var last_level
	var start
	
	for i in range(0,max_levels):
		var new_level = Levels.instance()
		add_child_below_node(top , new_level)
		new_level.correct_color(rand_range(0,2))
		if Global.diff_speeds == true:
			random_speeds(new_level)
		if Global.collors == true:
			pass
		if Global.diff_heights == true:
			new_level.randome_level_heights()
		spawn.y -= new_level.get_text_height()
		new_level.set_position(spawn)
		if i > 0:
			last_level.set_next_level(new_level)
		if i == 0:
			start = new_level
		last_level = new_level
		new_level.connect("move_camera", self, "_on_new_level_move_camera")
	
		
		
	return start

func _on_new_level_move_camera(camera_mover):
	var camera_movement = camera_start_position - camera_mover
	camera_tween.interpolate_property(camera, "position", camera_start_position, camera_movement, 1,Tween.TRANS_LINEAR,Tween.EASE_IN)
	camera_tween.start()
	camera_start_position = camera_movement
	camera_move = camera_mover
	var middle_screen = (get_viewport().size.x+Global.get_offset())
	var top_screen = $level_movement.position.y-get_viewport().size.y+Global.get_offset()
	var coin_spawn_pos = Vector2(rand_range(Global.get_offset()+90, (middle_screen)), top_screen)
	spawn_pickup_coins(coin_spawn_pos)

func _on_Global_player_dead():
	var new_popup = player_died_popup.instance()
	var pos = Vector2(Global.screen_size.x/2, camera_start_position.y + camera_move.y)
	add_child(new_popup)
	new_popup.set_position(pos)
	popup = new_popup
		

func _on_player2_animation_done():
	$Timer.start(-2.5)


func _on_Timer_timeout():
	popup.show()
