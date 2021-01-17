.data
N: .word 10
str1: .string "th number in the Fibonacci sequence is "

.text
main:
        lw      a0, N
        jal     ra, fibonacci
        jal     ra, print

        # Exit program
        li       a0, 10
        ecall



fibonacci:
        li      t0,2
        blt     a0, t0, fin
        # less then 2, finish

        addi    sp, sp, -8
        sw      ra, 4(sp)
        sw      s0, 0(sp)

        mv      s0, a0
        addi    a0, a0, -1
        jal     ra, fibonacci
        mv      t0, s0
        mv      s0, a0
        addi    a0, t0, -2
        jal     ra, fibonacci
        add     a0, s0, a0

        lw      s0, 0(sp)
        lw      ra, 4(sp)
        addi    sp, sp, 8
fin:
        ret

print:
        mv      s0, a0
        li      a0, 1
        lw      a1, N
        ecall

        li      a0, 4
        la      a1, str1
        ecall

        li      a0, 1 
        mv      a1, s0
        ecall

        ret