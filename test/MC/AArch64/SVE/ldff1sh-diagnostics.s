// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// --------------------------------------------------------------------------//
// Invalid operand (.h)

ldff1sh z9.h, p7/z, [x0]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: ldff1sh z9.h, p7/z, [x0]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// --------------------------------------------------------------------------//
// restricted predicate has range [0, 7].

ldff1sh z12.s, p8/z, [x0]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ldff1sh z12.s, p8/z, [x0]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

ldff1sh z4.d, p8/z, [x0]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ldff1sh z4.d, p8/z, [x0]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// --------------------------------------------------------------------------//
// Invalid scalar + scalar addressing modes

ldff1sh z0.s, p0/z, [x0, sp]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: register must be x0..x30 or xzr, with required shift 'lsl #1'
// CHECK-NEXT: ldff1sh z0.s, p0/z, [x0, sp]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

ldff1sh z0.s, p0/z, [x0, x0, lsl #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: register must be x0..x30 or xzr, with required shift 'lsl #1'
// CHECK-NEXT: ldff1sh z0.s, p0/z, [x0, x0, lsl #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

ldff1sh z0.s, p0/z, [x0, w0]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: register must be x0..x30 or xzr, with required shift 'lsl #1'
// CHECK-NEXT: ldff1sh z0.s, p0/z, [x0, w0]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

ldff1sh z0.s, p0/z, [x0, w0, uxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: register must be x0..x30 or xzr, with required shift 'lsl #1'
// CHECK-NEXT: ldff1sh z0.s, p0/z, [x0, w0, uxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// --------------------------------------------------------------------------//
// Invalid scalar + vector addressing modes

ldff1sh z0.d, p0/z, [x0, z0.h]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid shift/extend specified, expected 'z[0..31].d, (uxtw|sxtw)'
// CHECK-NEXT: ldff1sh z0.d, p0/z, [x0, z0.h]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

ldff1sh z0.d, p0/z, [x0, z0.s]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid shift/extend specified, expected 'z[0..31].d, (uxtw|sxtw)'
// CHECK-NEXT: ldff1sh z0.d, p0/z, [x0, z0.s]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

ldff1sh z0.s, p0/z, [x0, z0.s]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid shift/extend specified, expected 'z[0..31].s, (uxtw|sxtw)'
// CHECK-NEXT: ldff1sh z0.s, p0/z, [x0, z0.s]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

ldff1sh z0.s, p0/z, [x0, z0.s, uxtw #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid shift/extend specified, expected 'z[0..31].s, (uxtw|sxtw)'
// CHECK-NEXT: ldff1sh z0.s, p0/z, [x0, z0.s, uxtw #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

ldff1sh z0.s, p0/z, [x0, z0.s, lsl #1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid shift/extend specified, expected 'z[0..31].s, (uxtw|sxtw)'
// CHECK-NEXT: ldff1sh z0.s, p0/z, [x0, z0.s, lsl #1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

ldff1sh z0.d, p0/z, [x0, z0.d, lsl #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid shift/extend specified, expected 'z[0..31].d, (uxtw|sxtw)'
// CHECK-NEXT: ldff1sh z0.d, p0/z, [x0, z0.d, lsl #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

ldff1sh z0.d, p0/z, [x0, z0.d, sxtw #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid shift/extend specified, expected 'z[0..31].d, (uxtw|sxtw)'
// CHECK-NEXT: ldff1sh z0.d, p0/z, [x0, z0.d, sxtw #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:
