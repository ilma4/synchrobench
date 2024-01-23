#!/bin/bash

DIR="updVar-size100"
mkdir -p "$DIR"


for alg in CoarseGrainedListBasedSet  HandOverHandListIntSet  LazyLinkedListSortedSet
do
  echo "Who I am: $alg on `uname -n`"
  echo "started on" `date`
  for upd in 0 10 100; do
    OUTPUT="$DIR/$alg-$upd.log"
    rm "$OUTPUT"
    for tr in 1 4 6 8 10 12
    do
      java -cp bin contention.benchmark.Test -b linkedlists.lockbased.$alg -d 2000 -t "$tr" -u "$upd" -i 100 -r 200 -W 0 | grep Throughput >> "$OUTPUT"
    done
  done
done
echo "finished on" `date`
echo "DONE \o/"

