#!/usr/local/bin/r3
Red [
	Title:   "Pandore test"
	Author:  "ldci"
	File: 	 %callp.r3
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
call/wait/shell prog

prin "Image Conversion Test: "
prog: rejoin ["bin/pany2pan " sampleDir "tangram.bmp " tmpDir "tangram.pan"]
call/wait/shell prog
call/wait/shell "bin/pstatus"

prin "Shows Pandore Image: "
prog: rejoin ["bin/pvisu.app/Contents/MacOS/pvisu " tmpDir "tangram.pan "];--with Qt
call/wait/shell prog
call/shell/wait "bin/pstatus"
print "Done"