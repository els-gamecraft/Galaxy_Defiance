extends Node2D

@export var GreenEnemyScene: PackedScene
@export var RedEnemyScene: PackedScene
@export var BlueSilverEnemyScene: PackedScene
@export var PinkEnemyScnene: PackedScene

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
	green_enemy_spawn_timer.timeout.connect(handle_spawn.bind(GreenEnemyScene, green_enemy_spawn_timer))
	red_enemy_spawn_timer.timeout.connect(handle_spawn.bind(RedEnemyScene, red_enemy_spawn_timer))
	blue_silver_timer.timeout.connect(handle_spawn.bind(BlueSilverEnemyScene, blue_silver_timer))
	pink_enemy_spawn_timer.timeout.connect(handle_spawn.bind(PinkEnemyScnene, pink_enemy_spawn_timer))
	
func handle_spawn(enemy_scene: PackedScene, timer: Timer) -> void:
	spawner_component.scene = enemy_scene
	spawner_component.spawn(Vector2(randf_range(margin, screen_width-margin), -16))
	timer.start()
	
