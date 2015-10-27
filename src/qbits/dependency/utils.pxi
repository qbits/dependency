(ns qbits.dependency.utils)

;; Taken from https://github.com/pixie-lang/pixie/pull/361/commits
;; until we get something else

(defn -merge-sort-step
  [comp-fn merged-left merged-right res]
  (cond
    (empty? merged-left) (into res merged-right)
    (empty? merged-right) (into res merged-left)
    :else
    (if (neg? (comp-fn (first merged-left) (first merged-right)))
      (recur comp-fn (rest merged-left) merged-right (conj res (first merged-left)))
      (recur comp-fn merged-left (rest merged-right) (conj res (first merged-right))))))

(defn -merge-sort-split
  [comp-fn coll]
  (if (> (count coll) 1)
    (let [[left right] (split-at (/ (count coll) 2) coll)]
      (-merge-sort-step comp-fn
                        (-merge-sort-split comp-fn left)
                        (-merge-sort-split comp-fn right)
                        []))
    coll))

(defn merge-sort [comp-fn coll]
  (-merge-sort-split comp-fn coll))

(defn sort
  ([coll]
   (sort compare coll))
  ([comp-fn coll]
   (merge-sort comp-fn coll)))
