	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 15	sdk_version 10, 15, 4
	.globl	_main                   ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movl	$0, -4(%rbp)
	movl	%edi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	callq	_objc_autoreleasePoolPush
	movl	$8, -20(%rbp)
	movl	$6, -24(%rbp)
	movq	_OBJC_CLASSLIST_REFERENCES_$_(%rip), %rcx
	movq	%rcx, %rdi
	movq	%rax, -48(%rbp)         ## 8-byte Spill
	callq	_objc_alloc
	movq	_OBJC_SELECTOR_REFERENCES_(%rip), %rsi
	movq	%rax, %rdi
	leaq	L_.str(%rip), %rdx
	callq	*_objc_msgSend@GOTPCREL(%rip)
	leaq	L__unnamed_cfstring_(%rip), %rcx
	movq	%rax, -32(%rbp)
	movl	-20(%rbp), %r8d
	addl	-24(%rbp), %r8d
	movl	%r8d, -36(%rbp)
	movq	-32(%rbp), %rsi
	movl	-36(%rbp), %edx
	movq	%rcx, %rdi
	movb	$0, %al
	callq	_NSLog
	xorl	%edx, %edx
	movl	%edx, %esi
	leaq	-32(%rbp), %rcx
	movq	%rcx, %rdi
	callq	_objc_storeStrong
	movq	-48(%rbp), %rdi         ## 8-byte Reload
	callq	_objc_autoreleasePoolPop
	xorl	%eax, %eax
	addq	$48, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__DATA,__objc_classrefs,regular,no_dead_strip
	.p2align	3               ## @"OBJC_CLASSLIST_REFERENCES_$_"
_OBJC_CLASSLIST_REFERENCES_$_:
	.quad	_OBJC_CLASS_$_NSString

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"C String"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_:                  ## @OBJC_METH_VAR_NAME_
	.asciz	"initWithUTF8String:"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_
_OBJC_SELECTOR_REFERENCES_:
	.quad	L_OBJC_METH_VAR_NAME_

	.section	__TEXT,__cstring,cstring_literals
L_.str.1:                               ## @.str.1
	.asciz	"%@ rank %d"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_
L__unnamed_cfstring_:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.1
	.quad	10                      ## 0xa

	.section	__DATA,__objc_imageinfo,regular,no_dead_strip
L_OBJC_IMAGE_INFO:
	.long	0
	.long	64

.subsections_via_symbols
