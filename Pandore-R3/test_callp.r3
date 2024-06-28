#!/usr/local/bin/r3
REBOL [
	Title:   "Pandore test"
	Author:  "Ldci"
	File: 	 %callp.r3
]


status: ""
OS: system/platform
print OS
if any [OS = 'macOS OS = 'Linux ] [home: select list-env "HOME"] 
if any [OS = 'MSDOS OS = 'Windows][home: select list-env "USERPROFILE"]

panhome: rejoin [home "/Programmation/pandore/"]
sampleDir: rejoin [panhome "examples/"]
tmpDir: rejoin [sampleDir "tmp/"]
if not exists? to-file tmpDir [make-dir to-file tmpDir]
change-dir to-file panhome
print "Rebol 3.17.0 Version"
prin "Pandore Version: " 
prog: rejoin [panhome "bin/pversion"]
call/wait prog

prin "Image Conversion Test: to pan format: "
prog: rejoin ["bin/pany2pan " sampleDir "tangram.bmp " tmpDir "tangram.pan"]
call/wait/shell prog
call/wait/shell "bin/pstatus"

prin "Image Conversion Test: from pan format: "
prog: rejoin ["bin/ppan2jpeg 1.0 " tmpDir "tangram.pan " tmpDir "tangram.jpg" ]
call/wait/shell prog
call/wait/shell "bin/pstatus"

prog: rejoin ["bin/pvisu.app/Contents/MacOS/pvisu " tmpDir "tangram.pan "]
call/wait/shell prog

comment[
;--if Qt not installed we use Rebol-Opencv
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
]
]
print "Done"


 
