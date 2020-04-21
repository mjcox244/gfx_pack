[XCX_LOOT_FORCECHEST]
moduleMatches = 0xF882D5CF, 0x30B6E091, 0xAB97DE6B ; 1.0.1E, 1.0.2U, 1.0.1U

.origin = codecave

.int $forced
.int $treasure

; ----------------------------------------------------------------------------
; WHO  : ItemDrop::CItemDropManager::calcRank((unsigned short, int))
; WHAT : Force the chest quality

_goForced:
li r28, $treasure
li r4, $forced
cmpwi r4, 1
bne exit_goForced
mr. r28, r28
blr
exit_goForced:
mr. r28, r3
blr

0x021AAFA4 = bla _goForced

; ----------------------------------------------------------------------------
; WHO  : ItemDrop::CItemDropManager::calcRank((unsigned short, int))
; WHAT : Override the chest quality you get when the game initially decided you get no chest at all
;      : It's a bit tough to explain, but the function calcRank does this:
;      : 1) Calculate luck for gold chest, if success exit with gold quality (1), else process next step
;      : 2) Calculate luck for silver chest, if success exit with silver quality (2), else process next step
;      : 3) Calculate luck for bronze chest, if success exit with bronze quality (3), else process next step
;      : 4) No chest at all, exit with no chest (0)
;      : --> The mod below only changes this last step. So even if you put value 1 (gold chest), you'll still get a silver chest if the game succeeded the step 2.

0x21AAF18 = li r3, $treasure ; li r3, 1 ; 0 = nothing (default), 1 = gold, 2 = silver, 3 = bronze