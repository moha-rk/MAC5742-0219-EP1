#! /bin/bash

MEASUREMENTS=10
ITERATIONS=10
INITIAL_SIZE=16
THREADS=1

SIZE=$INITIAL_SIZE

NAMES=('mandelbrot_pth' 'mandelbrot_omp')

make
mkdir results

NAME='mandelbrot_seq'

mkdir results/$NAME

for ((i=1; i<=$ITERATIONS; i++)); do
    echo $SIZE >> full.log 2>&1
    echo $SIZE >> seahorse.log 2>&1
    echo $SIZE >> elephant.log 2>&1
    echo $SIZE >> triple_spiral.log 2>&1
    for ((j=1; j<=$MEASUREMENTS; j++)); do
            echo "./$NAME -2.5 1.5 -2.0 2.0 $SIZE >> full.log 2>&1"
            ./$NAME -2.5 1.5 -2.0 2.0 $SIZE >> full.log 2>&1
            echo "./$NAME -0.8 -0.7 0.05 0.15 $SIZE >> seahorse.log 2>&1"
            ./$NAME -0.8 -0.7 0.05 0.15 $SIZE >> seahorse.log 2>&1
            echo "./$NAME 0.175 0.375 -0.1 0.1 $SIZE >> elephant.log 2>&1"
            ./$NAME 0.175 0.375 -0.1 0.1 $SIZE >> elephant.log 2>&1
            echo "./$NAME -0.188 -0.012 0.554 0.754 $SIZE >> triple_spiral.log 2>&1"
            ./$NAME -0.188 -0.012 0.554 0.754 $SIZE >> triple_spiral.log 2>&1
    done
    SIZE=$(($SIZE * 2))
done

SIZE=$INITIAL_SIZE

mv *.log results/$NAME
rm output.ppm


for NAME in ${NAMES[@]}; do
    mkdir results/$NAME
    for n in 1 2 4 8 16 32 
    do
        for ((i=1; i<=$ITERATIONS; i++)); do
                echo $n $SIZE >> full.log 2>&1
                echo $n $SIZE >> seahorse.log 2>&1
                echo $n $SIZE >> elephant.log 2>&1
                echo $n $SIZE >> triple_spiral.log 2>&1
                for ((j=1; j<=$MEASUREMENTS; j++)); do
                        echo "./$NAME -2.5 1.5 -2.0 2.0 $SIZE $n >> full.log 2>&1"
                        ./$NAME -2.5 1.5 -2.0 2.0 $SIZE $n >> full.log 2>&1
                        echo "./$NAME -0.8 -0.7 0.05 0.15 $SIZE $n >> seahorse.log 2>&1"
                        ./$NAME -0.8 -0.7 0.05 0.15 $SIZE $n >> seahorse.log 2>&1
                        echo "./$NAME 0.175 0.375 -0.1 0.1 $SIZE $n >> elephant.log 2>&1"
                        ./$NAME 0.175 0.375 -0.1 0.1 $SIZE $n >> elephant.log 2>&1
                        echo "./$NAME -0.188 -0.012 0.554 0.754 $SIZE $n >> triple_spiral.log 2>&1"
                        ./$NAME -0.188 -0.012 0.554 0.754 $SIZE $n >> triple_spiral.log 2>&1
                done
                SIZE=$(($SIZE * 2))
        done

        SIZE=$INITIAL_SIZE
    done
    mv *.log results/$NAME
    rm output.ppm
done
