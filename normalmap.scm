(define (script-fu-normalmap inImage inDrawable)
(let* ()
	; end of local variables
	; (aset! redMatrix 0 42)
	; (gimp-undo-push-group-start inImage)
	(gimp-desaturate-full
		inDrawable
		1 ; 0 = lightness, 1 = luminosity, 2 = avg
	)
	(plug-in-convmatrix
		1 ; not interactive?
		inImage ; input image (unused)
		inDrawable ; drawable
		25 ; always 25, matrix size
		#(
			0 0 0 0 0
			0 0 0 0 0
			0 -1 0 1 0
			0 0 0 0 0
			0 0 0 0 0
		)
		0 ; enable weighting by alpha channel?
		1 ; divisor
		127 ; offset
		5 ; # amount of entries in next array, always 5
		#(1 1 0 0 0) ; (1 0 0 1 0) = blue only
		0 ; 0 = extend, 1 = wrap, 2 = clear
	)
	(plug-in-convmatrix
		1 ; not interactive?
		inImage ; input image (unused)
		inDrawable ; drawable
		25 ; always 25, matrix size
		#(
			0 0 0 0 0
			0 0 -1 0 0
			0 0 0 0 0
			0 0 1 0 0
			0 0 0 0 0
		)
		0 ; enable weighting by alpha channel?
		1 ; divisor
		127 ; offset
		5 ; # amount of entries in next array, always 5
		#(1 0 1 0 0)
		0 ; 0 = extend, 1 = wrap, 2 = clear
	)
	(plug-in-convmatrix
		1 ; not interactive?
		inImage ; input image (unused)
		inDrawable ; drawable
		25 ; always 25, matrix size
		#(
			0 0 0 0 0
			0 0 0 0 0
			0 0 0 0 0
			0 0 0 0 0
			0 0 0 0 0
		)
		0 ; enable weighting by alpha channel?
		1 ; divisor
		255 ; offset
		5 ; # amount of entries in next array, always 5
		#(1 0 0 1 0)
		0 ; 0 = extend, 1 = wrap, 2 = clear
	)
	(gimp-displays-flush)
	; (gimp-undo-push-group-end inImage)
))

(script-fu-register
	"script-fu-normalmap"
	"NormalMap"
	"Creates a normal map from a height image!"
	"Antonio Noack"
	"all mine 2019, all rights reserved"
	"February 28, 2019"
	"" ; image type the script works on
	SF-IMAGE "Image" 0
	SF-DRAWABLE "Drawable" 0
)
(script-fu-menu-register "script-fu-normalmap" "<Image>/Filters")
