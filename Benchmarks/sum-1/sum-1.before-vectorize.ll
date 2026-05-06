; *** IR Dump Before LoopVectorizePass on sum_1 ***
; ModuleID = 'sum-1.ll.init'
source_filename = "./sum-1.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-darwin24.6.0"

@seed = internal unnamed_addr global i64 0, align 8
@size = internal unnamed_addr global i32 0, align 4
@ima = internal unnamed_addr global ptr null, align 8
@imb = internal unnamed_addr global ptr null, align 8
@imr = internal unnamed_addr global ptr null, align 8

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(write, argmem: none, inaccessiblemem: none) uwtable
define dso_local void @Initrand() local_unnamed_addr #0 {
  store i64 74755, ptr @seed, align 8, !tbaa !5
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, argmem: none, inaccessiblemem: none) uwtable
define dso_local range(i32 0, 65536) i32 @Rand() local_unnamed_addr #1 {
  %1 = load i64, ptr @seed, align 8, !tbaa !5
  %2 = mul nuw nsw i64 %1, 1309
  %3 = add nuw nsw i64 %2, 13849
  %4 = and i64 %3, 65535
  store i64 %4, ptr @seed, align 8, !tbaa !5
  %5 = trunc nuw nsw i64 %4 to i32
  ret i32 %5
}

; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, argmem: write, inaccessiblemem: none) uwtable
define dso_local void @InitArray(ptr nocapture noundef writeonly %0) local_unnamed_addr #2 {
  %2 = load i32, ptr @size, align 4, !tbaa !9
  %3 = icmp sgt i32 %2, 0
  br i1 %3, label %.lr.ph.preheader, label %11

.lr.ph.preheader:                                 ; preds = %1
  %seed.promoted = load i64, ptr @seed, align 8, !tbaa !5
  %seed.promoted.fr = freeze i64 %seed.promoted
  %wide.trip.count = zext nneg i32 %2 to i64
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %indvars.iv = phi i64 [ 0, %.lr.ph.preheader ], [ %indvars.iv.next, %.lr.ph ]
  %4 = phi i64 [ %seed.promoted.fr, %.lr.ph.preheader ], [ %7, %.lr.ph ]
  %5 = mul i64 %4, 1309
  %6 = add i64 %5, 13849
  %7 = and i64 %6, 65535
  %.lhs.trunc = trunc i64 %6 to i16
  %8 = urem i16 %.lhs.trunc, 120
  %.zext = zext nneg i16 %8 to i32
  %9 = add nsw i32 %.zext, -60
  %10 = getelementptr inbounds i32, ptr %0, i64 %indvars.iv
  store i32 %9, ptr %10, align 4, !tbaa !9
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %._crit_edge, label %.lr.ph, !llvm.loop !11

._crit_edge:                                      ; preds = %.lr.ph
  store i64 %7, ptr @seed, align 8, !tbaa !5
  br label %11

11:                                               ; preds = %._crit_edge, %1
  ret void
}

; Function Attrs: nounwind memory(readwrite, argmem: none) uwtable
define dso_local range(i32 0, 2) i32 @init(i32 noundef %0) local_unnamed_addr #3 {
  store i32 %0, ptr @size, align 4, !tbaa !9
  %2 = sext i32 %0 to i64
  %3 = tail call ptr @calloc(i64 noundef %2, i64 noundef 4) #8
  store ptr %3, ptr @ima, align 8, !tbaa !14
  %.not = icmp eq ptr %3, null
  br i1 %.not, label %InitArray.exit18, label %4

4:                                                ; preds = %1
  %5 = tail call ptr @calloc(i64 noundef %2, i64 noundef 4) #8
  store ptr %5, ptr @imb, align 8, !tbaa !14
  %.not5 = icmp eq ptr %5, null
  br i1 %.not5, label %6, label %7

6:                                                ; preds = %4
  tail call void @free(ptr noundef nonnull %3)
  br label %InitArray.exit18

7:                                                ; preds = %4
  %8 = tail call ptr @calloc(i64 noundef %2, i64 noundef 4) #8
  store ptr %8, ptr @imr, align 8, !tbaa !14
  %.not6 = icmp eq ptr %8, null
  br i1 %.not6, label %9, label %10

9:                                                ; preds = %7
  tail call void @free(ptr noundef nonnull %3)
  tail call void @free(ptr noundef nonnull %5)
  br label %InitArray.exit18

10:                                               ; preds = %7
  store i64 74755, ptr @seed, align 8, !tbaa !5
  %11 = icmp sgt i32 %0, 0
  br i1 %11, label %.lr.ph.preheader.i, label %InitArray.exit18

.lr.ph.preheader.i:                               ; preds = %10
  %wide.trip.count.i = zext nneg i32 %0 to i64
  br label %.lr.ph.i

.lr.ph.i:                                         ; preds = %.lr.ph.i, %.lr.ph.preheader.i
  %indvars.iv.i = phi i64 [ 0, %.lr.ph.preheader.i ], [ %indvars.iv.next.i, %.lr.ph.i ]
  %12 = phi i64 [ 74755, %.lr.ph.preheader.i ], [ %15, %.lr.ph.i ]
  %13 = mul nuw nsw i64 %12, 1309
  %14 = add nuw nsw i64 %13, 13849
  %15 = and i64 %14, 65535
  %.lhs.trunc.i = trunc i64 %14 to i16
  %16 = urem i16 %.lhs.trunc.i, 120
  %.zext.i = zext nneg i16 %16 to i32
  %17 = add nsw i32 %.zext.i, -60
  %18 = getelementptr inbounds i32, ptr %3, i64 %indvars.iv.i
  store i32 %17, ptr %18, align 4, !tbaa !9
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i, 1
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, %wide.trip.count.i
  br i1 %exitcond.not.i, label %.lr.ph.i11, label %.lr.ph.i, !llvm.loop !11

