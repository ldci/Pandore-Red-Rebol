Rebol [
	name:    pandore
	title:   "Codec: PAN"
	Author:  "Oldes"
	version: 0.0.1
	purpose: "Decode data from Pandore library files"
	note:    https://clouard.users.greyc.fr/Pandore/
]

register-codec [
	name:  'pandore
	type:  'image
	title: "Pandore library file"
	suffixes: [%.pan]

	decode: function [
		{Extracts content of the PAN file}
		data  [binary! file! url!]
		;return: [object!]
	][
		unless binary? data [ data: read data ]
		out: copy pobject
		set out binary/read data [
			BYTES 12    ;= magic
			UI32LE      ;= ptype
			BYTES 9     ;= ident
			BYTES 10    ;= date
			UI8         ;= unused
			UI32LE      ;= nbands
			UI32LE      ;= nrow
			UI32LE      ;= ncol
			UI32LE      ;= ndep
			BYTES
		]
		out/magic: trim/tail to string! out/magic
		out/ptype: ajoin [out/ptype ": " to string! pick obj-types out/ptype]
		out/ident: to string! trim out/ident
		out/date:  to date! join #"2" to string! trim out/date
		;@@ TODO... extract data according the object type...
		out
	]

	pobject: construct [
		;-- header                                                
		magic:      ;; The magic number (12 bytes) @ref PO_MAGIC
		ptype:      ;; The object type (4 bytes)
		ident:      ;; The autor name (9 bytes + 1 complement)
		date:       ;; The creation date (10 bytes)
		unused:     ;; Unused (1 complement)
		;-- attributes                                            
		nbands:     ;; The number of bands
		nrow:       ;; The number of columns
		ncol:       ;; The number of rows
		ndep:       ;; The number of planes (depth)
		;-- the rest of file                                      
		data:
	]
	obj-types: [
		Po_Collection
		Po_Img1duc Po_Img1dsl Po_Img1dsf
		Po_Img2duc Po_Img2dsl Po_Img2dsf
		Po_Img3duc Po_Img3dsl Po_Img3dsf
		Po_Reg1d Po_Reg2d Po_Reg3d
		Po_Graph2d Po_Graph3d
		Po_Imc2duc Po_Imc2dsl Po_Imc2dsf
		Po_Imc3duc Po_Imc3dsl Po_Imc3dsf
		Po_Imx1duc Po_Imx1dsl
		Po4_Imx1dul Po_Imx1dsf
		Po_Imx2duc Po_Imx2dsl Po4_Imx2dul
		Po_Imx2dsf Po_Imx3duc Po_Imx3dsl
		Po4_Imx3dul Po_Imx3dsf
		Po_Point1d Po_Point2d Po_Point3d
		Po_Dimension1d Po_Dimension2d Po_Dimension3d
	]
]