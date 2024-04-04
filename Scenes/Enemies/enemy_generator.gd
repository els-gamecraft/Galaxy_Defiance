extends Node2D

@export var GreenEnemyScene: PackedScene
@export var RedEnemyScene: PackedScene
@export var BlueSilverEnemyScene: PackedScene
@export var PinkEnemyScnene: PackedScene

@export var game_stats: GameStats

#const GreenEnemyScene = preload("res://Scenes/Enemies/green_enemy.tscn")

var margin: int = 8
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")

@onready var spawner_component: SpawnerComponent = $SpawnerComponent
@onready var green_enemy_spawn_timer: Timer = $GreenEnemySpawnTimer
@onready var red_enemy_spawn_timer: Timer = $RedEnemySpawnTimer
@onready var blue_silver_timer: Timer = $BlueSilverTimer
@onready var pink_enemy_spawn_timer: Timer = $PinkEnemySpawnTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	green_enemy_spawn_timer.timeout.connect(handle_spawn.bind(GreenEnemyScene, green_enemy_spawn_timer, 3))
	red_enemy_spawn_timer.timeout.connect(handle_spawn.bind(RedEnemyScene, red_enemy_spawn_timer, 10))
	blue_silver_timer.timeout.connect(handle_spawn.bind(BlueSilverEnemyScene, blue_silver_timer, 2))
	pink_enemy_spawn_timer.timeout.connect(handle_spawn.bind(PinkEnemyScnene, pink_enemy_spawn_timer, 10))
	
	game_stats.score_changed.connect(func(new_score: int):
		if new_score > 10:
			blue_silver_timer.process_mode = Node.PROCESS_MODE_INHERIT
		
		if new_score > 35:
			red_enemy_spawn_timer.process_mode = Node.PROCESS_MODE_INHERIT
		
		if new_score > 60:
			pink_enemy_spawn_timer.process_mode = Node.PROCESS_MODE_INHERIT
	)
	
	
func handle_spawn(enemy_scene: PackedScene, timer: Timer, time_offset: float = 1.0) -> void:
	spawner_component.scene = enemy_scene
	var multiplier: float = 0.0015 		# higher = faster enemy spawn rate 
	spawner_component.spawn(Vector2(randf_range(margin, screen_width-margin), -16))
	var spawn_rate = time_offset / (1 + (game_stats.score * multiplier))
	timer.start(spawn_rate + randf_range(0.24, 0.5))
	
