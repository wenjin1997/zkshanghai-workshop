pragma circom 2.1.4;

template Num2Bites (nBits) {
    signal input in;
    
    signal output b[nBits];

    // 先计算 in 的二进制表达
    for (var i = 0; i < nBits; i++) {
        b[i] <-- (in \ 2 ** i) % 2;
    }

    // 约束：确保 b 是 in 的二进制表达
    var accm = 0; // 可变变量，累加
    for (var i = 0; i < nBits; i++) {
        accm += b[i] * 2**i;
    }
    accm === in; // 约束

    // 约束：b的每一位是二进制，也就是 0 / 1
    for (var i = 0; i < nBits; i++) {
        0 === b[i] * (1 - b[i]);
    }
}

component main = Num2Bites(5);

/* INPUT = {
    "in": "10"
} */