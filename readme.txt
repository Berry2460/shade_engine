Shade Engine commands:

IMPORTRANT to use this in source code: setlocal enabledelayedexpansion

m(x)m(y) = map coordinate block (use wall numbers or n for air)
x(x)x(y) = screen coordinates (used for models)
cx = camera x
cy = camera y
turn = camera turn angle 1-4 NESW
render = max render distance 2-7 default 5
floor = floor texture
sky = sky texture
wmax = wall maximum
w(number)f = wall (number) face texture
w(number)s = wall (number) side texture
model = the name of your model file to be drawn on screen (.bat extension is automatically added)

example of a model:
set model=crosshair

Contents of "crosshair.bat":
set x8x8=/\

textures are two characters wide, ex:(##, ==, *-, @#, @@)

screen dimensions are 16x16
