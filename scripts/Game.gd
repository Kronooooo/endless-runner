extends Node

var pLava = 0.10
var pWall = 0.90
var rng = RandomNumberGenerator.new()
var Lava = load("res://scenes/Lava.tscn")
var Wall = load("res://scenes/Wall.tscn")
var Player = load("res://scenes/Player.tscn")

const MAXLAVA = 7
const BLOCKSIZE = 32

func _ready():
	rng.seed = hash("Test")
	pLava = 1
	for i in range(2):
		for j in range(1,101):
			var block
			if rng.randf() <= pLava:
				block = Lava.instance()
				if pLava == 0.03:
					pLava = 0.1
					block = Wall.instance()
				if pLava <= 0.1:
					pLava -= 0.01
			else:
				block = Wall.instance()
			add_child(block)
			block.position.x = BLOCKSIZE * 2 * j - 32
			block.position.y = +1080-(BLOCKSIZE * i)
		pLava = 0.1
	var player = Player.instance()
	add_child(player)
	player.position.x = 100
	player.position.y = -50
