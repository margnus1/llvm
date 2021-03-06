; This testcase ensures that CFL AA gives conservative answers on variables
; that involve arguments.

; RUN: opt < %s -disable-basicaa -cfl-aa -aa-eval -print-may-aliases -disable-output 2>&1 | FileCheck %s
; RUN: opt < %s -aa-pipeline=cfl-aa -passes=aa-eval -print-may-aliases -disable-output 2>&1 | FileCheck %s

; CHECK: Function: test2
; CHECK: MayAlias: i32* %arg1, i32* %arg2
define void @test2(i32* %arg1, i32* %arg2) {
  store i32 0, i32* %arg1
  store i32 0, i32* %arg2

  ret void
}

define void @test() {
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  call void @test2(i32* %a, i32* %b)

  ret void
}
