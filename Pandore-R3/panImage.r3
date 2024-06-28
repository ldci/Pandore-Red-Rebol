#!/usr/local/bin/r3
REBOL [
]

;--for reading pan images
do %pObject/panlibObj.r3

OS: system/platform
print ["OS:" OS]
if any [OS = 'macOS OS = 'Linux ] [home: select list-env "HOME"] 
if any [OS = 'MSDOS OS = 'Windows][home: select list-env "USERPROFILE"]
panhome: rejoin [home "/Programmation/pandore/"]
sampleDir: rejoin [panhome "examples/"]
tmpDir: rejoin [sampleDir "tmp/"]
change-dir to-file panhome
print ["Rebol Version:" system/version ]
prin "Pandore Version: " 
prog: rejoin [panhome "bin/pversion"]
call/wait prog

pFile: to-file rejoin [sampleDir "tangram.pan"]
pandore/readPanHeader pFile							;--read pan file header
pandore/readPanAttributes  pFile					;--read pan file properties
pandore/readPanImage  pFile							;--read pan file data as binary
idx: pandore/pobject/poprop/colorspace				;--default RGB colorspace
x: pandore/pobject/poprop/ncol						;--columns number
y: pandore/pobject/poprop/nrow						;--rows number
bands: pandore/pobject/poprop/nbands				;--bands number
depth: pandore/pobject/poprop/ndep					;--number of planes (depth)
print [to string! PColorSpace/(idx + 1) x y bands]	;--image properties
probe depth											;--? 

;--create a Rebol image with pan image data
img: make image! reduce [as-pair x y pandore/pobject/data]
;--we use Opencv for image visualisation 
cv: import 'opencv
mat: cv/Matrix img
cv/imshow/name mat "Pan Image"
print "Any key to close"
cv/waitKey 0




