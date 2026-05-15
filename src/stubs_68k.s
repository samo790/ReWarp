; ==============================================================================
; POWERUP/PPC.LIBRARY 68K STUB GENERATOR - PROJECT SYNC
; Version: 18.2
; ==============================================================================
;
; vasmm68k_mot -Fhunk -DTARGET_PPC=0 -o LIBS:powerup.library stubs_68k.s
; vasmm68k_mot -Fhunk -DTARGET_PPC=1 -o LIBS:ppc.library stubs_68k.s
;
; --- CONFIGURAZIONE VERSIONING ---
MY_LIB_VER  EQU 18
MY_LIB_REV  EQU 2

; --- TARGET SWITCH (0=PowerUP, 1=PPC) ---
; Può essere impostato via riga di comando con -DTARGET_PPC=1
    IFND TARGET_PPC
TARGET_PPC  EQU 0       
    ENDC

    SECTION "Code",CODE

    ; --- Struttura Standard Library Amiga ---
    dc.l    0               ; ln_Succ
    dc.l    0               ; ln_Pred
    dc.b    9               ; ln_Type (NT_LIBRARY)
    dc.b    0               ; ln_Pri
    dc.l    libName         ; ln_Name
    dc.b    105             ; lib_Flags (LIBF_SUMUSED|LIBF_CHANGED)
    dc.b    0               ; pad
    dc.w    34              ; lib_PosSize
    dc.w    0               ; lib_NegSize (Verrà calcolato dall'assembler)
    dc.w    MY_LIB_VER      ; Version 18
    dc.w    MY_LIB_REV      ; Revision 2
    dc.l    idString        ; Puntatore alla stringa ID
    dc.l    0               ; lib_Sum
    dc.w    0               ; lib_OpenCnt

    ; --- Macro Magic Trap con ID ---
    macro PUP_STUB lvo, id
        dc.w    \lvo
        dc.w    $4EF8, $0004
        dc.l    \id
    endm

    ; --- La Jump Table 68k ---
    PUP_STUB -6,  100               ; Open
    PUP_STUB -12, 101               ; Close
    PUP_STUB -18, 102               ; Expunge
    PUP_STUB -24, 103               ; Reserved
    PUP_STUB -30,  1                ; RunPPC_Master
    PUP_STUB -54,  2                ; AllocSignalPPC
    PUP_STUB -60,  3                ; FreeSignalPPC
    PUP_STUB -90,  4                ; GetPPCState
    PUP_STUB -300, 5                ; SetSignalPPC
    PUP_STUB -306, 6                ; SPrintF_Real (VPrintf)
    PUP_STUB -318, 7                ; AvailMem_Wrapper
    PUP_STUB -324, 8                ; AllocVecPPC_Magic
    PUP_STUB -330, 9                ; FreeVecPPC_Magic
    PUP_STUB -336, 1                ; RunPPC (Re-entry)
    PUP_STUB -378, 10               ; ObtainSemaphorePPC
    PUP_STUB -390, 11               ; ReleaseSemaphorePPC
    PUP_STUB -492, 12               ; WaitPPC
    PUP_STUB -498, 13               ; NewList
    PUP_STUB -594, 14               ; WaitTime_Wrapper
    PUP_STUB -600, 15               ; GetInfo
    PUP_STUB -606, 16               ; CreateMsgPortPPC
    PUP_STUB -612, 17               ; DeleteMsgPortPPC
    PUP_STUB -636, 18               ; PutMsgPPC
    PUP_STUB -642, 19               ; GetMsgPPC
    PUP_STUB -648, 20               ; ReplyMsgPPC
    dc.w    0                       ; Fine tabella

    ; --- Dati Identificativi (Standard AmigaOS) ---
    IF TARGET_PPC=0
libName:  dc.b "powerup.library",0
    ELSE
libName:  dc.b "ppc.library",0
    ENDC

    ; Nota: La stringa deve iniziare con $VER: per essere letta dal comando Version
    CNOP 0,2
idString: 
    IF TARGET_PPC=0
    dc.b "$VER: powerup.library 18.2 (10.05.2026) Gold",0
    ELSE
    dc.b "$VER: ppc.library 18.2 (10.05.2026) Gold",0
    ENDC

    EVEN

