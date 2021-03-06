// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve2  2>&1 < %s| FileCheck %s


// ------------------------------------------------------------------------- //
// Invalid element width

raddhnb z0.b, z1.b, z2.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid element width
// CHECK-NEXT: raddhnb z0.b, z1.b, z2.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

raddhnb z0.h, z1.h, z2.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid element width
// CHECK-NEXT: raddhnb z0.h, z1.h, z2.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

raddhnb z0.s, z1.s, z2.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid element width
// CHECK-NEXT: raddhnb z0.s, z1.s, z2.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

raddhnb z0.d, z1.d, z2.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid element width
// CHECK-NEXT: raddhnb z0.d, z1.d, z2.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// --------------------------------------------------------------------------//
// Negative tests for instructions that are incompatible with movprfx

movprfx z0, z7
raddhnb  z0.s, z1.d, z31.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: instruction is unpredictable when following a movprfx, suggest replacing movprfx with mov
// CHECK-NEXT: raddhnb  z0.s, z1.d, z31.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

movprfx z0.s, p0/z, z7.s
raddhnb  z0.s, z1.d, z31.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: instruction is unpredictable when following a movprfx, suggest replacing movprfx with mov
// CHECK-NEXT: raddhnb  z0.s, z1.d, z31.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:
