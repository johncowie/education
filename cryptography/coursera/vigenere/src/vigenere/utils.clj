(ns vigenere.utils)

(defn hex-to-int [h]
  (Integer/parseInt h 16))

(defn int-to-hex [i]
  (format "%X" i))

(defn hex-string-to-ints [s]
  (->> s
       (partition 2)
       (map (partial apply str))
       (map hex-to-int)))

(defn prepad [c n s]
  (->>
   (concat (reverse s) (repeat c))
      (take n)
      reverse
      (reduce str)))

(defn byte-int-to-binary [i]
  (->>
   (Integer/toString i 2)
   (prepad \0 8)))
