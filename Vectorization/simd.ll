; ModuleID = 'simd.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.AoS = type { double, double, double }

@.str = private unnamed_addr constant [4 x i8] c"%f\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %1 = tail call noalias i8* @malloc(i64 240000000) #2, !dbg !10
  %2 = bitcast i8* %1 to %struct.AoS*, !dbg !10
  br label %3, !dbg !11

; <label>:3                                       ; preds = %3, %0
  %indvars.iv3 = phi i64 [ 0, %0 ], [ %indvars.iv.next4, %3 ]
  %4 = trunc i64 %indvars.iv3 to i32, !dbg !15
  %5 = sitofp i32 %4 to double, !dbg !15
  %6 = getelementptr inbounds %struct.AoS* %2, i64 %indvars.iv3, i32 0, !dbg !15
  store double %5, double* %6, align 8, !dbg !15, !tbaa !17
  %7 = getelementptr inbounds %struct.AoS* %2, i64 %indvars.iv3, i32 1, !dbg !22
  store double 1.000000e+00, double* %7, align 8, !dbg !22, !tbaa !23
  %indvars.iv.next4 = add nuw nsw i64 %indvars.iv3, 1, !dbg !11
  %exitcond5 = icmp eq i64 %indvars.iv.next4, 10000000, !dbg !11
  br i1 %exitcond5, label %overflow.checked, label %3, !dbg !11, !llvm.loop !24

overflow.checked:                                 ; preds = %3
  %8 = getelementptr inbounds i8* %1, i64 24, !dbg !27
  %9 = bitcast i8* %8 to double*, !dbg !27
  %10 = load double* %9, align 8, !dbg !27, !tbaa !17
  %11 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), double %10) #2, !dbg !27
  %12 = tail call noalias i8* @malloc(i64 80000000) #2, !dbg !28
  %13 = bitcast i8* %12 to double*, !dbg !28
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %overflow.checked
  %index = phi i64 [ 0, %overflow.checked ], [ %index.next.1, %vector.body ], !dbg !29
  %induction69 = or i64 %index, 1
  %14 = trunc i64 %index to i32, !dbg !33
  %induction810 = or i32 %14, 1, !dbg !33
  %15 = sitofp i32 %14 to double, !dbg !33
  %16 = sitofp i32 %induction810 to double, !dbg !33
  %17 = getelementptr inbounds double* %13, i64 %index, !dbg !33
  %18 = getelementptr inbounds double* %13, i64 %induction69, !dbg !33
  store double %15, double* %17, align 8, !dbg !33, !tbaa !35
  store double %16, double* %18, align 8, !dbg !33, !tbaa !35
  %index.next = add i64 %index, 2, !dbg !29
  %induction69.1 = or i64 %index.next, 1
  %19 = trunc i64 %index.next to i32, !dbg !33
  %induction810.1 = or i32 %19, 1, !dbg !33
  %20 = sitofp i32 %19 to double, !dbg !33
  %21 = sitofp i32 %induction810.1 to double, !dbg !33
  %22 = getelementptr inbounds double* %13, i64 %index.next, !dbg !33
  %23 = getelementptr inbounds double* %13, i64 %induction69.1, !dbg !33
  store double %20, double* %22, align 8, !dbg !33, !tbaa !35
  store double %21, double* %23, align 8, !dbg !33, !tbaa !35
  %index.next.1 = add i64 %index.next, 2, !dbg !29
  %24 = icmp eq i64 %index.next.1, 10000000, !dbg !29
  br i1 %24, label %middle.block, label %vector.body, !dbg !29, !llvm.loop !36

