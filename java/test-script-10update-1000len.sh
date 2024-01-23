#!/bin/bash

DIR="upd10_size1000"
mkdir -p "$DIR"


for alg in CoarseGrainedListBasedSet  HandOverHandListIntSet  LazyLinkedListSortedSet
do
  echo "Who I am: $alg on `uname -n`"
  echo "started on" `date`
  rm "$DIR/$alg.log"
	for tr in 1 4 6 8 10 12
	do
		java -cp bin contention.benchmark.Test -b linkedlists.lockbased.$alg -d 2000 -t "$tr" -u 10 -i 1000 -r 2000 -W 0 | grep Throughput >> "$DIR/$alg.log"
	done
done
echo "finished on" `date`
echo "DONE \o/"