.lr.ph.i11:                                       ; preds = %.lr.ph.i, %.lr.ph.i11
  %indvars.iv.i12 = phi i64 [ %indvars.iv.next.i15, %.lr.ph.i11 ], [ 0, %.lr.ph.i ]
  %19 = phi i64 [ %22, %.lr.ph.i11 ], [ %15, %.lr.ph.i ]
  %20 = mul nuw nsw i64 %19, 1309
  %21 = add nuw nsw i64 %20, 13849
  %22 = and i64 %21, 65535
  %.lhs.trunc.i13 = trunc i64 %21 to i16
  %23 = urem i16 %.lhs.trunc.i13, 120
  %.zext.i14 = zext nneg i16 %23 to i32
  %24 = add nsw i32 %.zext.i14, -60
  %25 = getelementptr inbounds i32, ptr %5, i64 %indvars.iv.i12
  store i32 %24, ptr %25, align 4, !tbaa !9
  %indvars.iv.next.i15 = add nuw nsw i64 %indvars.iv.i12, 1
  %exitcond.not.i16 = icmp eq i64 %indvars.iv.next.i15, %wide.trip.count.i
  br i1 %exitcond.not.i16, label %._crit_edge.i17, label %.lr.ph.i11, !llvm.loop !11

._crit_edge.i17:                                  ; preds = %.lr.ph.i11
  store i64 %22, ptr @seed, align 8, !tbaa !5
  br label %InitArray.exit18

InitArray.exit18:                                 ; preds = %10, %._crit_edge.i17, %1, %9, %6
  %.0 = phi i32 [ 0, %9 ], [ 0, %6 ], [ 0, %1 ], [ 1, %._crit_edge.i17 ], [ 1, %10 ]
  ret i32 %.0
}

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,zeroed") allocsize(0,1) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @calloc(i64 noundef, i64 noundef) local_unnamed_addr #4

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #5

; Function Attrs: mustprogress nounwind willreturn uwtable
define dso_local void @deinit() local_unnamed_addr #6 {
  %1 = load ptr, ptr @ima, align 8, !tbaa !14
  tail call void @free(ptr noundef %1)
  %2 = load ptr, ptr @imb, align 8, !tbaa !14
  tail call void @free(ptr noundef %2)
  %3 = load ptr, ptr @imr, align 8, !tbaa !14
  tail call void @free(ptr noundef %3)
  ret void
}

; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, inaccessiblemem: none) uwtable
define dso_local i32 @sum_1() local_unnamed_addr #7 {
  %1 = load i32, ptr @size, align 4, !tbaa !9
  %2 = icmp sgt i32 %1, 0
  br i1 %2, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %3 = load ptr, ptr @ima, align 8, !tbaa !14
  %4 = load ptr, ptr @imb, align 8, !tbaa !14
  %5 = load ptr, ptr @imr, align 8, !tbaa !14
  %wide.trip.count = zext nneg i32 %1 to i64
  br label %6

6:                                                ; preds = %.lr.ph, %6
  %indvars.iv = phi i64 [ 0, %.lr.ph ], [ %indvars.iv.next, %6 ]
  %.011 = phi i32 [ 0, %.lr.ph ], [ %13, %6 ]
  %7 = getelementptr inbounds i32, ptr %3, i64 %indvars.iv
  %8 = load i32, ptr %7, align 4, !tbaa !9
  %9 = getelementptr inbounds i32, ptr %4, i64 %indvars.iv
  %10 = load i32, ptr %9, align 4, !tbaa !9
  %11 = add nsw i32 %10, %8
  %12 = getelementptr inbounds i32, ptr %5, i64 %indvars.iv
  store i32 %11, ptr %12, align 4, !tbaa !9
  %13 = add i32 %11, %.011
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %._crit_edge.loopexit, label %6, !llvm.loop !16

._crit_edge.loopexit:                             ; preds = %6
  %.lcssa = phi i32 [ %13, %6 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %.0.lcssa = phi i32 [ 0, %0 ], [ %.lcssa, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(write, argmem: none, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m3" "tune-cpu"="generic" }
attributes #1 = { mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, argmem: none, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m3" "tune-cpu"="generic" }
attributes #2 = { nofree norecurse nosync nounwind memory(readwrite, argmem: write, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m3" "tune-cpu"="generic" }
attributes #3 = { nounwind memory(readwrite, argmem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m3" "tune-cpu"="generic" }
attributes #4 = { mustprogress nofree nounwind willreturn allockind("alloc,zeroed") allocsize(0,1) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m3" "tune-cpu"="generic" }
attributes #5 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m3" "tune-cpu"="generic" }
attributes #6 = { mustprogress nounwind willreturn uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m3" "tune-cpu"="generic" }
attributes #7 = { nofree norecurse nosync nounwind memory(readwrite, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m3" "tune-cpu"="generic" }
attributes #8 = { allocsize(0,1) }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 19.1.2 (++20241028122730+d8752671e825-1~exp1~20241028122742.57)"}
!5 = !{!6, !6, i64 0}
!6 = !{!"long", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{!10, !10, i64 0}
!10 = !{!"int", !7, i64 0}
!11 = distinct !{!11, !12, !13}
!12 = !{!"llvm.loop.mustprogress"}
!13 = !{!"llvm.loop.unroll.disable"}
!14 = !{!15, !15, i64 0}
!15 = !{!"any pointer", !7, i64 0}
!16 = distinct !{!16, !12, !13}
