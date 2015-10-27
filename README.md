# dependency

Direct port of https://github.com/stuartsierra/dependency, which
deserves all the praise.

A data structure for representing dependency graphs in Pixie.

This library provides a basic implementation of a directed acyclic
graph (DAG) data structure, represented as a pair of maps. It is
immutable and persistent.

Nodes in the graph may be any type which supports Pixies's equality
semantics such as keywords, symbols, or strings.

## Usage

    (require '[qbits.dependency :as dep])

Create a new dependency graph:

    (def g1 (-> (dep/graph)
                (dep/depend :b :a)   ; "B depends on A"
                (dep/depend :c :b)   ; "C depends on B"
                (dep/depend :c :a)   ; "C depends on A"
                (dep/depend :d :c))) ; "D depends on C"

This creates a structure like the following:

         :a
        / |
      :b  |
        \ |
         :c
          |
         :d

Ask questions of the graph:

    (dep/transitive-dependencies g1 :d)
    ;;=> #{:a :c :b}

    (dep/depends? g1 :d :b)
    ;;=> true

Get a topological sort:

    (dep/topo-sort g1)
    ;;=> (:a :b :c :d)

Refer to the docstrings for more API documentation. Refer to the tests
for more examples.


## Copyright and License

This library is a port of https://github.com/stuartsierra/dependency.

Copyright (c) Stuart Sierra, 2012-2015. All rights reserved. The use
and distribution terms for this software are covered by the Eclipse
Public License 1.0 (http://opensource.org/licenses/eclipse-1.0.php)
which can be found in the file epl-v10.html at the root of this
distribution. By using this software in any fashion, you are agreeing
to be bound by the terms of this license. You must not remove this
notice, or any other, from this software.