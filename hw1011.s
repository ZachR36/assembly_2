.text

    .globl sum_positive_ints
    .type sum_positive_ints, @function
sum_positive_ints:
    movq $0, %rax
    cmpq $0, %rsi # No elements to sum
    jle finished
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
    je finished
    jmp sum_loop
finished:
    ret

    .globl reverse_longs
    .type reverse_longs, @function
reverse_longs:
    # TODO: Problem 2
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
