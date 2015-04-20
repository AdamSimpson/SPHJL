all: simd
simd: simd.c
	clang -O2 -S -emit-llvm -gline-tables-only -gcolumn-info simd.c -o simd
