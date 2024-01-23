#!/bin/bash

DIR="upd10_size1000"
mkdir -p "$DIR"


for alg in CoarseGrainedListBasedSet  HandOverHandListIntSet  LazyLinkedListSortedSet
do
  echo "Who I am: $alg on `uname -n`"
  echo "started on" `date`
  for len in 100 1000 10000 ; do
    buff=$(( 2 * len))
    OUTPUT="$DIR/$alg-$len.log"
    rm "$OUTPUT"
    for tr in $(seq 1 16)
    do
      java -cp bin contention.benchmark.Test -b linkedlists.lockbased.$alg -d 2000 -t "$tr" -u 10 -i $len -r $buff -W 0 | grep Throughput >> "$OUTPUT"
  #		echo "→ $OUTPUT	$alg	$tr	without -W 0"
  #		java -cp bin contention.benchmark.Test -b linkedlists.lockbased.$OUTPUT -d 3000 -t $alg -u $tr -alg 1024 -r 2048 | grep Throughput
    done
    # wait
  done
done
echo "finished on" `date`
echo "DONE \o/"

