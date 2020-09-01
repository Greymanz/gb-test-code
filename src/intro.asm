INCLUDE "defines.asm"

SECTION "Intro", ROMX

Intro::
	ld hl, vSpriteTile
	ld de, SpriteTile
	ld c, SpriteTile.end - SpriteTile
	call LCDMemcpySmall


	ld hl, wShadowOAM
	ld a, 16 + 16
	ld [hli], a
	ld [hli], a
	xor a
	ld [hli], a
	ld [hli], a

	ld a, h
	ld [hOAMHigh], a

	ld c, NB_SPRITES - 1
    xor a
    ld  hl, wShadowOAM + 4
.clearSprites
    ld [hli], a
    inc l ; inc hl
    inc l ; inc hl
    inc l ; inc hl
    dec c
    jr nz, .clearSprites


	ld a, LCDCF_ON | LCDCF_OBJON
	ld [hLCDC], a


.lockup
	rst WaitVBlank
	jr .lockup

SECTION "1 Tile Sprite", ROM0
	
SpriteTile:
	INCBIN "res/sprite.2bpp"
.end

SECTION UNION "8000 tile block", VRAM[$8000]

vSpriteTile:
    ds 16
