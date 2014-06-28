
	.file "premain.s"

; Define weak linkage for _premain, so that it can be overridden
	.section ".text","ax"
	.weak _premain
_premain:
	im _break
	nop
	im main
	poppc
	

