#!/bin/bash

DIR="upd10_sizeVar"
mkdir -p "$DIR"


for alg in CoarseGrainedListBasedSet  HandOverHandListIntSet  LazyLinkedListSortedSet
do
  echo "Who I am: $alg on `uname -n`"
  echo "started on" `date`
  for len in 100 1000 10000 ; do
    buff=$(( 2 * len))
    OUTPUT="$DIR/$alg-$len.log"
    rm "$OUTPUT"
    for tr in 1 4 6 8 10 12
    do
      java -cp bin contention.benchmark.Test -b linkedlists.lockbased.$alg -d 2000 -t "$tr" -u 10 -i $len -r $buff -W 0 | grep Throughput >> "$OUTPUT"
    done
  done
done
echo "finished on" `date`
echo "DONE \o/"

