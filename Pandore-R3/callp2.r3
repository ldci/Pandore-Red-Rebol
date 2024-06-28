#!/usr/local/bin/r3
REBOL [
	Title:   "Pandore test"
	Author:  "Ldci"
	File: 	 %callp2.r3
]


status: ""
OS: system/platform
print ["OS:" OS]
if any [OS = 'macOS OS = 'Linux ] [home: select list-env "HOME"] 
if any [OS = 'MSDOS OS = 'Windows][home: select list-env "USERPROFILE"]
panhome: rejoin [home "/Programmation/pandore/"]
sampleDir: rejoin [panhome "examples/"]
tmpDir: rejoin [sampleDir "tmp/"]
if not exists? to-file tmpDir [make-dir to-file tmpDir]
change-dir to-file panhome
print ["Rebol Version:" system/version ]
prin "Pandore Version: " 
prog: rejoin [panhome "bin/pversion"]
call/wait prog

prin "Image Conversion Test: "
prog: rejoin ["bin/pany2pan " sampleDir "tangram.bmp " tmpDir "tangram.pan"]
call/wait/shell prog
call/wait/shell "bin/pstatus"

prin "Shows Pandore Image: "

"if Qt not installed we use Oldes's Rebol-Opencv"
cv: import 'opencv
filename: to-file rejoin [tmpDir "tangram.jpg"]
with cv [
	mat: Matrix imread/image filename
	print ["mat size    :" size: get-property mat MAT_SIZE]
    print ["mat type    :" type: get-property mat MAT_TYPE]
    print ["mat depth   :" depth: get-property mat MAT_DEPTH]
    print ["mat channels:" channels: get-property mat MAT_CHANNELS]
	imshow/name mat "Pan Image to JPG"
	waitKey 0
	print "Done"

]