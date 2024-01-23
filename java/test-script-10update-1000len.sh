#!/bin/bash

DIR="upd10_size1000"
mkdir -p "$DIR"

THREADS=12

for i in 1 2 3
do
  case $i in
  "1" )	echo CoarseGrainedListIntSet
      OUTPUT="CoarseGrainedListBasedSet"
  ;;
  "2" )	echo HandOverHandListIntSet
      OUTPUT="HandOverHandListIntSet"
  ;;
  "3" )	echo LazyLinkedListSortedSet
      OUTPUT="LazyLinkedListSortedSet"
  ;;
  *)		echo "Specify algorithm"
      exit 0
  esac
  echo "Who I am: $OUTPUT on `uname -n`"
  echo "started on" `date`
  rm "$DIR/$i.log"
	for j in `seq 10`
	do
		java -cp bin contention.benchmark.Test -b linkedlists.lockbased.$OUTPUT -d 2000 -t "$THREADS" -u 10 -i 1000 -r 2000 -W 0 | grep Throughput >> "$DIR/$i.log"
#		echo "→ $OUTPUT	$i	$j	without -W 0"
#		java -cp bin contention.benchmark.Test -b linkedlists.lockbased.$OUTPUT -d 3000 -t $i -u $j -i 1024 -r 2048 | grep Throughput
	done 
	# wait
done
echo "finished on" `date`
echo "DONE \o/"

