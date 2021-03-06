; RUN: llc -mtriple=thumb-eabi -mcpu=arm1156t2-s -mattr=+thumb2 %s -o - | FileCheck %s

; These tests would be improved by 'movs r0, #0' being rematerialized below the
; tst as 'mov.w r0, #0'.

; 0x000000bb = 187
define i32 @f2(i32 %a) {
    %tmp = and i32 %a, 187
    %tmp1 = icmp eq i32 0, %tmp
    %ret = select i1 %tmp1, i32 42, i32 24
    ret i32 %ret
}
; CHECK-LABEL: f2:
; CHECK: 	tst.w	{{.*}}, #187

; 0x00aa00aa = 11141290
define i32 @f3(i32 %a) {
    %tmp = and i32 %a, 11141290 
    %tmp1 = icmp eq i32 %tmp, 0
    %ret = select i1 %tmp1, i32 42, i32 24
    ret i32 %ret
}
; CHECK-LABEL: f3:
; CHECK: 	tst.w	{{.*}}, #11141290

; 0xcc00cc00 = 3422604288
define i32 @f6(i32 %a) {
    %tmp = and i32 %a, 3422604288
    %tmp1 = icmp eq i32 0, %tmp
    %ret = select i1 %tmp1, i32 42, i32 24
    ret i32 %ret
}
; CHECK-LABEL: f6:
; CHECK: 	tst.w	{{.*}}, #-872363008

; 0xdddddddd = 3722304989
define i32 @f7(i32 %a) {
    %tmp = and i32 %a, 3722304989
    %tmp1 = icmp eq i32 %tmp, 0
    %ret = select i1 %tmp1, i32 42, i32 24
    ret i32 %ret
}
; CHECK-LABEL: f7:
; CHECK: 	tst.w	{{.*}}, #-572662307

; 0x00110000 = 1114112
define i32 @f10(i32 %a) {
    %tmp = and i32 %a, 1114112
    %tmp1 = icmp eq i32 0, %tmp
    %ret = select i1 %tmp1, i32 42, i32 24
    ret i32 %ret
}
; CHECK-LABEL: f10:
; CHECK: 	tst.w	{{.*}}, #1114112

; 0x000000bb = 187
define i1 @f12(i32 %a) {
    %tmp = and i32 %a, 187
    %tmp1 = icmp eq i32 0, %tmp
    ret i1 %tmp1
}
; CHECK-LABEL: f12:
; CHECK: 	  and r0, r0, #187
; CHECK-NEXT: clz r0, r0
; CHECK-NEXT: lsrs r0, r0, #5

; 0x00aa00aa = 11141290
define i1 @f13(i32 %a) {
    %tmp = and i32 %a, 11141290
    %tmp1 = icmp eq i32 %tmp, 0
    ret i1 %tmp1
}
; CHECK-LABEL: f13:
; CHECK: 	  and r0, r0, #11141290
; CHECK-NEXT: clz r0, r0
; CHECK-NEXT: lsrs r0, r0, #5

; 0xcc00cc00 = 3422604288
define i1 @f16(i32 %a) {
    %tmp = and i32 %a, 3422604288
    %tmp1 = icmp eq i32 0, %tmp
    ret i1 %tmp1
}
; CHECK-LABEL: f16:
; CHECK: 	  and r0, r0, #-872363008
; CHECK-NEXT: clz r0, r0
; CHECK-NEXT: lsrs r0, r0, #5

; 0xdddddddd = 3722304989
define i1 @f17(i32 %a) {
    %tmp = and i32 %a, 3722304989
    %tmp1 = icmp eq i32 %tmp, 0
    ret i1 %tmp1
}
; CHECK-LABEL: f17:
; CHECK: 	  bic r0, r0, #572662306
; CHECK-NEXT: clz r0, r0
; CHECK-NEXT: lsrs r0, r0, #5

; 0x00110000 = 1114112
define i1 @f18(i32 %a) {
    %tmp = and i32 %a, 1114112
    %tmp1 = icmp eq i32 0, %tmp
    ret i1 %tmp1
}
; CHECK-LABEL: f18:
; CHECK: 	  and r0, r0, #1114112
; CHECK-NEXT: clz r0, r0
; CHECK-NEXT: lsrs r0, r0, #5

