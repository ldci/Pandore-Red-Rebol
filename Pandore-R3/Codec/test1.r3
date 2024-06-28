#!/usr/local/bin/r3
Rebol [title: "PAN codec  test"]

import %pandore.reb
panFile: load %tangram.pan
print ["Magic  :" panFile/magic] 
print ["Type   :" panFile/ptype]
print ["Author :" panFile/ident]
print ["Date   :" panFile/date]
print ["Unused :" panFile/unused]
print ["Bands  :" panFile/nbands]
print ["Rows   :" panFile/nrow]
print ["Columns:" panFile/ncol]
print ["Depth  :" panFile/ndep]

;--create a Rebol image with pan image data
img: make image! reduce [as-pair panFile/ncol panFile/nrow panFile/data]
;--we use Opencv for image visualisation 
cv: import 'opencv
mat: cv/Matrix img
cv/imshow/name mat "Pan Image"
print "Any key to close"
cv/waitKey 0