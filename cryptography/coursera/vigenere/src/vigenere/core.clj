(ns vigenere.core
  (:require [vigenere.utils :refer :all]))

(def rawcyphertext "F96DE8C227A259C87EE1DA2AED57C93FE5DA36ED4EC87EF2C63AAE5B9A7EFFD673BE4ACF7BE8923CAB1ECE7AF2DA3DA44FCF7AE29235A24C963FF0DF3CA3599A70E5DA36BF1ECE77F8DC34BE129A6CF4D126BF5B9A7CFEDF3EB850D37CF0C63AA2509A76FF9227A55B9A6FE3D720A850D97AB1DD35ED5FCE6BF0D138A84CC931B1F121B44ECE70F6C032BD56C33FF9D320ED5CDF7AFF9226BE5BDE3FF7DD21ED56CF71F5C036A94D963FF8D473A351CE3FE5DA3CB84DDB71F5C17FED51DC3FE8D732BF4D963FF3C727ED4AC87EF5DB27A451D47EFD9230BF47CA6BFEC12ABE4ADF72E29224A84CDF3FF5D720A459D47AF59232A35A9A7AE7D33FB85FCE7AF5923AA31EDB3FF7D33ABF52C33FF0D673A551D93FFCD33DA35BC831B1F43CBF1EDF67F0DF23A15B963FE5DA36ED68D378F4DC36BF5B9A7AFFD121B44ECE76FEDC73BE5DD27AFCD773BA5FC93FE5DA3CB859D26BB1C63CED5CDF3FE2D730B84CDF3FF7DD21ED5ADF7CF0D636BE1EDB79E5D721ED57CE3FE6D320ED57D469F4DC27A85A963FF3C727ED49DF3FFFDD24ED55D470E69E73AC50DE3FE5DA3ABE1EDF67F4C030A44DDF3FF5D73EA250C96BE3D327A84D963FE5DA32B91ED36BB1D132A31ED87AB1D021A255DF71B1C436BF479A7AF0C13AA14794")


(def cyphertext
  (hex-string-to-ints rawcyphertext))

(def freqs
  (zipmap (map int "abcdefghijklmnopqrstuvwxyz")
          (map #(/ % 100) [8.167 1.492 2.782 4.253 12.702 2.228 2.015 6.094 6.966 0.153 0.772
                           4.025 2.406 6.749 7.507 1.929  0.095 5.987 6.327 9.056 2.758 0.978 2.360 0.150 1.974 0.074])))

(defn square [x] (* x x))

(defn distribution [items]
  (let [size (count items)]
    (->> items
         (group-by identity)
         (map (fn [[k v]] (* 1.0 (square (/ (count v) size)))))
         (reduce +))))

(defn candidate-length-score [cyphertext l]
  (distribution (take-nth l cyphertext)))

(defn key-length [cyphertext]
  (let [tries (range 1 14)]
    (->>
     (zipmap tries (map (partial candidate-length-score cyphertext) tries))
     (sort-by second)
     last
     first)))

(defn shift-score [sample shifter]
  (let [sample-size (count sample)
        shifted-sample (map (partial bit-xor shifter) sample)
        counts (->> shifted-sample (group-by identity) (map (fn [[k v]] [k (count v)])) (into {}))]
    (->> freqs
         (map (fn [[fk fv]] (* fv (/ (get counts fk 0.0) sample-size))))
         (reduce +))))

(defn p [v] (println v) v)

(defn find-shift [cyphertext l n]
  (let [sample (->> cyphertext (drop n) (take-nth l))
        shifts (range 0 256)]
    (->>
     (zipmap shifts (map (partial shift-score sample) shifts))
     (sort-by second)
     last
     first)))

(defn decode [cyphertext key]
  (->> cyphertext
       (map bit-xor (cycle key))
       (map char)
       (reduce str)))

(defn encode [string key]
  (map bit-xor (map int string) (cycle key)))

(defn crack [cyphertext]
  (let [l (key-length cyphertext)
        k (map (partial find-shift cyphertext l) (range 0 l))]
    (decode cyphertext k)))

(def a (encode "Once upon a time I was a little boy with a little toy who liked to run up and down the hills like a crazy person.
        I would speak to the horses and shout at the crows and I don't really know what came over me but it felt so good." (hex-string-to-ints "A1FFB3")))

(crack cyphertext)

(crack a)
