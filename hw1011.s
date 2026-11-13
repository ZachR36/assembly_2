.text

    .globl sum_positive_ints
    .type sum_positive_ints, @function
sum_positive_ints:
    movq $0, %rax
    cmpq $0, %rsi # No elements to sum
    jle finished_1
sum_loop:
    # If nonnegative, add this one
    cmpl $0, (%rdi)
    jge add_case
    jmp next_int
add_case:
    movl (%rdi), %r10d
    addq %r10, %rax
next_int:
    addq $4, %rdi # Move array pointer to the next element
    # Alter n, see if we should keep going
    subq $1, %rsi
    cmpq $0, %rsi
    je finished_1
    jmp sum_loop
finished_1:
    ret

    .globl reverse_longs
    .type reverse_longs, @function
reverse_longs:
    cmpq $1, %rsi # If the array is size 1 or 0/potentially NULL, we're done
    jle finished_2
    # Make a pointer to the last element
    movq $8, %rdx
    imulq %rsi, %rdx
    addq %rdi, %rdx
    subq $8, %rdx # Now it points to the last element
reverse:
    # Store the first and last elements
    movq (%rdi), %rcx
    movq (%rdx), %r8
    # Swap them
    movq %rcx, (%rdx)
    movq %r8, (%rdi)
    # Update the pointers
    addq $8, %rdi
    subq $8, %rdx
    # Check if we're done
    cmpq %rdi, %rdx
    ja reverse # If the second pointer is at a higher element, keep going
finished_2:
    ret

    .globl sensor_score
    .type sensor_score, @function
sensor_score:
    # TODO: Problem 3
    movq $0, %rax
    ret

    .globl sensor_array_total
    .type sensor_array_total, @function
sensor_array_total:
    # TODO: Problem 4
    movq $0, %rax
    ret

    .globl make_arithmetic_sequence
    .type make_arithmetic_sequence, @function
make_arithmetic_sequence:
    # TODO: Problem 5
    movq $0, %rax
    ret

    .globl make_sensor
    .type make_sensor, @function
make_sensor:
    # TODO: Problem 6A
    movq $0, %rax
    ret

    .globl sensor_destroy
    .type sensor_destroy, @function
sensor_destroy:
    # TODO: Problem 6B
    ret

    .section .note.GNU-stack,"",@progbits
