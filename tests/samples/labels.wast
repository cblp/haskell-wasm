(module
  (func (export "block") (result i32)
    (block $exit (result i32)
      (br $exit (i32.const 1))
      (i32.const 0)
    )
  )

  (func (export "loop1") (result i32)
    (local $i i32)
    (set_local $i (i32.const 0))
    (block $exit (result i32)
      (loop $cont (result i32)
        (set_local $i (i32.add (get_local $i) (i32.const 1)))
        (if (i32.eq (get_local $i) (i32.const 5))
          (then (br $exit (get_local $i)))
        )
        (br $cont)
      )
    )
  )

  (func (export "loop2") (result i32)
    (local $i i32)
    (set_local $i (i32.const 0))
    (block $exit (result i32)
      (loop $cont (result i32)
        (set_local $i (i32.add (get_local $i) (i32.const 1)))
        (if (i32.eq (get_local $i) (i32.const 5))
          (then (br $cont))
        )
        (if (i32.eq (get_local $i) (i32.const 8))
          (then (br $exit (get_local $i)))
        )
        (set_local $i (i32.add (get_local $i) (i32.const 1)))
        (br $cont)
      )
    )
  )

  (func (export "loop3") (result i32)
    (local $i i32)
    (set_local $i (i32.const 0))
    (block $exit (result i32)
      (loop $cont (result i32)
        (set_local $i (i32.add (get_local $i) (i32.const 1)))
        (if (i32.eq (get_local $i) (i32.const 5))
          (then (br $exit (get_local $i)))
        )
        (get_local $i)
      )
    )
  )

  (func (export "loop4") (param $max i32) (result i32)
    (local $i i32)
    (set_local $i (i32.const 1))
    (block $exit (result i32)
      (loop $cont (result i32)
        (set_local $i (i32.add (get_local $i) (get_local $i)))
        (if (i32.gt_u (get_local $i) (get_local $max))
          (then (br $exit (get_local $i)))
        )
        (br $cont)
      )
    )
  )

  (func (export "loop5") (result i32)
    (i32.add
      (loop $l (result i32) (i32.const 1))
      (i32.const 1)
    )
  )

  (func (export "if") (result i32)
    (local $i i32)
    (set_local $i (i32.const 0))
    (block
      (if $l
        (i32.const 1)
        (then (br $l) (set_local $i (i32.const 666)))
      )
      (set_local $i (i32.add (get_local $i) (i32.const 1)))
      (if $l
        (i32.const 1)
        (then (br $l) (set_local $i (i32.const 666)))
        (else (set_local $i (i32.const 888)))
      )
      (set_local $i (i32.add (get_local $i) (i32.const 1)))
      (if $l
        (i32.const 1)
        (then (br $l) (set_local $i (i32.const 666)))
        (else (set_local $i (i32.const 888)))
      )
      (set_local $i (i32.add (get_local $i) (i32.const 1)))
      (if $l
        (i32.const 0)
        (then (set_local $i (i32.const 888)))
        (else (br $l) (set_local $i (i32.const 666)))
      )
      (set_local $i (i32.add (get_local $i) (i32.const 1)))
      (if $l
        (i32.const 0)
        (then (set_local $i (i32.const 888)))
        (else (br $l) (set_local $i (i32.const 666)))
      )
      (set_local $i (i32.add (get_local $i) (i32.const 1)))
    )
    (get_local $i)
  )

  (func (export "if2") (result i32)
    (local $i i32)
    (set_local $i (i32.const 0))
    (block
      (if
        (i32.const 1)
        (then (br 0) (set_local $i (i32.const 666)))
      )
      (set_local $i (i32.add (get_local $i) (i32.const 1)))
      (if
        (i32.const 1)
        (then (br 0) (set_local $i (i32.const 666)))
        (else (set_local $i (i32.const 888)))
      )
      (set_local $i (i32.add (get_local $i) (i32.const 1)))
      (if
        (i32.const 1)
        (then (br 0) (set_local $i (i32.const 666)))
        (else (set_local $i (i32.const 888)))
      )
      (set_local $i (i32.add (get_local $i) (i32.const 1)))
      (if
        (i32.const 0)
        (then (set_local $i (i32.const 888)))
        (else (br 0) (set_local $i (i32.const 666)))
      )
      (set_local $i (i32.add (get_local $i) (i32.const 1)))
      (if
        (i32.const 0)
        (then (set_local $i (i32.const 888)))
        (else (br 0) (set_local $i (i32.const 666)))
      )
      (set_local $i (i32.add (get_local $i) (i32.const 1)))
    )
    (get_local $i)
  )

  (func (export "switch") (param i32) (result i32)
    (block $ret (result i32)
      (i32.mul (i32.const 10)
        (block $exit (result i32)
          (block $0
            (block $default
              (block $3
                (block $2
                  (block $1
                    (br_table $0 $1 $2 $3 $default (get_local 0))
                  ) ;; 1
                ) ;; 2
                (br $exit (i32.const 2))
              ) ;; 3
              (br $ret (i32.const 3))
            ) ;; default
          ) ;; 0
          (i32.const 5)
        )
      )
    )
  )

  (func (export "return") (param i32) (result i32)
    (block $default
      (block $1
        (block $0
          (br_table $0 $1 (get_local 0))
          (br $default)
        ) ;; 0
        (return (i32.const 0))
      ) ;; 1
    ) ;; default
    (i32.const 2)
  )

  (func (export "br_if0") (result i32)
    (local $i i32)
    (set_local $i (i32.const 0))
    (block $outer (result i32)
      (block $inner
        (br_if $inner (i32.const 0))
        (set_local $i (i32.or (get_local $i) (i32.const 0x1)))
        (br_if $inner (i32.const 1))
        (set_local $i (i32.or (get_local $i) (i32.const 0x2)))
      )
      (drop (br_if $outer
        (block (result i32)
          (set_local $i (i32.or (get_local $i) (i32.const 0x4)))
          (get_local $i)
        )
        (i32.const 0)
      ))
      (set_local $i (i32.or (get_local $i) (i32.const 0x8)))
      (drop (br_if $outer
        (block (result i32)
          (set_local $i (i32.or (get_local $i) (i32.const 0x10)))
          (get_local $i)
        )
        (i32.const 1)
      ))
      (set_local $i (i32.or (get_local $i) (i32.const 0x20))) (get_local $i)
    )
  )

  (func (export "br_if1") (result i32)
    (block $l0 (result i32)
      (drop
        (br_if $l0
          (block $l1 (result i32) (br $l1 (i32.const 1)))
          (i32.const 1)
        )
      )
      (i32.const 1)
    )
  )

  (func (export "br_if2") (result i32)
    (block $l0 (result i32)
      (if (i32.const 1)
        (then (br $l0 (block $l1 (result i32) (br $l1 (i32.const 1)))))
      )
      (i32.const 1)
    )
  )

  (func (export "br_if3") (result i32)
    (local $i1 i32)
    (drop
      (i32.add
        (block $l0 (result i32)
          (drop (br_if $l0
            (block (result i32) (set_local $i1 (i32.const 1)) (get_local $i1))
            (block (result i32) (set_local $i1 (i32.const 2)) (get_local $i1))
          ))
          (i32.const 0)
        )
        (i32.const 0)
      )
    )
    (get_local $i1)
  )

  (func (export "br") (result i32)
    (block $l0 (result i32)
      (if (i32.const 1)
        (then (br $l0 (block $l1 (result i32) (br $l1 (i32.const 1)))))
        (else (block (drop (block $l1 (result i32) (br $l1 (i32.const 1))))))
      )
      (i32.const 1)
    )
  )

  (func (export "shadowing") (result i32)
    (block $l1 (result i32) (i32.xor (br $l1 (i32.const 1)) (i32.const 2)))
  )

  (func (export "redefinition") (result i32)
    (block $l1 (result i32)
      (i32.add
        (block $l1 (result i32) (i32.const 2))
        (block $l1 (result i32) (br $l1 (i32.const 3)))
      )
    )
  )
)