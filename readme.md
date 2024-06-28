## Using Pandore library with Red and Rebol
I really appreciate using Pandore library [(Pandore)](https://clouard.users.greyc.fr/Pandore/) which provides  a lot of useful image processing operators. In many case when processing images, you have to apply successive operators: An image processing application is very often a chain of operators and Pandore offers very complete and efficient operators. The library is 100% pure C++ code  and can't be easily binded to Red or Rebol. But we have a solution with `call` instruction which can be used to execute a shell process to run another process or program.
The idea is simple. You ask Pandore to process the image(s) and then visualise the result with Red or Rebol.

### But, so far the code is considered just like a proof of concept without guarantees.

## Installing Pandore
Go to Pandore website and download the lib which is optimized for Linux and macOS (including the new ARM Apple processors). 

The complete installation needs a C++ compiler which is required and  Qt (version >= 4.0.0). Without Qt API, operators 'pvisu' and 'pdraw' are not available.  However, the rest of the operators works without Qt.

Then unpack and install the distribution on your computer.

The idea is now to call the operators from Red or Rebol3 programs with call. This is really simple. All operators are in /pandore/bin directory and your code must point to this directory.
`panhome: "Your access to/pandore`
`change-dir to-file panhome`

Then just use call operator 
`call/output "bin/pversion" status` 

The pversion operator can be used to test if the pandore lib is correctly installed. Here we use wait/output in order to redirect stdout to a string and get the result of the operator: SUCCESS or FAILURE. When using other operators which process image don't forget to use `call/wait`  to run the operator and wait for execution.

## Using Pandore with Red
We use Red 0.6.5 [(Red)](http://www.red-lang.org/p/about.html) on 32-bit X-86 macOS (Mojave). If Qt is not present on your system you'll find pvisu.red tool. You must compile a release version (red -r pvisu.red) and move the compiled pvisu file to pandore/bin directory. pvisu uses filename as argument: `bin/pvisu test.pan`


## Using Pandore with Rebol
We use  [(Rebol3)](https://github.com/Oldes/Rebol3) on 64-bit ARM macOS (Sonora). X-86 processors are also supported. If Qt is not present on your system you can use  Oldes's extension for Rebol3 that allows you to use recent versions of OpenCV: [(OpenCV by Oldes)] (https://github.com/Oldes/Rebol-OpenCV).
`img: make image! reduce [as-pair x y pandore/pobject/data]`
`cv: import 'opencv`
`mat: cv/Matrix img`
`cv/imshow/name mat "Pan Image"`
`print "Any key to close"`
`cv/waitKey 0`
