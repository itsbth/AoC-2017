(ns aoc-day-five.core
  (:require [clojure.string :as str])
  (:gen-class))

(defn read-input []
  (mapv read-string
        (str/split (slurp "../input") #"\n")))

(defn do-one [a idx updater]
  (let [jump (get a idx)]
    [(update a idx updater) (+ idx jump)]))

(defn solve [a updater]
  (loop [arr a idx 0 iterations 0]
    (if (>= idx (count arr))
      iterations
      (let [[arr idx] (do-one arr idx updater)]
        (recur arr idx (inc iterations))))))

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println "part 1:" (solve (read-input) inc))
  (println "part 2:" (solve (read-input) (fn [x] (if (< x 3) (inc x) (dec x))))))
