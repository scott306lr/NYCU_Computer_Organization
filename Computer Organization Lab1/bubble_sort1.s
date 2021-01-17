.data
str1: .string "Array: "
str2: .string "Sorted: "
space: .string " "
newline: .string "\n"

.text
main:
        # s0: arr  s1: N
	     li			sp, 0
        li       s0, 1000
        li       s1, 10
        # Load array
        li       t0, 5
        sw       t0, 0(s0)
        li       t0, 3
        sw       t0, 4(s0)
        li       t0, 6
        sw       t0, 8(s0)
        li       t0, 7
        sw       t0, 12(s0)
        li       t0, 31
        sw       t0, 16(s0)
        li       t0, 23
        sw       t0, 20(s0)
        li       t0, 43
        sw       t0, 24(s0)
        li       t0, 12
        sw       t0, 28(s0)
        li       t0, 45
        sw       t0, 32(s0)
        li       t0, 1
        sw       t0, 36(s0)

        jal      ra, printArray 
        # a0: i=0
        mv       a0, zero   
        jal      ra, icompare
	    jal      ra, printsorted
        # Exit program
        li       a0, 10
        ecall

icompare:
        # i<N

        bge      a0, s1, end

        addi     sp, sp, -4
        sw       ra, 0(sp)
        addi     a1, a0, -1
        jal      ra, jcompare
        # i++
        addi     a0, a0, 1

        lw       ra, 0(sp) 
        addi     sp, sp, 4
        j        icompare
end:
        ret

jcompare:
        # j >= 0
        blt     a1, zero, end

        
        # data[j] > data[j+1]
        slli    t0, a1, 2
        add     t1, t0, s0
        addi    t2, t1, 4
        lw      t2, 0(t1)
        lw      t3, 0(t2)   
        bge     t3, t2, end

		addi    sp, sp, -4
        sw      ra, 0(sp)
        # execute swap
        jal     ra, swap
        # j--
        addi    a1, a1, -1

        lw      ra, 0(sp)
        addi    sp, sp, 4    
        j       jcompare

swap:
        sw      t3, 0(t0)
        sw      t2, 0(t1)
        ret


printArray:
        la       a1, str1
        li       a0, 4   
        ecall
        # a2: i=0
        mv       a2, zero
        
        addi     sp, sp, -12
        sw       ra, 8(sp)
        sw       a1, 4(sp)
        sw       a1, 0(sp)
        jal      ra, pArr

        la       a1, newline
        li       a0, 4
        ecall

        lw       a1, 0(sp)
        lw       a0, 4(sp)
        lw       ra, 8(sp)
        addi     sp, sp, 12
        ret   
pArr:
        bge      a2, s1, end

        addi     sp, sp, -4
        sw       ra, 0(sp)
        # print array
        slli     t0, a2, 2
        add      t1, t0, s0
        lw       a1, 0(t1)
        li       a0, 1
        ecall

        la       a1, space
        li       a0, 4
        ecall
        # i++
        addi     a2, a2, 1

        lw       ra, 0(sp)
        addi     sp, sp, 4
        j        pArr
   
printSorted:
        la       a1, str2
        li       a0, 4   
        ecall
        # a2: i=0
        mv       a2, zero
        
        addi     sp, sp, -12
        sw       ra, 8(sp)
        sw       a0, 4(sp)
        sw       a1, 0(sp)
        jal      ra, pArr

        la       a1, newline
        li       a0, 4
        ecall

        lw       a1, 0(sp)
        lw       a0, 4(sp)
        lw       ra, 8(sp)
        addi     sp, sp, 12
        ret   

