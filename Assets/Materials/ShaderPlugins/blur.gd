# Simple Blur
extends VisualShaderNodeCustom
class_name VisualShaderSimpleBlur

func _get_name():
	return "Simple Blur"

func _get_category():
	return "Visual FX"

func _get_description():
	return "A simple blur effect"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_input_port_count():
	return 2

func _get_input_port_name(port):
	match port:
		0:
			return "input_texture"
		1:
			return "Intensity"

func _get_input_port_type(port):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count():
	return 1

func _get_output_port_name(port):
	return "Blurred"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR

func _get_global_code(mode):
	return """
		
	"""
func _get_code(input_vars, output_vars, mode, type):
	pass