middle.block:                                     ; preds = %vector.body
  %25 = getelementptr inbounds i8* %12, i64 8, !dbg !39
  %26 = bitcast i8* %25 to double*, !dbg !39
  %27 = load double* %26, align 8, !dbg !39, !tbaa !35
  %28 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), double %27) #2, !dbg !39
  ret i32 0, !dbg !40
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!7, !8}
!llvm.ident = !{!9}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"Ubuntu clang version 3.5.0-4ubuntu2 (tags/RELEASE_350/final) (based on LLVM 3.5.0)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 2} ; [ DW_TAG_compile_unit ] [/home/atj/Documents/SPHJL/Vectorization/simd.c] [DW_LANG_C99]
!1 = metadata !{metadata !"simd.c", metadata !"/home/atj/Documents/SPHJL/Vectorization"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"main", metadata !"main", metadata !"", i32 16, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i8**)* @main, null, null, metadata !2, i32 17} ; [ DW_TAG_subprogram ] [line 16] [def] [scope 17] [main]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/home/atj/Documents/SPHJL/Vectorization/simd.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !2, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!8 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!9 = metadata !{metadata !"Ubuntu clang version 3.5.0-4ubuntu2 (tags/RELEASE_350/final) (based on LLVM 3.5.0)"}
!10 = metadata !{i32 22, i32 25, metadata !4, null}
!11 = metadata !{i32 24, i32 9, metadata !12, null}
!12 = metadata !{i32 786443, metadata !1, metadata !13, i32 24, i32 9, i32 2, i32 5} ; [ DW_TAG_lexical_block ] [/home/atj/Documents/SPHJL/Vectorization/simd.c]
!13 = metadata !{i32 786443, metadata !1, metadata !14, i32 24, i32 9, i32 1, i32 4} ; [ DW_TAG_lexical_block ] [/home/atj/Documents/SPHJL/Vectorization/simd.c]
!14 = metadata !{i32 786443, metadata !1, metadata !4, i32 24, i32 5, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/atj/Documents/SPHJL/Vectorization/simd.c]
!15 = metadata !{i32 25, i32 9, metadata !16, null}
!16 = metadata !{i32 786443, metadata !1, metadata !14, i32 24, i32 29, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/atj/Documents/SPHJL/Vectorization/simd.c]
!17 = metadata !{metadata !18, metadata !19, i64 0}
!18 = metadata !{metadata !"", metadata !19, i64 0, metadata !19, i64 8, metadata !19, i64 16}
!19 = metadata !{metadata !"double", metadata !20, i64 0}
!20 = metadata !{metadata !"omnipotent char", metadata !21, i64 0}
!21 = metadata !{metadata !"Simple C/C++ TBAA"}
!22 = metadata !{i32 26, i32 9, metadata !16, null}
!23 = metadata !{metadata !18, metadata !19, i64 8}
!24 = metadata !{metadata !24, metadata !25, metadata !26}
!25 = metadata !{metadata !"llvm.loop.vectorize.enable", i1 true}
!26 = metadata !{metadata !"llvm.loop.unroll.enable", i1 false}
!27 = metadata !{i32 28, i32 5, metadata !4, null}
!28 = metadata !{i32 32, i32 13, metadata !4, null}
!29 = metadata !{i32 35, i32 9, metadata !30, null}
!30 = metadata !{i32 786443, metadata !1, metadata !31, i32 35, i32 9, i32 2, i32 7} ; [ DW_TAG_lexical_block ] [/home/atj/Documents/SPHJL/Vectorization/simd.c]
!31 = metadata !{i32 786443, metadata !1, metadata !32, i32 35, i32 9, i32 1, i32 6} ; [ DW_TAG_lexical_block ] [/home/atj/Documents/SPHJL/Vectorization/simd.c]
!32 = metadata !{i32 786443, metadata !1, metadata !4, i32 35, i32 5, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/atj/Documents/SPHJL/Vectorization/simd.c]
!33 = metadata !{i32 36, i32 9, metadata !34, null}
!34 = metadata !{i32 786443, metadata !1, metadata !32, i32 35, i32 29, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/atj/Documents/SPHJL/Vectorization/simd.c]
!35 = metadata !{metadata !19, metadata !19, i64 0}
!36 = metadata !{metadata !36, metadata !37, metadata !38}
!37 = metadata !{metadata !"llvm.loop.vectorize.width", i32 1}
!38 = metadata !{metadata !"llvm.loop.interleave.count", i32 1}
!39 = metadata !{i32 40, i32 5, metadata !4, null}
!40 = metadata !{i32 42, i32 5, metadata !4, null}
