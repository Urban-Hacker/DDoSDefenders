extends Control


func _ready():
	_on_balance_changed()
	Core.on_balance_changed.connect(_on_balance_changed)


func _on_balance_changed():
	$MoneyLabel.text = str(Core.get_sats_balance()) + "$"
