extends Node

var rng = RandomNumberGenerator.new()
var pLava = 0.50
var lavaChance = 0.50
var pWall = 0.75
var pEnemy = 0.1
var currentBlocksGenerated = 0

var block
var item

var Lava = load("res://scenes/Lava.tscn")
var Wall = load("res://scenes/Wall.tscn")
var Player = load("res://scenes/Player.tscn")
var Checkpoint = load("res://scenes/Checkpoint.tscn")
var Key = load("res://scenes/Key.tscn")
var Door = load("res://scenes/Door.tscn")
var Trooper = load("res://scenes/Trooper.tscn")
var Chamber = load("res://scenes/Chamber.tscn")

var enemies = [Trooper]
var chambers = []

const BLOCKSIZE = 64

func _ready():
	rng.randomize()
	set_process(true)
	generateTerrain()
	var player = Player.instance()
	player.set_name("Player")
	add_child(player)
	player.position.x = 100
	player.position.y = -50
	
func _process(_delta):
	if chambers.size() == 4:
		call_deferred("free",chambers[0])
		
func generateTerrain():
	var numPlatform = 0
	var minPlatform = 3
	var parent = Chamber.instance()
	call_deferred("add_child",parent)
	chambers.append(parent)
	rng.randomize()
	for i in range(100):
		if i < 10 && currentBlocksGenerated == 0:
			block = Wall.instance()
		elif i <= 5:
			block = Wall.instance()
		elif i == 50:
			block = Checkpoint.instance()
		elif i >= 98:
			block = Wall.instance()
		elif rng.randf() < pLava:
			if pLava <= lavaChance-0.05:
				pLava = lavaChance
				block = Wall.instance()
			else:
				pLava -= 0.01
				block = Lava.instance()
			numPlatform = 0
		else:
			block = Wall.instance()
			numPlatform += 1
			if numPlatform < minPlatform:
				pLava = 0
			else:
				pLava = lavaChance
				
			rng.randomize()
			if rng.randf() < pEnemy:
				spawnEnemy(i)
				
		block.position.x = BLOCKSIZE * (i+currentBlocksGenerated)
		block.position.y = 1080
		call_deferred("add_child_below_node",parent,block)
	generateKey()
	generateDoor()
	currentBlocksGenerated += 100
	pLava = lavaChance
	pLava += 0.006
	lavaChance = pLava

func generateKey():
	var x = rng.randi_range(10,80)
	var y = rng.randi_range(3,5)
	item = Key.instance()
	item.position.x = BLOCKSIZE * (x+currentBlocksGenerated)
	item.position.y = 1080 - (BLOCKSIZE * y)
	call_deferred("add_child",item)
	
func generateDoor():
	block = Door.instance()
	block.position.x = BLOCKSIZE * (currentBlocksGenerated+99)
	block.position.y = 1080 - BLOCKSIZE
	call_deferred("add_child",block)
	for i in range(5):
		block = Wall.instance()
		block.position.x = BLOCKSIZE * (currentBlocksGenerated+99)
		block.position.y = 1080 - BLOCKSIZE * (i+3)
		call_deferred("add_child",block)
		
func spawnEnemy(i):
	enemies.shuffle()
	var enemy = enemies[0].instance()
	enemy.position.x = BLOCKSIZE * (i+currentBlocksGenerated)
	enemy.position.y = 1020
	call_deferred("add_child",enemy)
