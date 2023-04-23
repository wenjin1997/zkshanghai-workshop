pragma circom 2.1.4;

template IsZero () {
    signal input in;
    
    signal output out;

    signal inv <-- in == 0 ? 0 : 1/in; // 先辅助计算出 inv 的值

    /*
    // in 是 Unknown，编译器不会现在判断，那么就有两个赋值语句，这会报错
    if (in == 0) {
        inv <-- 0;
    } else {
        inv <-- 1 / in;
    }
    */

    // 约束
    out <== -in * inv + 1;
    in * out === 0;
}

component main = IsZero();

/* INPUT = {
    "in": "0"
} */