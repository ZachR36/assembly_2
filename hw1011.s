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
    movq $0, %rax
    # Collect all three values
    movslq (%rdi), %rsi # id
    movq 8(%rdi), %rax # reading
    movslq 16(%rdi), %rdx # weight
    # Combine the values
    imulq %rdx, %rax
    addq %rsi, %rax
    ret

    .globl sensor_array_total
    .type sensor_array_total, @function
sensor_array_total:
    movq $0, %rcx
    cmpq $0, %rsi
    jle finished_4 # Do nothing if the array is empty or NULL
    # Make %r8 a pointer to check when we're done
    movq $24, %rdx
    imulq %rsi, %rdx
    addq %rdi, %rdx
add_sensor:
    # Before calling sensor score, save the array pointer, the end pointer, and the sum
    pushq %rdi
    pushq %rdx
    pushq %rcx
    call sensor_score
    # Add to the total score
    popq %rcx
    addq %rax, %rcx
    # Get back and update the pointers
    popq %rdx
    popq %rdi
    addq $24, %rdi
    # Check if we're done
    cmpq %rdi, %rdx
    jg add_sensor
finished_4:
    movq %rcx, %rax
    ret

    .globl make_arithmetic_sequence
    .type make_arithmetic_sequence, @function
make_arithmetic_sequence:
    movq $0, %rax
    cmpq $0, %rdx
    jle finished_5
    # Save the inputs, then call malloc
    pushq %rdi
    pushq %rsi
    pushq %rdx
    movq $8, %rdi
    imulq %rdx, %rdi
    call malloc
    popq %rdx
    popq %rsi
    popq %rdi
    cmpq $0, %rax
    je no_space
    # If we got space on heap, set up to fill the array
    movq %rax, %rcx # Hold memory address on heap
    jmp fill_array
no_space:
    movq $0, %rax
    jmp finished_5
fill_array:
    movq %rdi, (%rcx)
    # Check if we're done
    subq $1, %rdx
    cmpq $0, %rdx
    je finished_5
    # Set up for next iteration
    addq $8, %rcx
    addq %rsi, %rdi
    jmp fill_array

finished_5:
    ret # Either zero or the starting point of the array

    .globl make_sensor
    .type make_sensor, @function
make_sensor:
    movq $0, %rax
    pushq %rdi
    pushq %rsi
    pushq %rdx
    movq $24, %rdi
    call malloc
    popq %rdx
    popq %rsi
    popq %rdi
    cmpq $0, %rax
    je finished_make
    # If we got memory, store the sensor here
    movl %edi, (%rax)
    movq %rsi, 8(%rax)
    movl %edx, 16(%rax)
finished_make:
    ret

    .globl sensor_destroy
    .type sensor_destroy, @function
sensor_destroy:
    cmpq $0, %rdi
    je finished_destroy
    subq $8, %rsp
    call free
    addq $8, %rsp
finished_destroy:
    ret

    .section .note.GNU-stack,"",@progbits
