grade0: Grade0,
grade1: Grade1,
grade2: Grade2,
grade3: Grade3,
grade4: Grade4,
//TODO:
//format
//invDual (figure out what this is)
//leftDot: (e0,e1).leftDot(2e01,3e12,e23) == (-2e0,3e2)
//dot
//geo
//reg (needs invDual)
pub const zero: @This() = .{
    .grade0 = Grade0.zero,
    .grade1 = Grade1.zero,
    .grade2 = Grade2.zero,
    .grade3 = Grade3.zero,
    .grade4 = Grade4.zero,
};
pub fn magSq(a: @This()) f32 {
    return a.grade0.magSq() + a.grade1.magSq() + a.grade2.magSq() + a.grade3.magSq();
}
pub fn mag(a: @This()) f32 {
    return @sqrt(a.magSq());
}
pub fn neg(a: @This()) @This() {
    return .{
        .grade0 = a.grade0.neg(),
        .grade1 = a.grade1.neg(),
        .grade2 = a.grade2.neg(),
        .grade3 = a.grade3.neg(),
        .grade4 = a.grade4.neg(),
    };
}
pub fn rev(a: @This()) @This() {
    return .{
        .grade0 = a.grade0.rev(),
        .grade1 = a.grade1.rev(),
        .grade2 = a.grade2.rev(),
        .grade3 = a.grade3.rev(),
        .grade4 = a.grade4.rev(),
    };
}
pub fn dual(a: @This()) @This() {
    return .{
        .grade0 = a.grade4.dual(),
        .grade1 = a.grade3.dual(),
        .grade2 = a.grade2.dual(),
        .grade3 = a.grade1.dual(),
        .grade4 = a.grade0.dual(),
    };
}
pub fn add(a: @This(), b: @This()) @This() {
    return .{
        .grade0 = a.grade0.add(b.grade0),
        .grade1 = a.grade1.add(b.grade1),
        .grade2 = a.grade2.add(b.grade2),
        .grade3 = a.grade3.add(b.grade3),
        .grade4 = a.grade4.add(b.grade4),
    };
}
pub fn span(a: @This(), b: @This()) @This() {
    return .{
        .grade0 = a.grade0.span(b.grade0),
        .grade1 = a.grade0.span(b.grade1).add(a.grade1.span(b.grade0)),
        .grade2 = a.grade0.span(b.grade2).add(a.grade1.span(b.grade1)).add(a.grade2.span(b.grade0)),
        .grade3 = a.grade0.span(b.grade3).add(a.grade1.span(b.grade2)).add(a.grade2.span(b.grade1)).add(a.grade3.span(b.grade0)),
        .grade4 = a.grade0.span(b.grade4).add(a.grade1.span(b.grade3)).add(a.grade2.span(b.grade2)).add(a.grade3.span(b.grade1)).add(a.grade4.span(b.grade0)),
    };
}
pub fn leftDot(a: @This(), b: @This()) @This() {
    return .{
        .grade0 = a.grade0.leftDot(b.grade0).add(a.grade1.leftDot(b.grade1)).add(a.grade2.leftDot(b.grade2)).add(a.grade3.leftDot(b.grade3)).add(a.grade4.leftDot(b.grade4)),
        .grade1 = a.grade0.leftDot(b.grade1).add(a.grade1.leftDot(b.grade2)).add(a.grade2.leftDot(b.grade3)).add(a.grade3.leftDot(b.grade4)),
        .grade2 = a.grade0.leftDot(b.grade2).add(a.grade1.leftDot(b.grade3)).add(a.grade2.leftDot(b.grade4)),
        .grade3 = a.grade0.leftDot(b.grade3).add(a.grade1.leftDot(b.grade4)),
        .grade4 = a.grade0.leftDot(b.grade4),
    };
}
pub fn rightDot(a: @This(), b: @This()) @This() {
    return .{
        .grade0 = a.grade0.rightDot(b.grade0).add(a.grade1.rightDot(b.grade1)).add(a.grade2.rightDot(b.grade2)).add(a.grade3.rightDot(b.grade3)).add(a.grade4.rightDot(b.grade4)),
        .grade1 = a.grade1.rightDot(b.grade0).add(a.grade2.rightDot(b.grade1)).add(a.grade3.rightDot(b.grade2)).add(a.grade4.rightDot(b.grade3)),
        .grade2 = a.grade2.rightDot(b.grade0).add(a.grade3.rightDot(b.grade1)).add(a.grade4.rightDot(b.grade2)),
        .grade3 = a.grade3.rightDot(b.grade0).add(a.grade4.rightDot(b.grade1)),
        .grade4 = a.grade4.rightDot(b.grade0),
    };
}
pub fn dot(a: @This(), b: @This()) @This() {
    return .{
        .grade0 = a.grade0.dot(b.grade0).add(a.grade1.dot(b.grade1)).add(a.grade2.dot(b.grade2)).add(a.grade3.dot(b.grade3)).add(a.grade4.dot(b.grade4)),
        .grade1 = a.grade0.dot(b.grade1).add(a.grade1.dot(b.grade0)).add(a.grade1.dot(b.grade2)).add(a.grade2.dot(b.grade1)).add(a.grade2.dot(b.grade3)).add(a.grade3.dot(b.grade2)).add(a.grade3.dot(b.grade4)).add(a.grade4.dot(b.grade3)),
        .grade2 = a.grade0.dot(b.grade2).add(a.grade2.dot(b.grade0)).add(a.grade1.dot(b.grade3)).add(a.grade3.dot(b.grade1)).add(a.grade2.dot(b.grade4)).add(a.grade4.dot(b.grade2)),
        .grade3 = a.grade0.dot(b.grade3).add(a.grade3.dot(b.grade0)).add(a.grade1.dot(b.grade4)).add(a.grade4.dot(b.grade1)),
        .grade4 = a.grade0.dot(b.grade4).add(a.grade4.dot(b.grade0)),
    };
}
pub const Grade0 = struct {
    one: f32,
    pub const zero: Grade0 = .{ .one = 0 };
    pub fn magSq(a: Grade0) f32 {
        return a.one * a.one;
    }
    pub fn mag(a: Grade0) f32 {
        return a.one;
    }
    pub fn neg(a: Grade0) Grade0 {
        return .{ .one = -a.one };
    }
    pub fn rev(a: Grade0) Grade0 {
        return a;
    }
    pub fn dual(a: Grade0) Grade4 {
        return .{ .e0123 = a.one };
    }
    pub fn add(a: Grade0, b: Grade0) Grade0 {
        return .{ .one = a.one + b.one };
    }
    pub fn span(a: Grade0, b: anytype) switch (@TypeOf(b)) {
        Grade0 => Grade0,
        Grade1 => Grade1,
        Grade2 => Grade2,
        Grade3 => Grade3,
        Grade4 => Grade4,
        else => @compileError("span: incompatible types"),
    } {
        switch (@TypeOf(b)) {
            Grade0 => return .{ .one = a.one * b.one },
            Grade1 => return .{
                .e0 = a.one * b.e0,
                .e1 = a.one * b.e1,
                .e2 = a.one * b.e2,
                .e3 = a.one * b.e3,
            },
            Grade2 => return .{
                .e01 = a.one * b.e01,
                .e02 = a.one * b.e02,
                .e03 = a.one * b.e03,
                .e12 = a.one * b.e12,
                .e13 = a.one * b.e13,
                .e23 = a.one * b.e23,
            },
            Grade3 => return .{
                .e012 = a.one * b.e012,
                .e013 = a.one * b.e013,
                .e023 = a.one * b.e023,
                .e123 = a.one * b.e123,
            },
            Grade4 => return .{ .e0123 = a.one * b.e0123 },
            else => unreachable,
        }
    }
    pub fn leftDot(a: Grade0, b: anytype) switch (@TypeOf(b)) {
        Grade0 => Grade0,
        Grade1 => Grade1,
        Grade2 => Grade2,
        Grade3 => Grade3,
        Grade4 => Grade4,
        else => @compileError("leftDot: incompatible types"),
    } {
        switch (@TypeOf(b)) {
            Grade0 => return .{ .one = a.one * b.one },
            Grade1 => return .{
                .e0 = a.one * b.e0,
                .e1 = a.one * b.e1,
                .e2 = a.one * b.e2,
                .e3 = a.one * b.e3,
            },
            Grade2 => return .{
                .e01 = a.one * b.e01,
                .e02 = a.one * b.e02,
                .e03 = a.one * b.e03,
                .e12 = a.one * b.e12,
                .e13 = a.one * b.e13,
                .e23 = a.one * b.e23,
            },
            Grade3 => return .{
                .e012 = a.one * b.e012,
                .e013 = a.one * b.e013,
                .e023 = a.one * b.e023,
                .e123 = a.one * b.e123,
            },
            Grade4 => return .{ .e0123 = a.one * b.e0123 },
            else => unreachable,
        }
    }
    pub fn rightDot(a: Grade0, b: Grade0) Grade0 {
        return .{ .one = a.one * b.one };
    }
    pub fn dot(a: Grade0, b: anytype) switch (@TypeOf(b)) {
        Grade0 => Grade0,
        Grade1 => Grade1,
        Grade2 => Grade2,
        Grade3 => Grade3,
        Grade4 => Grade4,
        else => @compileError("dot: incompatible types"),
    } {
        return a.leftDot(b);
    }
};
pub const Grade1 = struct {
    e0: f32,
    e1: f32,
    e2: f32,
    e3: f32,
    pub const zero: Grade1 = .{
        .e0 = 0,
        .e1 = 0,
        .e2 = 0,
        .e3 = 0,
    };
    pub fn magSq(a: Grade1) f32 {
        return a.e1 * a.e1 + a.e2 * a.e2 + a.e3 * a.e3;
    }
    pub fn mag(a: Grade1) f32 {
        return @sqrt(a.magSq());
    }
    pub fn neg(a: Grade1) Grade1 {
        return .{
            .e0 = -a.e0,
            .e1 = -a.e1,
            .e2 = -a.e2,
            .e3 = -a.e3,
        };
    }
    pub fn rev(a: Grade1) Grade1 {
        return a;
    }
    pub fn dual(a: Grade1) Grade3 {
        return .{
            .e012 = -a.e3,
            .e013 = a.e2,
            .e023 = -a.e1,
            .e123 = a.e0,
        };
    }
    pub fn add(a: Grade1, b: Grade1) Grade1 {
        return .{
            .e0 = a.e0 + b.e0,
            .e1 = a.e1 + b.e1,
            .e2 = a.e2 + b.e2,
            .e3 = a.e3 + b.e3,
        };
    }
    pub fn span(a: Grade1, b: anytype) switch (@TypeOf(b)) {
        Grade0 => Grade1,
        Grade1 => Grade2,
        Grade2 => Grade3,
        Grade3 => Grade4,
        else => @compileError("span: incompatible types"),
    } {
        switch (@TypeOf(b)) {
            Grade0 => return .{
                .e0 = a.e0 * b.one,
                .e1 = a.e1 * b.one,
                .e2 = a.e2 * b.one,
                .e3 = a.e3 * b.one,
            },
            Grade1 => return .{
                .e01 = a.e0 * b.e1 - a.e1 * b.e0,
                .e02 = a.e0 * b.e2 - a.e2 * b.e0,
                .e03 = a.e0 * b.e3 - a.e3 * b.e0,
                .e12 = a.e1 * b.e2 - a.e2 * b.e1,
                .e13 = a.e1 * b.e3 - a.e3 * b.e1,
                .e23 = a.e2 * b.e3 - a.e3 * b.e2,
            },
            Grade2 => return .{
                .e012 = a.e0 * b.e12 - a.e1 * b.e02 + a.e2 * b.e01,
                .e013 = a.e0 * b.e13 - a.e1 * b.e03 + a.e3 * b.e01,
                .e023 = a.e0 * b.e23 - a.e2 * b.e03 + a.e3 * b.e02,
                .e123 = a.e1 * b.e23 - a.e2 * b.e13 + a.e3 * b.e12,
            },
            Grade3 => return .{
                .e0123 = a.e0 * b.e123 -
                    a.e1 * b.e023 +
                    a.e2 * b.e013 -
                    a.e3 * b.e012,
            },
            else => unreachable,
        }
    }
    pub fn leftDot(a: Grade1, b: anytype) switch (@TypeOf(b)) {
        Grade1 => Grade0,
        Grade2 => Grade1,
        Grade3 => Grade2,
        Grade4 => Grade3,
        else => @compileError("leftDot: incompatible types"),
    } {
        switch (@TypeOf(b)) {
            Grade1 => return .{ .one = a.e1 * b.e1 + a.e2 * b.e2 + a.e3 * b.e3 },
            Grade2 => return .{
                .e0 = -a.e1 * b.e01 - a.e2 * b.e02 - a.e3 * b.e03,
                .e1 = -a.e2 * b.e12 - a.e3 * b.e13,
                .e2 = a.e1 * b.e12 - a.e3 * b.e23,
                .e3 = a.e1 * b.e13 + a.e2 * b.e23,
            },
            Grade3 => return .{
                .e01 = a.e2 * b.e012 + a.e3 * b.e013,
                .e02 = -a.e1 * b.e012 + a.e3 * b.e023,
                .e03 = -a.e1 * b.e013 - a.e2 * b.e023,
                .e12 = a.e3 * b.e123,
                .e13 = -a.e2 * b.e123,
                .e23 = a.e1 * b.e123,
            },
            Grade4 => return .{
                .e012 = -a.e3 * b.e0123,
                .e013 = a.e2 * b.e0123,
                .e023 = -a.e1 * b.e0123,
                .e123 = 0,
            },
            else => unreachable,
        }
    }
    pub fn rightDot(a: Grade1, b: anytype) switch (@TypeOf(b)) {
        Grade0 => Grade1,
        Grade1 => Grade0,
        else => @compileError("rightDot: incompatible types"),
    } {
        switch (@TypeOf(b)) {
            Grade0 => return .{
                .e0 = a.e0 * b.one,
                .e1 = a.e1 * b.one,
                .e2 = a.e2 * b.one,
                .e3 = a.e3 * b.one,
            },
            Grade1 => return .{ .one = a.e1 * b.e1 + a.e2 * b.e2 + a.e3 * b.e3 },
            else => unreachable,
        }
    }
    pub fn dot(a: Grade1, b: anytype) switch (@TypeOf(b)) {
        Grade0 => Grade1,
        Grade1 => Grade0,
        Grade2 => Grade1,
        Grade3 => Grade2,
        Grade4 => Grade3,
        else => @compileError("dot: incompatible types"),
    } {
        switch (@TypeOf(b)) {
            Grade0 => return a.rightDot(b),
            Grade1, Grade2, Grade3, Grade4 => return a.leftDot(b),
            else => unreachable,
        }
    }
};
pub const Grade2 = struct {
    e01: f32,
    e02: f32,
    e03: f32,
    e12: f32,
    e13: f32,
    e23: f32,
    pub const zero: Grade2 = .{
        .e01 = 0,
        .e02 = 0,
        .e03 = 0,
        .e12 = 0,
        .e13 = 0,
        .e23 = 0,
    };
    pub fn magSq(a: Grade2) f32 {
        return a.e12 * a.e12 + a.e13 * a.e13 + a.e23 * a.e23;
    }
    pub fn mag(a: Grade2) f32 {
        return @sqrt(a.magSq());
    }
    pub fn neg(a: Grade2) Grade2 {
        return .{
            .e01 = -a.e01,
            .e02 = -a.e02,
            .e03 = -a.e03,
            .e12 = -a.e12,
            .e13 = -a.e13,
            .e23 = -a.e23,
        };
    }
    pub fn rev(a: Grade2) Grade2 {
        return a.neg();
    }
    pub fn dual(a: Grade2) Grade2 {
        return .{
            .e01 = a.e23,
            .e02 = -a.e13,
            .e03 = a.e12,
            .e12 = a.e03,
            .e13 = -a.e02,
            .e23 = a.e01,
        };
    }
    pub fn add(a: Grade2, b: Grade2) Grade2 {
        return .{
            .e01 = a.e01 + b.e01,
            .e02 = a.e02 + b.e02,
            .e03 = a.e03 + b.e03,
            .e12 = a.e12 + b.e12,
            .e13 = a.e13 + b.e13,
            .e23 = a.e23 + b.e23,
        };
    }
    pub fn span(a: Grade2, b: anytype) switch (@TypeOf(b)) {
        Grade0 => Grade2,
        Grade1 => Grade3,
        Grade2 => Grade4,
        else => @compileError("span: incompatible types"),
    } {
        switch (@TypeOf(b)) {
            Grade0 => return .{
                .e01 = a.e01 * b.one,
                .e02 = a.e02 * b.one,
                .e03 = a.e03 * b.one,
                .e12 = a.e12 * b.one,
                .e13 = a.e13 * b.one,
                .e23 = a.e23 * b.one,
            },
            Grade1 => return .{
                .e012 = a.e01 * b.e2 - a.e02 * b.e1 + a.e12 * b.e0,
                .e013 = a.e01 * b.e3 - a.e03 * b.e1 + a.e13 * b.e0,
                .e023 = a.e02 * b.e3 - a.e03 * b.e2 + a.e23 * b.e0,
                .e123 = a.e12 * b.e3 - a.e13 * b.e2 + a.e23 * b.e1,
            },
            Grade2 => return .{
                .e0123 = a.e01 * b.e23 -
                    a.e02 * b.e13 +
                    a.e03 * b.e12 +
                    a.e12 * b.e03 -
                    a.e13 * b.e02 +
                    a.e23 * b.e01,
            },
            else => unreachable,
        }
    }
    pub fn leftDot(a: Grade2, b: anytype) switch (@TypeOf(b)) {
        Grade2 => Grade0,
        Grade3 => Grade1,
        Grade4 => Grade2,
        else => @compileError("leftDot: incompatible types"),
    } {
        switch (@TypeOf(b)) {
            Grade2 => return .{ .one = -a.e12 * b.e12 - a.e13 * b.e13 - a.e23 * b.e23 },
            Grade3 => return .{
                .e0 = -a.e12 * b.e012 - a.e13 * b.e013 - a.e23 * b.e023,
                .e1 = -a.e23 * b.e123,
                .e2 = a.e13 * b.e123,
                .e3 = -a.e12 * b.e123,
            },
            Grade4 => return .{
                .e01 = -a.e23 * b.e0123,
                .e02 = a.e13 * b.e0123,
                .e03 = -a.e12 * b.e0123,
                .e12 = 0,
                .e13 = 0,
                .e23 = 0,
            },
            else => unreachable,
        }
    }
    pub fn rightDot(a: Grade2, b: anytype) switch (@TypeOf(b)) {
        Grade0 => Grade2,
        Grade1 => Grade1,
        Grade2 => Grade0,
        else => @compileError("rightDot: incompatible types"),
    } {
        switch (@TypeOf(b)) {
            Grade0 => return .{
                .e01 = a.e01 * b.one,
                .e02 = a.e02 * b.one,
                .e03 = a.e03 * b.one,
                .e12 = a.e12 * b.one,
                .e13 = a.e13 * b.one,
                .e23 = a.e23 * b.one,
            },
            Grade1 => return .{
                .e0 = a.e01 * b.e1 + a.e02 * b.e2 + a.e03 * b.e3,
                .e1 = a.e12 * b.e2 + a.e13 * b.e3,
                .e2 = -a.e12 * b.e1 + a.e23 * b.e3,
                .e3 = -a.e13 * b.e1 - a.e23 * b.e2,
            },
            Grade2 => return .{ .one = -a.e12 * b.e12 - a.e13 * b.e13 - a.e23 * b.e23 },
            else => unreachable,
        }
    }
    pub fn dot(a: Grade2, b: anytype) switch (@TypeOf(b)) {
        Grade0 => Grade2,
        Grade1 => Grade1,
        Grade2 => Grade0,
        Grade3 => Grade1,
        Grade4 => Grade2,
        else => @compileError("dot: incompatible types"),
    } {
        switch (@TypeOf(b)) {
            Grade0, Grade1 => return a.rightDot(b),
            Grade2, Grade3, Grade4 => return a.leftDot(b),
            else => unreachable,
        }
    }
};
pub const Grade3 = struct {
    e012: f32,
    e013: f32,
    e023: f32,
    e123: f32,
    pub const zero: Grade3 = .{
        .e012 = 0,
        .e013 = 0,
        .e023 = 0,
        .e123 = 0,
    };
    pub fn magSq(a: Grade3) f32 {
        return a.e123 * a.e123;
    }
    pub fn mag(a: Grade3) f32 {
        return @abs(a.e123);
    }
    pub fn neg(a: Grade3) Grade3 {
        return .{
            .e012 = -a.e012,
            .e013 = -a.e013,
            .e023 = -a.e023,
            .e123 = -a.e123,
        };
    }
    pub fn rev(a: Grade3) Grade3 {
        return a.neg();
    }
    pub fn dual(a: Grade3) Grade1 {
        return .{
            .e0 = -a.e123,
            .e1 = a.e023,
            .e2 = -a.e013,
            .e3 = a.e012,
        };
    }
    pub fn add(a: Grade3, b: Grade3) Grade3 {
        return .{
            .e012 = a.e012 + b.e012,
            .e013 = a.e013 + b.e013,
            .e023 = a.e023 + b.e023,
            .e123 = a.e123 + b.e123,
        };
    }
    pub fn span(a: Grade3, b: anytype) switch (@TypeOf(b)) {
        Grade0 => Grade3,
        Grade1 => Grade4,
        else => @compileError("span: incompatible types"),
    } {
        switch (@TypeOf(b)) {
            Grade0 => return .{
                .e012 = a.e012 * b.one,
                .e013 = a.e013 * b.one,
                .e023 = a.e023 * b.one,
                .e123 = a.e123 * b.one,
            },
            Grade1 => return .{
                .e0123 = a.e012 * b.e3 -
                    a.e013 * b.e2 +
                    a.e023 * b.e1 -
                    a.e123 * b.e0,
            },
            else => unreachable,
        }
    }
    pub fn leftDot(a: Grade3, b: anytype) switch (@TypeOf(b)) {
        Grade3 => Grade0,
        Grade4 => Grade1,
        else => @compileError("leftDot: incompatible types"),
    } {
        switch (@TypeOf(b)) {
            Grade3 => return .{ .one = -a.e123 * b.e123 },
            Grade4 => return .{
                .e0 = a.e123 * b.e0123,
                .e1 = 0,
                .e2 = 0,
                .e3 = 0,
            },
            else => unreachable,
        }
    }
    pub fn rightDot(a: Grade3, b: anytype) switch (@TypeOf(b)) {
        Grade0 => Grade3,
        Grade1 => Grade2,
        Grade2 => Grade1,
        Grade3 => Grade0,
        else => @compileError("rightDot: incompatible types"),
    } {
        switch (@TypeOf(b)) {
            Grade0 => return .{
                .e012 = a.e012 * b.one,
                .e013 = a.e013 * b.one,
                .e023 = a.e023 * b.one,
                .e123 = a.e123 * b.one,
            },
            Grade1 => return .{
                .e01 = a.e012 * b.e2 + a.e013 * b.e3,
                .e02 = -a.e012 * b.e1 + a.e023 * b.e3,
                .e03 = -a.e013 * b.e1 - a.e023 * b.e2,
                .e12 = a.e123 * b.e3,
                .e13 = -a.e123 * b.e2,
                .e23 = a.e123 * b.e1,
            },
            Grade2 => return .{
                .e0 = -a.e012 * b.e12 - a.e013 * b.e13 - a.e023 * b.e23,
                .e1 = -a.e123 * b.e23,
                .e2 = a.e123 * b.e13,
                .e3 = -a.e123 * b.e12,
            },
            Grade3 => return .{ .one = -a.e123 * b.e123 },
            else => unreachable,
        }
    }
    pub fn dot(a: Grade3, b: anytype) switch (@TypeOf(b)) {
        Grade0 => Grade3,
        Grade1 => Grade2,
        Grade2 => Grade1,
        Grade3 => Grade0,
        Grade4 => Grade1,
        else => @compileError("dot: incompatible types"),
    } {
        switch (@TypeOf(b)) {
            Grade0, Grade1, Grade2 => return a.rightDot(b),
            Grade3, Grade4 => return a.leftDot(b),
            else => unreachable,
        }
    }
};
pub const Grade4 = struct {
    e0123: f32,
    pub const zero: Grade4 = .{ .e0123 = 0 };
    pub fn magSq(a: Grade4) f32 {
        _ = a;
        return 0;
    }
    pub fn mag(a: Grade4) f32 {
        _ = a;
        return 0;
    }
    pub fn neg(a: Grade4) Grade4 {
        return .{ .e0123 = -a.e0123 };
    }
    pub fn rev(a: Grade4) Grade4 {
        return a;
    }
    pub fn dual(a: Grade4) Grade0 {
        return .{ .one = a.e0123 };
    }
    pub fn add(a: Grade4, b: Grade4) Grade4 {
        return .{ .e0123 = a.e0123 + b.e0123 };
    }
    pub fn span(a: Grade4, b: Grade0) Grade4 {
        return .{ .e0123 = a.e0123 * b.one };
    }
    pub fn leftDot(a: Grade4, b: Grade4) Grade0 {
        _ = .{ a, b };
        return .{ .one = 0 };
    }
    pub fn rightDot(a: Grade4, b: anytype) switch (@TypeOf(b)) {
        Grade0 => Grade4,
        Grade1 => Grade3,
        Grade2 => Grade2,
        Grade3 => Grade1,
        Grade4 => Grade0,
        else => @compileError("rightDot: incompatible types"),
    } {
        switch (@TypeOf(b)) {
            Grade0 => return .{ .e0123 = a.e0123 * b.one },
            Grade1 => return .{
                .e012 = a.e0123 * b.e3,
                .e013 = -a.e0123 * b.e2,
                .e023 = a.e0123 * b.e1,
                .e123 = 0,
            },
            Grade2 => return .{
                .e01 = -a.e0123 * b.e23,
                .e02 = a.e0123 * b.e13,
                .e03 = -a.e0123 * b.e12,
                .e12 = 0,
                .e13 = 0,
                .e23 = 0,
            },
            Grade3 => return .{
                .e0 = -a.e0123 * b.e123,
                .e1 = 0,
                .e2 = 0,
                .e3 = 0,
            },
            Grade4 => return .{ .one = 0 },
            else => unreachable,
        }
    }
    pub fn dot(a: Grade4, b: anytype) switch (@TypeOf(b)) {
        Grade0 => Grade4,
        Grade1 => Grade3,
        Grade2 => Grade2,
        Grade3 => Grade1,
        Grade4 => Grade0,
        else => @compileError("dot: incompatible types"),
    } {
        switch (@TypeOf(b)) {
            Grade0, Grade1, Grade2, Grade3, Grade4 => return a.rightDot(b),
            else => unreachable,
        }
    }
};
