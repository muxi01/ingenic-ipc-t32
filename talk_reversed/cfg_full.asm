
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
  444d00:	24c62270 	addiu	a2,a2,8816
  444d04:	0c197ca4 	jal	65f290 <snprintf@plt>
  444d08:	24050080 	li	a1,128
  444d0c:	0c197ce4 	jal	65f390 <pthread_mutex_unlock@plt>
  444d10:	02a02025 	move	a0,s5
  444d14:	1000fbd6 	b	443c70 <cJSON_GetObjectItem@@Base+0x39c4>
  444d18:	3c02005e 	lui	v0,0x5e
  444d1c:	0c197d74 	jal	65f5d0 <pthread_mutex_lock@plt>
  444d20:	03c02025 	move	a0,s8
  444d24:	8e820888 	lw	v0,2184(s4)
  444d28:	10400003 	beqz	v0,444d38 <cJSON_GetObjectItem@@Base+0x4a8c>
  444d2c:	00000000 	nop
  444d30:	0c10c66f 	jal	4319bc <_ftext@@Base+0xe1fc>
  444d34:	26840888 	addiu	a0,s4,2184
  444d38:	8e820884 	lw	v0,2180(s4)
  444d3c:	10400004 	beqz	v0,444d50 <cJSON_GetObjectItem@@Base+0x4aa4>
  444d40:	3c02005e 	lui	v0,0x5e
  444d44:	82820c9c 	lb	v0,3228(s4)
  444d48:	1440023e 	bnez	v0,445644 <cJSON_GetObjectItem@@Base+0x5398>
  444d4c:	3c02005e 	lui	v0,0x5e
  444d50:	afa20178 	sw	v0,376(sp)
  444d54:	3c02005e 	lui	v0,0x5e
  444d58:	afa2017c 	sw	v0,380(sp)
  444d5c:	3c02005e 	lui	v0,0x5e
  444d60:	3c16005e 	lui	s6,0x5e
  444d64:	afa20180 	sw	v0,384(sp)
  444d68:	0c197ce4 	jal	65f390 <pthread_mutex_unlock@plt>
  444d6c:	03c02025 	move	a0,s8
  444d70:	8e820888 	lw	v0,2184(s4)
  444d74:	1040020c 	beqz	v0,4455a8 <cJSON_GetObjectItem@@Base+0x52fc>
  444d78:	3c02005e 	lui	v0,0x5e
  444d7c:	8c46d6c0 	lw	a2,-10560(v0)
  444d80:	8c47d6c4 	lw	a3,-10556(v0)
  444d84:	02002025 	move	a0,s0
  444d88:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  444d8c:	26e5a714 	addiu	a1,s7,-22764
  444d90:	c6800430 	lwc1	$f0,1072(s4)
  444d94:	02002025 	move	a0,s0
  444d98:	26c5f604 	addiu	a1,s6,-2556
  444d9c:	46800021 	cvt.d.w	$f0,$f0
  444da0:	44060000 	mfc1	a2,$f0
  444da4:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  444da8:	44070800 	mfc1	a3,$f1
  444dac:	96860420 	lhu	a2,1056(s4)
  444db0:	3c05005e 	lui	a1,0x5e
  444db4:	24a5a6e4 	addiu	a1,a1,-22812
  444db8:	44860000 	mtc1	a2,$f0
  444dbc:	02002025 	move	a0,s0
  444dc0:	46800021 	cvt.d.w	$f0,$f0
  444dc4:	44060000 	mfc1	a2,$f0
  444dc8:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  444dcc:	44070800 	mfc1	a3,$f1
  444dd0:	8e820428 	lw	v0,1064(s4)
  444dd4:	44820000 	mtc1	v0,$f0
  444dd8:	46800021 	cvt.d.w	$f0,$f0
  444ddc:	44060000 	mfc1	a2,$f0
  444de0:	044001e1 	bltz	v0,445568 <cJSON_GetObjectItem@@Base+0x52bc>
  444de4:	44070800 	mfc1	a3,$f1
  444de8:	8fa20178 	lw	v0,376(sp)
  444dec:	02002025 	move	a0,s0
  444df0:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  444df4:	24451ec0 	addiu	a1,v0,7872
  444df8:	8e820424 	lw	v0,1060(s4)
  444dfc:	44820000 	mtc1	v0,$f0
  444e00:	46800021 	cvt.d.w	$f0,$f0
  444e04:	44060000 	mfc1	a2,$f0
  444e08:	044001df 	bltz	v0,445588 <cJSON_GetObjectItem@@Base+0x52dc>
  444e0c:	44070800 	mfc1	a3,$f1
  444e10:	8fa2017c 	lw	v0,380(sp)
  444e14:	02002025 	move	a0,s0
  444e18:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  444e1c:	24451ed0 	addiu	a1,v0,7888
  444e20:	8e82042c 	lw	v0,1068(s4)
  444e24:	44820000 	mtc1	v0,$f0
  444e28:	46800021 	cvt.d.w	$f0,$f0
  444e2c:	44060000 	mfc1	a2,$f0
  444e30:	044001c5 	bltz	v0,445548 <cJSON_GetObjectItem@@Base+0x529c>
  444e34:	44070800 	mfc1	a3,$f1
  444e38:	8fa20180 	lw	v0,384(sp)
  444e3c:	02002025 	move	a0,s0
  444e40:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  444e44:	24451eec 	addiu	a1,v0,7916
  444e48:	1000fbed 	b	443e00 <cJSON_GetObjectItem@@Base+0x3b54>
  444e4c:	02802025 	move	a0,s4
  444e50:	3c17005e 	lui	s7,0x5e
  444e54:	26e5f9bc 	addiu	a1,s7,-1604
  444e58:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  444e5c:	02602025 	move	a0,s3
  444e60:	10400004 	beqz	v0,444e74 <cJSON_GetObjectItem@@Base+0x4bc8>
  444e64:	00000000 	nop
  444e68:	8c43000c 	lw	v1,12(v0)
  444e6c:	10760004 	beq	v1,s6,444e80 <cJSON_GetObjectItem@@Base+0x4bd4>
  444e70:	00000000 	nop
  444e74:	27a400b4 	addiu	a0,sp,180
  444e78:	1000fb72 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  444e7c:	26e7f9bc 	addiu	a3,s7,-1604
  444e80:	26970cec 	addiu	s7,s4,3308
  444e84:	02e02025 	move	a0,s7
  444e88:	0c197d74 	jal	65f5d0 <pthread_mutex_lock@plt>
  444e8c:	8c560014 	lw	s6,20(v0)
  444e90:	24020001 	li	v0,1
  444e94:	12a201d6 	beq	s5,v0,4455f0 <cJSON_GetObjectItem@@Base+0x5344>
  444e98:	00000000 	nop
  444e9c:	8e840884 	lw	a0,2180(s4)
  444ea0:	02c03025 	move	a2,s6
  444ea4:	02a02825 	move	a1,s5
  444ea8:	afa00010 	sw	zero,16(sp)
  444eac:	0c10be81 	jal	42fa04 <_ftext@@Base+0xc244>
  444eb0:	2407ffff 	li	a3,-1
  444eb4:	0040a825 	move	s5,v0
  444eb8:	144001be 	bnez	v0,4455b4 <cJSON_GetObjectItem@@Base+0x5308>
  444ebc:	0000b025 	move	s6,zero
  444ec0:	0c197ce4 	jal	65f390 <pthread_mutex_unlock@plt>
  444ec4:	02e02025 	move	a0,s7
  444ec8:	0c10dde0 	jal	437780 <_ftext@@Base+0x13fc0>
  444ecc:	02802025 	move	a0,s4
  444ed0:	44960000 	mtc1	s6,$f0
  444ed4:	96420006 	lhu	v0,6(s2)
  444ed8:	46800021 	cvt.d.w	$f0,$f0
  444edc:	44060000 	mfc1	a2,$f0
  444ee0:	44070800 	mfc1	a3,$f1
  444ee4:	1000fafa 	b	443ad0 <cJSON_GetObjectItem@@Base+0x3824>
  444ee8:	a6220006 	sh	v0,6(s1)
  444eec:	00003025 	move	a2,zero
  444ef0:	1000fb76 	b	443ccc <cJSON_GetObjectItem@@Base+0x3a20>
  444ef4:	00003825 	move	a3,zero
  444ef8:	3c05005e 	lui	a1,0x5e
  444efc:	3c04005e 	lui	a0,0x5e
  444f00:	24a525a0 	addiu	a1,a1,9632
  444f04:	0c197bcc 	jal	65ef30 <printf@plt>
  444f08:	24842028 	addiu	a0,a0,8232
  444f0c:	0c10d5fc 	jal	4357f0 <_ftext@@Base+0x12030>
  444f10:	ae9507a8 	sw	s5,1960(s4)
  444f14:	ae820c58 	sw	v0,3160(s4)
  444f18:	00001025 	move	v0,zero
  444f1c:	ae820c30 	sw	v0,3120(s4)
  444f20:	ae820c28 	sw	v0,3112(s4)
  444f24:	96420006 	lhu	v0,6(s2)
  444f28:	ae830c5c 	sw	v1,3164(s4)
  444f2c:	00001825 	move	v1,zero
  444f30:	ae830c34 	sw	v1,3124(s4)
  444f34:	ae830c2c 	sw	v1,3116(s4)
  444f38:	00003025 	move	a2,zero
  444f3c:	00003825 	move	a3,zero
  444f40:	0000a825 	move	s5,zero
  444f44:	1000fae2 	b	443ad0 <cJSON_GetObjectItem@@Base+0x3824>
  444f48:	a6220006 	sh	v0,6(s1)
  444f4c:	3c05005e 	lui	a1,0x5e
  444f50:	3c04005e 	lui	a0,0x5e
  444f54:	00403025 	move	a2,v0
  444f58:	24a525a0 	addiu	a1,a1,9632
  444f5c:	0c197bcc 	jal	65ef30 <printf@plt>
  444f60:	24841e78 	addiu	a0,a0,7800
  444f64:	3c06005e 	lui	a2,0x5e
  444f68:	02a03825 	move	a3,s5
  444f6c:	1000fc8f 	b	4441ac <cJSON_GetObjectItem@@Base+0x3f00>
  444f70:	24c61e98 	addiu	a2,a2,7832
  444f74:	8c420014 	lw	v0,20(v0)
  444f78:	2c430004 	sltiu	v1,v0,4
  444f7c:	1460005c 	bnez	v1,4450f0 <cJSON_GetObjectItem@@Base+0x4e44>
  444f80:	3c03005e 	lui	v1,0x5e
  444f84:	3c07005e 	lui	a3,0x5e
  444f88:	27a400b4 	addiu	a0,sp,180
  444f8c:	1000fb2d 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  444f90:	24e71ec8 	addiu	a3,a3,7880
  444f94:	3c05005e 	lui	a1,0x5e
  444f98:	3c04005e 	lui	a0,0x5e
  444f9c:	00403025 	move	a2,v0
  444fa0:	24a525a0 	addiu	a1,a1,9632
  444fa4:	0c197bcc 	jal	65ef30 <printf@plt>
  444fa8:	24841e3c 	addiu	a0,a0,7740
  444fac:	3c06005e 	lui	a2,0x5e
  444fb0:	02a03825 	move	a3,s5
  444fb4:	1000fc7d 	b	4441ac <cJSON_GetObjectItem@@Base+0x3f00>
  444fb8:	24c61e5c 	addiu	a2,a2,7772
  444fbc:	44861000 	mtc1	a2,$f2
  444fc0:	3c02005e 	lui	v0,0x5e
  444fc4:	d440b468 	ldc1	$f0,-19352(v0)
  444fc8:	44871800 	mtc1	a3,$f3
  444fcc:	46201000 	add.d	$f0,$f2,$f0
  444fd0:	44060000 	mfc1	a2,$f0
  444fd4:	1000fea7 	b	444a74 <cJSON_GetObjectItem@@Base+0x47c8>
  444fd8:	44070800 	mfc1	a3,$f1
  444fdc:	44861000 	mtc1	a2,$f2
  444fe0:	3c02005e 	lui	v0,0x5e
  444fe4:	d440b468 	ldc1	$f0,-19352(v0)
  444fe8:	44871800 	mtc1	a3,$f3
  444fec:	46201000 	add.d	$f0,$f2,$f0
  444ff0:	44060000 	mfc1	a2,$f0
  444ff4:	1000fe75 	b	4449cc <cJSON_GetObjectItem@@Base+0x4720>
  444ff8:	44070800 	mfc1	a3,$f1
  444ffc:	27a400b4 	addiu	a0,sp,180
  445000:	1000fb10 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  445004:	24e7f6c0 	addiu	a3,a3,-2368
  445008:	3c15005e 	lui	s5,0x5e
  44500c:	ae820b9c 	sw	v0,2972(s4)
  445010:	26a52384 	addiu	a1,s5,9092
  445014:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  445018:	02602025 	move	a0,s3
  44501c:	10400004 	beqz	v0,445030 <cJSON_GetObjectItem@@Base+0x4d84>
  445020:	24030010 	li	v1,16
  445024:	8c44000c 	lw	a0,12(v0)
  445028:	10830048 	beq	a0,v1,44514c <cJSON_GetObjectItem@@Base+0x4ea0>
  44502c:	00000000 	nop
  445030:	3c06005e 	lui	a2,0x5e
  445034:	26a72384 	addiu	a3,s5,9092
  445038:	27a400b4 	addiu	a0,sp,180
  44503c:	24c6ff1c 	addiu	a2,a2,-228
  445040:	0c197ca4 	jal	65f290 <snprintf@plt>
  445044:	24050080 	li	a1,128
  445048:	3c05005e 	lui	a1,0x5e
  44504c:	3c04005e 	lui	a0,0x5e
  445050:	27a600b4 	addiu	a2,sp,180
  445054:	24a525a0 	addiu	a1,a1,9632
  445058:	0c197bcc 	jal	65ef30 <printf@plt>
  44505c:	2484ca58 	addiu	a0,a0,-13736
  445060:	3c02005e 	lui	v0,0x5e
  445064:	8c4625c8 	lw	a2,9672(v0)
  445068:	8c4725cc 	lw	a3,9676(v0)
  44506c:	96420006 	lhu	v0,6(s2)
  445070:	0000a825 	move	s5,zero
  445074:	1000fa96 	b	443ad0 <cJSON_GetObjectItem@@Base+0x3824>
  445078:	a6220006 	sh	v0,6(s1)
  44507c:	0c10c4cb 	jal	43132c <_ftext@@Base+0xdb6c>
  445080:	02802025 	move	a0,s4
  445084:	0040a825 	move	s5,v0
  445088:	00003025 	move	a2,zero
  44508c:	1040fafb 	beqz	v0,443c7c <cJSON_GetObjectItem@@Base+0x39d0>
  445090:	00003825 	move	a3,zero
  445094:	3c05005e 	lui	a1,0x5e
  445098:	3c04005e 	lui	a0,0x5e
  44509c:	00403025 	move	a2,v0
  4450a0:	24a525a0 	addiu	a1,a1,9632
  4450a4:	0c197bcc 	jal	65ef30 <printf@plt>
  4450a8:	248421cc 	addiu	a0,a0,8652
  4450ac:	3c06005e 	lui	a2,0x5e
  4450b0:	02a03825 	move	a3,s5
  4450b4:	1000fc3d 	b	4441ac <cJSON_GetObjectItem@@Base+0x3f00>
  4450b8:	24c621e8 	addiu	a2,a2,8680
  4450bc:	3c05005e 	lui	a1,0x5e
  4450c0:	3c04005e 	lui	a0,0x5e
  4450c4:	00403025 	move	a2,v0
  4450c8:	24a525a0 	addiu	a1,a1,9632
  4450cc:	0c197bcc 	jal	65ef30 <printf@plt>
  4450d0:	24841e00 	addiu	a0,a0,7680
  4450d4:	3c06005e 	lui	a2,0x5e
  4450d8:	02a03825 	move	a3,s5
  4450dc:	1000fc33 	b	4441ac <cJSON_GetObjectItem@@Base+0x3f00>
  4450e0:	24c61e20 	addiu	a2,a2,7712
  4450e4:	27a400b4 	addiu	a0,sp,180
  4450e8:	1000fad6 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  4450ec:	24e70068 	addiu	a3,a3,104
  4450f0:	ae820428 	sw	v0,1064(s4)
  4450f4:	24651ed0 	addiu	a1,v1,7888
  4450f8:	02602025 	move	a0,s3
  4450fc:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  445100:	afa3017c 	sw	v1,380(sp)
  445104:	10400004 	beqz	v0,445118 <cJSON_GetObjectItem@@Base+0x4e6c>
  445108:	00000000 	nop
  44510c:	8c5e000c 	lw	s8,12(v0)
  445110:	13d50005 	beq	s8,s5,445128 <cJSON_GetObjectItem@@Base+0x4e7c>
  445114:	00000000 	nop
  445118:	8fa2017c 	lw	v0,380(sp)
  44511c:	27a400b4 	addiu	a0,sp,180
  445120:	1000fac8 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  445124:	24471ed0 	addiu	a3,v0,7888
  445128:	8c430014 	lw	v1,20(v0)
  44512c:	2462e0c0 	addiu	v0,v1,-8000
  445130:	2c421f41 	sltiu	v0,v0,8001
  445134:	14400157 	bnez	v0,445694 <cJSON_GetObjectItem@@Base+0x53e8>
  445138:	3c02005e 	lui	v0,0x5e
  44513c:	3c07005e 	lui	a3,0x5e
  445140:	27a400b4 	addiu	a0,sp,180
  445144:	1000fabf 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  445148:	24e71edc 	addiu	a3,a3,7900
  44514c:	8c450010 	lw	a1,16(v0)
  445150:	24060021 	li	a2,33
  445154:	0c197bb0 	jal	65eec0 <strncpy@plt>
  445158:	26840bc5 	addiu	a0,s4,3013
  44515c:	8e820b94 	lw	v0,2964(s4)
  445160:	44820000 	mtc1	v0,$f0
  445164:	46800021 	cvt.d.w	$f0,$f0
  445168:	44060000 	mfc1	a2,$f0
  44516c:	04400205 	bltz	v0,445984 <cJSON_GetObjectItem@@Base+0x56d8>
  445170:	44070800 	mfc1	a3,$f1
  445174:	3c05005e 	lui	a1,0x5e
  445178:	02002025 	move	a0,s0
  44517c:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  445180:	24a5e3b0 	addiu	a1,a1,-7248
  445184:	c6800ba0 	lwc1	$f0,2976(s4)
  445188:	3c05005e 	lui	a1,0x5e
  44518c:	02002025 	move	a0,s0
  445190:	46800021 	cvt.d.w	$f0,$f0
  445194:	44060000 	mfc1	a2,$f0
  445198:	44070800 	mfc1	a3,$f1
  44519c:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  4451a0:	24a52420 	addiu	a1,a1,9248
  4451a4:	3c05005e 	lui	a1,0x5e
  4451a8:	02002025 	move	a0,s0
  4451ac:	26860ba4 	addiu	a2,s4,2980
  4451b0:	0c11038d 	jal	440e34 <cJSON_GetObjectItem@@Base+0xb88>
  4451b4:	24a5242c 	addiu	a1,a1,9260
  4451b8:	3c05005e 	lui	a1,0x5e
  4451bc:	02002025 	move	a0,s0
  4451c0:	26860b50 	addiu	a2,s4,2896
  4451c4:	0c11038d 	jal	440e34 <cJSON_GetObjectItem@@Base+0xb88>
  4451c8:	24a52438 	addiu	a1,a1,9272
  4451cc:	3c05005e 	lui	a1,0x5e
  4451d0:	26860b71 	addiu	a2,s4,2929
  4451d4:	24a52444 	addiu	a1,a1,9284
  4451d8:	0c11038d 	jal	440e34 <cJSON_GetObjectItem@@Base+0xb88>
  4451dc:	02002025 	move	a0,s0
  4451e0:	0c10d5fc 	jal	4357f0 <_ftext@@Base+0x12030>
  4451e4:	0000a825 	move	s5,zero
  4451e8:	ae820c10 	sw	v0,3088(s4)
  4451ec:	96420006 	lhu	v0,6(s2)
  4451f0:	ae830c14 	sw	v1,3092(s4)
  4451f4:	00003025 	move	a2,zero
  4451f8:	00003825 	move	a3,zero
  4451fc:	1000fa34 	b	443ad0 <cJSON_GetObjectItem@@Base+0x3824>
  445200:	a6220006 	sh	v0,6(s1)
  445204:	26e5f640 	addiu	a1,s7,-2496
  445208:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  44520c:	02602025 	move	a0,s3
  445210:	10400004 	beqz	v0,445224 <cJSON_GetObjectItem@@Base+0x4f78>
  445214:	00000000 	nop
  445218:	8c43000c 	lw	v1,12(v0)
  44521c:	107e0004 	beq	v1,s8,445230 <cJSON_GetObjectItem@@Base+0x4f84>
  445220:	00000000 	nop
  445224:	27a400b4 	addiu	a0,sp,180
  445228:	1000fa86 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  44522c:	26e7f640 	addiu	a3,s7,-2496
  445230:	d4580018 	ldc1	$f24,24(v0)
  445234:	4636c63c 	c.lt.d	$fcc6,$f24,$f22
  445238:	45190004 	bc1t	$fcc6,44524c <cJSON_GetObjectItem@@Base+0x4fa0>
  44523c:	d6c0fce0 	ldc1	$f0,-800(s6)
  445240:	4638013c 	c.lt.d	$fcc1,$f0,$f24
  445244:	450401b5 	bc1f	$fcc1,44591c <cJSON_GetObjectItem@@Base+0x5670>
  445248:	00000000 	nop
  44524c:	3c07005e 	lui	a3,0x5e
  445250:	27a400b4 	addiu	a0,sp,180
  445254:	1000fa7b 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  445258:	24e7f700 	addiu	a3,a3,-2304
  44525c:	8c650010 	lw	a1,16(v1)
  445260:	24060021 	li	a2,33
  445264:	268406cc 	addiu	a0,s4,1740
  445268:	0c197bb0 	jal	65eec0 <strncpy@plt>
  44526c:	afa3017c 	sw	v1,380(sp)
  445270:	8fa3017c 	lw	v1,380(sp)
  445274:	3c040066 	lui	a0,0x66
  445278:	24060021 	li	a2,33
  44527c:	8c650010 	lw	a1,16(v1)
  445280:	0c197bb0 	jal	65eec0 <strncpy@plt>
  445284:	24844c30 	addiu	a0,a0,19504
  445288:	3c08005e 	lui	t0,0x5e
  44528c:	2505e3a4 	addiu	a1,t0,-7260
  445290:	02602025 	move	a0,s3
  445294:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  445298:	afa8017c 	sw	t0,380(sp)
  44529c:	10400005 	beqz	v0,4452b4 <cJSON_GetObjectItem@@Base+0x5008>
  4452a0:	8fa8017c 	lw	t0,380(sp)
  4452a4:	8c44000c 	lw	a0,12(v0)
  4452a8:	24030008 	li	v1,8
  4452ac:	10830004 	beq	a0,v1,4452c0 <cJSON_GetObjectItem@@Base+0x5014>
  4452b0:	00000000 	nop
  4452b4:	27a400b4 	addiu	a0,sp,180
  4452b8:	1000fa62 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  4452bc:	2507e3a4 	addiu	a3,t0,-7260
  4452c0:	8c420014 	lw	v0,20(v0)
  4452c4:	afa8017c 	sw	t0,380(sp)
  4452c8:	00021fc3 	sra	v1,v0,0x1f
  4452cc:	00602825 	move	a1,v1
  4452d0:	ae830834 	sw	v1,2100(s4)
  4452d4:	00402025 	move	a0,v0
  4452d8:	0c10d638 	jal	4358e0 <_ftext@@Base+0x12120>
  4452dc:	ae820830 	sw	v0,2096(s4)
  4452e0:	3c06005e 	lui	a2,0x5e
  4452e4:	02002025 	move	a0,s0
  4452e8:	24c6dc4c 	addiu	a2,a2,-9140
  4452ec:	0c11038d 	jal	440e34 <cJSON_GetObjectItem@@Base+0xb88>
  4452f0:	26a51cb8 	addiu	a1,s5,7352
  4452f4:	3c06005e 	lui	a2,0x5e
  4452f8:	02002025 	move	a0,s0
  4452fc:	24c6dccc 	addiu	a2,a2,-9012
  445300:	0c11038d 	jal	440e34 <cJSON_GetObjectItem@@Base+0xb88>
  445304:	26c5203c 	addiu	a1,s6,8252
  445308:	02002025 	move	a0,s0
  44530c:	268606ed 	addiu	a2,s4,1773
  445310:	0c11038d 	jal	440e34 <cJSON_GetObjectItem@@Base+0xb88>
  445314:	26e5fe38 	addiu	a1,s7,-456
  445318:	8fa20178 	lw	v0,376(sp)
  44531c:	3c06005e 	lui	a2,0x5e
  445320:	02002025 	move	a0,s0
  445324:	24c6cdc0 	addiu	a2,a2,-12864
  445328:	0c11038d 	jal	440e34 <cJSON_GetObjectItem@@Base+0xb88>
  44532c:	244500c0 	addiu	a1,v0,192
  445330:	92860712 	lbu	a2,1810(s4)
  445334:	92890713 	lbu	t1,1811(s4)
  445338:	92830710 	lbu	v1,1808(s4)
  44533c:	92850711 	lbu	a1,1809(s4)
  445340:	9282070f 	lbu	v0,1807(s4)
  445344:	9287070e 	lbu	a3,1806(s4)
  445348:	afa6001c 	sw	a2,28(sp)
  44534c:	3c06005e 	lui	a2,0x5e
  445350:	afa90020 	sw	t1,32(sp)
  445354:	afa30014 	sw	v1,20(sp)
  445358:	27a40134 	addiu	a0,sp,308
  44535c:	afa50018 	sw	a1,24(sp)
  445360:	24c6febc 	addiu	a2,a2,-324
  445364:	24050040 	li	a1,64
  445368:	0c197ca4 	jal	65f290 <snprintf@plt>
  44536c:	afa20010 	sw	v0,16(sp)
  445370:	27a60134 	addiu	a2,sp,308
  445374:	02002025 	move	a0,s0
  445378:	0c11038d 	jal	440e34 <cJSON_GetObjectItem@@Base+0xb88>
  44537c:	27c5fef4 	addiu	a1,s8,-268
  445380:	c6800750 	lwc1	$f0,1872(s4)
  445384:	3c05005e 	lui	a1,0x5e
  445388:	02002025 	move	a0,s0
  44538c:	46800021 	cvt.d.w	$f0,$f0
  445390:	44060000 	mfc1	a2,$f0
  445394:	44070800 	mfc1	a3,$f1
  445398:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  44539c:	24a5240c 	addiu	a1,a1,9228
  4453a0:	0c10d60f 	jal	43583c <_ftext@@Base+0x1207c>
  4453a4:	00000000 	nop
  4453a8:	3c06000f 	lui	a2,0xf
  4453ac:	34c64240 	ori	a2,a2,0x4240
  4453b0:	00003825 	move	a3,zero
  4453b4:	00402025 	move	a0,v0
  4453b8:	0c197dcc 	jal	65f730 <__udivdi3@plt>
  4453bc:	00602825 	move	a1,v1
  4453c0:	00602825 	move	a1,v1
  4453c4:	0c197cdc 	jal	65f370 <__floatundidf@plt>
  4453c8:	00402025 	move	a0,v0
  4453cc:	8fa8017c 	lw	t0,380(sp)
  4453d0:	44060000 	mfc1	a2,$f0
  4453d4:	44070800 	mfc1	a3,$f1
  4453d8:	2505e3a4 	addiu	a1,t0,-7260
  4453dc:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  4453e0:	02002025 	move	a0,s0
  4453e4:	8e860888 	lw	a2,2184(s4)
  4453e8:	3c05005e 	lui	a1,0x5e
  4453ec:	02002025 	move	a0,s0
  4453f0:	0006302b 	sltu	a2,zero,a2
  4453f4:	44860000 	mtc1	a2,$f0
  4453f8:	a2860768 	sb	a2,1896(s4)
  4453fc:	46800021 	cvt.d.w	$f0,$f0
  445400:	44060000 	mfc1	a2,$f0
  445404:	44070800 	mfc1	a3,$f1
  445408:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  44540c:	24a5f60c 	addiu	a1,a1,-2548
  445410:	8e840884 	lw	a0,2180(s4)
  445414:	10800163 	beqz	a0,4459a4 <cJSON_GetObjectItem@@Base+0x56f8>
  445418:	00000000 	nop
  44541c:	0c10bf52 	jal	42fd48 <_ftext@@Base+0xc588>
  445420:	27a50030 	addiu	a1,sp,48
  445424:	8fa20040 	lw	v0,64(sp)
  445428:	38420001 	xori	v0,v0,0x1
  44542c:	2c420001 	sltiu	v0,v0,1
  445430:	a2820769 	sb	v0,1897(s4)
  445434:	82860769 	lb	a2,1897(s4)
  445438:	3c05005e 	lui	a1,0x5e
  44543c:	24a5f5f4 	addiu	a1,a1,-2572
  445440:	44860000 	mtc1	a2,$f0
  445444:	02002025 	move	a0,s0
  445448:	46800021 	cvt.d.w	$f0,$f0
  44544c:	44060000 	mfc1	a2,$f0
  445450:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  445454:	44070800 	mfc1	a3,$f1
  445458:	8e82076c 	lw	v0,1900(s4)
  44545c:	44820000 	mtc1	v0,$f0
  445460:	46800021 	cvt.d.w	$f0,$f0
  445464:	44060000 	mfc1	a2,$f0
  445468:	04400171 	bltz	v0,445a30 <cJSON_GetObjectItem@@Base+0x5784>
  44546c:	44070800 	mfc1	a3,$f1
  445470:	3c05005e 	lui	a1,0x5e
  445474:	24a5e38c 	addiu	a1,a1,-7284
  445478:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  44547c:	02002025 	move	a0,s0
  445480:	8e820770 	lw	v0,1904(s4)
  445484:	44820000 	mtc1	v0,$f0
  445488:	46800021 	cvt.d.w	$f0,$f0
  44548c:	44060000 	mfc1	a2,$f0
  445490:	04400180 	bltz	v0,445a94 <cJSON_GetObjectItem@@Base+0x57e8>
  445494:	44070800 	mfc1	a3,$f1
  445498:	3c05005e 	lui	a1,0x5e
  44549c:	24a51cc0 	addiu	a1,a1,7360
  4454a0:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  4454a4:	02002025 	move	a0,s0
  4454a8:	8e840ce4 	lw	a0,3300(s4)
  4454ac:	0c10d9ca 	jal	436728 <_ftext@@Base+0x12f68>
  4454b0:	0000a825 	move	s5,zero
  4454b4:	44060000 	mfc1	a2,$f0
  4454b8:	44070800 	mfc1	a3,$f1
  4454bc:	3c05005e 	lui	a1,0x5e
  4454c0:	f6800778 	sdc1	$f0,1912(s4)
  4454c4:	02002025 	move	a0,s0
  4454c8:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  4454cc:	24a51ccc 	addiu	a1,a1,7372
  4454d0:	8e860788 	lw	a2,1928(s4)
  4454d4:	8e87078c 	lw	a3,1932(s4)
  4454d8:	3c05005e 	lui	a1,0x5e
  4454dc:	02002025 	move	a0,s0
  4454e0:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  4454e4:	24a5e398 	addiu	a1,a1,-7272
  4454e8:	8e8607a0 	lw	a2,1952(s4)
  4454ec:	8e8707a4 	lw	a3,1956(s4)
  4454f0:	3c05005e 	lui	a1,0x5e
  4454f4:	02002025 	move	a0,s0
  4454f8:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  4454fc:	24a51cdc 	addiu	a1,a1,7388
  445500:	8e860790 	lw	a2,1936(s4)
  445504:	8e870794 	lw	a3,1940(s4)
  445508:	3c05005e 	lui	a1,0x5e
  44550c:	02002025 	move	a0,s0
  445510:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  445514:	24a51ce8 	addiu	a1,a1,7400
  445518:	0c10d5fc 	jal	4357f0 <_ftext@@Base+0x12030>
  44551c:	00000000 	nop
  445520:	3c04005e 	lui	a0,0x5e
  445524:	ae820c28 	sw	v0,3112(s4)
  445528:	ae830c2c 	sw	v1,3116(s4)
  44552c:	0c197c44 	jal	65f110 <puts@plt>
  445530:	24841cf4 	addiu	a0,a0,7412
  445534:	96420006 	lhu	v0,6(s2)
  445538:	00003025 	move	a2,zero
  44553c:	00003825 	move	a3,zero
  445540:	1000f963 	b	443ad0 <cJSON_GetObjectItem@@Base+0x3824>
  445544:	a6220006 	sh	v0,6(s1)
  445548:	44861000 	mtc1	a2,$f2
  44554c:	3c02005e 	lui	v0,0x5e
  445550:	d440b468 	ldc1	$f0,-19352(v0)
  445554:	44871800 	mtc1	a3,$f3
  445558:	46201000 	add.d	$f0,$f2,$f0
  44555c:	44060000 	mfc1	a2,$f0
  445560:	1000fe35 	b	444e38 <cJSON_GetObjectItem@@Base+0x4b8c>
  445564:	44070800 	mfc1	a3,$f1
  445568:	44861000 	mtc1	a2,$f2
  44556c:	3c02005e 	lui	v0,0x5e
  445570:	d440b468 	ldc1	$f0,-19352(v0)
  445574:	44871800 	mtc1	a3,$f3
  445578:	46201000 	add.d	$f0,$f2,$f0
  44557c:	44060000 	mfc1	a2,$f0
  445580:	1000fe19 	b	444de8 <cJSON_GetObjectItem@@Base+0x4b3c>
  445584:	44070800 	mfc1	a3,$f1
  445588:	44861000 	mtc1	a2,$f2
  44558c:	3c02005e 	lui	v0,0x5e
  445590:	d440b468 	ldc1	$f0,-19352(v0)
  445594:	44871800 	mtc1	a3,$f3
  445598:	46201000 	add.d	$f0,$f2,$f0
  44559c:	44060000 	mfc1	a2,$f0
  4455a0:	1000fe1b 	b	444e10 <cJSON_GetObjectItem@@Base+0x4b64>
  4455a4:	44070800 	mfc1	a3,$f1
  4455a8:	00003025 	move	a2,zero
  4455ac:	1000fdf5 	b	444d84 <cJSON_GetObjectItem@@Base+0x4ad8>
  4455b0:	00003825 	move	a3,zero
  4455b4:	3c05005e 	lui	a1,0x5e
  4455b8:	3c04005e 	lui	a0,0x5e
  4455bc:	00403025 	move	a2,v0
  4455c0:	24a525a0 	addiu	a1,a1,9632
  4455c4:	0c197bcc 	jal	65ef30 <printf@plt>
  4455c8:	24841dcc 	addiu	a0,a0,7628
  4455cc:	3c06005e 	lui	a2,0x5e
  4455d0:	02a03825 	move	a3,s5
  4455d4:	24c61de8 	addiu	a2,a2,7656
  4455d8:	24050080 	li	a1,128
  4455dc:	27a400b4 	addiu	a0,sp,180
  4455e0:	0c197ca4 	jal	65f290 <snprintf@plt>
  4455e4:	24160001 	li	s6,1
  4455e8:	1000fe35 	b	444ec0 <cJSON_GetObjectItem@@Base+0x4c14>
  4455ec:	00000000 	nop
  4455f0:	8e820888 	lw	v0,2184(s4)
  4455f4:	1040fe29 	beqz	v0,444e9c <cJSON_GetObjectItem@@Base+0x4bf0>
  4455f8:	3c1e005e 	lui	s8,0x5e
  4455fc:	3c04005e 	lui	a0,0x5e
  445600:	27c525a0 	addiu	a1,s8,9632
  445604:	2484d018 	addiu	a0,a0,-12264
  445608:	0c197bcc 	jal	65ef30 <printf@plt>
  44560c:	a3a00030 	sb	zero,48(sp)
  445610:	0c10c66f 	jal	4319bc <_ftext@@Base+0xe1fc>
  445614:	26840888 	addiu	a0,s4,2184
  445618:	27a60030 	addiu	a2,sp,48
  44561c:	24052005 	li	a1,8197
  445620:	0c10c524 	jal	431490 <_ftext@@Base+0xdcd0>
  445624:	02802025 	move	a0,s4
  445628:	1040fe1c 	beqz	v0,444e9c <cJSON_GetObjectItem@@Base+0x4bf0>
  44562c:	3c04005e 	lui	a0,0x5e
  445630:	27c525a0 	addiu	a1,s8,9632
  445634:	0c197bcc 	jal	65ef30 <printf@plt>
  445638:	248414b0 	addiu	a0,a0,5296
  44563c:	1000fe18 	b	444ea0 <cJSON_GetObjectItem@@Base+0x4bf4>
  445640:	8e840884 	lw	a0,2180(s4)
  445644:	3c05005e 	lui	a1,0x5e
  445648:	3c04005e 	lui	a0,0x5e
  44564c:	24a525a0 	addiu	a1,a1,9632
  445650:	0c197bcc 	jal	65ef30 <printf@plt>
  445654:	24841a8c 	addiu	a0,a0,6796
  445658:	8e840884 	lw	a0,2180(s4)
  44565c:	2407ffff 	li	a3,-1
  445660:	afa00010 	sw	zero,16(sp)
  445664:	2406ffff 	li	a2,-1
  445668:	0c10be81 	jal	42fa04 <_ftext@@Base+0xc244>
  44566c:	24050001 	li	a1,1
  445670:	3c02005e 	lui	v0,0x5e
  445674:	afa20178 	sw	v0,376(sp)
  445678:	3c02005e 	lui	v0,0x5e
  44567c:	afa2017c 	sw	v0,380(sp)
  445680:	3c02005e 	lui	v0,0x5e
  445684:	a2800c9c 	sb	zero,3228(s4)
  445688:	3c16005e 	lui	s6,0x5e
  44568c:	1000fdb6 	b	444d68 <cJSON_GetObjectItem@@Base+0x4abc>
  445690:	afa20180 	sw	v0,384(sp)
  445694:	ae830424 	sw	v1,1060(s4)
  445698:	24451eec 	addiu	a1,v0,7916
  44569c:	02602025 	move	a0,s3
  4456a0:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  4456a4:	afa20180 	sw	v0,384(sp)
  4456a8:	10400004 	beqz	v0,4456bc <cJSON_GetObjectItem@@Base+0x5410>
  4456ac:	00000000 	nop
  4456b0:	8c43000c 	lw	v1,12(v0)
  4456b4:	107e0012 	beq	v1,s8,445700 <cJSON_GetObjectItem@@Base+0x5454>
  4456b8:	00000000 	nop
  4456bc:	8fa20180 	lw	v0,384(sp)
  4456c0:	27a400b4 	addiu	a0,sp,180
  4456c4:	1000f95f 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  4456c8:	24471eec 	addiu	a3,v0,7916
  4456cc:	24030002 	li	v1,2
  4456d0:	1443fba9 	bne	v0,v1,444578 <cJSON_GetObjectItem@@Base+0x42cc>
  4456d4:	3c04005e 	lui	a0,0x5e
  4456d8:	26c525a0 	addiu	a1,s6,9632
  4456dc:	0c197bcc 	jal	65ef30 <printf@plt>
  4456e0:	24842280 	addiu	a0,a0,8832
  4456e4:	2402000e 	li	v0,14
  4456e8:	ae820b94 	sw	v0,2964(s4)
  4456ec:	24050003 	li	a1,3
  4456f0:	0c108e24 	jal	423890 <_ftext@@Base+0xd0>
  4456f4:	26840be8 	addiu	a0,s4,3048
  4456f8:	1000fb9f 	b	444578 <cJSON_GetObjectItem@@Base+0x42cc>
  4456fc:	00000000 	nop
  445700:	8c420014 	lw	v0,20(v0)
  445704:	2c430801 	sltiu	v1,v0,2049
  445708:	106000a8 	beqz	v1,4459ac <cJSON_GetObjectItem@@Base+0x5700>
  44570c:	269e0cec 	addiu	s8,s4,3308
  445710:	03c02025 	move	a0,s8
  445714:	0c197d74 	jal	65f5d0 <pthread_mutex_lock@plt>
  445718:	ae82042c 	sw	v0,1068(s4)
  44571c:	8e840884 	lw	a0,2180(s4)
  445720:	10800026 	beqz	a0,4457bc <cJSON_GetObjectItem@@Base+0x5510>
  445724:	00000000 	nop
  445728:	0c10bf52 	jal	42fd48 <_ftext@@Base+0xc588>
  44572c:	27a50030 	addiu	a1,sp,48
  445730:	8fa30040 	lw	v1,64(sp)
  445734:	24020001 	li	v0,1
  445738:	10620010 	beq	v1,v0,44577c <cJSON_GetObjectItem@@Base+0x54d0>
  44573c:	3c04005e 	lui	a0,0x5e
  445740:	241500ca 	li	s5,202
  445744:	14600003 	bnez	v1,445754 <cJSON_GetObjectItem@@Base+0x54a8>
  445748:	8fa20060 	lw	v0,96(sp)
  44574c:	1040001b 	beqz	v0,4457bc <cJSON_GetObjectItem@@Base+0x5510>
  445750:	00000000 	nop
  445754:	8e840884 	lw	a0,2180(s4)
  445758:	27a50030 	addiu	a1,sp,48
  44575c:	0c10bf52 	jal	42fd48 <_ftext@@Base+0xc588>
  445760:	26b5ffff 	addiu	s5,s5,-1
  445764:	12a00034 	beqz	s5,445838 <cJSON_GetObjectItem@@Base+0x558c>
  445768:	3c04005e 	lui	a0,0x5e
  44576c:	0c197e14 	jal	65f850 <usleep@plt>
  445770:	240403e8 	li	a0,1000
  445774:	1000fff3 	b	445744 <cJSON_GetObjectItem@@Base+0x5498>
  445778:	8fa30040 	lw	v1,64(sp)
  44577c:	3c05005e 	lui	a1,0x5e
  445780:	24a525a0 	addiu	a1,a1,9632
  445784:	24841f04 	addiu	a0,a0,7940
  445788:	0c197bcc 	jal	65ef30 <printf@plt>
  44578c:	afa30188 	sw	v1,392(sp)
  445790:	8fa30188 	lw	v1,392(sp)
  445794:	8e840884 	lw	a0,2180(s4)
  445798:	2407ffff 	li	a3,-1
  44579c:	a2830c9c 	sb	v1,3228(s4)
  4457a0:	2406ffff 	li	a2,-1
  4457a4:	afa00010 	sw	zero,16(sp)
  4457a8:	00002825 	move	a1,zero
  4457ac:	0c10be81 	jal	42fa04 <_ftext@@Base+0xc244>
  4457b0:	241500ca 	li	s5,202
  4457b4:	1000ffe3 	b	445744 <cJSON_GetObjectItem@@Base+0x5498>
  4457b8:	8fa30040 	lw	v1,64(sp)
  4457bc:	8e840888 	lw	a0,2184(s4)
  4457c0:	1080007e 	beqz	a0,4459bc <cJSON_GetObjectItem@@Base+0x5710>
  4457c4:	8fa20184 	lw	v0,388(sp)
  4457c8:	1040fd67 	beqz	v0,444d68 <cJSON_GetObjectItem@@Base+0x4abc>
  4457cc:	00000000 	nop
  4457d0:	8e860434 	lw	a2,1076(s4)
  4457d4:	0c10c7b8 	jal	431ee0 <_ftext@@Base+0xe720>
  4457d8:	8e850430 	lw	a1,1072(s4)
  4457dc:	1040fd62 	beqz	v0,444d68 <cJSON_GetObjectItem@@Base+0x4abc>
  4457e0:	0040a825 	move	s5,v0
  4457e4:	3c05005e 	lui	a1,0x5e
  4457e8:	3c04005e 	lui	a0,0x5e
  4457ec:	00403025 	move	a2,v0
  4457f0:	24a525a0 	addiu	a1,a1,9632
  4457f4:	0c197bcc 	jal	65ef30 <printf@plt>
  4457f8:	24841f68 	addiu	a0,a0,8040
  4457fc:	3c06005e 	lui	a2,0x5e
  445800:	27a400b4 	addiu	a0,sp,180
  445804:	02a03825 	move	a3,s5
  445808:	24c61f8c 	addiu	a2,a2,8076
  44580c:	0c197ca4 	jal	65f290 <snprintf@plt>
  445810:	24050080 	li	a1,128
  445814:	03c02025 	move	a0,s8
  445818:	0c197ce4 	jal	65f390 <pthread_mutex_unlock@plt>
  44581c:	00000000 	nop
  445820:	3c02005e 	lui	v0,0x5e
  445824:	8c46d6c0 	lw	a2,-10560(v0)
  445828:	8c47d6c4 	lw	a3,-10556(v0)
  44582c:	96420006 	lhu	v0,6(s2)
  445830:	1000f8a7 	b	443ad0 <cJSON_GetObjectItem@@Base+0x3824>
  445834:	a6220006 	sh	v0,6(s1)
  445838:	3c05005e 	lui	a1,0x5e
  44583c:	24a525a0 	addiu	a1,a1,9632
  445840:	0c197bcc 	jal	65ef30 <printf@plt>
  445844:	248404e0 	addiu	a0,a0,1248
  445848:	3c03005e 	lui	v1,0x5e
  44584c:	24620500 	addiu	v0,v1,1280
  445850:	8c6a0500 	lw	t2,1280(v1)
  445854:	8c490004 	lw	t1,4(v0)
  445858:	8c480008 	lw	t0,8(v0)
  44585c:	8c47000c 	lw	a3,12(v0)
  445860:	8c460010 	lw	a2,16(v0)
  445864:	8c450014 	lw	a1,20(v0)
  445868:	94430018 	lhu	v1,24(v0)
  44586c:	9042001a 	lbu	v0,26(v0)
  445870:	03c02025 	move	a0,s8
  445874:	afaa00b4 	sw	t2,180(sp)
  445878:	afa900b8 	sw	t1,184(sp)
  44587c:	afa800bc 	sw	t0,188(sp)
  445880:	afa700c0 	sw	a3,192(sp)
  445884:	afa600c4 	sw	a2,196(sp)
  445888:	afa500c8 	sw	a1,200(sp)
  44588c:	a7a300cc 	sh	v1,204(sp)
  445890:	1000ffe1 	b	445818 <cJSON_GetObjectItem@@Base+0x556c>
  445894:	a3a200ce 	sb	v0,206(sp)
  445898:	3c04005e 	lui	a0,0x5e
  44589c:	26c525a0 	addiu	a1,s6,9632
  4458a0:	0c197bcc 	jal	65ef30 <printf@plt>
  4458a4:	248422b8 	addiu	a0,a0,8888
  4458a8:	2402000f 	li	v0,15
  4458ac:	ae820b94 	sw	v0,2964(s4)
  4458b0:	24050004 	li	a1,4
  4458b4:	0c108e24 	jal	423890 <_ftext@@Base+0xd0>
  4458b8:	26840be8 	addiu	a0,s4,3048
  4458bc:	1000fb2e 	b	444578 <cJSON_GetObjectItem@@Base+0x42cc>
  4458c0:	00000000 	nop
  4458c4:	3c04005e 	lui	a0,0x5e
  4458c8:	26c525a0 	addiu	a1,s6,9632
  4458cc:	0c197bcc 	jal	65ef30 <printf@plt>
  4458d0:	248422f8 	addiu	a0,a0,8952
  4458d4:	24020010 	li	v0,16
  4458d8:	0c10d5fc 	jal	4357f0 <_ftext@@Base+0x12030>
  4458dc:	ae820b94 	sw	v0,2964(s4)
  4458e0:	ae820c08 	sw	v0,3080(s4)
  4458e4:	ae830c0c 	sw	v1,3084(s4)
  4458e8:	24050005 	li	a1,5
  4458ec:	0c108e24 	jal	423890 <_ftext@@Base+0xd0>
  4458f0:	26840be8 	addiu	a0,s4,3048
  4458f4:	1000fb20 	b	444578 <cJSON_GetObjectItem@@Base+0x42cc>
  4458f8:	00000000 	nop
  4458fc:	3c04005e 	lui	a0,0x5e
  445900:	26c525a0 	addiu	a1,s6,9632
  445904:	0c197bcc 	jal	65ef30 <printf@plt>
  445908:	2484e370 	addiu	a0,a0,-7312
  44590c:	0000a025 	move	s4,zero
  445910:	8e220014 	lw	v0,20(s1)
  445914:	1000f88d 	b	443b4c <cJSON_GetObjectItem@@Base+0x38a0>
  445918:	2415ffff 	li	s5,-1
  44591c:	3c16005e 	lui	s6,0x5e
  445920:	26c51fac 	addiu	a1,s6,8108
  445924:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  445928:	02602025 	move	a0,s3
  44592c:	10400004 	beqz	v0,445940 <cJSON_GetObjectItem@@Base+0x5694>
  445930:	24030008 	li	v1,8
  445934:	8c5e000c 	lw	s8,12(v0)
  445938:	13c30004 	beq	s8,v1,44594c <cJSON_GetObjectItem@@Base+0x56a0>
  44593c:	00000000 	nop
  445940:	27a400b4 	addiu	a0,sp,180
  445944:	1000f8bf 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  445948:	26c71fac 	addiu	a3,s6,8108
  44594c:	44800000 	mtc1	zero,$f0
  445950:	d4560018 	ldc1	$f22,24(v0)
  445954:	44800800 	mtc1	zero,$f1
  445958:	4620b73c 	c.lt.d	$fcc7,$f22,$f0
  44595c:	451d0005 	bc1t	$fcc7,445974 <cJSON_GetObjectItem@@Base+0x56c8>
  445960:	3c02005e 	lui	v0,0x5e
  445964:	d440ad20 	ldc1	$f0,-21216(v0)
  445968:	4636023c 	c.lt.d	$fcc2,$f0,$f22
  44596c:	4508003d 	bc1f	$fcc2,445a64 <cJSON_GetObjectItem@@Base+0x57b8>
  445970:	00000000 	nop
  445974:	3c07005e 	lui	a3,0x5e
  445978:	27a400b4 	addiu	a0,sp,180
  44597c:	1000f8b1 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  445980:	24e71fc0 	addiu	a3,a3,8128
  445984:	44861000 	mtc1	a2,$f2
  445988:	3c02005e 	lui	v0,0x5e
  44598c:	d440b468 	ldc1	$f0,-19352(v0)
  445990:	44871800 	mtc1	a3,$f3
  445994:	46201000 	add.d	$f0,$f2,$f0
  445998:	44060000 	mfc1	a2,$f0
  44599c:	1000fdf5 	b	445174 <cJSON_GetObjectItem@@Base+0x4ec8>
  4459a0:	44070800 	mfc1	a3,$f1
  4459a4:	1000fea3 	b	445434 <cJSON_GetObjectItem@@Base+0x5188>
  4459a8:	a2800769 	sb	zero,1897(s4)
  4459ac:	3c07005e 	lui	a3,0x5e
  4459b0:	27a400b4 	addiu	a0,sp,180
  4459b4:	1000f8a3 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  4459b8:	24e71ef8 	addiu	a3,a3,7928
  4459bc:	3c060044 	lui	a2,0x44
  4459c0:	02803825 	move	a3,s4
  4459c4:	24c62560 	addiu	a2,a2,9568
  4459c8:	26850420 	addiu	a1,s4,1056
  4459cc:	0c10c6ba 	jal	431ae8 <_ftext@@Base+0xe328>
  4459d0:	26840888 	addiu	a0,s4,2184
  4459d4:	1040001e 	beqz	v0,445a50 <cJSON_GetObjectItem@@Base+0x57a4>
  4459d8:	0040a825 	move	s5,v0
  4459dc:	3c05005e 	lui	a1,0x5e
  4459e0:	3c04005e 	lui	a0,0x5e
  4459e4:	24a525a0 	addiu	a1,a1,9632
  4459e8:	0c197bcc 	jal	65ef30 <printf@plt>
  4459ec:	24841f34 	addiu	a0,a0,7988
  4459f0:	3c03005e 	lui	v1,0x5e
  4459f4:	24621f50 	addiu	v0,v1,8016
  4459f8:	8c681f50 	lw	t0,8016(v1)
  4459fc:	8c470004 	lw	a3,4(v0)
  445a00:	8c460008 	lw	a2,8(v0)
  445a04:	8c45000c 	lw	a1,12(v0)
  445a08:	8c430010 	lw	v1,16(v0)
  445a0c:	90420014 	lbu	v0,20(v0)
  445a10:	03c02025 	move	a0,s8
  445a14:	afa800b4 	sw	t0,180(sp)
  445a18:	afa700b8 	sw	a3,184(sp)
  445a1c:	afa600bc 	sw	a2,188(sp)
  445a20:	afa500c0 	sw	a1,192(sp)
  445a24:	afa300c4 	sw	v1,196(sp)
  445a28:	1000ff7b 	b	445818 <cJSON_GetObjectItem@@Base+0x556c>
  445a2c:	a3a200c8 	sb	v0,200(sp)
  445a30:	44861000 	mtc1	a2,$f2
  445a34:	3c02005e 	lui	v0,0x5e
  445a38:	d440b468 	ldc1	$f0,-19352(v0)
  445a3c:	44871800 	mtc1	a3,$f3
  445a40:	46201000 	add.d	$f0,$f2,$f0
  445a44:	44060000 	mfc1	a2,$f0
  445a48:	1000fe89 	b	445470 <cJSON_GetObjectItem@@Base+0x51c4>
  445a4c:	44070800 	mfc1	a3,$f1
  445a50:	0c10d5fc 	jal	4357f0 <_ftext@@Base+0x12030>
  445a54:	00000000 	nop
  445a58:	ae820c38 	sw	v0,3128(s4)
  445a5c:	1000fcc2 	b	444d68 <cJSON_GetObjectItem@@Base+0x4abc>
  445a60:	ae830c3c 	sw	v1,3132(s4)
  445a64:	3c16005e 	lui	s6,0x5e
  445a68:	26c5f654 	addiu	a1,s6,-2476
  445a6c:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  445a70:	02602025 	move	a0,s3
  445a74:	10400004 	beqz	v0,445a88 <cJSON_GetObjectItem@@Base+0x57dc>
  445a78:	00000000 	nop
  445a7c:	8c57000c 	lw	s7,12(v0)
  445a80:	12fe000c 	beq	s7,s8,445ab4 <cJSON_GetObjectItem@@Base+0x5808>
  445a84:	00000000 	nop
  445a88:	27a400b4 	addiu	a0,sp,180
  445a8c:	1000f86d 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  445a90:	26c7f654 	addiu	a3,s6,-2476
  445a94:	44861000 	mtc1	a2,$f2
  445a98:	3c02005e 	lui	v0,0x5e
  445a9c:	d440b468 	ldc1	$f0,-19352(v0)
  445aa0:	44871800 	mtc1	a3,$f3
  445aa4:	46201000 	add.d	$f0,$f2,$f0
  445aa8:	44060000 	mfc1	a2,$f0
  445aac:	1000fe7a 	b	445498 <cJSON_GetObjectItem@@Base+0x51ec>
  445ab0:	44070800 	mfc1	a3,$f1
  445ab4:	8c5e0014 	lw	s8,20(v0)
  445ab8:	2fc20002 	sltiu	v0,s8,2
  445abc:	14400004 	bnez	v0,445ad0 <cJSON_GetObjectItem@@Base+0x5824>
  445ac0:	3c07005e 	lui	a3,0x5e
  445ac4:	27a400b4 	addiu	a0,sp,180
  445ac8:	1000f85e 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  445acc:	24e7f718 	addiu	a3,a3,-2280
  445ad0:	3c16005e 	lui	s6,0x5e
  445ad4:	26c5f668 	addiu	a1,s6,-2456
  445ad8:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  445adc:	02602025 	move	a0,s3
  445ae0:	10400004 	beqz	v0,445af4 <cJSON_GetObjectItem@@Base+0x5848>
  445ae4:	00000000 	nop
  445ae8:	8c43000c 	lw	v1,12(v0)
  445aec:	10770004 	beq	v1,s7,445b00 <cJSON_GetObjectItem@@Base+0x5854>
  445af0:	00000000 	nop
  445af4:	27a400b4 	addiu	a0,sp,180
  445af8:	1000f852 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  445afc:	26c7f668 	addiu	a3,s6,-2456
  445b00:	d4400018 	ldc1	$f0,24(v0)
  445b04:	3c02005e 	lui	v0,0x5e
  445b08:	d44225d0 	ldc1	$f2,9680(v0)
  445b0c:	4622003c 	c.lt.d	$f0,$f2
  445b10:	45010005 	bc1t	445b28 <cJSON_GetObjectItem@@Base+0x587c>
  445b14:	3c02005e 	lui	v0,0x5e
  445b18:	d442fce8 	ldc1	$f2,-792(v0)
  445b1c:	4620133c 	c.lt.d	$fcc3,$f2,$f0
  445b20:	450c0005 	bc1f	$fcc3,445b38 <cJSON_GetObjectItem@@Base+0x588c>
  445b24:	00000000 	nop
  445b28:	3c07005e 	lui	a3,0x5e
  445b2c:	27a400b4 	addiu	a0,sp,180
  445b30:	1000f844 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  445b34:	24e7f730 	addiu	a3,a3,-2256
  445b38:	4620a520 	cvt.s.d	$f20,$f20
  445b3c:	4620c620 	cvt.s.d	$f24,$f24
  445b40:	4620b5a0 	cvt.s.d	$f22,$f22
  445b44:	12a00005 	beqz	s5,445b5c <cJSON_GetObjectItem@@Base+0x58b0>
  445b48:	46200020 	cvt.s.d	$f0,$f0
  445b4c:	4616c040 	add.s	$f1,$f24,$f22
  445b50:	4601a43c 	c.lt.s	$fcc4,$f20,$f1
  445b54:	45110008 	bc1t	$fcc4,445b78 <cJSON_GetObjectItem@@Base+0x58cc>
  445b58:	00000000 	nop
  445b5c:	ae9505d4 	sw	s5,1492(s4)
  445b60:	e69405d8 	swc1	$f20,1496(s4)
  445b64:	e69805dc 	swc1	$f24,1500(s4)
  445b68:	e69605e0 	swc1	$f22,1504(s4)
  445b6c:	ae9e05e8 	sw	s8,1512(s4)
  445b70:	1000f8a2 	b	443dfc <cJSON_GetObjectItem@@Base+0x3b50>
  445b74:	e68005ec 	swc1	$f0,1516(s4)
  445b78:	3c07005e 	lui	a3,0x5e
  445b7c:	27a400b4 	addiu	a0,sp,180
  445b80:	1000f830 	b	443c44 <cJSON_GetObjectItem@@Base+0x3998>
  445b84:	24e71fd8 	addiu	a3,a3,8152
  445b88:	27bdeec0 	addiu	sp,sp,-4416
  445b8c:	afb61130 	sw	s6,4400(sp)
  445b90:	afb1111c 	sw	s1,4380(sp)
  445b94:	afb01118 	sw	s0,4376(sp)
  445b98:	00a08825 	move	s1,a1
  445b9c:	0080b025 	move	s6,a0
  445ba0:	00002825 	move	a1,zero
  445ba4:	27a41030 	addiu	a0,sp,4144
  445ba8:	00c08025 	move	s0,a2
  445bac:	24060080 	li	a2,128
  445bb0:	afbf113c 	sw	ra,4412(sp)
  445bb4:	afb41128 	sw	s4,4392(sp)
  445bb8:	afb31124 	sw	s3,4388(sp)
  445bbc:	afbe1138 	sw	s8,4408(sp)
  445bc0:	afb71134 	sw	s7,4404(sp)
  445bc4:	afb5112c 	sw	s5,4396(sp)
  445bc8:	0c197d18 	jal	65f460 <memset@plt>
  445bcc:	afb21120 	sw	s2,4384(sp)
  445bd0:	27a410b0 	addiu	a0,sp,4272
  445bd4:	24060040 	li	a2,64
  445bd8:	0c197d18 	jal	65f460 <memset@plt>
  445bdc:	00002825 	move	a1,zero
  445be0:	96260006 	lhu	a2,6(s1)
  445be4:	3c13005e 	lui	s3,0x5e
  445be8:	3c04005e 	lui	a0,0x5e
  445bec:	2665258c 	addiu	a1,s3,9612
  445bf0:	2484244c 	addiu	a0,a0,9292
  445bf4:	afa010f0 	sw	zero,4336(sp)
  445bf8:	afa010f4 	sw	zero,4340(sp)
  445bfc:	afa010f8 	sw	zero,4344(sp)
  445c00:	0c197bcc 	jal	65ef30 <printf@plt>
  445c04:	afa010fc 	sw	zero,4348(sp)
  445c08:	8e270010 	lw	a3,16(s1)
  445c0c:	96260006 	lhu	a2,6(s1)
  445c10:	3c04005e 	lui	a0,0x5e
  445c14:	2665258c 	addiu	a1,s3,9612
  445c18:	0c197bcc 	jal	65ef30 <printf@plt>
  445c1c:	24841c80 	addiu	a0,a0,7296
  445c20:	0c110020 	jal	440080 <cJSON_Parse@@Base>
  445c24:	8e240010 	lw	a0,16(s1)
  445c28:	1040009e 	beqz	v0,445ea4 <cJSON_GetObjectItem@@Base+0x5bf8>
  445c2c:	0040a025 	move	s4,v0
  445c30:	0c11041f 	jal	44107c <cJSON_GetObjectItem@@Base+0xdd0>
  445c34:	00000000 	nop
  445c38:	104000b9 	beqz	v0,445f20 <cJSON_GetObjectItem@@Base+0x5c74>
  445c3c:	00409025 	move	s2,v0
  445c40:	96260006 	lhu	a2,6(s1)
  445c44:	24020002 	li	v0,2
  445c48:	10c20070 	beq	a2,v0,445e0c <cJSON_GetObjectItem@@Base+0x5b60>
  445c4c:	24020003 	li	v0,3
  445c50:	10c2005c 	beq	a2,v0,445dc4 <cJSON_GetObjectItem@@Base+0x5b18>
  445c54:	24020004 	li	v0,4
  445c58:	3c04005e 	lui	a0,0x5e
  445c5c:	2665258c 	addiu	a1,s3,9612
  445c60:	0c197bcc 	jal	65ef30 <printf@plt>
  445c64:	24842390 	addiu	a0,a0,9104
  445c68:	96270006 	lhu	a3,6(s1)
  445c6c:	3c06005e 	lui	a2,0x5e
  445c70:	24c623ac 	addiu	a2,a2,9132
  445c74:	24050080 	li	a1,128
  445c78:	0c197ca4 	jal	65f290 <snprintf@plt>
  445c7c:	27a41030 	addiu	a0,sp,4144
  445c80:	3c02005e 	lui	v0,0x5e
  445c84:	8c4625c8 	lw	a2,9672(v0)
  445c88:	8c4725cc 	lw	a3,9676(v0)
  445c8c:	0000a825 	move	s5,zero
  445c90:	0000b825 	move	s7,zero
  445c94:	96220006 	lhu	v0,6(s1)
  445c98:	a6020006 	sh	v0,6(s0)
  445c9c:	3c05005e 	lui	a1,0x5e
  445ca0:	02402025 	move	a0,s2
  445ca4:	0c110352 	jal	440d48 <cJSON_GetObjectItem@@Base+0xa9c>
  445ca8:	24a50324 	addiu	a1,a1,804
  445cac:	3c05005e 	lui	a1,0x5e
  445cb0:	27a61030 	addiu	a2,sp,4144
  445cb4:	24a523c4 	addiu	a1,a1,9156
  445cb8:	0c11038d 	jal	440e34 <cJSON_GetObjectItem@@Base+0xb88>
  445cbc:	02402025 	move	a0,s2
  445cc0:	0c110026 	jal	440098 <cJSON_Print@@Base>
  445cc4:	02402025 	move	a0,s2
  445cc8:	00402025 	move	a0,v0
  445ccc:	0c197bc0 	jal	65ef00 <strlen@plt>
  445cd0:	00408825 	move	s1,v0
  445cd4:	8e060018 	lw	a2,24(s0)
  445cd8:	24c3ffff 	addiu	v1,a2,-1
  445cdc:	0062102b 	sltu	v0,v1,v0
  445ce0:	144000e8 	bnez	v0,446084 <cJSON_GetObjectItem@@Base+0x5dd8>
  445ce4:	2665258c 	addiu	a1,s3,9612
  445ce8:	8e040010 	lw	a0,16(s0)
  445cec:	0c197bb0 	jal	65eec0 <strncpy@plt>
  445cf0:	02202825 	move	a1,s1
  445cf4:	0c197bc0 	jal	65ef00 <strlen@plt>
  445cf8:	02202025 	move	a0,s1
  445cfc:	8e030010 	lw	v1,16(s0)
  445d00:	02202025 	move	a0,s1
  445d04:	00621021 	addu	v0,v1,v0
  445d08:	0c197bc0 	jal	65ef00 <strlen@plt>
  445d0c:	a0400000 	sb	zero,0(v0)
  445d10:	24420001 	addiu	v0,v0,1
  445d14:	ae020014 	sw	v0,20(s0)
  445d18:	8e030010 	lw	v1,16(s0)
  445d1c:	3c04005e 	lui	a0,0x5e
  445d20:	2665258c 	addiu	a1,s3,9612
  445d24:	00621021 	addu	v0,v1,v0
  445d28:	a0400000 	sb	zero,0(v0)
  445d2c:	8e070010 	lw	a3,16(s0)
  445d30:	96060006 	lhu	a2,6(s0)
  445d34:	0c197bcc 	jal	65ef30 <printf@plt>
  445d38:	248423e8 	addiu	a0,a0,9192
  445d3c:	12800003 	beqz	s4,445d4c <cJSON_GetObjectItem@@Base+0x5aa0>
  445d40:	00000000 	nop
  445d44:	0c10fd70 	jal	43f5c0 <cJSON_Delete@@Base>
  445d48:	02802025 	move	a0,s4
  445d4c:	12400003 	beqz	s2,445d5c <cJSON_GetObjectItem@@Base+0x5ab0>
  445d50:	00000000 	nop
  445d54:	0c10fd70 	jal	43f5c0 <cJSON_Delete@@Base>
  445d58:	02402025 	move	a0,s2
  445d5c:	12a00003 	beqz	s5,445d6c <cJSON_GetObjectItem@@Base+0x5ac0>
  445d60:	00000000 	nop
  445d64:	0c197ecc 	jal	65fb30 <fclose@plt>
  445d68:	02a02025 	move	a0,s5
  445d6c:	12200003 	beqz	s1,445d7c <cJSON_GetObjectItem@@Base+0x5ad0>
  445d70:	00000000 	nop
  445d74:	0c197bf4 	jal	65efd0 <free@plt>
  445d78:	02202025 	move	a0,s1
  445d7c:	96060006 	lhu	a2,6(s0)
  445d80:	3c04005e 	lui	a0,0x5e
  445d84:	2665258c 	addiu	a1,s3,9612
  445d88:	0c197bcc 	jal	65ef30 <printf@plt>
  445d8c:	24842524 	addiu	a0,a0,9508
  445d90:	8fbf113c 	lw	ra,4412(sp)
  445d94:	02e01025 	move	v0,s7
  445d98:	8fbe1138 	lw	s8,4408(sp)
  445d9c:	8fb71134 	lw	s7,4404(sp)
  445da0:	8fb61130 	lw	s6,4400(sp)
  445da4:	8fb5112c 	lw	s5,4396(sp)
  445da8:	8fb41128 	lw	s4,4392(sp)
  445dac:	8fb31124 	lw	s3,4388(sp)
  445db0:	8fb21120 	lw	s2,4384(sp)
  445db4:	8fb1111c 	lw	s1,4380(sp)
  445db8:	8fb01118 	lw	s0,4376(sp)
  445dbc:	03e00008 	jr	ra
  445dc0:	27bd1140 	addiu	sp,sp,4416
  445dc4:	8ec60894 	lw	a2,2196(s6)
  445dc8:	10c2001f 	beq	a2,v0,445e48 <cJSON_GetObjectItem@@Base+0x5b9c>
  445dcc:	3c04005e 	lui	a0,0x5e
  445dd0:	2665258c 	addiu	a1,s3,9612
  445dd4:	0c197bcc 	jal	65ef30 <printf@plt>
  445dd8:	24842460 	addiu	a0,a0,9312
  445ddc:	8ec70894 	lw	a3,2196(s6)
  445de0:	3c06005e 	lui	a2,0x5e
  445de4:	24c62478 	addiu	a2,a2,9336
  445de8:	24050080 	li	a1,128
  445dec:	0c197ca4 	jal	65f290 <snprintf@plt>
  445df0:	27a41030 	addiu	a0,sp,4144
  445df4:	3c02005e 	lui	v0,0x5e
  445df8:	8c46d6c0 	lw	a2,-10560(v0)
  445dfc:	8c47d6c4 	lw	a3,-10556(v0)
  445e00:	0000a825 	move	s5,zero
  445e04:	1000ffa3 	b	445c94 <cJSON_GetObjectItem@@Base+0x59e8>
  445e08:	0000b825 	move	s7,zero
  445e0c:	8ec60894 	lw	a2,2196(s6)
  445e10:	14c2ffef 	bne	a2,v0,445dd0 <cJSON_GetObjectItem@@Base+0x5b24>
  445e14:	3c04005e 	lui	a0,0x5e
  445e18:	3c17005e 	lui	s7,0x5e
  445e1c:	26e51cb8 	addiu	a1,s7,7352
  445e20:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  445e24:	02802025 	move	a0,s4
  445e28:	10400004 	beqz	v0,445e3c <cJSON_GetObjectItem@@Base+0x5b90>
  445e2c:	24030010 	li	v1,16
  445e30:	8c55000c 	lw	s5,12(v0)
  445e34:	12a30068 	beq	s5,v1,445fd8 <cJSON_GetObjectItem@@Base+0x5d2c>
  445e38:	24060021 	li	a2,33
  445e3c:	27a41030 	addiu	a0,sp,4144
  445e40:	1000000d 	b	445e78 <cJSON_GetObjectItem@@Base+0x5bcc>
  445e44:	26e71cb8 	addiu	a3,s7,7352
  445e48:	3c15005e 	lui	s5,0x5e
  445e4c:	26a5251c 	addiu	a1,s5,9500
  445e50:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  445e54:	02802025 	move	a0,s4
  445e58:	10400005 	beqz	v0,445e70 <cJSON_GetObjectItem@@Base+0x5bc4>
  445e5c:	0040b825 	move	s7,v0
  445e60:	8c43000c 	lw	v1,12(v0)
  445e64:	24020010 	li	v0,16
  445e68:	10620034 	beq	v1,v0,445f3c <cJSON_GetObjectItem@@Base+0x5c90>
  445e6c:	3c1e005e 	lui	s8,0x5e
  445e70:	27a41030 	addiu	a0,sp,4144
  445e74:	26a7251c 	addiu	a3,s5,9500
  445e78:	3c06005e 	lui	a2,0x5e
  445e7c:	24c6ff1c 	addiu	a2,a2,-228
  445e80:	0c197ca4 	jal	65f290 <snprintf@plt>
  445e84:	24050080 	li	a1,128
  445e88:	3c04005e 	lui	a0,0x5e
  445e8c:	27a61030 	addiu	a2,sp,4144
  445e90:	2665258c 	addiu	a1,s3,9612
  445e94:	0c197bcc 	jal	65ef30 <printf@plt>
  445e98:	2484ca58 	addiu	a0,a0,-13736
  445e9c:	1000ff79 	b	445c84 <cJSON_GetObjectItem@@Base+0x59d8>
  445ea0:	3c02005e 	lui	v0,0x5e
  445ea4:	0c10fd1d 	jal	43f474 <cJSON_GetErrorPtr@@Base>
  445ea8:	24150002 	li	s5,2
  445eac:	3c04005e 	lui	a0,0x5e
  445eb0:	00403025 	move	a2,v0
  445eb4:	2665258c 	addiu	a1,s3,9612
  445eb8:	0c197bcc 	jal	65ef30 <printf@plt>
  445ebc:	2484ce7c 	addiu	a0,a0,-12676
  445ec0:	3c03005e 	lui	v1,0x5e
  445ec4:	24621ca4 	addiu	v0,v1,7332
  445ec8:	8c661ca4 	lw	a2,7332(v1)
  445ecc:	8c450004 	lw	a1,4(v0)
  445ed0:	8c440008 	lw	a0,8(v0)
  445ed4:	8c43000c 	lw	v1,12(v0)
  445ed8:	94420010 	lhu	v0,16(v0)
  445edc:	afa61030 	sw	a2,4144(sp)
  445ee0:	afa51034 	sw	a1,4148(sp)
  445ee4:	afa41038 	sw	a0,4152(sp)
  445ee8:	afa3103c 	sw	v1,4156(sp)
  445eec:	a7a21040 	sh	v0,4160(sp)
  445ef0:	0000b825 	move	s7,zero
  445ef4:	96220006 	lhu	v0,6(s1)
  445ef8:	0c11041f 	jal	44107c <cJSON_GetObjectItem@@Base+0xdd0>
  445efc:	a6020006 	sh	v0,6(s0)
  445f00:	1040014b 	beqz	v0,446430 <cJSON_GetObjectItem@@Base+0x6184>
  445f04:	00409025 	move	s2,v0
  445f08:	44950000 	mtc1	s5,$f0
  445f0c:	0000a825 	move	s5,zero
  445f10:	46800021 	cvt.d.w	$f0,$f0
  445f14:	44060000 	mfc1	a2,$f0
  445f18:	1000ff60 	b	445c9c <cJSON_GetObjectItem@@Base+0x59f0>
  445f1c:	44070800 	mfc1	a3,$f1
  445f20:	3c04005e 	lui	a0,0x5e
  445f24:	2665258c 	addiu	a1,s3,9612
  445f28:	0c197bcc 	jal	65ef30 <printf@plt>
  445f2c:	2484e370 	addiu	a0,a0,-7312
  445f30:	0000a825 	move	s5,zero
  445f34:	1000ffef 	b	445ef4 <cJSON_GetObjectItem@@Base+0x5c48>
  445f38:	2417ffff 	li	s7,-1
  445f3c:	3c05005e 	lui	a1,0x5e
  445f40:	24a524e4 	addiu	a1,a1,9444
  445f44:	0c197d48 	jal	65f520 <fopen@plt>
  445f48:	27c4fb18 	addiu	a0,s8,-1256
  445f4c:	10400079 	beqz	v0,446134 <cJSON_GetObjectItem@@Base+0x5e88>
  445f50:	0040a825 	move	s5,v0
  445f54:	8ef70010 	lw	s7,16(s7)
  445f58:	27be0830 	addiu	s8,sp,2096
  445f5c:	0c197bc0 	jal	65ef00 <strlen@plt>
  445f60:	02e02025 	move	a0,s7
  445f64:	24030001 	li	v1,1
  445f68:	afa30014 	sw	v1,20(sp)
  445f6c:	afbe0010 	sw	s8,16(sp)
  445f70:	24470001 	addiu	a3,v0,1
  445f74:	02e03025 	move	a2,s7
  445f78:	27a510f0 	addiu	a1,sp,4336
  445f7c:	0c10d669 	jal	4359a4 <_ftext@@Base+0x121e4>
  445f80:	26c4086d 	addiu	a0,s6,2157
  445f84:	04400056 	bltz	v0,4460e0 <cJSON_GetObjectItem@@Base+0x5e34>
  445f88:	00000000 	nop
  445f8c:	02a03825 	move	a3,s5
  445f90:	00403025 	move	a2,v0
  445f94:	24050001 	li	a1,1
  445f98:	0c197d70 	jal	65f5c0 <fwrite@plt>
  445f9c:	03c02025 	move	a0,s8
  445fa0:	02a02025 	move	a0,s5
  445fa4:	0c197ecc 	jal	65fb30 <fclose@plt>
  445fa8:	3c15005e 	lui	s5,0x5e
  445fac:	26a5e3a4 	addiu	a1,s5,-7260
  445fb0:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  445fb4:	02802025 	move	a0,s4
  445fb8:	10400004 	beqz	v0,445fcc <cJSON_GetObjectItem@@Base+0x5d20>
  445fbc:	24030008 	li	v1,8
  445fc0:	8c44000c 	lw	a0,12(v0)
  445fc4:	10830025 	beq	a0,v1,44605c <cJSON_GetObjectItem@@Base+0x5db0>
  445fc8:	24030005 	li	v1,5
  445fcc:	27a41030 	addiu	a0,sp,4144
  445fd0:	1000ffa9 	b	445e78 <cJSON_GetObjectItem@@Base+0x5bcc>
  445fd4:	26a7e3a4 	addiu	a3,s5,-7260
  445fd8:	8c450010 	lw	a1,16(v0)
  445fdc:	26c40648 	addiu	a0,s6,1608
  445fe0:	0c197bb0 	jal	65eec0 <strncpy@plt>
  445fe4:	3c1e005e 	lui	s8,0x5e
  445fe8:	27c5203c 	addiu	a1,s8,8252
  445fec:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  445ff0:	02802025 	move	a0,s4
  445ff4:	10400004 	beqz	v0,446008 <cJSON_GetObjectItem@@Base+0x5d5c>
  445ff8:	00000000 	nop
  445ffc:	8c43000c 	lw	v1,12(v0)
  446000:	10750004 	beq	v1,s5,446014 <cJSON_GetObjectItem@@Base+0x5d68>
  446004:	24060021 	li	a2,33
  446008:	27a41030 	addiu	a0,sp,4144
  44600c:	1000ff9a 	b	445e78 <cJSON_GetObjectItem@@Base+0x5bcc>
  446010:	27c7203c 	addiu	a3,s8,8252
  446014:	8c450010 	lw	a1,16(v0)
  446018:	26c40669 	addiu	a0,s6,1641
  44601c:	0c197bb0 	jal	65eec0 <strncpy@plt>
  446020:	afa31100 	sw	v1,4352(sp)
  446024:	3c02005e 	lui	v0,0x5e
  446028:	2445fe38 	addiu	a1,v0,-456
  44602c:	02802025 	move	a0,s4
  446030:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  446034:	afa21104 	sw	v0,4356(sp)
  446038:	10400004 	beqz	v0,44604c <cJSON_GetObjectItem@@Base+0x5da0>
  44603c:	8fa31100 	lw	v1,4352(sp)
  446040:	8c44000c 	lw	a0,12(v0)
  446044:	10830015 	beq	a0,v1,44609c <cJSON_GetObjectItem@@Base+0x5df0>
  446048:	24060021 	li	a2,33
  44604c:	8fa21104 	lw	v0,4356(sp)
  446050:	27a41030 	addiu	a0,sp,4144
  446054:	1000ff88 	b	445e78 <cJSON_GetObjectItem@@Base+0x5bcc>
  446058:	2447fe38 	addiu	a3,v0,-456
  44605c:	8c420014 	lw	v0,20(v0)
  446060:	aec30894 	sw	v1,2196(s6)
  446064:	00021fc3 	sra	v1,v0,0x1f
  446068:	aec20830 	sw	v0,2096(s6)
  44606c:	aec30834 	sw	v1,2100(s6)
  446070:	00003025 	move	a2,zero
  446074:	00003825 	move	a3,zero
  446078:	0000a825 	move	s5,zero
  44607c:	1000ff05 	b	445c94 <cJSON_GetObjectItem@@Base+0x59e8>
  446080:	0000b825 	move	s7,zero
  446084:	3c04005e 	lui	a0,0x5e
  446088:	0c197bcc 	jal	65ef30 <printf@plt>
  44608c:	248423cc 	addiu	a0,a0,9164
  446090:	2417ffff 	li	s7,-1
  446094:	1000ff20 	b	445d18 <cJSON_GetObjectItem@@Base+0x5a6c>
  446098:	8e020014 	lw	v0,20(s0)
  44609c:	8c450010 	lw	a1,16(v0)
  4460a0:	0c197bb0 	jal	65eec0 <strncpy@plt>
  4460a4:	26c4068a 	addiu	a0,s6,1674
  4460a8:	3c02005e 	lui	v0,0x5e
  4460ac:	2445fef4 	addiu	a1,v0,-268
  4460b0:	02802025 	move	a0,s4
  4460b4:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  4460b8:	afa21100 	sw	v0,4352(sp)
  4460bc:	10400004 	beqz	v0,4460d0 <cJSON_GetObjectItem@@Base+0x5e24>
  4460c0:	24030010 	li	v1,16
  4460c4:	8c55000c 	lw	s5,12(v0)
  4460c8:	12a3002a 	beq	s5,v1,446174 <cJSON_GetObjectItem@@Base+0x5ec8>
  4460cc:	24060021 	li	a2,33
  4460d0:	8fa21100 	lw	v0,4352(sp)
  4460d4:	27a41030 	addiu	a0,sp,4144
  4460d8:	1000ff67 	b	445e78 <cJSON_GetObjectItem@@Base+0x5bcc>
  4460dc:	2447fef4 	addiu	a3,v0,-268
  4460e0:	3c04005e 	lui	a0,0x5e
  4460e4:	2665258c 	addiu	a1,s3,9612
  4460e8:	0c197bcc 	jal	65ef30 <printf@plt>
  4460ec:	2484f858 	addiu	a0,a0,-1960
  4460f0:	3c03005e 	lui	v1,0x5e
  4460f4:	2462249c 	addiu	v0,v1,9372
  4460f8:	8c66249c 	lw	a2,9372(v1)
  4460fc:	8c450004 	lw	a1,4(v0)
  446100:	8c440008 	lw	a0,8(v0)
  446104:	8c43000c 	lw	v1,12(v0)
  446108:	8c420010 	lw	v0,16(v0)
  44610c:	afa61030 	sw	a2,4144(sp)
  446110:	afa51034 	sw	a1,4148(sp)
  446114:	afa21040 	sw	v0,4160(sp)
  446118:	3c02005e 	lui	v0,0x5e
  44611c:	afa41038 	sw	a0,4152(sp)
  446120:	afa3103c 	sw	v1,4156(sp)
  446124:	8c46d6c0 	lw	a2,-10560(v0)
  446128:	8c47d6c4 	lw	a3,-10556(v0)
  44612c:	1000fed9 	b	445c94 <cJSON_GetObjectItem@@Base+0x59e8>
  446130:	0000b825 	move	s7,zero
  446134:	3c04005e 	lui	a0,0x5e
  446138:	27c6fb18 	addiu	a2,s8,-1256
  44613c:	2665258c 	addiu	a1,s3,9612
  446140:	0c197bcc 	jal	65ef30 <printf@plt>
  446144:	2484cb94 	addiu	a0,a0,-13420
  446148:	27c7fb18 	addiu	a3,s8,-1256
  44614c:	3c06005e 	lui	a2,0x5e
  446150:	24c6248c 	addiu	a2,a2,9356
  446154:	24050080 	li	a1,128
  446158:	0c197ca4 	jal	65f290 <snprintf@plt>
  44615c:	27a41030 	addiu	a0,sp,4144
  446160:	3c02005e 	lui	v0,0x5e
  446164:	8c46d6c0 	lw	a2,-10560(v0)
  446168:	8c47d6c4 	lw	a3,-10556(v0)
  44616c:	1000fec9 	b	445c94 <cJSON_GetObjectItem@@Base+0x59e8>
  446170:	0000b825 	move	s7,zero
  446174:	8c450010 	lw	a1,16(v0)
  446178:	0c197bb0 	jal	65eec0 <strncpy@plt>
  44617c:	26c4080e 	addiu	a0,s6,2062
  446180:	3c07005e 	lui	a3,0x5e
  446184:	24e52538 	addiu	a1,a3,9528
  446188:	02802025 	move	a0,s4
  44618c:	0c1100ab 	jal	4402ac <cJSON_GetObjectItem@@Base>
  446190:	afa71108 	sw	a3,4360(sp)
  446194:	00401825 	move	v1,v0
  446198:	10400004 	beqz	v0,4461ac <cJSON_GetObjectItem@@Base+0x5f00>
  44619c:	8fa71108 	lw	a3,4360(sp)
  4461a0:	8c62000c 	lw	v0,12(v1)
  4461a4:	10550004 	beq	v0,s5,4461b8 <cJSON_GetObjectItem@@Base+0x5f0c>
  4461a8:	00000000 	nop
  4461ac:	27a41030 	addiu	a0,sp,4144
  4461b0:	1000ff31 	b	445e78 <cJSON_GetObjectItem@@Base+0x5bcc>
  4461b4:	24e72538 	addiu	a3,a3,9528
  4461b8:	3c07005e 	lui	a3,0x5e
  4461bc:	3c02005e 	lui	v0,0x5e
  4461c0:	24e4fad4 	addiu	a0,a3,-1324
  4461c4:	244524e4 	addiu	a1,v0,9444
  4461c8:	afa3110c 	sw	v1,4364(sp)
  4461cc:	afa71108 	sw	a3,4360(sp)
  4461d0:	0c197d48 	jal	65f520 <fopen@plt>
  4461d4:	afa21110 	sw	v0,4368(sp)
  4461d8:	0040a825 	move	s5,v0
  4461dc:	8fa71108 	lw	a3,4360(sp)
  4461e0:	1040009c 	beqz	v0,446454 <cJSON_GetObjectItem@@Base+0x61a8>
  4461e4:	8fa3110c 	lw	v1,4364(sp)
  4461e8:	8c660010 	lw	a2,16(v1)
  4461ec:	00c02025 	move	a0,a2
  4461f0:	0c197bc0 	jal	65ef00 <strlen@plt>
  4461f4:	afa61108 	sw	a2,4360(sp)
  4461f8:	24030001 	li	v1,1
  4461fc:	8fa61108 	lw	a2,4360(sp)
  446200:	afa30014 	sw	v1,20(sp)
  446204:	27a30830 	addiu	v1,sp,2096
  446208:	afa30010 	sw	v1,16(sp)
  44620c:	24470001 	addiu	a3,v0,1
  446210:	27a510f0 	addiu	a1,sp,4336
  446214:	0c10d669 	jal	4359a4 <_ftext@@Base+0x121e4>
  446218:	26c4086d 	addiu	a0,s6,2157
  44621c:	0440ffb0 	bltz	v0,4460e0 <cJSON_GetObjectItem@@Base+0x5e34>
  446220:	00000000 	nop
  446224:	02a03825 	move	a3,s5
  446228:	00403025 	move	a2,v0
  44622c:	24050001 	li	a1,1
  446230:	0c197d70 	jal	65f5c0 <fwrite@plt>
  446234:	27a40830 	addiu	a0,sp,2096
  446238:	0c197ecc 	jal	65fb30 <fclose@plt>
  44623c:	02a02025 	move	a0,s5
  446240:	3c06005e 	lui	a2,0x5e
  446244:	26e51cb8 	addiu	a1,s7,7352
  446248:	02402025 	move	a0,s2
  44624c:	0c11038d 	jal	440e34 <cJSON_GetObjectItem@@Base+0xb88>
  446250:	24c6dc4c 	addiu	a2,a2,-9140
  446254:	3c06005e 	lui	a2,0x5e
  446258:	02402025 	move	a0,s2
  44625c:	24c6dccc 	addiu	a2,a2,-9012
  446260:	0c11038d 	jal	440e34 <cJSON_GetObjectItem@@Base+0xb88>
  446264:	27c5203c 	addiu	a1,s8,8252
  446268:	8fa21104 	lw	v0,4356(sp)
  44626c:	02402025 	move	a0,s2
  446270:	26c606ed 	addiu	a2,s6,1773
  446274:	0c11038d 	jal	440e34 <cJSON_GetObjectItem@@Base+0xb88>
  446278:	2445fe38 	addiu	a1,v0,-456
  44627c:	3c06005e 	lui	a2,0x5e
  446280:	3c05005e 	lui	a1,0x5e
  446284:	02402025 	move	a0,s2
  446288:	24c6cdc0 	addiu	a2,a2,-12864
  44628c:	0c11038d 	jal	440e34 <cJSON_GetObjectItem@@Base+0xb88>
  446290:	24a500c0 	addiu	a1,a1,192
  446294:	92c60712 	lbu	a2,1810(s6)
  446298:	92c80713 	lbu	t0,1811(s6)
  44629c:	92c30710 	lbu	v1,1808(s6)
  4462a0:	92c50711 	lbu	a1,1809(s6)
  4462a4:	92c2070f 	lbu	v0,1807(s6)
  4462a8:	92c7070e 	lbu	a3,1806(s6)
  4462ac:	afa6001c 	sw	a2,28(sp)
  4462b0:	3c06005e 	lui	a2,0x5e
  4462b4:	afa80020 	sw	t0,32(sp)
  4462b8:	afa30014 	sw	v1,20(sp)
  4462bc:	27a410b0 	addiu	a0,sp,4272
  4462c0:	afa50018 	sw	a1,24(sp)
  4462c4:	24c6febc 	addiu	a2,a2,-324
  4462c8:	24050040 	li	a1,64
  4462cc:	0c197ca4 	jal	65f290 <snprintf@plt>
  4462d0:	afa20010 	sw	v0,16(sp)
  4462d4:	8fa21100 	lw	v0,4352(sp)
  4462d8:	02402025 	move	a0,s2
  4462dc:	27a610b0 	addiu	a2,sp,4272
  4462e0:	0c11038d 	jal	440e34 <cJSON_GetObjectItem@@Base+0xb88>
  4462e4:	2445fef4 	addiu	a1,v0,-268
  4462e8:	24050800 	li	a1,2048
  4462ec:	0c10d713 	jal	435c4c <_ftext@@Base+0x1248c>
  4462f0:	27a40830 	addiu	a0,sp,2096
  4462f4:	10400018 	beqz	v0,446358 <cJSON_GetObjectItem@@Base+0x60ac>
  4462f8:	0040b825 	move	s7,v0
  4462fc:	3c04005e 	lui	a0,0x5e
  446300:	2665258c 	addiu	a1,s3,9612
  446304:	0c197bcc 	jal	65ef30 <printf@plt>
  446308:	248424b0 	addiu	a0,a0,9392
  44630c:	3c03005e 	lui	v1,0x5e
  446310:	246224cc 	addiu	v0,v1,9420
  446314:	8c6724cc 	lw	a3,9420(v1)
  446318:	8c460004 	lw	a2,4(v0)
  44631c:	8c450008 	lw	a1,8(v0)
  446320:	8c44000c 	lw	a0,12(v0)
  446324:	8c430010 	lw	v1,16(v0)
  446328:	90420014 	lbu	v0,20(v0)
  44632c:	afa71030 	sw	a3,4144(sp)
  446330:	afa61034 	sw	a2,4148(sp)
  446334:	a3a21044 	sb	v0,4164(sp)
  446338:	3c02005e 	lui	v0,0x5e
  44633c:	afa51038 	sw	a1,4152(sp)
  446340:	afa4103c 	sw	a0,4156(sp)
  446344:	afa31040 	sw	v1,4160(sp)
  446348:	8c46d6c0 	lw	a2,-10560(v0)
  44634c:	8c47d6c4 	lw	a3,-10556(v0)
  446350:	1000fe50 	b	445c94 <cJSON_GetObjectItem@@Base+0x59e8>
  446354:	0000a825 	move	s5,zero
  446358:	8fa21110 	lw	v0,4368(sp)
  44635c:	3c1e005e 	lui	s8,0x5e
  446360:	27c4fb34 	addiu	a0,s8,-1228
  446364:	0c197d48 	jal	65f520 <fopen@plt>
  446368:	244524e4 	addiu	a1,v0,9444
  44636c:	10400060 	beqz	v0,4464f0 <cJSON_GetObjectItem@@Base+0x6244>
  446370:	0040a825 	move	s5,v0
  446374:	0c197bc0 	jal	65ef00 <strlen@plt>
  446378:	27a40830 	addiu	a0,sp,2096
  44637c:	27be0030 	addiu	s8,sp,48
  446380:	24030001 	li	v1,1
  446384:	afa30014 	sw	v1,20(sp)
  446388:	afbe0010 	sw	s8,16(sp)
  44638c:	24470001 	addiu	a3,v0,1
  446390:	27a60830 	addiu	a2,sp,2096
  446394:	27a510f0 	addiu	a1,sp,4336
  446398:	0c10d669 	jal	4359a4 <_ftext@@Base+0x121e4>
  44639c:	26c4086d 	addiu	a0,s6,2157
  4463a0:	04400040 	bltz	v0,4464a4 <cJSON_GetObjectItem@@Base+0x61f8>
  4463a4:	3c04005e 	lui	a0,0x5e
  4463a8:	00403025 	move	a2,v0
  4463ac:	02a03825 	move	a3,s5
  4463b0:	24050001 	li	a1,1
  4463b4:	0c197d70 	jal	65f5c0 <fwrite@plt>
  4463b8:	03c02025 	move	a0,s8
  4463bc:	0c197ecc 	jal	65fb30 <fclose@plt>
  4463c0:	02a02025 	move	a0,s5
  4463c4:	24060800 	li	a2,2048
  4463c8:	03c02825 	move	a1,s8
  4463cc:	0c10d7a3 	jal	435e8c <_ftext@@Base+0x126cc>
  4463d0:	27a40830 	addiu	a0,sp,2096
  4463d4:	10400028 	beqz	v0,446478 <cJSON_GetObjectItem@@Base+0x61cc>
  4463d8:	0040b825 	move	s7,v0
  4463dc:	3c04005e 	lui	a0,0x5e
  4463e0:	2665258c 	addiu	a1,s3,9612
  4463e4:	0c197bcc 	jal	65ef30 <printf@plt>
  4463e8:	248424e8 	addiu	a0,a0,9448
  4463ec:	3c03005e 	lui	v1,0x5e
  4463f0:	24622500 	addiu	v0,v1,9472
  4463f4:	8c662500 	lw	a2,9472(v1)
  4463f8:	8c450004 	lw	a1,4(v0)
  4463fc:	8c440008 	lw	a0,8(v0)
  446400:	8c43000c 	lw	v1,12(v0)
  446404:	90420010 	lbu	v0,16(v0)
  446408:	afa61030 	sw	a2,4144(sp)
  44640c:	afa51034 	sw	a1,4148(sp)
  446410:	a3a21040 	sb	v0,4160(sp)
  446414:	3c02005e 	lui	v0,0x5e
  446418:	afa41038 	sw	a0,4152(sp)
  44641c:	afa3103c 	sw	v1,4156(sp)
  446420:	8c46d6c0 	lw	a2,-10560(v0)
  446424:	8c47d6c4 	lw	a3,-10556(v0)
  446428:	1000fe1a 	b	445c94 <cJSON_GetObjectItem@@Base+0x59e8>
  44642c:	0000a825 	move	s5,zero
  446430:	3c04005e 	lui	a0,0x5e
  446434:	2665258c 	addiu	a1,s3,9612
  446438:	0c197bcc 	jal	65ef30 <printf@plt>
  44643c:	2484e370 	addiu	a0,a0,-7312
  446440:	0000a825 	move	s5,zero
  446444:	8e020014 	lw	v0,20(s0)
  446448:	00008825 	move	s1,zero
  44644c:	1000fe32 	b	445d18 <cJSON_GetObjectItem@@Base+0x5a6c>
  446450:	2417ffff 	li	s7,-1
  446454:	3c04005e 	lui	a0,0x5e
  446458:	24e6fad4 	addiu	a2,a3,-1324
  44645c:	2665258c 	addiu	a1,s3,9612
  446460:	2484cb94 	addiu	a0,a0,-13420
  446464:	0c197bcc 	jal	65ef30 <printf@plt>
  446468:	afa71100 	sw	a3,4352(sp)
  44646c:	8fa71100 	lw	a3,4352(sp)
  446470:	1000ff36 	b	44614c <cJSON_GetObjectItem@@Base+0x5ea0>
  446474:	24e7fad4 	addiu	a3,a3,-1324
  446478:	3c05005e 	lui	a1,0x5e
  44647c:	03c03025 	move	a2,s8
  446480:	24a52514 	addiu	a1,a1,9492
  446484:	0c11038d 	jal	440e34 <cJSON_GetObjectItem@@Base+0xb88>
  446488:	02402025 	move	a0,s2
  44648c:	24020004 	li	v0,4
  446490:	aec20894 	sw	v0,2196(s6)
  446494:	00003025 	move	a2,zero
  446498:	00003825 	move	a3,zero
  44649c:	1000fdfd 	b	445c94 <cJSON_GetObjectItem@@Base+0x59e8>
  4464a0:	0000a825 	move	s5,zero
  4464a4:	2665258c 	addiu	a1,s3,9612
  4464a8:	0c197bcc 	jal	65ef30 <printf@plt>
  4464ac:	2484f858 	addiu	a0,a0,-1960
  4464b0:	3c03005e 	lui	v1,0x5e
  4464b4:	2462249c 	addiu	v0,v1,9372
  4464b8:	8c66249c 	lw	a2,9372(v1)
  4464bc:	8c450004 	lw	a1,4(v0)
  4464c0:	8c440008 	lw	a0,8(v0)
  4464c4:	8c43000c 	lw	v1,12(v0)
  4464c8:	8c420010 	lw	v0,16(v0)
  4464cc:	afa61030 	sw	a2,4144(sp)
  4464d0:	afa51034 	sw	a1,4148(sp)
  4464d4:	afa21040 	sw	v0,4160(sp)
  4464d8:	3c02005e 	lui	v0,0x5e
  4464dc:	afa41038 	sw	a0,4152(sp)
  4464e0:	afa3103c 	sw	v1,4156(sp)
  4464e4:	8c46d6c0 	lw	a2,-10560(v0)
  4464e8:	1000fdea 	b	445c94 <cJSON_GetObjectItem@@Base+0x59e8>
  4464ec:	8c47d6c4 	lw	a3,-10556(v0)
  4464f0:	3c04005e 	lui	a0,0x5e
  4464f4:	27c6fb34 	addiu	a2,s8,-1228
  4464f8:	2665258c 	addiu	a1,s3,9612
  4464fc:	0c197bcc 	jal	65ef30 <printf@plt>
  446500:	2484cb94 	addiu	a0,a0,-13420
  446504:	3c06005e 	lui	a2,0x5e
  446508:	27c7fb34 	addiu	a3,s8,-1228
  44650c:	24c6248c 	addiu	a2,a2,9356
  446510:	24050080 	li	a1,128
  446514:	0c197ca4 	jal	65f290 <snprintf@plt>
  446518:	27a41030 	addiu	a0,sp,4144
  44651c:	3c02005e 	lui	v0,0x5e
  446520:	8c46d6c0 	lw	a2,-10560(v0)
  446524:	1000fddb 	b	445c94 <cJSON_GetObjectItem@@Base+0x59e8>
  446528:	8c47d6c4 	lw	a3,-10556(v0)
  44652c:	00000000 	nop
  446530:	27bdffa8 	addiu	sp,sp,-88
  446534:	afb10038 	sw	s1,56(sp)
  446538:	afbf0054 	sw	ra,84(sp)
  44653c:	afb70050 	sw	s7,80(sp)
  446540:	afb6004c 	sw	s6,76(sp)
  446544:	afb50048 	sw	s5,72(sp)
  446548:	afb40044 	sw	s4,68(sp)
  44654c:	afb30040 	sw	s3,64(sp)
  446550:	afb2003c 	sw	s2,60(sp)
  446554:	afb00034 	sw	s0,52(sp)
  446558:	00808825 	move	s1,a0
  44655c:	afa00020 	sw	zero,32(sp)
  446560:	afa00024 	sw	zero,36(sp)
  446564:	afa00028 	sw	zero,40(sp)
  446568:	1080009a 	beqz	a0,4467d4 <cJSON_GetObjectItem@@Base+0x6528>
  44656c:	afa0002c 	sw	zero,44(sp)
  446570:	8c820004 	lw	v0,4(a0)
  446574:	10400097 	beqz	v0,4467d4 <cJSON_GetObjectItem@@Base+0x6528>
  446578:	00000000 	nop
  44657c:	8c820000 	lw	v0,0(a0)
  446580:	10400095 	beqz	v0,4467d8 <cJSON_GetObjectItem@@Base+0x652c>
  446584:	26360028 	addiu	s6,s1,40
  446588:	8c820010 	lw	v0,16(a0)
  44658c:	10400092 	beqz	v0,4467d8 <cJSON_GetObjectItem@@Base+0x652c>
  446590:	00000000 	nop
  446594:	24960028 	addiu	s6,a0,40
  446598:	0c197d74 	jal	65f5d0 <pthread_mutex_lock@plt>
  44659c:	02c02025 	move	a0,s6
  4465a0:	8e240004 	lw	a0,4(s1)
  4465a4:	3c05005e 	lui	a1,0x5e
  4465a8:	0c197d48 	jal	65f520 <fopen@plt>
  4465ac:	24a50654 	addiu	a1,a1,1620
  4465b0:	1040007f 	beqz	v0,4467b0 <cJSON_GetObjectItem@@Base+0x6504>
  4465b4:	00409825 	move	s3,v0
  4465b8:	24060002 	li	a2,2
  4465bc:	00002825 	move	a1,zero
  4465c0:	0c197d84 	jal	65f610 <fseek@plt>
  4465c4:	00402025 	move	a0,v0
  4465c8:	0c197bb8 	jal	65eee0 <ftell@plt>
  4465cc:	02602025 	move	a0,s3
  4465d0:	00408025 	move	s0,v0
  4465d4:	00003025 	move	a2,zero
  4465d8:	00002825 	move	a1,zero
  4465dc:	0c197d84 	jal	65f610 <fseek@plt>
  4465e0:	02602025 	move	a0,s3
  4465e4:	1a000061 	blez	s0,44676c <cJSON_GetObjectItem@@Base+0x64c0>
  4465e8:	00000000 	nop
  4465ec:	0c197dc8 	jal	65f720 <malloc@plt>
  4465f0:	02002025 	move	a0,s0
  4465f4:	1040007c 	beqz	v0,4467e8 <cJSON_GetObjectItem@@Base+0x653c>
  4465f8:	0040b825 	move	s7,v0
  4465fc:	02603825 	move	a3,s3
  446600:	02003025 	move	a2,s0
  446604:	24050001 	li	a1,1
  446608:	0c197cc4 	jal	65f310 <fread@plt>
  44660c:	00402025 	move	a0,v0
  446610:	1602006d 	bne	s0,v0,4467c8 <cJSON_GetObjectItem@@Base+0x651c>
  446614:	00000000 	nop
  446618:	0c197dc8 	jal	65f720 <malloc@plt>
  44661c:	26040001 	addiu	a0,s0,1
  446620:	1040006f 	beqz	v0,4467e0 <cJSON_GetObjectItem@@Base+0x6534>
  446624:	0040a825 	move	s5,v0
  446628:	8e240010 	lw	a0,16(s1)
  44662c:	02003825 	move	a3,s0
  446630:	afa00014 	sw	zero,20(sp)
  446634:	afa20010 	sw	v0,16(sp)
  446638:	02e03025 	move	a2,s7
  44663c:	0c10d6be 	jal	435af8 <_ftext@@Base+0x12338>
  446640:	27a50020 	addiu	a1,sp,32
  446644:	18400066 	blez	v0,4467e0 <cJSON_GetObjectItem@@Base+0x6534>
  446648:	00408025 	move	s0,v0
  44664c:	8e240000 	lw	a0,0(s1)
  446650:	02a21021 	addu	v0,s5,v0
  446654:	3c05005e 	lui	a1,0x5e
  446658:	a0400000 	sb	zero,0(v0)
  44665c:	0c197d48 	jal	65f520 <fopen@plt>
  446660:	24a5dfa4 	addiu	a1,a1,-8284
  446664:	10400008 	beqz	v0,446688 <cJSON_GetObjectItem@@Base+0x63dc>
  446668:	00409025 	move	s2,v0
  44666c:	02a02025 	move	a0,s5
  446670:	00403825 	move	a3,v0
  446674:	02003025 	move	a2,s0
  446678:	0c197d70 	jal	65f5c0 <fwrite@plt>
  44667c:	24050001 	li	a1,1
  446680:	0c197ecc 	jal	65fb30 <fclose@plt>
  446684:	02402025 	move	a0,s2
  446688:	8e220020 	lw	v0,32(s1)
  44668c:	26340020 	addiu	s4,s1,32
  446690:	8c520000 	lw	s2,0(v0)
  446694:	2450fffc 	addiu	s0,v0,-4
  446698:	1282000e 	beq	s4,v0,4466d4 <cJSON_GetObjectItem@@Base+0x6428>
  44669c:	2652fffc 	addiu	s2,s2,-4
  4466a0:	0c197bf4 	jal	65efd0 <free@plt>
  4466a4:	8e040000 	lw	a0,0(s0)
  4466a8:	8e020008 	lw	v0,8(s0)
  4466ac:	8e030004 	lw	v1,4(s0)
  4466b0:	02002025 	move	a0,s0
  4466b4:	02408025 	move	s0,s2
  4466b8:	ac620004 	sw	v0,4(v1)
  4466bc:	0c197bf4 	jal	65efd0 <free@plt>
  4466c0:	ac430000 	sw	v1,0(v0)
  4466c4:	8e430004 	lw	v1,4(s2)
  4466c8:	26420004 	addiu	v0,s2,4
  4466cc:	1454fff4 	bne	v0,s4,4466a0 <cJSON_GetObjectItem@@Base+0x63f4>
  4466d0:	2472fffc 	addiu	s2,v1,-4
  4466d4:	3c120062 	lui	s2,0x62
  4466d8:	26458fe8 	addiu	a1,s2,-28696
  4466dc:	0c197c24 	jal	65f090 <strtok@plt>
  4466e0:	02a02025 	move	a0,s5
  4466e4:	00408025 	move	s0,v0
  4466e8:	10400015 	beqz	v0,446740 <cJSON_GetObjectItem@@Base+0x6494>
  4466ec:	26528fe8 	addiu	s2,s2,-28696
  4466f0:	0c197dc8 	jal	65f720 <malloc@plt>
  4466f4:	2404000c 	li	a0,12
  4466f8:	02002025 	move	a0,s0
  4466fc:	1040000b 	beqz	v0,44672c <cJSON_GetObjectItem@@Base+0x6480>
  446700:	00408025 	move	s0,v0
  446704:	0c197bdc 	jal	65ef70 <strdup@plt>
  446708:	00000000 	nop
  44670c:	ae020000 	sw	v0,0(s0)
  446710:	10400029 	beqz	v0,4467b8 <cJSON_GetObjectItem@@Base+0x650c>
  446714:	26030004 	addiu	v1,s0,4
  446718:	8e220024 	lw	v0,36(s1)
  44671c:	ae140004 	sw	s4,4(s0)
  446720:	ae230024 	sw	v1,36(s1)
  446724:	ae020008 	sw	v0,8(s0)
  446728:	ac430000 	sw	v1,0(v0)
  44672c:	02402825 	move	a1,s2
  446730:	0c197c24 	jal	65f090 <strtok@plt>
  446734:	00002025 	move	a0,zero
  446738:	1440ffed 	bnez	v0,4466f0 <cJSON_GetObjectItem@@Base+0x6444>
  44673c:	00408025 	move	s0,v0
  446740:	00008025 	move	s0,zero
  446744:	0c197ecc 	jal	65fb30 <fclose@plt>
  446748:	02602025 	move	a0,s3
  44674c:	0c197bf4 	jal	65efd0 <free@plt>
  446750:	02e02025 	move	a0,s7
  446754:	12a00008 	beqz	s5,446778 <cJSON_GetObjectItem@@Base+0x64cc>
  446758:	00000000 	nop
  44675c:	0c197bf4 	jal	65efd0 <free@plt>
  446760:	02a02025 	move	a0,s5
  446764:	10000004 	b	446778 <cJSON_GetObjectItem@@Base+0x64cc>
  446768:	00000000 	nop
  44676c:	00008025 	move	s0,zero
  446770:	0c197ecc 	jal	65fb30 <fclose@plt>
  446774:	02602025 	move	a0,s3
  446778:	0c197ce4 	jal	65f390 <pthread_mutex_unlock@plt>
  44677c:	02c02025 	move	a0,s6
  446780:	8fbf0054 	lw	ra,84(sp)
  446784:	02001025 	move	v0,s0
  446788:	8fb70050 	lw	s7,80(sp)
  44678c:	8fb6004c 	lw	s6,76(sp)
  446790:	8fb50048 	lw	s5,72(sp)
  446794:	8fb40044 	lw	s4,68(sp)
  446798:	8fb30040 	lw	s3,64(sp)
  44679c:	8fb2003c 	lw	s2,60(sp)
  4467a0:	8fb10038 	lw	s1,56(sp)
  4467a4:	8fb00034 	lw	s0,52(sp)
  4467a8:	03e00008 	jr	ra
  4467ac:	27bd0058 	addiu	sp,sp,88
  4467b0:	1000fff1 	b	446778 <cJSON_GetObjectItem@@Base+0x64cc>
  4467b4:	00008025 	move	s0,zero
  4467b8:	0c197bf4 	jal	65efd0 <free@plt>
  4467bc:	02002025 	move	a0,s0
  4467c0:	1000ffdb 	b	446730 <cJSON_GetObjectItem@@Base+0x6484>
  4467c4:	02402825 	move	a1,s2
  4467c8:	0000a825 	move	s5,zero
  4467cc:	1000ffdd 	b	446744 <cJSON_GetObjectItem@@Base+0x6498>
  4467d0:	2410ffff 	li	s0,-1
  4467d4:	26360028 	addiu	s6,s1,40
  4467d8:	1000ffe7 	b	446778 <cJSON_GetObjectItem@@Base+0x64cc>
  4467dc:	2410ffff 	li	s0,-1
  4467e0:	1000ffd8 	b	446744 <cJSON_GetObjectItem@@Base+0x6498>
  4467e4:	2410ffff 	li	s0,-1
  4467e8:	1000ffe1 	b	446770 <cJSON_GetObjectItem@@Base+0x64c4>
  4467ec:	2410ffff 	li	s0,-1
  4467f0:	10800043 	beqz	a0,446900 <cJSON_GetObjectItem@@Base+0x6654>
  4467f4:	00000000 	nop
  4467f8:	10a00041 	beqz	a1,446900 <cJSON_GetObjectItem@@Base+0x6654>
  4467fc:	00000000 	nop
  446800:	8ca20000 	lw	v0,0(a1)
  446804:	1040003e 	beqz	v0,446900 <cJSON_GetObjectItem@@Base+0x6654>
  446808:	00000000 	nop
  44680c:	8ca20004 	lw	v0,4(a1)
  446810:	1040003b 	beqz	v0,446900 <cJSON_GetObjectItem@@Base+0x6654>
  446814:	00000000 	nop
  446818:	8ca20010 	lw	v0,16(a1)
  44681c:	10400038 	beqz	v0,446900 <cJSON_GetObjectItem@@Base+0x6654>
  446820:	00000000 	nop
  446824:	8ca20008 	lw	v0,8(a1)
  446828:	18400035 	blez	v0,446900 <cJSON_GetObjectItem@@Base+0x6654>
  44682c:	00000000 	nop
  446830:	27bdffd8 	addiu	sp,sp,-40
  446834:	afbf0024 	sw	ra,36(sp)
  446838:	afb10020 	sw	s1,32(sp)
  44683c:	afb0001c 	sw	s0,28(sp)
  446840:	88a70003 	lwl	a3,3(a1)
  446844:	88a60007 	lwl	a2,7(a1)
  446848:	00808025 	move	s0,a0
  44684c:	88a3000f 	lwl	v1,15(a1)
  446850:	88a4000b 	lwl	a0,11(a1)
  446854:	88a20013 	lwl	v0,19(a1)
  446858:	98a70000 	lwr	a3,0(a1)
  44685c:	98a60004 	lwr	a2,4(a1)
  446860:	98a3000c 	lwr	v1,12(a1)
  446864:	98a20010 	lwr	v0,16(a1)
  446868:	98a40008 	lwr	a0,8(a1)
  44686c:	aa070003 	swl	a3,3(s0)
  446870:	ba070000 	swr	a3,0(s0)
  446874:	aa060007 	swl	a2,7(s0)
  446878:	ba060004 	swr	a2,4(s0)
  44687c:	aa04000b 	swl	a0,11(s0)
  446880:	ba040008 	swr	a0,8(s0)
  446884:	aa03000f 	swl	v1,15(s0)
  446888:	ba03000c 	swr	v1,12(s0)
  44688c:	aa020013 	swl	v0,19(s0)
  446890:	26030020 	addiu	v1,s0,32
  446894:	ba020010 	swr	v0,16(s0)
  446898:	00002825 	move	a1,zero
  44689c:	ae030020 	sw	v1,32(s0)
  4468a0:	ae030024 	sw	v1,36(s0)
  4468a4:	0c197c10 	jal	65f040 <pthread_mutex_init@plt>
  4468a8:	26040028 	addiu	a0,s0,40
  4468ac:	14400009 	bnez	v0,4468d4 <cJSON_GetObjectItem@@Base+0x6628>
  4468b0:	00408825 	move	s1,v0
  4468b4:	0c11194c 	jal	446530 <cJSON_GetObjectItem@@Base+0x6284>
  4468b8:	02002025 	move	a0,s0
  4468bc:	8fbf0024 	lw	ra,36(sp)
  4468c0:	8fb10020 	lw	s1,32(sp)
  4468c4:	8fb0001c 	lw	s0,28(sp)
  4468c8:	00001025 	move	v0,zero
  4468cc:	03e00008 	jr	ra
  4468d0:	27bd0028 	addiu	sp,sp,40
  4468d4:	3c05005e 	lui	a1,0x5e
  4468d8:	3c04005e 	lui	a0,0x5e
  4468dc:	24a52654 	addiu	a1,a1,9812
  4468e0:	0c197bcc 	jal	65ef30 <printf@plt>
  4468e4:	2484d9f4 	addiu	a0,a0,-9740
  4468e8:	8fbf0024 	lw	ra,36(sp)
  4468ec:	02201025 	move	v0,s1
  4468f0:	8fb0001c 	lw	s0,28(sp)
  4468f4:	8fb10020 	lw	s1,32(sp)
  4468f8:	03e00008 	jr	ra
  4468fc:	27bd0028 	addiu	sp,sp,40
  446900:	03e00008 	jr	ra
  446904:	2402ffff 	li	v0,-1
  446908:	27bdff78 	addiu	sp,sp,-136
  44690c:	afb10064 	sw	s1,100(sp)
  446910:	afbf0084 	sw	ra,132(sp)
  446914:	afbe0080 	sw	s8,128(sp)
  446918:	afb7007c 	sw	s7,124(sp)
  44691c:	afb60078 	sw	s6,120(sp)
  446920:	afb50074 	sw	s5,116(sp)
  446924:	afb40070 	sw	s4,112(sp)
  446928:	afb3006c 	sw	s3,108(sp)
  44692c:	afb20068 	sw	s2,104(sp)
  446930:	afb00060 	sw	s0,96(sp)
  446934:	00808825 	move	s1,a0
  446938:	afa00040 	sw	zero,64(sp)
  44693c:	afa00044 	sw	zero,68(sp)
  446940:	afa00048 	sw	zero,72(sp)
  446944:	afa0004c 	sw	zero,76(sp)
  446948:	afa00020 	sw	zero,32(sp)
  44694c:	afa00024 	sw	zero,36(sp)
  446950:	afa00028 	sw	zero,40(sp)
  446954:	afa0002c 	sw	zero,44(sp)
  446958:	afa00030 	sw	zero,48(sp)
  44695c:	afa00034 	sw	zero,52(sp)
  446960:	afa00038 	sw	zero,56(sp)
  446964:	108000e6 	beqz	a0,446d00 <cJSON_GetObjectItem@@Base+0x6a54>
  446968:	afa0003c 	sw	zero,60(sp)
  44696c:	10a000e4 	beqz	a1,446d00 <cJSON_GetObjectItem@@Base+0x6a54>
  446970:	00a08025 	move	s0,a1
  446974:	8c820010 	lw	v0,16(a0)
  446978:	104000e1 	beqz	v0,446d00 <cJSON_GetObjectItem@@Base+0x6a54>
  44697c:	24820028 	addiu	v0,a0,40
  446980:	00402025 	move	a0,v0
  446984:	0c197d74 	jal	65f5d0 <pthread_mutex_lock@plt>
  446988:	afa20058 	sw	v0,88(sp)
  44698c:	0c10d5fc 	jal	4357f0 <_ftext@@Base+0x12030>
  446990:	00000000 	nop
  446994:	8e28000c 	lw	t0,12(s1)
  446998:	1900000f 	blez	t0,4469d8 <cJSON_GetObjectItem@@Base+0x672c>
  44699c:	000829c0 	sll	a1,t0,0x7
  4469a0:	8e260018 	lw	a2,24(s1)
  4469a4:	00082080 	sll	a0,t0,0x2
  4469a8:	8e27001c 	lw	a3,28(s1)
  4469ac:	00a42023 	subu	a0,a1,a0
  4469b0:	00882021 	addu	a0,a0,t0
  4469b4:	00464823 	subu	t1,v0,a2
  4469b8:	0049402b 	sltu	t0,v0,t1
  4469bc:	00672823 	subu	a1,v1,a3
  4469c0:	000420c0 	sll	a0,a0,0x3
  4469c4:	00a82823 	subu	a1,a1,t0
  4469c8:	000447c3 	sra	t0,a0,0x1f
  4469cc:	0105502a 	slt	t2,t0,a1
  4469d0:	114000be 	beqz	t2,446ccc <cJSON_GetObjectItem@@Base+0x6a20>
  4469d4:	00000000 	nop
  4469d8:	ae220018 	sw	v0,24(s1)
  4469dc:	ae23001c 	sw	v1,28(s1)
  4469e0:	0c197dc8 	jal	65f720 <malloc@plt>
  4469e4:	2404000c 	li	a0,12
  4469e8:	104000ce 	beqz	v0,446d24 <cJSON_GetObjectItem@@Base+0x6a78>
  4469ec:	00409025 	move	s2,v0
  4469f0:	0c197d6c 	jal	65f5b0 <time@plt>
  4469f4:	27a40050 	addiu	a0,sp,80
  4469f8:	0c197e34 	jal	65f8d0 <localtime@plt>
  4469fc:	27a40050 	addiu	a0,sp,80
  446a00:	3c06005e 	lui	a2,0x5e
  446a04:	27a40020 	addiu	a0,sp,32
  446a08:	00403825 	move	a3,v0
  446a0c:	24c6260c 	addiu	a2,a2,9740
  446a10:	24050020 	li	a1,32
  446a14:	0c197da0 	jal	65f680 <strftime@plt>
  446a18:	3c15005e 	lui	s5,0x5e
  446a1c:	27a70020 	addiu	a3,sp,32
  446a20:	26a62620 	addiu	a2,s5,9760
  446a24:	00002825 	move	a1,zero
  446a28:	00002025 	move	a0,zero
  446a2c:	0c197ca4 	jal	65f290 <snprintf@plt>
  446a30:	afb00010 	sw	s0,16(sp)
  446a34:	24540001 	addiu	s4,v0,1
  446a38:	0c197dc8 	jal	65f720 <malloc@plt>
  446a3c:	02802025 	move	a0,s4
  446a40:	1040007f 	beqz	v0,446c40 <cJSON_GetObjectItem@@Base+0x6994>
  446a44:	ae420000 	sw	v0,0(s2)
  446a48:	afb00010 	sw	s0,16(sp)
  446a4c:	00402025 	move	a0,v0
  446a50:	27a70020 	addiu	a3,sp,32
  446a54:	26a62620 	addiu	a2,s5,9760
  446a58:	0c197ca4 	jal	65f290 <snprintf@plt>
  446a5c:	02802825 	move	a1,s4
  446a60:	8e240008 	lw	a0,8(s1)
  446a64:	26300020 	addiu	s0,s1,32
  446a68:	1880001a 	blez	a0,446ad4 <cJSON_GetObjectItem@@Base+0x6828>
  446a6c:	00000000 	nop
  446a70:	8e250020 	lw	a1,32(s1)
  446a74:	12050017 	beq	s0,a1,446ad4 <cJSON_GetObjectItem@@Base+0x6828>
  446a78:	00a01025 	move	v0,a1
  446a7c:	00001825 	move	v1,zero
  446a80:	8c420000 	lw	v0,0(v0)
  446a84:	1450fffe 	bne	v0,s0,446a80 <cJSON_GetObjectItem@@Base+0x67d4>
  446a88:	24630001 	addiu	v1,v1,1
  446a8c:	0064182a 	slt	v1,v1,a0
  446a90:	14600010 	bnez	v1,446ad4 <cJSON_GetObjectItem@@Base+0x6828>
  446a94:	00000000 	nop
  446a98:	24b4fffc 	addiu	s4,a1,-4
  446a9c:	1280fff2 	beqz	s4,446a68 <cJSON_GetObjectItem@@Base+0x67bc>
  446aa0:	00000000 	nop
  446aa4:	8ca20004 	lw	v0,4(a1)
  446aa8:	8ca30000 	lw	v1,0(a1)
  446aac:	8ca4fffc 	lw	a0,-4(a1)
  446ab0:	ac620004 	sw	v0,4(v1)
  446ab4:	ac430000 	sw	v1,0(v0)
  446ab8:	aca00000 	sw	zero,0(a1)
  446abc:	0c197bf4 	jal	65efd0 <free@plt>
  446ac0:	aca00004 	sw	zero,4(a1)
  446ac4:	0c197bf4 	jal	65efd0 <free@plt>
  446ac8:	02802025 	move	a0,s4
  446acc:	1000ffe6 	b	446a68 <cJSON_GetObjectItem@@Base+0x67bc>
  446ad0:	8e240008 	lw	a0,8(s1)
  446ad4:	8e220024 	lw	v0,36(s1)
  446ad8:	26430004 	addiu	v1,s2,4
  446adc:	ae230024 	sw	v1,36(s1)
  446ae0:	ae420008 	sw	v0,8(s2)
  446ae4:	ae500004 	sw	s0,4(s2)
  446ae8:	ac430000 	sw	v1,0(v0)
  446aec:	8e220020 	lw	v0,32(s1)
  446af0:	1202006f 	beq	s0,v0,446cb0 <cJSON_GetObjectItem@@Base+0x6a04>
  446af4:	2454fffc 	addiu	s4,v0,-4
  446af8:	02809025 	move	s2,s4
  446afc:	0000a825 	move	s5,zero
  446b00:	0c197bc0 	jal	65ef00 <strlen@plt>
  446b04:	8e440000 	lw	a0,0(s2)
  446b08:	8e430004 	lw	v1,4(s2)
  446b0c:	24420001 	addiu	v0,v0,1
  446b10:	02a2a821 	addu	s5,s5,v0
  446b14:	1603fffa 	bne	s0,v1,446b00 <cJSON_GetObjectItem@@Base+0x6854>
  446b18:	2472fffc 	addiu	s2,v1,-4
  446b1c:	12a00064 	beqz	s5,446cb0 <cJSON_GetObjectItem@@Base+0x6a04>
  446b20:	00000000 	nop
  446b24:	0c197dc8 	jal	65f720 <malloc@plt>
  446b28:	02a02025 	move	a0,s5
  446b2c:	1040007d 	beqz	v0,446d24 <cJSON_GetObjectItem@@Base+0x6a78>
  446b30:	0040b025 	move	s6,v0
  446b34:	0000f025 	move	s8,zero
  446b38:	2417000a 	li	s7,10
  446b3c:	8e930000 	lw	s3,0(s4)
  446b40:	0c197bc0 	jal	65ef00 <strlen@plt>
  446b44:	02602025 	move	a0,s3
  446b48:	00409025 	move	s2,v0
  446b4c:	02de2021 	addu	a0,s6,s8
  446b50:	025e9021 	addu	s2,s2,s8
  446b54:	00403025 	move	a2,v0
  446b58:	0c197e0c 	jal	65f830 <memcpy@plt>
  446b5c:	02602825 	move	a1,s3
  446b60:	02d21021 	addu	v0,s6,s2
  446b64:	a0570000 	sb	s7,0(v0)
  446b68:	8e820004 	lw	v0,4(s4)
  446b6c:	265e0001 	addiu	s8,s2,1
  446b70:	1602fff2 	bne	s0,v0,446b3c <cJSON_GetObjectItem@@Base+0x6890>
  446b74:	2454fffc 	addiu	s4,v0,-4
  446b78:	0c197dc8 	jal	65f720 <malloc@plt>
  446b7c:	02a02025 	move	a0,s5
  446b80:	10400080 	beqz	v0,446d84 <cJSON_GetObjectItem@@Base+0x6ad8>
  446b84:	00409025 	move	s2,v0
  446b88:	8e240010 	lw	a0,16(s1)
  446b8c:	02a03825 	move	a3,s5
  446b90:	afa00014 	sw	zero,20(sp)
  446b94:	afa20010 	sw	v0,16(sp)
  446b98:	02c03025 	move	a2,s6
  446b9c:	0c10d669 	jal	4359a4 <_ftext@@Base+0x121e4>
  446ba0:	27a50040 	addiu	a1,sp,64
  446ba4:	18400070 	blez	v0,446d68 <cJSON_GetObjectItem@@Base+0x6abc>
  446ba8:	0040a025 	move	s4,v0
  446bac:	8e240000 	lw	a0,0(s1)
  446bb0:	3c17005e 	lui	s7,0x5e
  446bb4:	0c197d48 	jal	65f520 <fopen@plt>
  446bb8:	26e5dfa4 	addiu	a1,s7,-8284
  446bbc:	10400068 	beqz	v0,446d60 <cJSON_GetObjectItem@@Base+0x6ab4>
  446bc0:	00408025 	move	s0,v0
  446bc4:	00403825 	move	a3,v0
  446bc8:	02a03025 	move	a2,s5
  446bcc:	24050001 	li	a1,1
  446bd0:	0c197d70 	jal	65f5c0 <fwrite@plt>
  446bd4:	02c02025 	move	a0,s6
  446bd8:	0c197ecc 	jal	65fb30 <fclose@plt>
  446bdc:	02002025 	move	a0,s0
  446be0:	8e240004 	lw	a0,4(s1)
  446be4:	0c197d48 	jal	65f520 <fopen@plt>
  446be8:	26e5dfa4 	addiu	a1,s7,-8284
  446bec:	10400054 	beqz	v0,446d40 <cJSON_GetObjectItem@@Base+0x6a94>
  446bf0:	00408025 	move	s0,v0
  446bf4:	00403825 	move	a3,v0
  446bf8:	02803025 	move	a2,s4
  446bfc:	24050001 	li	a1,1
  446c00:	0c197d70 	jal	65f5c0 <fwrite@plt>
  446c04:	02402025 	move	a0,s2
  446c08:	0c197ecc 	jal	65fb30 <fclose@plt>
  446c0c:	02002025 	move	a0,s0
  446c10:	3c04005e 	lui	a0,0x5e
  446c14:	2484cfec 	addiu	a0,a0,-12308
  446c18:	0c197f78 	jal	65fde0 <system@plt>
  446c1c:	00008025 	move	s0,zero
  446c20:	0c197bf4 	jal	65efd0 <free@plt>
  446c24:	02c02025 	move	a0,s6
  446c28:	12400012 	beqz	s2,446c74 <cJSON_GetObjectItem@@Base+0x69c8>
  446c2c:	00000000 	nop
  446c30:	0c197bf4 	jal	65efd0 <free@plt>
  446c34:	02402025 	move	a0,s2
  446c38:	1000000e 	b	446c74 <cJSON_GetObjectItem@@Base+0x69c8>
  446c3c:	00000000 	nop
  446c40:	3c05005e 	lui	a1,0x5e
  446c44:	3c04005e 	lui	a0,0x5e
  446c48:	2484ceec 	addiu	a0,a0,-12564
  446c4c:	0c197bcc 	jal	65ef30 <printf@plt>
  446c50:	24a52640 	addiu	a1,a1,9792
  446c54:	8e440000 	lw	a0,0(s2)
  446c58:	10800003 	beqz	a0,446c68 <cJSON_GetObjectItem@@Base+0x69bc>
  446c5c:	00000000 	nop
  446c60:	0c197bf4 	jal	65efd0 <free@plt>
  446c64:	00000000 	nop
  446c68:	02402025 	move	a0,s2
  446c6c:	0c197bf4 	jal	65efd0 <free@plt>
  446c70:	2410ffff 	li	s0,-1
  446c74:	0c197ce4 	jal	65f390 <pthread_mutex_unlock@plt>
  446c78:	8fa40058 	lw	a0,88(sp)
  446c7c:	8fbf0084 	lw	ra,132(sp)
  446c80:	02001025 	move	v0,s0
  446c84:	8fbe0080 	lw	s8,128(sp)
  446c88:	8fb7007c 	lw	s7,124(sp)
  446c8c:	8fb60078 	lw	s6,120(sp)
  446c90:	8fb50074 	lw	s5,116(sp)
  446c94:	8fb40070 	lw	s4,112(sp)
  446c98:	8fb3006c 	lw	s3,108(sp)
  446c9c:	8fb20068 	lw	s2,104(sp)
  446ca0:	8fb10064 	lw	s1,100(sp)
  446ca4:	8fb00060 	lw	s0,96(sp)
  446ca8:	03e00008 	jr	ra
  446cac:	27bd0088 	addiu	sp,sp,136
  446cb0:	8e240000 	lw	a0,0(s1)
  446cb4:	0c197d34 	jal	65f4d0 <unlink@plt>
  446cb8:	00008025 	move	s0,zero
  446cbc:	0c197d34 	jal	65f4d0 <unlink@plt>
  446cc0:	8e240004 	lw	a0,4(s1)
  446cc4:	1000ffeb 	b	446c74 <cJSON_GetObjectItem@@Base+0x69c8>
  446cc8:	00000000 	nop
  446ccc:	14a80004 	bne	a1,t0,446ce0 <cJSON_GetObjectItem@@Base+0x6a34>
  446cd0:	3c05005e 	lui	a1,0x5e
  446cd4:	0089202b 	sltu	a0,a0,t1
  446cd8:	1480ff3f 	bnez	a0,4469d8 <cJSON_GetObjectItem@@Base+0x672c>
  446cdc:	00000000 	nop
  446ce0:	3c04005e 	lui	a0,0x5e
  446ce4:	afa20010 	sw	v0,16(sp)
  446ce8:	afa30014 	sw	v1,20(sp)
  446cec:	24a52640 	addiu	a1,a1,9792
  446cf0:	0c197bcc 	jal	65ef30 <printf@plt>
  446cf4:	248425e8 	addiu	a0,a0,9704
  446cf8:	1000ffde 	b	446c74 <cJSON_GetObjectItem@@Base+0x69c8>
  446cfc:	00008025 	move	s0,zero
  446d00:	3c05005e 	lui	a1,0x5e
  446d04:	3c04005e 	lui	a0,0x5e
  446d08:	24a52640 	addiu	a1,a1,9792
  446d0c:	0c197bcc 	jal	65ef30 <printf@plt>
  446d10:	248425d8 	addiu	a0,a0,9688
  446d14:	26220028 	addiu	v0,s1,40
  446d18:	afa20058 	sw	v0,88(sp)
  446d1c:	1000ffd5 	b	446c74 <cJSON_GetObjectItem@@Base+0x69c8>
  446d20:	2410ffff 	li	s0,-1
  446d24:	3c05005e 	lui	a1,0x5e
  446d28:	3c04005e 	lui	a0,0x5e
  446d2c:	24a52640 	addiu	a1,a1,9792
  446d30:	0c197bcc 	jal	65ef30 <printf@plt>
  446d34:	2484ceec 	addiu	a0,a0,-12564
  446d38:	1000ffce 	b	446c74 <cJSON_GetObjectItem@@Base+0x69c8>
  446d3c:	2410ffff 	li	s0,-1
  446d40:	8e260004 	lw	a2,4(s1)
  446d44:	3c05005e 	lui	a1,0x5e
  446d48:	3c04005e 	lui	a0,0x5e
  446d4c:	24a52640 	addiu	a1,a1,9792
  446d50:	0c197bcc 	jal	65ef30 <printf@plt>
  446d54:	24842628 	addiu	a0,a0,9768
  446d58:	1000ffb1 	b	446c20 <cJSON_GetObjectItem@@Base+0x6974>
  446d5c:	2410ffff 	li	s0,-1
  446d60:	1000fff8 	b	446d44 <cJSON_GetObjectItem@@Base+0x6a98>
  446d64:	8e260000 	lw	a2,0(s1)
  446d68:	3c05005e 	lui	a1,0x5e
  446d6c:	3c04005e 	lui	a0,0x5e
  446d70:	24a52640 	addiu	a1,a1,9792
  446d74:	0c197bcc 	jal	65ef30 <printf@plt>
  446d78:	2484f858 	addiu	a0,a0,-1960
  446d7c:	1000ffa8 	b	446c20 <cJSON_GetObjectItem@@Base+0x6974>
  446d80:	2410ffff 	li	s0,-1
  446d84:	3c05005e 	lui	a1,0x5e
  446d88:	3c04005e 	lui	a0,0x5e
  446d8c:	24a52640 	addiu	a1,a1,9792
  446d90:	0c197bcc 	jal	65ef30 <printf@plt>
  446d94:	2484ceec 	addiu	a0,a0,-12564
  446d98:	1000ffa1 	b	446c20 <cJSON_GetObjectItem@@Base+0x6974>
  446d9c:	2410ffff 	li	s0,-1
  446da0:	27bdffa0 	addiu	sp,sp,-96
  446da4:	afb0004c 	sw	s0,76(sp)
  446da8:	3c10005e 	lui	s0,0x5e
  446dac:	24050006 	li	a1,6
  446db0:	26042670 	addiu	a0,s0,9840
  446db4:	afbf005c 	sw	ra,92(sp)
  446db8:	afb30058 	sw	s3,88(sp)
  446dbc:	afb20054 	sw	s2,84(sp)
  446dc0:	afb10050 	sw	s1,80(sp)
  446dc4:	afa00038 	sw	zero,56(sp)
  446dc8:	afa0003c 	sw	zero,60(sp)
  446dcc:	0c197eb4 	jal	65fad0 <access@plt>
  446dd0:	afa00040 	sw	zero,64(sp)
  446dd4:	2403ffff 	li	v1,-1
  446dd8:	1043002d 	beq	v0,v1,446e90 <cJSON_GetObjectItem@@Base+0x6be4>
  446ddc:	8fbf005c 	lw	ra,92(sp)
  446de0:	26042670 	addiu	a0,s0,9840
  446de4:	0c197e88 	jal	65fa20 <open@plt>
  446de8:	24050002 	li	a1,2
  446dec:	3c100067 	lui	s0,0x67
  446df0:	04400067 	bltz	v0,446f90 <cJSON_GetObjectItem@@Base+0x6ce4>
  446df4:	ae028f30 	sw	v0,-28880(s0)
  446df8:	24060004 	li	a2,4
  446dfc:	27a50044 	addiu	a1,sp,68
  446e00:	00402025 	move	a0,v0
  446e04:	0c197d28 	jal	65f4a0 <read@plt>
  446e08:	afa00044 	sw	zero,68(sp)
  446e0c:	3c020001 	lui	v0,0x1
  446e10:	2443020b 	addiu	v1,v0,523
  446e14:	8fa20044 	lw	v0,68(sp)
  446e18:	0043102b 	sltu	v0,v0,v1
  446e1c:	10400022 	beqz	v0,446ea8 <cJSON_GetObjectItem@@Base+0x6bfc>
  446e20:	3c110067 	lui	s1,0x67
  446e24:	0c15a823 	jal	56a08c <cJSON_GetObjectItem@@Base+0x129de0>
  446e28:	00000000 	nop
  446e2c:	8fa40044 	lw	a0,68(sp)
  446e30:	3c03005e 	lui	v1,0x5e
  446e34:	246329e0 	addiu	v1,v1,10720
  446e38:	afa40028 	sw	a0,40(sp)
  446e3c:	afa30020 	sw	v1,32(sp)
  446e40:	afa30018 	sw	v1,24(sp)
  446e44:	3c04005e 	lui	a0,0x5e
  446e48:	3c03005e 	lui	v1,0x5e
  446e4c:	24050051 	li	a1,81
  446e50:	248426ec 	addiu	a0,a0,9964
  446e54:	246326a8 	addiu	v1,v1,9896
  446e58:	3c07005e 	lui	a3,0x5e
  446e5c:	afa50024 	sw	a1,36(sp)
  446e60:	afa4001c 	sw	a0,28(sp)
  446e64:	afa50014 	sw	a1,20(sp)
  446e68:	afa30010 	sw	v1,16(sp)
  446e6c:	24e72684 	addiu	a3,a3,9860
  446e70:	24060002 	li	a2,2
  446e74:	00402825 	move	a1,v0
  446e78:	0c15a916 	jal	56a458 <cJSON_GetObjectItem@@Base+0x12a1ac>
  446e7c:	24040005 	li	a0,5
  446e80:	0c197ee0 	jal	65fb80 <close@plt>
  446e84:	8e048f30 	lw	a0,-28880(s0)
  446e88:	ae008f30 	sw	zero,-28880(s0)
  446e8c:	8fbf005c 	lw	ra,92(sp)
  446e90:	8fb30058 	lw	s3,88(sp)
  446e94:	8fb20054 	lw	s2,84(sp)
  446e98:	8fb10050 	lw	s1,80(sp)
  446e9c:	8fb0004c 	lw	s0,76(sp)
  446ea0:	03e00008 	jr	ra
  446ea4:	27bd0060 	addiu	sp,sp,96
  446ea8:	8e048f30 	lw	a0,-28880(s0)
  446eac:	3c12c004 	lui	s2,0xc004
  446eb0:	26268f34 	addiu	a2,s1,-28876
  446eb4:	0c197c78 	jal	65f1e0 <ioctl@plt>
  446eb8:	3645f427 	ori	a1,s2,0xf427
  446ebc:	04400055 	bltz	v0,447014 <cJSON_GetObjectItem@@Base+0x6d68>
  446ec0:	8e258f34 	lw	a1,-28876(s1)
  446ec4:	10a0ffee 	beqz	a1,446e80 <cJSON_GetObjectItem@@Base+0x6bd4>
  446ec8:	3c13006a 	lui	s3,0x6a
  446ecc:	3c06005e 	lui	a2,0x5e
  446ed0:	afa00010 	sw	zero,16(sp)
  446ed4:	24070001 	li	a3,1
  446ed8:	24c62778 	addiu	a2,a2,10104
  446edc:	0c133e79 	jal	4cf9e4 <cJSON_GetObjectItem@@Base+0x8f738>
  446ee0:	2664bfb0 	addiu	a0,s3,-16464
  446ee4:	0440ffe6 	bltz	v0,446e80 <cJSON_GetObjectItem@@Base+0x6bd4>
  446ee8:	2673bfb0 	addiu	s3,s3,-16464
  446eec:	8e630084 	lw	v1,132(s3)
  446ef0:	8e228f34 	lw	v0,-28876(s1)
  446ef4:	8e048f30 	lw	a0,-28880(s0)
  446ef8:	27a60038 	addiu	a2,sp,56
  446efc:	3645f428 	ori	a1,s2,0xf428
  446f00:	afa30040 	sw	v1,64(sp)
  446f04:	0c197c78 	jal	65f1e0 <ioctl@plt>
  446f08:	afa2003c 	sw	v0,60(sp)
  446f0c:	0441ffe0 	bgez	v0,446e90 <cJSON_GetObjectItem@@Base+0x6be4>
  446f10:	8fbf005c 	lw	ra,92(sp)
  446f14:	0c15a823 	jal	56a08c <cJSON_GetObjectItem@@Base+0x129de0>
  446f18:	00000000 	nop
  446f1c:	0c197d54 	jal	65f550 <__errno_location@plt>
  446f20:	00408825 	move	s1,v0
  446f24:	0c197f40 	jal	65fd00 <strerror@plt>
  446f28:	8c440000 	lw	a0,0(v0)
  446f2c:	afa20028 	sw	v0,40(sp)
  446f30:	3c02005e 	lui	v0,0x5e
  446f34:	24422784 	addiu	v0,v0,10116
  446f38:	afa2001c 	sw	v0,28(sp)
  446f3c:	3c03005e 	lui	v1,0x5e
  446f40:	3c02005e 	lui	v0,0x5e
  446f44:	246329e0 	addiu	v1,v1,10720
  446f48:	24040067 	li	a0,103
  446f4c:	244226a8 	addiu	v0,v0,9896
  446f50:	3c07005e 	lui	a3,0x5e
  446f54:	02202825 	move	a1,s1
  446f58:	afa40024 	sw	a0,36(sp)
  446f5c:	afa30020 	sw	v1,32(sp)
  446f60:	afa30018 	sw	v1,24(sp)
  446f64:	afa40014 	sw	a0,20(sp)
  446f68:	afa20010 	sw	v0,16(sp)
  446f6c:	24e72684 	addiu	a3,a3,9860
  446f70:	24060002 	li	a2,2
  446f74:	0c15a916 	jal	56a458 <cJSON_GetObjectItem@@Base+0x12a1ac>
  446f78:	24040005 	li	a0,5
  446f7c:	8e650080 	lw	a1,128(s3)
  446f80:	0c1341be 	jal	4d06f8 <cJSON_GetObjectItem@@Base+0x9044c>
  446f84:	02602025 	move	a0,s3
  446f88:	1000ffbd 	b	446e80 <cJSON_GetObjectItem@@Base+0x6bd4>
  446f8c:	00000000 	nop
  446f90:	0c15a823 	jal	56a08c <cJSON_GetObjectItem@@Base+0x129de0>
  446f94:	00000000 	nop
  446f98:	0c197d54 	jal	65f550 <__errno_location@plt>
  446f9c:	00408025 	move	s0,v0
  446fa0:	0c197f40 	jal	65fd00 <strerror@plt>
  446fa4:	8c440000 	lw	a0,0(v0)
  446fa8:	afa20028 	sw	v0,40(sp)
  446fac:	3c02005e 	lui	v0,0x5e
  446fb0:	2442268c 	addiu	v0,v0,9868
  446fb4:	afa2001c 	sw	v0,28(sp)
  446fb8:	3c03005e 	lui	v1,0x5e
  446fbc:	3c02005e 	lui	v0,0x5e
  446fc0:	246329e0 	addiu	v1,v1,10720
  446fc4:	24040049 	li	a0,73
  446fc8:	244226a8 	addiu	v0,v0,9896
  446fcc:	3c07005e 	lui	a3,0x5e
  446fd0:	afa40024 	sw	a0,36(sp)
  446fd4:	afa30020 	sw	v1,32(sp)
  446fd8:	afa30018 	sw	v1,24(sp)
  446fdc:	afa40014 	sw	a0,20(sp)
  446fe0:	afa20010 	sw	v0,16(sp)
  446fe4:	02002825 	move	a1,s0
  446fe8:	24e72684 	addiu	a3,a3,9860
  446fec:	24060002 	li	a2,2
  446ff0:	0c15a916 	jal	56a458 <cJSON_GetObjectItem@@Base+0x12a1ac>
  446ff4:	24040006 	li	a0,6
  446ff8:	8fbf005c 	lw	ra,92(sp)
  446ffc:	8fb30058 	lw	s3,88(sp)
