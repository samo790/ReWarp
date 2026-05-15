==============================================================================
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
    dc.w    0               ; lib_NegSize (Calcolato dinamicamente)
    dc.w    MY_LIB_VER      
    dc.w    MY_LIB_REV      
    dc.l    idString        ; Puntatore alla stringa ID
    dc.l    0               ; lib_Sum
    dc.w    0               ; lib_OpenCnt

    ; --- Macro di aggancio corretto per i vettori ---
    macro PUP_STUB lvo, id
        dc.w    \lvo
        dc.w    $4EF8, $0004   ; Trappola d'ambiente per il bridge
        dc.l    \id
    endm

    ; --- LA JUMP TABLE REALINEATA SUI VETTORI UFFICIALI PHASE5 ---
    ; Nota: Gli offset devono corrispondere millimetricamente a ppc.library originale
    PUP_STUB -6,  100               ; Open
    PUP_STUB -12, 101               ; Close
    PUP_STUB -18, 102               ; Expunge
    PUP_STUB -24, 103               ; Reserved
    
    PUP_STUB -30,  1                ; PPCGetAttrsA
    PUP_STUB -36,  2                ; PPCSetAttrsA
    PUP_STUB -42,  3                ; PPCAllocMem
    PUP_STUB -48,  4                ; PPCFreeMem
    PUP_STUB -54,  5                ; PPCCreateTaskA (La chiamata chiave)
    PUP_STUB -60,  6                ; PPCDeleteTask
    PUP_STUB -66,  7                ; PPCWait
    PUP_STUB -72,  8                ; PPCSignal
    PUP_STUB -78,  9                ; PPCGetNextPPCMsg
    PUP_STUB -84,  10               ; PPCPutPPCMsg
    PUP_STUB -90,  11               ; PPCRepPPCMsg
    PUP_STUB -96,  12               ; PPCAllocPPCMsg
    PUP_STUB -102, 13               ; PPCFreePPCMsg
    PUP_STUB -108, 14               ; PPCAllocSemaphore
    PUP_STUB -114, 15               ; PPCFreeSemaphore
    PUP_STUB -120, 16               ; PPCObtainSemaphore
    PUP_STUB -126, 17               ; PPCAttemptSemaphore
    PUP_STUB -132, 18               ; PPCReleaseSemaphore
    PUP_STUB -138, 19               ; PPCFindTask
    PUP_STUB -144, 20               ; PPCObtain
    dc.w    0                       ; Fine tabella obbligatoria

    ; --- Dati Identificativi ---
    IF TARGET_PPC=0
libName:  dc.b "powerup.library",0
    ELSE
libName:  dc.b "ppc.library",0
    ENDC

    CNOP 0,2
idString: 
    IF TARGET_PPC=0
    dc.b "$VER: powerup.library 18.2 (15.05.2026)",0
    ELSE
    dc.b "$VER: ppc.library 18.2 (15.05.2026)",0
    ENDC

    EVEN
