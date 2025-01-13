extends Control

@onready var Coins = %Coin_counter
@onready var Esses = %Ess_counter
@onready var L_picked = $transparency/Hot_bar/HotBarPicked_L
@onready var R_picked = $transparency/Hot_bar/HotBarPicked_R
@onready var druid_a = $"transparency/Health&stamina_bar/DruidBase"
@onready var druid_d = $"transparency/Health&stamina_bar/DruidDeath"

func _process(delta: float) -> void:
	if Global_Vars.Spell_slot == 0:
		L_picked.visible = true
		R_picked.visible = false
	else :
		L_picked.visible = false
		R_picked.visible = true
	if Global_Vars.dead_b == true:
		druid_a.visible = false
		druid_d.visible = true
	Coins.text = str(Global_Vars.coins)
	Esses.text = str(Global_Vars.essenses)
	
