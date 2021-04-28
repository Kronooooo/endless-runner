extends Node

var rng = RandomNumberGenerator.new()
var pLava = 0.50
var pWall = 0.75
var currentBlocksGenerated = 0
var block

var item

var Lava = load("res://scenes/Lava.tscn")
var Wall = load("res://scenes/Wall.tscn")
var Player = load("res://scenes/Player.tscn")
var Checkpoint = load("res://scenes/Checkpoint.tscn")
var Key = load("res://scenes/Key.tscn")
var Door = load("res://scenes/Door.tscn")

const BLOCKSIZE = 64
const LAVACHANCE = 0.50

func _ready():
	rng.randomize()
	set_process(true)
	generateTerrain()
	var player = Player.instance()
	player.set_name("Player")
	add_child(player)
	player.position.x = 100
	player.position.y = -50
	
func generateTerrain():
	rng.randomize()
	pLava = 1
	for i in range(2):
		for j in range(100):
			if j <= 1:
				block = Wall.instance()
			elif j < 10 && currentBlocksGenerated == 0:
				block = Wall.instance()
			elif j == 50 && i == 1:
				block = Checkpoint.instance()
			elif j >= 98 && i == 1:
				block = Wall.instance()
			elif rng.randf() <= pLava:
				if pLava == LAVACHANCE-0.06:
					pLava = LAVACHANCE
					block = Wall.instance()
				elif pLava <= LAVACHANCE:
					pLava -= 0.01
					block = Lava.instance()
				else:
					block = Lava.instance()
			else:
				block = Wall.instance()
			block.position.x = BLOCKSIZE * (j+currentBlocksGenerated)
			block.position.y = 1080 - (BLOCKSIZE * i)
			call_deferred("add_child",block)
		pLava = LAVACHANCE
	generateKey()
	generateDoor()
	currentBlocksGenerated += 100

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
	block.position.y = 1080 - (BLOCKSIZE * 2)
	call_deferred("add_child",block)
	for i in range(5):
		block = Wall.instance()
		block.position.x = BLOCKSIZE * (currentBlocksGenerated+99)
		block.position.y = 1080 - (BLOCKSIZE * (i+4))
		call_deferred("add_child",block)
