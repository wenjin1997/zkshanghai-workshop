pragma circom 2.1.4;

// 将 in 转换为 n 位二进制表达
template Num2Bits(n) {
    signal input in;
    signal output out[n];

    for (var i = 0; i < n; i++) {
        out[i] <-- (in \ 2**i) % 2;
    }

    var accm = 0;
    for (var i = 0; i < n; i++) {
        accm += out[i] * 2**i;
    }
    accm === in;

    // 约束输出的每一位是 0 / 1
    for (var i = 0; i < n; i++) {
        out[i] * (1 - out[i]) === 0;
    }
}


// in[0] < in[1] 返回 1，否则返回0
template LessThan (n) {
    // 先确定输入信号最多为 2**252 - 1
    assert(n <= 252);
    signal input in[2];
    signal output out;

    component n2b = Num2Bits(n+1);
    n2b.in <== in[0] - in[1] + (2**n); // n+1位二进制，最大数是 2**n
    out <== 1 - n2b.out[n];
}

template LessEqThan(n) {
    assert(n <= 252);
    signal input in[2];
    signal output out;

    component n2b = Num2Bits(n+1);
    n2b.in <== in[1] - in[0] + (2**n); // n+1位二进制，最大数是 2**n
    out <== n2b.out[n];
}

template GreaterThan(n) {
    assert(n <= 252);
    signal input in[2];
    signal output out;

    component n2b = Num2Bits(n+1);
    n2b.in <== in[1] - in[0] + (2**n);
    out <== 1 - n2b.out[n];
}

template GreaterEqThan(n) {
    assert(n <= 252);
    signal input in[2];
    signal output out;

    component n2b = Num2Bits(n+1);
    n2b.in <== in[0] - in[1] + (2**n);
    out <== n2b.out[n];
}

component main = GreaterEqThan(3);

/* INPUT = {
    "in": ["4", "3"]
} */