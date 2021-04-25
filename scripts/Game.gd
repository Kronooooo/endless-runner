extends Node

var pLava = 0.50
var pWall = 0.75
var rng = RandomNumberGenerator.new()
var currentBlocksGenerated = 0

var block

var Lava = load("res://scenes/Lava.tscn")
var Wall = load("res://scenes/Wall.tscn")
var Player = load("res://scenes/Player.tscn")
var Checkpoint = load("res://scenes/Checkpoint.tscn")

const MAXLAVA = 7
const BLOCKSIZE = 64
const LAVACHANCE = 0.50

func _ready():
	randomize()
	set_process(true)
	generate()
	var player = Player.instance()
	player.set_name("Player")
	add_child(player)
	player.position.x = 100
	player.position.y = -50
	
func generate():
	pLava = 1
	for i in range(2):
		for j in range(100):
			if j < 10 && currentBlocksGenerated == 0:
				block = Wall.instance()
			elif j == 50 && i==1:
				block = Checkpoint.instance()
			elif rng.randf() <= pLava:
				if pLava == LAVACHANCE-0.07:
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
			block.position.y = 1080-(BLOCKSIZE * i)
			call_deferred("add_child",block)
		pLava = LAVACHANCE
	currentBlocksGenerated += 100
