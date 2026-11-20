
bu_app.bin:     file format elf32-tradlittlemips


Disassembly of section .text:

00443800 <cJSON_GetObjectItem@@Base+0x3554>:
  443800:	2484a680 	addiu	a0,a0,-22912
  443804:	8fbf001c 	lw	ra,28(sp)
  443808:	2402ffff 	li	v0,-1
  44380c:	03e00008 	jr	ra
  443810:	27bd0020 	addiu	sp,sp,32
  443814:	27bdffe0 	addiu	sp,sp,-32
  443818:	10800012 	beqz	a0,443864 <cJSON_GetObjectItem@@Base+0x35b8>
  44381c:	afbf001c 	sw	ra,28(sp)
  443820:	8c830004 	lw	v1,4(a0)
  443824:	00801025 	move	v0,a0
  443828:	8c840000 	lw	a0,0(a0)
  44382c:	70a31802 	mul	v1,a1,v1
  443830:	ac450008 	sw	a1,8(v0)
  443834:	3c0251eb 	lui	v0,0x51eb
  443838:	3442851f 	ori	v0,v0,0x851f
  44383c:	00620018 	mult	v1,v0
  443840:	00032fc3 	sra	a1,v1,0x1f
  443844:	00001010 	mfhi	v0
  443848:	00021143 	sra	v0,v0,0x5
  44384c:	0c10950e 	jal	425438 <_ftext@@Base+0x1c78>
  443850:	00452823 	subu	a1,v0,a1
  443854:	00001025 	move	v0,zero
  443858:	8fbf001c 	lw	ra,28(sp)
  44385c:	03e00008 	jr	ra
  443860:	27bd0020 	addiu	sp,sp,32
  443864:	3c04005e 	lui	a0,0x5e
  443868:	0c197c44 	jal	65f110 <puts@plt>
  44386c:	2484a680 	addiu	a0,a0,-22912
  443870:	1000fff9 	b	443858 <cJSON_GetObjectItem@@Base+0x35ac>
  443874:	2402ffff 	li	v0,-1
  443878:	27bdffd0 	addiu	sp,sp,-48
  44387c:	afbf002c 	sw	ra,44(sp)
  443880:	afb20028 	sw	s2,40(sp)
  443884:	afb10024 	sw	s1,36(sp)
  443888:	10800003 	beqz	a0,443898 <cJSON_GetObjectItem@@Base+0x35ec>
  44388c:	afb00020 	sw	s0,32(sp)
  443890:	14a0000b 	bnez	a1,4438c0 <cJSON_GetObjectItem@@Base+0x3614>
  443894:	00a08825 	move	s1,a1
  443898:	3c04005e 	lui	a0,0x5e
  44389c:	0c197c44 	jal	65f110 <puts@plt>
  4438a0:	2484a680 	addiu	a0,a0,-22912
  4438a4:	2402ffff 	li	v0,-1
  4438a8:	8fbf002c 	lw	ra,44(sp)
  4438ac:	8fb20028 	lw	s2,40(sp)
  4438b0:	8fb10024 	lw	s1,36(sp)
  4438b4:	8fb00020 	lw	s0,32(sp)
  4438b8:	03e00008 	jr	ra
  4438bc:	27bd0030 	addiu	sp,sp,48
  4438c0:	00c09025 	move	s2,a2
  4438c4:	00002825 	move	a1,zero
  4438c8:	24060068 	li	a2,104
  4438cc:	00808025 	move	s0,a0
  4438d0:	0c197d18 	jal	65f460 <memset@plt>
  4438d4:	afa70018 	sw	a3,24(sp)
  4438d8:	8a230003 	lwl	v1,3(s1)
  4438dc:	8a220007 	lwl	v0,7(s1)
  4438e0:	8fa70018 	lw	a3,24(sp)
  4438e4:	9a230000 	lwr	v1,0(s1)
  4438e8:	9a220004 	lwr	v0,4(s1)
  4438ec:	26040010 	addiu	a0,s0,16
  4438f0:	aa030003 	swl	v1,3(s0)
  4438f4:	ba030000 	swr	v1,0(s0)
  4438f8:	aa020007 	swl	v0,7(s0)
  4438fc:	ba020004 	swr	v0,4(s0)
  443900:	8e250000 	lw	a1,0(s1)
  443904:	ae120008 	sw	s2,8(s0)
  443908:	0c10944d 	jal	425134 <_ftext@@Base+0x1974>
  44390c:	ae07000c 	sw	a3,12(s0)
  443910:	14400015 	bnez	v0,443968 <cJSON_GetObjectItem@@Base+0x36bc>
  443914:	3c05005e 	lui	a1,0x5e
  443918:	8e250004 	lw	a1,4(s1)
  44391c:	0c10944d 	jal	425134 <_ftext@@Base+0x1974>
  443920:	26040038 	addiu	a0,s0,56
  443924:	1440000f 	bnez	v0,443964 <cJSON_GetObjectItem@@Base+0x36b8>
  443928:	3c060044 	lui	a2,0x44
  44392c:	02003825 	move	a3,s0
  443930:	24c63204 	addiu	a2,a2,12804
  443934:	00002825 	move	a1,zero
  443938:	0c197c14 	jal	65f050 <pthread_create@plt>
  44393c:	26040064 	addiu	a0,s0,100
  443940:	1040ffda 	beqz	v0,4438ac <cJSON_GetObjectItem@@Base+0x3600>
  443944:	8fbf002c 	lw	ra,44(sp)
  443948:	3c05005e 	lui	a1,0x5e
  44394c:	3c04005e 	lui	a0,0x5e
  443950:	24a51c58 	addiu	a1,a1,7256
  443954:	0c197bcc 	jal	65ef30 <printf@plt>
  443958:	2484d2e4 	addiu	a0,a0,-11548
  44395c:	1000ffd2 	b	4438a8 <cJSON_GetObjectItem@@Base+0x35fc>
  443960:	2402ffff 	li	v0,-1
  443964:	3c05005e 	lui	a1,0x5e
  443968:	3c04005e 	lui	a0,0x5e
  44396c:	24a51c58 	addiu	a1,a1,7256
  443970:	0c197bcc 	jal	65ef30 <printf@plt>
  443974:	2484a780 	addiu	a0,a0,-22656
  443978:	1000ffcb 	b	4438a8 <cJSON_GetObjectItem@@Base+0x35fc>
  44397c:	2402ffff 	li	v0,-1
  443980:	27bdfe30 	addiu	sp,sp,-464
  443984:	afb401a0 	sw	s4,416(sp)
  443988:	afb20198 	sw	s2,408(sp)
  44398c:	afb10194 	sw	s1,404(sp)
  443990:	00a09025 	move	s2,a1
  443994:	0080a025 	move	s4,a0
  443998:	00002825 	move	a1,zero
  44399c:	27a400b4 	addiu	a0,sp,180
  4439a0:	00c08825 	move	s1,a2
  4439a4:	24060080 	li	a2,128
  4439a8:	afbf01b4 	sw	ra,436(sp)
  4439ac:	afbe01b0 	sw	s8,432(sp)
  4439b0:	afb701ac 	sw	s7,428(sp)
  4439b4:	afb601a8 	sw	s6,424(sp)
  4439b8:	afb501a4 	sw	s5,420(sp)
  4439bc:	afb3019c 	sw	s3,412(sp)
  4439c0:	afb00190 	sw	s0,400(sp)
  4439c4:	f7b801c8 	sdc1	$f24,456(sp)
  4439c8:	f7b601c0 	sdc1	$f22,448(sp)
  4439cc:	0c197d18 	jal	65f460 <memset@plt>
  4439d0:	f7b401b8 	sdc1	$f20,440(sp)
  4439d4:	24060040 	li	a2,64
  4439d8:	00002825 	move	a1,zero
  4439dc:	0c197d18 	jal	65f460 <memset@plt>
  4439e0:	27a40134 	addiu	a0,sp,308
  4439e4:	96460006 	lhu	a2,6(s2)
  4439e8:	24020001 	li	v0,1
  4439ec:	10c20008 	beq	a2,v0,443a10 <cJSON_GetObjectItem@@Base+0x3764>
  4439f0:	2402000e 	li	v0,14
  4439f4:	10c20006 	beq	a2,v0,443a10 <cJSON_GetObjectItem@@Base+0x3764>
  4439f8:	3c05005e 	lui	a1,0x5e
  4439fc:	8e470010 	lw	a3,16(s2)
  443a00:	3c04005e 	lui	a0,0x5e
  443a04:	24a525a0 	addiu	a1,a1,9632
  443a08:	0c197bcc 	jal	65ef30 <printf@plt>
  443a0c:	24841c80 	addiu	a0,a0,7296
  443a10:	0c110020 	jal	440080 <cJSON_Parse@@Base>
  443a14:	8e440010 	lw	a0,16(s2)
  443a18:	1040000f 	beqz	v0,443a58 <cJSON_GetObjectItem@@Base+0x37ac>
  443a1c:	00409825 	move	s3,v0
  443a20:	0c11041f 	jal	44107c <cJSON_GetObjectItem@@Base+0xdd0>
  443a24:	00000000 	nop
  443a28:	10400073 	beqz	v0,443bf8 <cJSON_GetObjectItem@@Base+0x394c>
  443a2c:	00408025 	move	s0,v0
  443a30:	96460006 	lhu	a2,6(s2)
  443a34:	2cc20013 	sltiu	v0,a2,19
  443a38:	1040028b 	beqz	v0,444468 <cJSON_GetObjectItem@@Base+0x41bc>
  443a3c:	3c03005e 	lui	v1,0x5e
  443a40:	00061080 	sll	v0,a2,0x2
  443a44:	24632540 	addiu	v1,v1,9536
  443a48:	00621021 	addu	v0,v1,v0
  443a4c:	8c420000 	lw	v0,0(v0)
  443a50:	00400008 	jr	v0
  443a54:	00000000 	nop
  443a58:	0c10fd1d 	jal	43f474 <cJSON_GetErrorPtr@@Base>
  443a5c:	3c16005e 	lui	s6,0x5e
  443a60:	3c04005e 	lui	a0,0x5e
  443a64:	00403025 	move	a2,v0
  443a68:	26c525a0 	addiu	a1,s6,9632
  443a6c:	0c197bcc 	jal	65ef30 <printf@plt>
  443a70:	2484ce7c 	addiu	a0,a0,-12676
  443a74:	3c03005e 	lui	v1,0x5e
  443a78:	24621ca4 	addiu	v0,v1,7332
  443a7c:	8c661ca4 	lw	a2,7332(v1)
  443a80:	8c450004 	lw	a1,4(v0)
  443a84:	8c440008 	lw	a0,8(v0)
  443a88:	8c43000c 	lw	v1,12(v0)
  443a8c:	94420010 	lhu	v0,16(v0)
  443a90:	afa600b4 	sw	a2,180(sp)
  443a94:	afa500b8 	sw	a1,184(sp)
  443a98:	afa400bc 	sw	a0,188(sp)
  443a9c:	afa300c0 	sw	v1,192(sp)
  443aa0:	a7a200c4 	sh	v0,196(sp)
  443aa4:	24140002 	li	s4,2
  443aa8:	0000a825 	move	s5,zero
  443aac:	96420006 	lhu	v0,6(s2)
  443ab0:	0c11041f 	jal	44107c <cJSON_GetObjectItem@@Base+0xdd0>
  443ab4:	a6220006 	sh	v0,6(s1)
  443ab8:	10400790 	beqz	v0,4458fc <cJSON_GetObjectItem@@Base+0x5650>
  443abc:	00408025 	move	s0,v0
  443ac0:	44940000 	mtc1	s4,$f0
  443ac4:	46800021 	cvt.d.w	$f0,$f0
  443ac8:	44060000 	mfc1	a2,$f0
  443acc:	44070800 	mfc1	a3,$f1
  443ad0:	3c05005e 	lui	a1,0x5e
  443ad4:	02002025 	move	a0,s0
  443ad8:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  443adc:	24a50324 	addiu	a1,a1,804
  443ae0:	3c05005e 	lui	a1,0x5e
  443ae4:	27a600b4 	addiu	a2,sp,180
  443ae8:	24a523c4 	addiu	a1,a1,9156
  443aec:	0c11038d 	jal	440e34 <cJSON_GetObjectItem@@Base+0xb88>
  443af0:	02002025 	move	a0,s0
  443af4:	0c110026 	jal	440098 <cJSON_Print@@Base>
  443af8:	02002025 	move	a0,s0
  443afc:	00402025 	move	a0,v0
  443b00:	0c197bc0 	jal	65ef00 <strlen@plt>
  443b04:	0040a025 	move	s4,v0
  443b08:	8e260018 	lw	a2,24(s1)
  443b0c:	24c3ffff 	addiu	v1,a2,-1
  443b10:	0062102b 	sltu	v0,v1,v0
  443b14:	14400385 	bnez	v0,44492c <cJSON_GetObjectItem@@Base+0x4680>
  443b18:	3c05005e 	lui	a1,0x5e
  443b1c:	8e240010 	lw	a0,16(s1)
  443b20:	0c197bb0 	jal	65eec0 <strncpy@plt>
  443b24:	02802825 	move	a1,s4
  443b28:	0c197bc0 	jal	65ef00 <strlen@plt>
  443b2c:	02802025 	move	a0,s4
  443b30:	8e230010 	lw	v1,16(s1)
  443b34:	02802025 	move	a0,s4
  443b38:	00621021 	addu	v0,v1,v0
  443b3c:	0c197bc0 	jal	65ef00 <strlen@plt>
  443b40:	a0400000 	sb	zero,0(v0)
  443b44:	24420001 	addiu	v0,v0,1
  443b48:	ae220014 	sw	v0,20(s1)
  443b4c:	8e230010 	lw	v1,16(s1)
  443b50:	24040001 	li	a0,1
  443b54:	00621021 	addu	v0,v1,v0
  443b58:	a0400000 	sb	zero,0(v0)
  443b5c:	96420006 	lhu	v0,6(s2)
  443b60:	10440009 	beq	v0,a0,443b88 <cJSON_GetObjectItem@@Base+0x38dc>
  443b64:	2403000e 	li	v1,14
  443b68:	10430007 	beq	v0,v1,443b88 <cJSON_GetObjectItem@@Base+0x38dc>
  443b6c:	3c05005e 	lui	a1,0x5e
  443b70:	8e270010 	lw	a3,16(s1)
  443b74:	96260006 	lhu	a2,6(s1)
  443b78:	3c04005e 	lui	a0,0x5e
  443b7c:	24a525a0 	addiu	a1,a1,9632
  443b80:	0c197bcc 	jal	65ef30 <printf@plt>
  443b84:	248423e8 	addiu	a0,a0,9192
  443b88:	12600003 	beqz	s3,443b98 <cJSON_GetObjectItem@@Base+0x38ec>
  443b8c:	00000000 	nop
  443b90:	0c10fd70 	jal	43f5c0 <cJSON_Delete@@Base>
  443b94:	02602025 	move	a0,s3
  443b98:	12000003 	beqz	s0,443ba8 <cJSON_GetObjectItem@@Base+0x38fc>
  443b9c:	00000000 	nop
  443ba0:	0c10fd70 	jal	43f5c0 <cJSON_Delete@@Base>
  443ba4:	02002025 	move	a0,s0
  443ba8:	12800004 	beqz	s4,443bbc <cJSON_GetObjectItem@@Base+0x3910>
  443bac:	8fbf01b4 	lw	ra,436(sp)
  443bb0:	0c197bf4 	jal	65efd0 <free@plt>
  443bb4:	02802025 	move	a0,s4
  443bb8:	8fbf01b4 	lw	ra,436(sp)
  443bbc:	02a01025 	move	v0,s5
  443bc0:	8fbe01b0 	lw	s8,432(sp)
  443bc4:	8fb701ac 	lw	s7,428(sp)
  443bc8:	8fb601a8 	lw	s6,424(sp)
  443bcc:	8fb501a4 	lw	s5,420(sp)
  443bd0:	8fb401a0 	lw	s4,416(sp)
  443bd4:	8fb3019c 	lw	s3,412(sp)
  443bd8:	8fb20198 	lw	s2,408(sp)
  443bdc:	8fb10194 	lw	s1,404(sp)
  443be0:	8fb00190 	lw	s0,400(sp)
  443be4:	d7b801c8 	ldc1	$f24,456(sp)
  443be8:	d7b601c0 	ldc1	$f22,448(sp)
  443bec:	d7b401b8 	ldc1	$f20,440(sp)
  443bf0:	03e00008 	jr	ra
  443bf4:	27bd01d0 	addiu	sp,sp,464
  443bf8:	3c16005e 	lui	s6,0x5e
  443bfc:	3c04005e 	lui	a0,0x5e
  443c00:	26c525a0 	addiu	a1,s6,9632
  443c04:	0c197bcc 	jal	65ef30 <printf@plt>
  443c08:	2484e370 	addiu	a0,a0,-7312
  443c0c:	0000a025 	move	s4,zero
  443c10:	1000ffa6 	b	443aac <cJSON_GetObjectItem@@Base+0x3800>
  443c14:	2415ffff 	li	s5,-1
  443c18:	3c16005e 	lui	s6,0x5e
  443c1c:	26c5f604 	addiu	a1,s6,-2556
  443c20:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  443c24:	02602025 	move	a0,s3
  443c28:	10400004 	beqz	v0,443c3c <cJSON_GetObjectItem@@Base+0x3990>
  443c2c:	24030008 	li	v1,8
  443c30:	8c44000c 	lw	a0,12(v0)
  443c34:	1083025e 	beq	a0,v1,4445b0 <cJSON_GetObjectItem@@Base+0x4304>
  443c38:	00000000 	nop
  443c3c:	27a400b4 	addiu	a0,sp,180
  443c40:	26c7f604 	addiu	a3,s6,-2556
  443c44:	3c06005e 	lui	a2,0x5e
  443c48:	24c6ff1c 	addiu	a2,a2,-228
  443c4c:	0c197ca4 	jal	65f290 <snprintf@plt>
  443c50:	24050080 	li	a1,128
  443c54:	3c05005e 	lui	a1,0x5e
  443c58:	3c04005e 	lui	a0,0x5e
  443c5c:	27a600b4 	addiu	a2,sp,180
  443c60:	24a525a0 	addiu	a1,a1,9632
  443c64:	0c197bcc 	jal	65ef30 <printf@plt>
  443c68:	2484ca58 	addiu	a0,a0,-13736
  443c6c:	3c02005e 	lui	v0,0x5e
  443c70:	8c4625c8 	lw	a2,9672(v0)
  443c74:	8c4725cc 	lw	a3,9676(v0)
  443c78:	0000a825 	move	s5,zero
  443c7c:	96420006 	lhu	v0,6(s2)
  443c80:	1000ff93 	b	443ad0 <cJSON_GetObjectItem@@Base+0x3824>
  443c84:	a6220006 	sh	v0,6(s1)
  443c88:	3c15005e 	lui	s5,0x5e
  443c8c:	26a52200 	addiu	a1,s5,8704
  443c90:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  443c94:	02602025 	move	a0,s3
  443c98:	10400004 	beqz	v0,443cac <cJSON_GetObjectItem@@Base+0x3a00>
  443c9c:	24030008 	li	v1,8
  443ca0:	8c44000c 	lw	a0,12(v0)
  443ca4:	1083020b 	beq	a0,v1,4444d4 <cJSON_GetObjectItem@@Base+0x4228>
  443ca8:	00000000 	nop
  443cac:	27a400b4 	addiu	a0,sp,180
  443cb0:	1000ffe4 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  443cb4:	26a72200 	addiu	a3,s5,8704
  443cb8:	8e820888 	lw	v0,2184(s4)
  443cbc:	1040048b 	beqz	v0,444eec <cJSON_GetObjectItem@@Base+0x4c40>
  443cc0:	3c02005e 	lui	v0,0x5e
  443cc4:	8c46d6c0 	lw	a2,-10560(v0)
  443cc8:	8c47d6c4 	lw	a3,-10556(v0)
  443ccc:	3c05005e 	lui	a1,0x5e
  443cd0:	02002025 	move	a0,s0
  443cd4:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  443cd8:	24a5a714 	addiu	a1,a1,-22764
  443cdc:	c6800430 	lwc1	$f0,1072(s4)
  443ce0:	3c05005e 	lui	a1,0x5e
  443ce4:	24a5f604 	addiu	a1,a1,-2556
  443ce8:	46800021 	cvt.d.w	$f0,$f0
  443cec:	44060000 	mfc1	a2,$f0
  443cf0:	44070800 	mfc1	a3,$f1
  443cf4:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  443cf8:	02002025 	move	a0,s0
  443cfc:	8e820428 	lw	v0,1064(s4)
  443d00:	44820000 	mtc1	v0,$f0
  443d04:	46800021 	cvt.d.w	$f0,$f0
  443d08:	44060000 	mfc1	a2,$f0
  443d0c:	044003ac 	bltz	v0,444bc0 <cJSON_GetObjectItem@@Base+0x4914>
  443d10:	44070800 	mfc1	a3,$f1
  443d14:	3c05005e 	lui	a1,0x5e
  443d18:	24a51ec0 	addiu	a1,a1,7872
  443d1c:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  443d20:	02002025 	move	a0,s0
  443d24:	8e820424 	lw	v0,1060(s4)
  443d28:	44820000 	mtc1	v0,$f0
  443d2c:	46800021 	cvt.d.w	$f0,$f0
  443d30:	44060000 	mfc1	a2,$f0
  443d34:	044003aa 	bltz	v0,444be0 <cJSON_GetObjectItem@@Base+0x4934>
  443d38:	44070800 	mfc1	a3,$f1
  443d3c:	3c05005e 	lui	a1,0x5e
  443d40:	24a51ed0 	addiu	a1,a1,7888
  443d44:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  443d48:	02002025 	move	a0,s0
  443d4c:	8e82042c 	lw	v0,1068(s4)
  443d50:	44820000 	mtc1	v0,$f0
  443d54:	46800021 	cvt.d.w	$f0,$f0
  443d58:	44060000 	mfc1	a2,$f0
  443d5c:	04400390 	bltz	v0,444ba0 <cJSON_GetObjectItem@@Base+0x48f4>
  443d60:	44070800 	mfc1	a3,$f1
  443d64:	3c05005e 	lui	a1,0x5e
  443d68:	24a51eec 	addiu	a1,a1,7916
  443d6c:	02002025 	move	a0,s0
  443d70:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  443d74:	0000a825 	move	s5,zero
  443d78:	96420006 	lhu	v0,6(s2)
  443d7c:	00003025 	move	a2,zero
  443d80:	00003825 	move	a3,zero
  443d84:	1000ff52 	b	443ad0 <cJSON_GetObjectItem@@Base+0x3824>
  443d88:	a6220006 	sh	v0,6(s1)
  443d8c:	8e820884 	lw	v0,2180(s4)
  443d90:	104002cf 	beqz	v0,4448d0 <cJSON_GetObjectItem@@Base+0x4624>
  443d94:	3c05005e 	lui	a1,0x5e
  443d98:	3c16005e 	lui	s6,0x5e
  443d9c:	26c5f604 	addiu	a1,s6,-2556
  443da0:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  443da4:	02602025 	move	a0,s3
  443da8:	1040ffa4 	beqz	v0,443c3c <cJSON_GetObjectItem@@Base+0x3990>
  443dac:	0040b825 	move	s7,v0
  443db0:	8c43000c 	lw	v1,12(v0)
  443db4:	24020008 	li	v0,8
  443db8:	1462ffa0 	bne	v1,v0,443c3c <cJSON_GetObjectItem@@Base+0x3990>
  443dbc:	00000000 	nop
  443dc0:	8ee50014 	lw	a1,20(s7)
  443dc4:	24a2001e 	addiu	v0,a1,30
  443dc8:	2c42005b 	sltiu	v0,v0,91
  443dcc:	10400342 	beqz	v0,444ad8 <cJSON_GetObjectItem@@Base+0x482c>
  443dd0:	3c07005e 	lui	a3,0x5e
  443dd4:	8e820414 	lw	v0,1044(s4)
  443dd8:	10a20009 	beq	a1,v0,443e00 <cJSON_GetObjectItem@@Base+0x3b54>
  443ddc:	02802025 	move	a0,s4
  443de0:	8e860418 	lw	a2,1048(s4)
  443de4:	0c10bf28 	jal	42fca0 <_ftext@@Base+0xc4e0>
  443de8:	8e840884 	lw	a0,2180(s4)
  443dec:	14400469 	bnez	v0,444f94 <cJSON_GetObjectItem@@Base+0x4ce8>
  443df0:	0040a825 	move	s5,v0
  443df4:	8ee20014 	lw	v0,20(s7)
  443df8:	ae820414 	sw	v0,1044(s4)
  443dfc:	02802025 	move	a0,s4
  443e00:	0c10dde0 	jal	437780 <_ftext@@Base+0x13fc0>
  443e04:	0000a825 	move	s5,zero
  443e08:	96420006 	lhu	v0,6(s2)
  443e0c:	00003025 	move	a2,zero
  443e10:	00003825 	move	a3,zero
  443e14:	1000ff2e 	b	443ad0 <cJSON_GetObjectItem@@Base+0x3824>
  443e18:	a6220006 	sh	v0,6(s1)
  443e1c:	26950cec 	addiu	s5,s4,3308
  443e20:	02a02025 	move	a0,s5
  443e24:	afa00030 	sw	zero,48(sp)
  443e28:	afa00034 	sw	zero,52(sp)
  443e2c:	afa00038 	sw	zero,56(sp)
  443e30:	afa0003c 	sw	zero,60(sp)
  443e34:	afa00040 	sw	zero,64(sp)
  443e38:	afa00044 	sw	zero,68(sp)
  443e3c:	afa00048 	sw	zero,72(sp)
  443e40:	afa0004c 	sw	zero,76(sp)
  443e44:	afa00050 	sw	zero,80(sp)
  443e48:	0c197d74 	jal	65f5d0 <pthread_mutex_lock@plt>
  443e4c:	afa00054 	sw	zero,84(sp)
  443e50:	c6800630 	lwc1	$f0,1584(s4)
  443e54:	3c05005e 	lui	a1,0x5e
  443e58:	02002025 	move	a0,s0
  443e5c:	46800021 	cvt.d.w	$f0,$f0
  443e60:	44060000 	mfc1	a2,$f0
  443e64:	44070800 	mfc1	a3,$f1
  443e68:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  443e6c:	24a52038 	addiu	a1,a1,8248
  443e70:	c68007ac 	lwc1	$f0,1964(s4)
  443e74:	3c05005e 	lui	a1,0x5e
  443e78:	02002025 	move	a0,s0
  443e7c:	46800021 	cvt.d.w	$f0,$f0
  443e80:	44060000 	mfc1	a2,$f0
  443e84:	44070800 	mfc1	a3,$f1
  443e88:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  443e8c:	24a52044 	addiu	a1,a1,8260
  443e90:	c68007b0 	lwc1	$f0,1968(s4)
  443e94:	3c05005e 	lui	a1,0x5e
  443e98:	02002025 	move	a0,s0
  443e9c:	46800021 	cvt.d.w	$f0,$f0
  443ea0:	44060000 	mfc1	a2,$f0
  443ea4:	44070800 	mfc1	a3,$f1
  443ea8:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  443eac:	24a52054 	addiu	a1,a1,8276
  443eb0:	c6800cd8 	lwc1	$f0,3288(s4)
  443eb4:	3c05005e 	lui	a1,0x5e
  443eb8:	02002025 	move	a0,s0
  443ebc:	46800021 	cvt.d.w	$f0,$f0
  443ec0:	44060000 	mfc1	a2,$f0
  443ec4:	44070800 	mfc1	a3,$f1
  443ec8:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  443ecc:	24a52060 	addiu	a1,a1,8288
  443ed0:	c6800cdc 	lwc1	$f0,3292(s4)
  443ed4:	3c05005e 	lui	a1,0x5e
  443ed8:	02002025 	move	a0,s0
  443edc:	46800021 	cvt.d.w	$f0,$f0
  443ee0:	44060000 	mfc1	a2,$f0
  443ee4:	44070800 	mfc1	a3,$f1
  443ee8:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  443eec:	24a52070 	addiu	a1,a1,8304
  443ef0:	c6800ce0 	lwc1	$f0,3296(s4)
  443ef4:	3c05005e 	lui	a1,0x5e
  443ef8:	02002025 	move	a0,s0
  443efc:	46800021 	cvt.d.w	$f0,$f0
  443f00:	44060000 	mfc1	a2,$f0
  443f04:	44070800 	mfc1	a3,$f1
  443f08:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  443f0c:	24a52084 	addiu	a1,a1,8324
  443f10:	c6800ccc 	lwc1	$f0,3276(s4)
  443f14:	3c05005e 	lui	a1,0x5e
  443f18:	02002025 	move	a0,s0
  443f1c:	46800021 	cvt.d.w	$f0,$f0
  443f20:	44060000 	mfc1	a2,$f0
  443f24:	44070800 	mfc1	a3,$f1
  443f28:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  443f2c:	24a52098 	addiu	a1,a1,8344
  443f30:	c6800cb4 	lwc1	$f0,3252(s4)
  443f34:	3c05005e 	lui	a1,0x5e
  443f38:	02002025 	move	a0,s0
  443f3c:	46800021 	cvt.d.w	$f0,$f0
  443f40:	44060000 	mfc1	a2,$f0
  443f44:	44070800 	mfc1	a3,$f1
  443f48:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  443f4c:	24a520a8 	addiu	a1,a1,8360
  443f50:	c6800cb8 	lwc1	$f0,3256(s4)
  443f54:	3c05005e 	lui	a1,0x5e
  443f58:	02002025 	move	a0,s0
  443f5c:	46800021 	cvt.d.w	$f0,$f0
  443f60:	44060000 	mfc1	a2,$f0
  443f64:	44070800 	mfc1	a3,$f1
  443f68:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  443f6c:	24a520b4 	addiu	a1,a1,8372
  443f70:	c6800cbc 	lwc1	$f0,3260(s4)
  443f74:	3c05005e 	lui	a1,0x5e
  443f78:	02002025 	move	a0,s0
  443f7c:	46800021 	cvt.d.w	$f0,$f0
  443f80:	44060000 	mfc1	a2,$f0
  443f84:	44070800 	mfc1	a3,$f1
  443f88:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  443f8c:	24a520c4 	addiu	a1,a1,8388
  443f90:	c6800cc0 	lwc1	$f0,3264(s4)
  443f94:	3c05005e 	lui	a1,0x5e
  443f98:	02002025 	move	a0,s0
  443f9c:	46800021 	cvt.d.w	$f0,$f0
  443fa0:	44060000 	mfc1	a2,$f0
  443fa4:	44070800 	mfc1	a3,$f1
  443fa8:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  443fac:	24a520d4 	addiu	a1,a1,8404
  443fb0:	c6800cc4 	lwc1	$f0,3268(s4)
  443fb4:	3c05005e 	lui	a1,0x5e
  443fb8:	02002025 	move	a0,s0
  443fbc:	46800021 	cvt.d.w	$f0,$f0
  443fc0:	44060000 	mfc1	a2,$f0
  443fc4:	44070800 	mfc1	a3,$f1
  443fc8:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  443fcc:	24a520e8 	addiu	a1,a1,8424
  443fd0:	c6800cc8 	lwc1	$f0,3272(s4)
  443fd4:	3c05005e 	lui	a1,0x5e
  443fd8:	02002025 	move	a0,s0
  443fdc:	46800021 	cvt.d.w	$f0,$f0
  443fe0:	44060000 	mfc1	a2,$f0
  443fe4:	44070800 	mfc1	a3,$f1
  443fe8:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  443fec:	24a52100 	addiu	a1,a1,8448
  443ff0:	c6800614 	lwc1	$f0,1556(s4)
  443ff4:	3c05005e 	lui	a1,0x5e
  443ff8:	24a52118 	addiu	a1,a1,8472
  443ffc:	46800021 	cvt.d.w	$f0,$f0
  444000:	44060000 	mfc1	a2,$f0
  444004:	44070800 	mfc1	a3,$f1
  444008:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  44400c:	02002025 	move	a0,s0
  444010:	0c197ce4 	jal	65f390 <pthread_mutex_unlock@plt>
  444014:	02a02025 	move	a0,s5
  444018:	8e840880 	lw	a0,2176(s4)
  44401c:	0c10d520 	jal	435480 <_ftext@@Base+0x11cc0>
  444020:	27a50030 	addiu	a1,sp,48
  444024:	83a6004c 	lb	a2,76(sp)
  444028:	3c05005e 	lui	a1,0x5e
  44402c:	02002025 	move	a0,s0
  444030:	44860000 	mtc1	a2,$f0
  444034:	24a52128 	addiu	a1,a1,8488
  444038:	46800021 	cvt.d.w	$f0,$f0
  44403c:	44060000 	mfc1	a2,$f0
  444040:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  444044:	44070800 	mfc1	a3,$f1
  444048:	8fa40030 	lw	a0,48(sp)
  44404c:	0c197ef8 	jal	65fbe0 <__floatdidf@plt>
  444050:	8fa50034 	lw	a1,52(sp)
  444054:	44060000 	mfc1	a2,$f0
  444058:	44070800 	mfc1	a3,$f1
  44405c:	3c05005e 	lui	a1,0x5e
  444060:	02002025 	move	a0,s0
  444064:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  444068:	24a52158 	addiu	a1,a1,8536
  44406c:	c7a00038 	lwc1	$f0,56(sp)
  444070:	3c05005e 	lui	a1,0x5e
  444074:	02002025 	move	a0,s0
  444078:	46800021 	cvt.d.w	$f0,$f0
  44407c:	44060000 	mfc1	a2,$f0
  444080:	44070800 	mfc1	a3,$f1
  444084:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  444088:	24a52138 	addiu	a1,a1,8504
  44408c:	8fa40040 	lw	a0,64(sp)
  444090:	0c197ef8 	jal	65fbe0 <__floatdidf@plt>
  444094:	8fa50044 	lw	a1,68(sp)
  444098:	44060000 	mfc1	a2,$f0
  44409c:	44070800 	mfc1	a3,$f1
  4440a0:	3c05005e 	lui	a1,0x5e
  4440a4:	02002025 	move	a0,s0
  4440a8:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  4440ac:	24a52140 	addiu	a1,a1,8512
  4440b0:	8fa40050 	lw	a0,80(sp)
  4440b4:	0c197ef8 	jal	65fbe0 <__floatdidf@plt>
  4440b8:	8fa50054 	lw	a1,84(sp)
  4440bc:	44060000 	mfc1	a2,$f0
  4440c0:	44070800 	mfc1	a3,$f1
  4440c4:	3c05005e 	lui	a1,0x5e
  4440c8:	02002025 	move	a0,s0
  4440cc:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  4440d0:	24a52150 	addiu	a1,a1,8528
  4440d4:	c7a00048 	lwc1	$f0,72(sp)
  4440d8:	3c05005e 	lui	a1,0x5e
  4440dc:	02002025 	move	a0,s0
  4440e0:	46800021 	cvt.d.w	$f0,$f0
  4440e4:	44060000 	mfc1	a2,$f0
  4440e8:	44070800 	mfc1	a3,$f1
  4440ec:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  4440f0:	24a52164 	addiu	a1,a1,8548
  4440f4:	828607b4 	lb	a2,1972(s4)
  4440f8:	3c05005e 	lui	a1,0x5e
  4440fc:	24a5216c 	addiu	a1,a1,8556
  444100:	44860000 	mtc1	a2,$f0
  444104:	02002025 	move	a0,s0
  444108:	46800021 	cvt.d.w	$f0,$f0
  44410c:	44060000 	mfc1	a2,$f0
  444110:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  444114:	44070800 	mfc1	a3,$f1
  444118:	8e860764 	lw	a2,1892(s4)
  44411c:	3c05005e 	lui	a1,0x5e
  444120:	24a5217c 	addiu	a1,a1,8572
  444124:	44860000 	mtc1	a2,$f0
  444128:	46800021 	cvt.d.w	$f0,$f0
  44412c:	44060000 	mfc1	a2,$f0
  444130:	44070800 	mfc1	a3,$f1
  444134:	1000ff0e 	b	443d70 <cJSON_GetObjectItem@@Base+0x3ac4>
  444138:	02002025 	move	a0,s0
  44413c:	3c15005e 	lui	s5,0x5e
  444140:	26a5f838 	addiu	a1,s5,-1992
  444144:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  444148:	02602025 	move	a0,s3
  44414c:	10400004 	beqz	v0,444160 <cJSON_GetObjectItem@@Base+0x3eb4>
  444150:	24030010 	li	v1,16
  444154:	8c56000c 	lw	s6,12(v0)
  444158:	12c30144 	beq	s6,v1,44466c <cJSON_GetObjectItem@@Base+0x43c0>
  44415c:	00000000 	nop
  444160:	27a400b4 	addiu	a0,sp,180
  444164:	1000feb7 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  444168:	26a7f838 	addiu	a3,s5,-1992
  44416c:	8e840884 	lw	a0,2180(s4)
  444170:	108001d7 	beqz	a0,4448d0 <cJSON_GetObjectItem@@Base+0x4624>
  444174:	3c05005e 	lui	a1,0x5e
  444178:	0c10bf52 	jal	42fd48 <_ftext@@Base+0xc588>
  44417c:	27a50030 	addiu	a1,sp,48
  444180:	1040020c 	beqz	v0,4449b4 <cJSON_GetObjectItem@@Base+0x4708>
  444184:	0040a825 	move	s5,v0
  444188:	3c05005e 	lui	a1,0x5e
  44418c:	3c04005e 	lui	a0,0x5e
  444190:	00403025 	move	a2,v0
  444194:	24a525a0 	addiu	a1,a1,9632
  444198:	0c197bcc 	jal	65ef30 <printf@plt>
  44419c:	24841d6c 	addiu	a0,a0,7532
  4441a0:	3c06005e 	lui	a2,0x5e
  4441a4:	02a03825 	move	a3,s5
  4441a8:	24c61d8c 	addiu	a2,a2,7564
  4441ac:	24050080 	li	a1,128
  4441b0:	0c197ca4 	jal	65f290 <snprintf@plt>
  4441b4:	27a400b4 	addiu	a0,sp,180
  4441b8:	3c02005e 	lui	v0,0x5e
  4441bc:	8c46d6c0 	lw	a2,-10560(v0)
  4441c0:	8c47d6c4 	lw	a3,-10556(v0)
  4441c4:	96420006 	lhu	v0,6(s2)
  4441c8:	1000fe41 	b	443ad0 <cJSON_GetObjectItem@@Base+0x3824>
  4441cc:	a6220006 	sh	v0,6(s1)
  4441d0:	3c15005e 	lui	s5,0x5e
  4441d4:	26a5f618 	addiu	a1,s5,-2536
  4441d8:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  4441dc:	02602025 	move	a0,s3
  4441e0:	10400004 	beqz	v0,4441f4 <cJSON_GetObjectItem@@Base+0x3f48>
  4441e4:	24030008 	li	v1,8
  4441e8:	8c56000c 	lw	s6,12(v0)
  4441ec:	12c300ab 	beq	s6,v1,44449c <cJSON_GetObjectItem@@Base+0x41f0>
  4441f0:	00000000 	nop
  4441f4:	27a400b4 	addiu	a0,sp,180
  4441f8:	1000fe92 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  4441fc:	26a7f618 	addiu	a3,s5,-2536
  444200:	8e820884 	lw	v0,2180(s4)
  444204:	104001b2 	beqz	v0,4448d0 <cJSON_GetObjectItem@@Base+0x4624>
  444208:	3c05005e 	lui	a1,0x5e
  44420c:	3c15005e 	lui	s5,0x5e
  444210:	26a5f5fc 	addiu	a1,s5,-2564
  444214:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  444218:	02602025 	move	a0,s3
  44421c:	10400005 	beqz	v0,444234 <cJSON_GetObjectItem@@Base+0x3f88>
  444220:	0040b025 	move	s6,v0
  444224:	8c43000c 	lw	v1,12(v0)
  444228:	24020008 	li	v0,8
  44422c:	1062012d 	beq	v1,v0,4446e4 <cJSON_GetObjectItem@@Base+0x4438>
  444230:	00000000 	nop
  444234:	27a400b4 	addiu	a0,sp,180
  444238:	1000fe82 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  44423c:	26a7f5fc 	addiu	a3,s5,-2564
  444240:	3c15005e 	lui	s5,0x5e
  444244:	26a5e3b0 	addiu	a1,s5,-7248
  444248:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  44424c:	02602025 	move	a0,s3
  444250:	10400004 	beqz	v0,444264 <cJSON_GetObjectItem@@Base+0x3fb8>
  444254:	24030008 	li	v1,8
  444258:	8c44000c 	lw	a0,12(v0)
  44425c:	108300ea 	beq	a0,v1,444608 <cJSON_GetObjectItem@@Base+0x435c>
  444260:	00000000 	nop
  444264:	27a400b4 	addiu	a0,sp,180
  444268:	1000fe76 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  44426c:	26a7e3b0 	addiu	a3,s5,-7248
  444270:	8e820884 	lw	v0,2180(s4)
  444274:	10400196 	beqz	v0,4448d0 <cJSON_GetObjectItem@@Base+0x4624>
  444278:	3c05005e 	lui	a1,0x5e
  44427c:	3c15005f 	lui	s5,0x5f
  444280:	26a52c18 	addiu	a1,s5,11288
  444284:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  444288:	02602025 	move	a0,s3
  44428c:	10400004 	beqz	v0,4442a0 <cJSON_GetObjectItem@@Base+0x3ff4>
  444290:	24030008 	li	v1,8
  444294:	8c44000c 	lw	a0,12(v0)
  444298:	1083010b 	beq	a0,v1,4446c8 <cJSON_GetObjectItem@@Base+0x441c>
  44429c:	00000000 	nop
  4442a0:	27a400b4 	addiu	a0,sp,180
  4442a4:	1000fe67 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  4442a8:	26a72c18 	addiu	a3,s5,11288
  4442ac:	8e820884 	lw	v0,2180(s4)
  4442b0:	10400187 	beqz	v0,4448d0 <cJSON_GetObjectItem@@Base+0x4624>
  4442b4:	3c05005e 	lui	a1,0x5e
  4442b8:	3c15005e 	lui	s5,0x5e
  4442bc:	26a51da8 	addiu	a1,s5,7592
  4442c0:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  4442c4:	02602025 	move	a0,s3
  4442c8:	10400004 	beqz	v0,4442dc <cJSON_GetObjectItem@@Base+0x4030>
  4442cc:	24030008 	li	v1,8
  4442d0:	8c56000c 	lw	s6,12(v0)
  4442d4:	12c300f5 	beq	s6,v1,4446ac <cJSON_GetObjectItem@@Base+0x4400>
  4442d8:	00000000 	nop
  4442dc:	27a400b4 	addiu	a0,sp,180
  4442e0:	1000fe58 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  4442e4:	26a71da8 	addiu	a3,s5,7592
  4442e8:	27a40030 	addiu	a0,sp,48
  4442ec:	24060084 	li	a2,132
  4442f0:	0c197d18 	jal	65f460 <memset@plt>
  4442f4:	00002825 	move	a1,zero
  4442f8:	8e840884 	lw	a0,2180(s4)
  4442fc:	10800174 	beqz	a0,4448d0 <cJSON_GetObjectItem@@Base+0x4624>
  444300:	3c05005e 	lui	a1,0x5e
  444304:	0c10bf7f 	jal	42fdfc <_ftext@@Base+0xc63c>
  444308:	27a50030 	addiu	a1,sp,48
  44430c:	1040018e 	beqz	v0,444948 <cJSON_GetObjectItem@@Base+0x469c>
  444310:	0040a825 	move	s5,v0
  444314:	3c05005e 	lui	a1,0x5e
  444318:	3c04005e 	lui	a0,0x5e
  44431c:	00403025 	move	a2,v0
  444320:	24a525a0 	addiu	a1,a1,9632
  444324:	0c197bcc 	jal	65ef30 <printf@plt>
  444328:	24841d1c 	addiu	a0,a0,7452
  44432c:	3c06005e 	lui	a2,0x5e
  444330:	02a03825 	move	a3,s5
  444334:	1000ff9d 	b	4441ac <cJSON_GetObjectItem@@Base+0x3f00>
  444338:	24c61d40 	addiu	a2,a2,7488
  44433c:	3c17005e 	lui	s7,0x5e
  444340:	26e5a714 	addiu	a1,s7,-22764
  444344:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  444348:	02602025 	move	a0,s3
  44434c:	10400004 	beqz	v0,444360 <cJSON_GetObjectItem@@Base+0x40b4>
  444350:	24030008 	li	v1,8
  444354:	8c55000c 	lw	s5,12(v0)
  444358:	12a30057 	beq	s5,v1,4444b8 <cJSON_GetObjectItem@@Base+0x420c>
  44435c:	00000000 	nop
  444360:	27a400b4 	addiu	a0,sp,180
  444364:	1000fe37 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  444368:	26e7a714 	addiu	a3,s7,-22764
  44436c:	8e8205d4 	lw	v0,1492(s4)
  444370:	00003025 	move	a2,zero
  444374:	10400004 	beqz	v0,444388 <cJSON_GetObjectItem@@Base+0x40dc>
  444378:	00003825 	move	a3,zero
  44437c:	3c02005e 	lui	v0,0x5e
  444380:	8c46d6c0 	lw	a2,-10560(v0)
  444384:	8c47d6c4 	lw	a3,-10556(v0)
  444388:	3c05005e 	lui	a1,0x5e
  44438c:	02002025 	move	a0,s0
  444390:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  444394:	24a5f618 	addiu	a1,a1,-2536
  444398:	c68005d8 	lwc1	$f0,1496(s4)
  44439c:	3c05005e 	lui	a1,0x5e
  4443a0:	02002025 	move	a0,s0
  4443a4:	46000021 	cvt.d.s	$f0,$f0
  4443a8:	44060000 	mfc1	a2,$f0
  4443ac:	44070800 	mfc1	a3,$f1
  4443b0:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  4443b4:	24a5f62c 	addiu	a1,a1,-2516
  4443b8:	c68005dc 	lwc1	$f0,1500(s4)
  4443bc:	3c05005e 	lui	a1,0x5e
  4443c0:	02002025 	move	a0,s0
  4443c4:	46000021 	cvt.d.s	$f0,$f0
  4443c8:	44060000 	mfc1	a2,$f0
  4443cc:	44070800 	mfc1	a3,$f1
  4443d0:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  4443d4:	24a5f640 	addiu	a1,a1,-2496
  4443d8:	c68005e0 	lwc1	$f0,1504(s4)
  4443dc:	3c05005e 	lui	a1,0x5e
  4443e0:	24a51fac 	addiu	a1,a1,8108
  4443e4:	46000021 	cvt.d.s	$f0,$f0
  4443e8:	44060000 	mfc1	a2,$f0
  4443ec:	44070800 	mfc1	a3,$f1
  4443f0:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  4443f4:	02002025 	move	a0,s0
  4443f8:	8e8205e8 	lw	v0,1512(s4)
  4443fc:	00003025 	move	a2,zero
  444400:	10400004 	beqz	v0,444414 <cJSON_GetObjectItem@@Base+0x4168>
  444404:	00003825 	move	a3,zero
  444408:	3c02005e 	lui	v0,0x5e
  44440c:	8c46d6c0 	lw	a2,-10560(v0)
  444410:	8c47d6c4 	lw	a3,-10556(v0)
  444414:	3c05005e 	lui	a1,0x5e
  444418:	24a5f654 	addiu	a1,a1,-2476
  44441c:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  444420:	02002025 	move	a0,s0
  444424:	c68005ec 	lwc1	$f0,1516(s4)
  444428:	3c05005e 	lui	a1,0x5e
  44442c:	24a5f668 	addiu	a1,a1,-2456
  444430:	1000ff3e 	b	44412c <cJSON_GetObjectItem@@Base+0x3e80>
  444434:	46000021 	cvt.d.s	$f0,$f0
  444438:	3c15005e 	lui	s5,0x5e
  44443c:	26a51cb8 	addiu	a1,s5,7352
  444440:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  444444:	02602025 	move	a0,s3
  444448:	10400004 	beqz	v0,44445c <cJSON_GetObjectItem@@Base+0x41b0>
  44444c:	24030010 	li	v1,16
  444450:	8c57000c 	lw	s7,12(v0)
  444454:	12e30075 	beq	s7,v1,44462c <cJSON_GetObjectItem@@Base+0x4380>
  444458:	00000000 	nop
  44445c:	27a400b4 	addiu	a0,sp,180
  444460:	1000fdf8 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  444464:	26a71cb8 	addiu	a3,s5,7352
  444468:	3c05005e 	lui	a1,0x5e
  44446c:	3c04005e 	lui	a0,0x5e
  444470:	24a525a0 	addiu	a1,a1,9632
  444474:	0c197bcc 	jal	65ef30 <printf@plt>
  444478:	24842390 	addiu	a0,a0,9104
  44447c:	96470006 	lhu	a3,6(s2)
  444480:	3c06005e 	lui	a2,0x5e
  444484:	24c623ac 	addiu	a2,a2,9132
  444488:	24050080 	li	a1,128
  44448c:	0c197ca4 	jal	65f290 <snprintf@plt>
  444490:	27a400b4 	addiu	a0,sp,180
  444494:	1000fdf6 	b	443c70 <cJSON_GetObjectItem@@Base+0x39c4>
  444498:	3c02005e 	lui	v0,0x5e
  44449c:	8c550014 	lw	s5,20(v0)
  4444a0:	2ea20002 	sltiu	v0,s5,2
  4444a4:	144001f0 	bnez	v0,444c68 <cJSON_GetObjectItem@@Base+0x49bc>
  4444a8:	3c07005e 	lui	a3,0x5e
  4444ac:	27a400b4 	addiu	a0,sp,180
  4444b0:	1000fde4 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  4444b4:	24e7f6d4 	addiu	a3,a3,-2348
  4444b8:	8c420014 	lw	v0,20(v0)
  4444bc:	2c430002 	sltiu	v1,v0,2
  4444c0:	14600188 	bnez	v1,444ae4 <cJSON_GetObjectItem@@Base+0x4838>
  4444c4:	3c07005e 	lui	a3,0x5e
  4444c8:	27a400b4 	addiu	a0,sp,180
  4444cc:	1000fddd 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  4444d0:	24e71eb4 	addiu	a3,a3,7860
  4444d4:	8c470014 	lw	a3,20(v0)
  4444d8:	2ce20006 	sltiu	v0,a3,6
  4444dc:	104001df 	beqz	v0,444c5c <cJSON_GetObjectItem@@Base+0x49b0>
  4444e0:	27a400b4 	addiu	a0,sp,180
  4444e4:	8e820b98 	lw	v0,2968(s4)
  4444e8:	10e20025 	beq	a3,v0,444580 <cJSON_GetObjectItem@@Base+0x42d4>
  4444ec:	3c16005e 	lui	s6,0x5e
  4444f0:	8e860b94 	lw	a2,2964(s4)
  4444f4:	3c04005e 	lui	a0,0x5e
  4444f8:	ae870b98 	sw	a3,2968(s4)
  4444fc:	26c525a0 	addiu	a1,s6,9632
  444500:	24842218 	addiu	a0,a0,8728
  444504:	0c197bcc 	jal	65ef30 <printf@plt>
  444508:	26950d4c 	addiu	s5,s4,3404
  44450c:	0c197d74 	jal	65f5d0 <pthread_mutex_lock@plt>
  444510:	02a02025 	move	a0,s5
  444514:	8e860b94 	lw	a2,2964(s4)
  444518:	2cc20015 	sltiu	v0,a2,21
  44451c:	144001ec 	bnez	v0,444cd0 <cJSON_GetObjectItem@@Base+0x4a24>
  444520:	3c02001f 	lui	v0,0x1f
  444524:	8e820b98 	lw	v0,2968(s4)
  444528:	24030003 	li	v1,3
  44452c:	104304da 	beq	v0,v1,445898 <cJSON_GetObjectItem@@Base+0x55ec>
  444530:	2c430004 	sltiu	v1,v0,4
  444534:	14600465 	bnez	v1,4456cc <cJSON_GetObjectItem@@Base+0x5420>
  444538:	24030004 	li	v1,4
  44453c:	104304e1 	beq	v0,v1,4458c4 <cJSON_GetObjectItem@@Base+0x5618>
  444540:	24030005 	li	v1,5
  444544:	1443000c 	bne	v0,v1,444578 <cJSON_GetObjectItem@@Base+0x42cc>
  444548:	3c04005e 	lui	a0,0x5e
  44454c:	26c525a0 	addiu	a1,s6,9632
  444550:	0c197bcc 	jal	65ef30 <printf@plt>
  444554:	24842334 	addiu	a0,a0,9012
  444558:	24020012 	li	v0,18
  44455c:	0c10d5fc 	jal	4357f0 <_ftext@@Base+0x12030>
  444560:	ae820b94 	sw	v0,2964(s4)
  444564:	ae820c08 	sw	v0,3080(s4)
  444568:	ae830c0c 	sw	v1,3084(s4)
  44456c:	24050006 	li	a1,6
  444570:	0c108e24 	jal	423890 <_ftext@@Base+0xd0>
  444574:	26840be8 	addiu	a0,s4,3048
  444578:	0c197ce4 	jal	65f390 <pthread_mutex_unlock@plt>
  44457c:	02a02025 	move	a0,s5
  444580:	3c15005e 	lui	s5,0x5e
  444584:	26a52368 	addiu	a1,s5,9064
  444588:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  44458c:	02602025 	move	a0,s3
  444590:	10400004 	beqz	v0,4445a4 <cJSON_GetObjectItem@@Base+0x42f8>
  444594:	24030008 	li	v1,8
  444598:	8c44000c 	lw	a0,12(v0)
  44459c:	108300b1 	beq	a0,v1,444864 <cJSON_GetObjectItem@@Base+0x45b8>
  4445a0:	00000000 	nop
  4445a4:	27a400b4 	addiu	a0,sp,180
  4445a8:	1000fda6 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  4445ac:	26a72368 	addiu	a3,s5,9064
  4445b0:	8c450014 	lw	a1,20(v0)
  4445b4:	24a2001e 	addiu	v0,a1,30
  4445b8:	2c42005b 	sltiu	v0,v0,91
  4445bc:	10400146 	beqz	v0,444ad8 <cJSON_GetObjectItem@@Base+0x482c>
  4445c0:	3c07005e 	lui	a3,0x5e
  4445c4:	8e840888 	lw	a0,2184(s4)
  4445c8:	1080fe0c 	beqz	a0,443dfc <cJSON_GetObjectItem@@Base+0x3b50>
  4445cc:	ae850430 	sw	a1,1072(s4)
  4445d0:	0c10c7b8 	jal	431ee0 <_ftext@@Base+0xe720>
  4445d4:	8e860434 	lw	a2,1076(s4)
  4445d8:	1040fe08 	beqz	v0,443dfc <cJSON_GetObjectItem@@Base+0x3b50>
  4445dc:	0040a825 	move	s5,v0
  4445e0:	3c05005e 	lui	a1,0x5e
  4445e4:	3c04005e 	lui	a0,0x5e
  4445e8:	00403025 	move	a2,v0
  4445ec:	24a525a0 	addiu	a1,a1,9632
  4445f0:	0c197bcc 	jal	65ef30 <printf@plt>
  4445f4:	24841f68 	addiu	a0,a0,8040
  4445f8:	3c06005e 	lui	a2,0x5e
  4445fc:	02a03825 	move	a3,s5
  444600:	1000feea 	b	4441ac <cJSON_GetObjectItem@@Base+0x3f00>
  444604:	24c61f8c 	addiu	a2,a2,8076
  444608:	8c550014 	lw	s5,20(v0)
  44460c:	12a0017c 	beqz	s5,444c00 <cJSON_GetObjectItem@@Base+0x4954>
  444610:	24020001 	li	v0,1
  444614:	12a20238 	beq	s5,v0,444ef8 <cJSON_GetObjectItem@@Base+0x4c4c>
  444618:	00000000 	nop
  44461c:	3c07005e 	lui	a3,0x5e
  444620:	27a400b4 	addiu	a0,sp,180
  444624:	1000fd87 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  444628:	24e7f9e8 	addiu	a3,a3,-1560
  44462c:	8c450010 	lw	a1,16(v0)
  444630:	24060021 	li	a2,33
  444634:	26840648 	addiu	a0,s4,1608
  444638:	0c197bb0 	jal	65eec0 <strncpy@plt>
  44463c:	3c16005e 	lui	s6,0x5e
  444640:	26c5203c 	addiu	a1,s6,8252
  444644:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  444648:	02602025 	move	a0,s3
  44464c:	10400004 	beqz	v0,444660 <cJSON_GetObjectItem@@Base+0x43b4>
  444650:	00000000 	nop
  444654:	8c5e000c 	lw	s8,12(v0)
  444658:	13d7002f 	beq	s8,s7,444718 <cJSON_GetObjectItem@@Base+0x446c>
  44465c:	00000000 	nop
  444660:	27a400b4 	addiu	a0,sp,180
  444664:	1000fd77 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  444668:	26c7203c 	addiu	a3,s6,8252
  44466c:	8c450010 	lw	a1,16(v0)
  444670:	24060021 	li	a2,33
  444674:	26840b08 	addiu	a0,s4,2824
  444678:	0c197bb0 	jal	65eec0 <strncpy@plt>
  44467c:	3c15005e 	lui	s5,0x5e
  444680:	26a52414 	addiu	a1,s5,9236
  444684:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  444688:	02602025 	move	a0,s3
  44468c:	10400004 	beqz	v0,4446a0 <cJSON_GetObjectItem@@Base+0x43f4>
  444690:	00000000 	nop
  444694:	8c43000c 	lw	v1,12(v0)
  444698:	1076002f 	beq	v1,s6,444758 <cJSON_GetObjectItem@@Base+0x44ac>
  44469c:	00000000 	nop
  4446a0:	27a400b4 	addiu	a0,sp,180
  4446a4:	1000fd67 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  4446a8:	26a72414 	addiu	a3,s5,9236
  4446ac:	8c550014 	lw	s5,20(v0)
  4446b0:	2ea20002 	sltiu	v0,s5,2
  4446b4:	144001e6 	bnez	v0,444e50 <cJSON_GetObjectItem@@Base+0x4ba4>
  4446b8:	3c07005e 	lui	a3,0x5e
  4446bc:	27a400b4 	addiu	a0,sp,180
  4446c0:	1000fd60 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  4446c4:	24e71dc4 	addiu	a3,a3,7620
  4446c8:	8c560014 	lw	s6,20(v0)
  4446cc:	2ec20002 	sltiu	v0,s6,2
  4446d0:	14400129 	bnez	v0,444b78 <cJSON_GetObjectItem@@Base+0x48cc>
  4446d4:	3c07005e 	lui	a3,0x5e
  4446d8:	27a400b4 	addiu	a0,sp,180
  4446dc:	1000fd59 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  4446e0:	24e7f6a4 	addiu	a3,a3,-2396
  4446e4:	8ec50014 	lw	a1,20(s6)
  4446e8:	04a00244 	bltz	a1,444ffc <cJSON_GetObjectItem@@Base+0x4d50>
  4446ec:	3c07005e 	lui	a3,0x5e
  4446f0:	8e820410 	lw	v0,1040(s4)
  4446f4:	10a2fdc2 	beq	a1,v0,443e00 <cJSON_GetObjectItem@@Base+0x3b54>
  4446f8:	02802025 	move	a0,s4
  4446fc:	0c10bed7 	jal	42fb5c <_ftext@@Base+0xc39c>
  444700:	8e840884 	lw	a0,2180(s4)
  444704:	14400211 	bnez	v0,444f4c <cJSON_GetObjectItem@@Base+0x4ca0>
  444708:	0040a825 	move	s5,v0
  44470c:	8ec20014 	lw	v0,20(s6)
  444710:	1000fdba 	b	443dfc <cJSON_GetObjectItem@@Base+0x3b50>
  444714:	ae820410 	sw	v0,1040(s4)
  444718:	8c450010 	lw	a1,16(v0)
  44471c:	24060021 	li	a2,33
  444720:	26840669 	addiu	a0,s4,1641
  444724:	0c197bb0 	jal	65eec0 <strncpy@plt>
  444728:	3c17005e 	lui	s7,0x5e
  44472c:	26e5fe38 	addiu	a1,s7,-456
  444730:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  444734:	02602025 	move	a0,s3
  444738:	10400004 	beqz	v0,44474c <cJSON_GetObjectItem@@Base+0x44a0>
  44473c:	00000000 	nop
  444740:	8c43000c 	lw	v1,12(v0)
  444744:	107e0037 	beq	v1,s8,444824 <cJSON_GetObjectItem@@Base+0x4578>
  444748:	3c1e005e 	lui	s8,0x5e
  44474c:	27a400b4 	addiu	a0,sp,180
  444750:	1000fd3c 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  444754:	26e7fe38 	addiu	a3,s7,-456
  444758:	8c450010 	lw	a1,16(v0)
  44475c:	24060021 	li	a2,33
  444760:	26840b29 	addiu	a0,s4,2857
  444764:	0c197bb0 	jal	65eec0 <strncpy@plt>
  444768:	3c15005e 	lui	s5,0x5e
  44476c:	26a500e0 	addiu	a1,s5,224
  444770:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  444774:	02602025 	move	a0,s3
  444778:	10400004 	beqz	v0,44478c <cJSON_GetObjectItem@@Base+0x44e0>
  44477c:	24030008 	li	v1,8
  444780:	8c44000c 	lw	a0,12(v0)
  444784:	10830004 	beq	a0,v1,444798 <cJSON_GetObjectItem@@Base+0x44ec>
  444788:	00000000 	nop
  44478c:	27a400b4 	addiu	a0,sp,180
  444790:	1000fd2c 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  444794:	26a700e0 	addiu	a3,s5,224
  444798:	8c420014 	lw	v0,20(v0)
  44479c:	2843003c 	slti	v1,v0,60
  4447a0:	14600250 	bnez	v1,4450e4 <cJSON_GetObjectItem@@Base+0x4e38>
  4447a4:	3c07005e 	lui	a3,0x5e
  4447a8:	8e830c1c 	lw	v1,3100(s4)
  4447ac:	10600233 	beqz	v1,44507c <cJSON_GetObjectItem@@Base+0x4dd0>
  4447b0:	ae820b4c 	sw	v0,2892(s4)
  4447b4:	3c05005e 	lui	a1,0x5e
  4447b8:	3c04005e 	lui	a0,0x5e
  4447bc:	24a525a0 	addiu	a1,a1,9632
  4447c0:	0c197bcc 	jal	65ef30 <printf@plt>
  4447c4:	2484218c 	addiu	a0,a0,8588
  4447c8:	3c03005e 	lui	v1,0x5e
  4447cc:	246221b0 	addiu	v0,v1,8624
  4447d0:	8c470004 	lw	a3,4(v0)
  4447d4:	8c460008 	lw	a2,8(v0)
  4447d8:	8c6821b0 	lw	t0,8624(v1)
  4447dc:	8c45000c 	lw	a1,12(v0)
  4447e0:	8c440010 	lw	a0,16(v0)
  4447e4:	8c430014 	lw	v1,20(v0)
  4447e8:	8c420018 	lw	v0,24(v0)
  4447ec:	afa700b8 	sw	a3,184(sp)
  4447f0:	afa600bc 	sw	a2,188(sp)
  4447f4:	afa200cc 	sw	v0,204(sp)
  4447f8:	3c02005e 	lui	v0,0x5e
  4447fc:	8c46d6c0 	lw	a2,-10560(v0)
  444800:	8c47d6c4 	lw	a3,-10556(v0)
  444804:	96420006 	lhu	v0,6(s2)
  444808:	afa800b4 	sw	t0,180(sp)
  44480c:	afa500c0 	sw	a1,192(sp)
  444810:	afa400c4 	sw	a0,196(sp)
  444814:	afa300c8 	sw	v1,200(sp)
  444818:	0000a825 	move	s5,zero
  44481c:	1000fcac 	b	443ad0 <cJSON_GetObjectItem@@Base+0x3824>
  444820:	a6220006 	sh	v0,6(s1)
  444824:	8c450010 	lw	a1,16(v0)
  444828:	24060021 	li	a2,33
  44482c:	2684068a 	addiu	a0,s4,1674
  444830:	0c197bb0 	jal	65eec0 <strncpy@plt>
  444834:	afa30178 	sw	v1,376(sp)
  444838:	27c5fef4 	addiu	a1,s8,-268
  44483c:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  444840:	02602025 	move	a0,s3
  444844:	10400004 	beqz	v0,444858 <cJSON_GetObjectItem@@Base+0x45ac>
  444848:	8fa30178 	lw	v1,376(sp)
  44484c:	8c47000c 	lw	a3,12(v0)
  444850:	10e3000b 	beq	a3,v1,444880 <cJSON_GetObjectItem@@Base+0x45d4>
  444854:	00000000 	nop
  444858:	27a400b4 	addiu	a0,sp,180
  44485c:	1000fcf9 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  444860:	27c7fef4 	addiu	a3,s8,-268
  444864:	8c420014 	lw	v0,20(v0)
  444868:	2c430065 	sltiu	v1,v0,101
  44486c:	146001e6 	bnez	v1,445008 <cJSON_GetObjectItem@@Base+0x4d5c>
  444870:	3c07005e 	lui	a3,0x5e
  444874:	27a400b4 	addiu	a0,sp,180
  444878:	1000fcf2 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  44487c:	24e72374 	addiu	a3,a3,9076
  444880:	8c450010 	lw	a1,16(v0)
  444884:	24060021 	li	a2,33
  444888:	268406ab 	addiu	a0,s4,1707
  44488c:	0c197bb0 	jal	65eec0 <strncpy@plt>
  444890:	afa7017c 	sw	a3,380(sp)
  444894:	3c02005e 	lui	v0,0x5e
  444898:	244500c0 	addiu	a1,v0,192
  44489c:	02602025 	move	a0,s3
  4448a0:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  4448a4:	afa20178 	sw	v0,376(sp)
  4448a8:	00401825 	move	v1,v0
  4448ac:	10400004 	beqz	v0,4448c0 <cJSON_GetObjectItem@@Base+0x4614>
  4448b0:	8fa7017c 	lw	a3,380(sp)
  4448b4:	8c62000c 	lw	v0,12(v1)
  4448b8:	10470268 	beq	v0,a3,44525c <cJSON_GetObjectItem@@Base+0x4fb0>
  4448bc:	00000000 	nop
  4448c0:	8fa20178 	lw	v0,376(sp)
  4448c4:	27a400b4 	addiu	a0,sp,180
  4448c8:	1000fcde 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  4448cc:	244700c0 	addiu	a3,v0,192
  4448d0:	3c04005e 	lui	a0,0x5e
  4448d4:	24a525a0 	addiu	a1,a1,9632
  4448d8:	0c197bcc 	jal	65ef30 <printf@plt>
  4448dc:	24840014 	addiu	a0,a0,20
  4448e0:	3c03005e 	lui	v1,0x5e
  4448e4:	24621d08 	addiu	v0,v1,7432
  4448e8:	8c661d08 	lw	a2,7432(v1)
  4448ec:	8c450004 	lw	a1,4(v0)
  4448f0:	8c440008 	lw	a0,8(v0)
  4448f4:	8c43000c 	lw	v1,12(v0)
  4448f8:	90420010 	lbu	v0,16(v0)
  4448fc:	afa600b4 	sw	a2,180(sp)
  444900:	afa500b8 	sw	a1,184(sp)
  444904:	a3a200c4 	sb	v0,196(sp)
  444908:	3c02005e 	lui	v0,0x5e
  44490c:	8c4625c0 	lw	a2,9664(v0)
  444910:	8c4725c4 	lw	a3,9668(v0)
  444914:	96420006 	lhu	v0,6(s2)
  444918:	afa400bc 	sw	a0,188(sp)
  44491c:	afa300c0 	sw	v1,192(sp)
  444920:	0000a825 	move	s5,zero
  444924:	1000fc6a 	b	443ad0 <cJSON_GetObjectItem@@Base+0x3824>
  444928:	a6220006 	sh	v0,6(s1)
  44492c:	3c04005e 	lui	a0,0x5e
  444930:	24a525a0 	addiu	a1,a1,9632
  444934:	0c197bcc 	jal	65ef30 <printf@plt>
  444938:	248423cc 	addiu	a0,a0,9164
  44493c:	2415ffff 	li	s5,-1
  444940:	1000fc82 	b	443b4c <cJSON_GetObjectItem@@Base+0x38a0>
  444944:	8e220014 	lw	v0,20(s1)
  444948:	0c110413 	jal	44104c <cJSON_GetObjectItem@@Base+0xda0>
  44494c:	27b70034 	addiu	s7,sp,52
  444950:	8fa30030 	lw	v1,48(sp)
  444954:	0040b025 	move	s6,v0
  444958:	1860000c 	blez	v1,44498c <cJSON_GetObjectItem@@Base+0x46e0>
  44495c:	0000a025 	move	s4,zero
  444960:	8ee40000 	lw	a0,0(s7)
  444964:	26940001 	addiu	s4,s4,1
  444968:	0c11036b 	jal	440dac <cJSON_GetObjectItem@@Base+0xb00>
  44496c:	26f70004 	addiu	s7,s7,4
  444970:	00402825 	move	a1,v0
  444974:	0c1100b7 	jal	4402dc <cJSON_GetObjectItem@@Base+0x30>
  444978:	02c02025 	move	a0,s6
  44497c:	8fa20030 	lw	v0,48(sp)
  444980:	0282102a 	slt	v0,s4,v0
  444984:	1440fff6 	bnez	v0,444960 <cJSON_GetObjectItem@@Base+0x46b4>
  444988:	00000000 	nop
  44498c:	3c05005e 	lui	a1,0x5e
  444990:	02c03025 	move	a2,s6
  444994:	24a51d60 	addiu	a1,a1,7520
  444998:	0c1100cf 	jal	44033c <cJSON_GetObjectItem@@Base+0x90>
  44499c:	02002025 	move	a0,s0
  4449a0:	96420006 	lhu	v0,6(s2)
  4449a4:	00003025 	move	a2,zero
  4449a8:	00003825 	move	a3,zero
  4449ac:	1000fc48 	b	443ad0 <cJSON_GetObjectItem@@Base+0x3824>
  4449b0:	a6220006 	sh	v0,6(s1)
  4449b4:	8fa20040 	lw	v0,64(sp)
  4449b8:	44820000 	mtc1	v0,$f0
  4449bc:	46800021 	cvt.d.w	$f0,$f0
  4449c0:	44060000 	mfc1	a2,$f0
  4449c4:	04400185 	bltz	v0,444fdc <cJSON_GetObjectItem@@Base+0x4d30>
  4449c8:	44070800 	mfc1	a3,$f1
  4449cc:	3c05005e 	lui	a1,0x5e
  4449d0:	02002025 	move	a0,s0
  4449d4:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  4449d8:	24a51da8 	addiu	a1,a1,7592
  4449dc:	c7a00044 	lwc1	$f0,68(sp)
  4449e0:	3c05005e 	lui	a1,0x5e
  4449e4:	02002025 	move	a0,s0
  4449e8:	46800021 	cvt.d.w	$f0,$f0
  4449ec:	44060000 	mfc1	a2,$f0
  4449f0:	44070800 	mfc1	a3,$f1
  4449f4:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  4449f8:	24a5f9bc 	addiu	a1,a1,-1604
  4449fc:	c7a00038 	lwc1	$f0,56(sp)
  444a00:	3c05005e 	lui	a1,0x5e
  444a04:	02002025 	move	a0,s0
  444a08:	46800021 	cvt.d.w	$f0,$f0
  444a0c:	44060000 	mfc1	a2,$f0
  444a10:	44070800 	mfc1	a3,$f1
  444a14:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  444a18:	24a5f604 	addiu	a1,a1,-2556
  444a1c:	c7a00034 	lwc1	$f0,52(sp)
  444a20:	3c05005e 	lui	a1,0x5e
  444a24:	02002025 	move	a0,s0
  444a28:	46800021 	cvt.d.w	$f0,$f0
  444a2c:	44060000 	mfc1	a2,$f0
  444a30:	44070800 	mfc1	a3,$f1
  444a34:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  444a38:	24a5f5fc 	addiu	a1,a1,-2564
  444a3c:	c7a00050 	lwc1	$f0,80(sp)
  444a40:	3c05005e 	lui	a1,0x5e
  444a44:	24a5f9b0 	addiu	a1,a1,-1616
  444a48:	46800021 	cvt.d.w	$f0,$f0
  444a4c:	44060000 	mfc1	a2,$f0
  444a50:	44070800 	mfc1	a3,$f1
  444a54:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  444a58:	02002025 	move	a0,s0
  444a5c:	8fa20030 	lw	v0,48(sp)
  444a60:	44820000 	mtc1	v0,$f0
  444a64:	46800021 	cvt.d.w	$f0,$f0
  444a68:	44060000 	mfc1	a2,$f0
  444a6c:	04400153 	bltz	v0,444fbc <cJSON_GetObjectItem@@Base+0x4d10>
  444a70:	44070800 	mfc1	a3,$f1
  444a74:	3c05005f 	lui	a1,0x5f
  444a78:	02002025 	move	a0,s0
  444a7c:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  444a80:	24a52c18 	addiu	a1,a1,11288
  444a84:	c7a00048 	lwc1	$f0,72(sp)
  444a88:	3c05005e 	lui	a1,0x5e
  444a8c:	02002025 	move	a0,s0
  444a90:	46800021 	cvt.d.w	$f0,$f0
  444a94:	44060000 	mfc1	a2,$f0
  444a98:	44070800 	mfc1	a3,$f1
  444a9c:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  444aa0:	24a51db0 	addiu	a1,a1,7600
  444aa4:	c7a0004c 	lwc1	$f0,76(sp)
  444aa8:	3c05005e 	lui	a1,0x5e
  444aac:	24a51dbc 	addiu	a1,a1,7612
  444ab0:	46800021 	cvt.d.w	$f0,$f0
  444ab4:	44060000 	mfc1	a2,$f0
  444ab8:	44070800 	mfc1	a3,$f1
  444abc:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  444ac0:	02002025 	move	a0,s0
  444ac4:	96420006 	lhu	v0,6(s2)
  444ac8:	00003025 	move	a2,zero
  444acc:	00003825 	move	a3,zero
  444ad0:	1000fbff 	b	443ad0 <cJSON_GetObjectItem@@Base+0x3824>
  444ad4:	a6220006 	sh	v0,6(s1)
  444ad8:	27a400b4 	addiu	a0,sp,180
  444adc:	1000fc59 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  444ae0:	24e7f6c8 	addiu	a3,a3,-2360
  444ae4:	1040008d 	beqz	v0,444d1c <cJSON_GetObjectItem@@Base+0x4a70>
  444ae8:	269e0cec 	addiu	s8,s4,3308
  444aec:	3c16005e 	lui	s6,0x5e
  444af0:	26c5f604 	addiu	a1,s6,-2556
  444af4:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  444af8:	02602025 	move	a0,s3
  444afc:	10400004 	beqz	v0,444b10 <cJSON_GetObjectItem@@Base+0x4864>
  444b00:	00000000 	nop
  444b04:	8c43000c 	lw	v1,12(v0)
  444b08:	10750010 	beq	v1,s5,444b4c <cJSON_GetObjectItem@@Base+0x48a0>
  444b0c:	00000000 	nop
  444b10:	afa00184 	sw	zero,388(sp)
  444b14:	3c02005e 	lui	v0,0x5e
  444b18:	24451ec0 	addiu	a1,v0,7872
  444b1c:	02602025 	move	a0,s3
  444b20:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  444b24:	afa20178 	sw	v0,376(sp)
  444b28:	10400004 	beqz	v0,444b3c <cJSON_GetObjectItem@@Base+0x4890>
  444b2c:	24030008 	li	v1,8
  444b30:	8c55000c 	lw	s5,12(v0)
  444b34:	12a3010f 	beq	s5,v1,444f74 <cJSON_GetObjectItem@@Base+0x4cc8>
  444b38:	00000000 	nop
  444b3c:	8fa20178 	lw	v0,376(sp)
  444b40:	27a400b4 	addiu	a0,sp,180
  444b44:	1000fc3f 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  444b48:	24471ec0 	addiu	a3,v0,7872
  444b4c:	8c430014 	lw	v1,20(v0)
  444b50:	2462001e 	addiu	v0,v1,30
  444b54:	2c42005b 	sltiu	v0,v0,91
  444b58:	1040ffdf 	beqz	v0,444ad8 <cJSON_GetObjectItem@@Base+0x482c>
  444b5c:	3c07005e 	lui	a3,0x5e
  444b60:	8e820430 	lw	v0,1072(s4)
  444b64:	1062ffea 	beq	v1,v0,444b10 <cJSON_GetObjectItem@@Base+0x4864>
  444b68:	24020001 	li	v0,1
  444b6c:	ae830430 	sw	v1,1072(s4)
  444b70:	1000ffe8 	b	444b14 <cJSON_GetObjectItem@@Base+0x4868>
  444b74:	afa20184 	sw	v0,388(sp)
  444b78:	8e82040c 	lw	v0,1036(s4)
  444b7c:	12c2fca0 	beq	s6,v0,443e00 <cJSON_GetObjectItem@@Base+0x3b54>
  444b80:	02802025 	move	a0,s4
  444b84:	8e840884 	lw	a0,2180(s4)
  444b88:	0c10bf02 	jal	42fc08 <_ftext@@Base+0xc448>
  444b8c:	02c02825 	move	a1,s6
  444b90:	1440014a 	bnez	v0,4450bc <cJSON_GetObjectItem@@Base+0x4e10>
  444b94:	0040a825 	move	s5,v0
  444b98:	1000fc98 	b	443dfc <cJSON_GetObjectItem@@Base+0x3b50>
  444b9c:	ae96040c 	sw	s6,1036(s4)
  444ba0:	44861000 	mtc1	a2,$f2
  444ba4:	3c02005e 	lui	v0,0x5e
  444ba8:	d440b468 	ldc1	$f0,-19352(v0)
  444bac:	44871800 	mtc1	a3,$f3
  444bb0:	46201000 	add.d	$f0,$f2,$f0
  444bb4:	44060000 	mfc1	a2,$f0
  444bb8:	1000fc6a 	b	443d64 <cJSON_GetObjectItem@@Base+0x3ab8>
  444bbc:	44070800 	mfc1	a3,$f1
  444bc0:	44861000 	mtc1	a2,$f2
  444bc4:	3c02005e 	lui	v0,0x5e
  444bc8:	d440b468 	ldc1	$f0,-19352(v0)
  444bcc:	44871800 	mtc1	a3,$f3
  444bd0:	46201000 	add.d	$f0,$f2,$f0
  444bd4:	44060000 	mfc1	a2,$f0
  444bd8:	1000fc4e 	b	443d14 <cJSON_GetObjectItem@@Base+0x3a68>
  444bdc:	44070800 	mfc1	a3,$f1
  444be0:	44861000 	mtc1	a2,$f2
  444be4:	3c02005e 	lui	v0,0x5e
  444be8:	d440b468 	ldc1	$f0,-19352(v0)
  444bec:	44871800 	mtc1	a3,$f3
  444bf0:	46201000 	add.d	$f0,$f2,$f0
  444bf4:	44060000 	mfc1	a2,$f0
  444bf8:	1000fc50 	b	443d3c <cJSON_GetObjectItem@@Base+0x3a90>
  444bfc:	44070800 	mfc1	a3,$f1
  444c00:	3c05005e 	lui	a1,0x5e
  444c04:	3c04005e 	lui	a0,0x5e
  444c08:	24a525a0 	addiu	a1,a1,9632
  444c0c:	0c197bcc 	jal	65ef30 <printf@plt>
  444c10:	24842018 	addiu	a0,a0,8216
  444c14:	0c10d5fc 	jal	4357f0 <_ftext@@Base+0x12030>
  444c18:	ae8007a8 	sw	zero,1960(s4)
  444c1c:	ae820c50 	sw	v0,3152(s4)
  444c20:	00001025 	move	v0,zero
  444c24:	ae820c30 	sw	v0,3120(s4)
  444c28:	ae820c28 	sw	v0,3112(s4)
  444c2c:	24020001 	li	v0,1
  444c30:	a2820c6d 	sb	v0,3181(s4)
  444c34:	96420006 	lhu	v0,6(s2)
  444c38:	ae830c54 	sw	v1,3156(s4)
  444c3c:	00001825 	move	v1,zero
  444c40:	ae830c34 	sw	v1,3124(s4)
  444c44:	ae830c2c 	sw	v1,3116(s4)
  444c48:	00003025 	move	a2,zero
  444c4c:	00003825 	move	a3,zero
  444c50:	0000a825 	move	s5,zero
  444c54:	1000fb9e 	b	443ad0 <cJSON_GetObjectItem@@Base+0x3824>
  444c58:	a6220006 	sh	v0,6(s1)
  444c5c:	3c07005e 	lui	a3,0x5e
  444c60:	1000fbf8 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  444c64:	24e7220c 	addiu	a3,a3,8716
  444c68:	3c17005e 	lui	s7,0x5e
  444c6c:	26e5f62c 	addiu	a1,s7,-2516
  444c70:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  444c74:	02602025 	move	a0,s3
  444c78:	10400004 	beqz	v0,444c8c <cJSON_GetObjectItem@@Base+0x49e0>
  444c7c:	00000000 	nop
  444c80:	8c5e000c 	lw	s8,12(v0)
  444c84:	13d60004 	beq	s8,s6,444c98 <cJSON_GetObjectItem@@Base+0x49ec>
  444c88:	00000000 	nop
  444c8c:	27a400b4 	addiu	a0,sp,180
  444c90:	1000fbec 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  444c94:	26e7f62c 	addiu	a3,s7,-2516
  444c98:	4480b000 	mtc1	zero,$f22
  444c9c:	d4540018 	ldc1	$f20,24(v0)
  444ca0:	4480b800 	mtc1	zero,$f23
  444ca4:	4636a53c 	c.lt.d	$fcc5,$f20,$f22
  444ca8:	45150006 	bc1t	$fcc5,444cc4 <cJSON_GetObjectItem@@Base+0x4a18>
  444cac:	3c07005e 	lui	a3,0x5e
  444cb0:	3c16005e 	lui	s6,0x5e
  444cb4:	d6c0fce0 	ldc1	$f0,-800(s6)
  444cb8:	4634003c 	c.lt.d	$f0,$f20
  444cbc:	45000151 	bc1f	445204 <cJSON_GetObjectItem@@Base+0x4f58>
  444cc0:	3c17005e 	lui	s7,0x5e
  444cc4:	27a400b4 	addiu	a0,sp,180
  444cc8:	1000fbde 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  444ccc:	24e7f6e8 	addiu	a3,a3,-2328
  444cd0:	24422480 	addiu	v0,v0,9344
  444cd4:	00c21006 	srlv	v0,v0,a2
  444cd8:	30420001 	andi	v0,v0,0x1
  444cdc:	1040fe11 	beqz	v0,444524 <cJSON_GetObjectItem@@Base+0x4278>
  444ce0:	26c525a0 	addiu	a1,s6,9632
  444ce4:	8e870b98 	lw	a3,2968(s4)
  444ce8:	3c04005e 	lui	a0,0x5e
  444cec:	0c197bcc 	jal	65ef30 <printf@plt>
  444cf0:	24842250 	addiu	a0,a0,8784
  444cf4:	8e870b94 	lw	a3,2964(s4)
  444cf8:	3c06005e 	lui	a2,0x5e
  444cfc:	27a400b4 	addiu	a0,sp,180
