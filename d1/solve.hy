(defn skip [it n]
  (next (islice it n n) None))

(def contents (-> (open "input") (.read) (.strip)))

(def size (len contents))

(def numbers (genexpr
               (int num)
               (num contents)))

(def [fst snd] (tee (cycle numbers)))
(skip snd 1)
; (skip snd (// size 2))

(def ans
  (sum (genexpr a
        ([a b]
         (islice (zip fst snd) size))
        (= a b))))

(print ans)
