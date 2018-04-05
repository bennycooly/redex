#!/bin/bash

mkdir -p .ekstazi/results
rm -rf .ekstazi/results/*

CC=clang CXX=clang++ CXXFLAGS=-flto LDFLAGS="-flto -fuse-ld=gold -Wl,-plugin-opt=save-temps" ./configure

# Measure compile time
perf stat -o .ekstazi/results/compile.txt make check -j8 TESTS= 

# Measure test time
perf stat -o .ekstazi/results/test.txt make check -j8

# Measure e2e time
make clean
perf stat -o .ekstazi/results/e2e.txt make check -j8
