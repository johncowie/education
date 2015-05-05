(ns vigenere.one-time-pad
  (:require [vigenere.utils :refer :all]
            [clojure.set :refer [intersection union difference]]))

(def rawciphertexts
  ["BB3A65F6F0034FA957F6A767699CE7FABA855AFB4F2B520AEAD612944A801E"
   "BA7F24F2A35357A05CB8A16762C5A6AAAC924AE6447F0608A3D11388569A1E"
   "A67261BBB30651BA5CF6BA297ED0E7B4E9894AA95E300247F0C0028F409A1E"
   "A57261F5F0004BA74CF4AA2979D9A6B7AC854DA95E305203EC8515954C9D0F"
   "BB3A70F3B91D48E84DF0AB702ECFEEB5BC8C5DA94C301E0BECD241954C831E"
   "A6726DE8F01A50E849EDBC6C7C9CF2B2A88E19FD423E0647ECCB04DD4C9D1E"
   "BC7570BBBF1D46E85AF9AA6C7A9CEFA9E9825CFD5E3A0047F7CD009305A71E"])

(def space 32)

(def ciphertexts
  (map hex-string-to-ints rawciphertexts))

(defn is-one-space? [i]
  (-> i
      byte-int-to-binary
      (subs 0 2)
      (= "01")))

(defn options-for-byte [byteA byteB]
  (let [x (bit-xor byteA byteB)]
    (if (is-one-space? x)
      #{space (bit-xor x space)}
      #{})))

(defn lookup-byte [ciphertexts m c]
  (-> ciphertexts (nth m) (nth c)))

(defn add-info-for-byte [ciphertexts info [[m1 c1] [m2 c2]]]
  (let [byteA (lookup-byte ciphertexts m1 c1)
        byteB (lookup-byte ciphertexts m2 c2)
        options (options-for-byte byteA byteB)]
    (-> info
        (assoc-in [[m1 c1] :byte] byteA)
        (update-in [[m1 c1] :options] union options)
        (assoc-in [[m2 c2] :byte] byteB)
        (update-in [[m2 c2] :options] union options))))

(map vector (repeat 2) (range 0 2))

(defn message-combinations [n]
  (if (= n 2)
    [[1 0]]
    (concat (map vector (repeat (dec n)) (range 0 (dec n)))
            (message-combinations (dec n)))))

(defn byte-pairings [n ml]
  (mapcat (fn [[m1 m2]] (map (fn [i] [[m1 i] [m2 i]]) (range 0 ml))) (message-combinations n)))

(defn apply-to-each-pair [info info-fn pairings]
  (reduce info-fn info pairings))

(defn analyse-pair [info [coordA coordB]]
  (let [{byteA :byte opA :options} (get info coordA)
        {byteB :byte opB :options} (get info coordB)]
    (if (= byteA byteB)
      (let [i (intersection opA opB)]
        (-> info
            (assoc-in [coordA :options] i)
            (assoc-in [coordB :options] i)))
      (let [diffA (difference opA opB)
            diffB (difference opB opA)]
        (condp = [(count diffA) (count diffB)]
          [1 1] (-> info (assoc-in [coordA :options] diffA) (assoc-in [coordB :options] diffB))
          ;[1 0] (assoc-in info [coordA :options] diffA)
          ;[0 1] (assoc-in info [coordB :options] diffB)
          info)
        ))))

(defn known-text [info n ml]
  (for [i (range 0 n)]
    (->>
     (for [j (range 0 ml)]
       (let [options (get-in info [[i j] :options])]
         (if (= 1 (count options))
           (char (first options))
           -
           )
         ))
     flatten
     (reduce str))))

(defn decode-byte-in-byte-info [m key-byte]
  (let [b (:byte m)
        a (bit-xor key-byte b)]
    (assoc m :options #{a})))

(defn decode-byte [key-byte char-no info message-no]
  (update-in info [[message-no char-no]] decode-byte-in-byte-info key-byte))

(defn get-byte-key-from-byte [{b :byte o :options}]
  (when b
    (bit-xor b (first o))))

(defn find-known-byte [info ci]
  (->> info
       (filter (fn [[[m c] {b :byte o :options}]] (and (= c ci) (= 1 (count o)))))
       first
       second
       get-byte-key-from-byte))

(defn deduce-key-at-pos [n info ci]
  (if-let [key-byte (find-known-byte info ci)]
    (reduce (partial decode-byte key-byte ci) info (range 0 n))
    info))

(defn deduce-key [info n ml]
  (reduce (partial deduce-key-at-pos n) info (range 0 ml)))

(defn add-known-letter [info coord v]
  (assoc-in info [coord :options] #{(-> v first int)}))

(defn add-known-letters [info pairs]
   (if (empty? (remove nil? pairs))
    info
    (let [[k v & r] pairs]
      (-> info
          (add-known-letter k v)
          (add-known-letters r)))))

(defn crack [ciphertexts & pairs]
  (let [n (count ciphertexts)
        ml (-> ciphertexts first count)
        pairings (byte-pairings n ml)]
    (-> {}
        identity
        (apply-to-each-pair (partial add-info-for-byte ciphertexts) pairings)
        (apply-to-each-pair analyse-pair pairings)
        (add-known-letters pairs)
        (deduce-key n ml)
        (known-text n ml)
        )))

(map (comp byte-int-to-binary hex-to-int) ["A8" "ED" "BD"])

(def test-cipher-texts (map hex-string-to-ints ["A8" "ED" "BD"]))

(crack test-cipher-texts)

(crack (map hex-string-to-ints ["66" "32" "23"]))

(reduce str (crack ciphertexts [0 0] "I" [0 6] "l" [0 8] "n" [0 10] "i" [0 17] "e" [0 20] "e" [0 29] "n" [0 30] "."))

(bit-xor (hex-to-int "01") (hex-to-int "00") (hex-to-int "02"))

(def cbb (+ (* 0.4 0.5 1/26)
            (* 0.4 0.5 1/26 1/26)
            (* 0.6 0.5 1/26 1/26)))

(/  (* (+ (/ 1 (* 2 26 26)) (/ 1 (* 2 26))) 0.4) cbb)
