.data
N1: .word 512
N2: .word 480
str1: .string "GCD value of "
str2: .string " and "
str3: .string " is "

.text
main:
        lw      a0, N1
        lw      a1, N2
        jal     ra, gcd
        jal     ra, print
        # Exit program
        li       a0, 10
        ecall

gcd:
        addi    sp,sp, -16
        sw      ra,0(sp)
        sw      s0,4(sp)
        
        beq     a1, zero, finish
        mv      s0, a1
        rem     a1, a0, a1
        mv      a0, s0
        jal     ra, gcd
        
        lw      ra,0(sp)
        lw      s0,4(sp)
        addi    sp,sp, 16
 
finish:
        ret     

print:
        
        mv      s0, a0
        li      a0, 4
        la      a1, str1
        ecall

        li      a0, 1
        lw      a1, N1
        ecall

        li      a0, 4
        la      a1, str2
        ecall

        li      a0, 1
        lw      a1, N2
        ecall

        li      a0, 4
        la      a1, str3
        ecall

        li      a0, 1
        mv      a1, s0
        ecall

        ret
        

    





        