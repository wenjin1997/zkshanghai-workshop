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


// 限制 in 最多为 nbits 位
template Range(nbits) {
    signal input in;
    signal bits[nbits];
    var bitsum = 0;
    for (var i = 0; i < nbits; i++) {
        bits[i] <-- (in >> i) & 1;
        bits[i] * (1 - bits[i]) === 0;
        bitsum = bitsum + 2 ** i * bits[i];
    }

    in === bitsum;
}

template IntegerDivide (nbits) {
    assert(nbits <= 126);
    signal input dividend;
    signal input divisor;

    signal output remainder;
    signal output quotient;
    
    // 限制被除数、除数最多为 nbits 位
    component range1 = Range(nbits);
    range1.in <== dividend;
    component range2 = Range(nbits);
    range2.in <== divisor;

    // 限制除数不能为0
    signal inv;
    inv <-- 1 / divisor;
    inv * divisor === 1;

    // 计算商和余数
    quotient <-- dividend \ divisor;
    remainder <== dividend - quotient * divisor;

    // 约束余数在范围 [0, divisor) 之间
    component lessthan = LessThan(nbits);
    lessthan.in[0] <== remainder;
    lessthan.in[1] <== divisor;
    lessthan.out === 1;

    // 约束是正确的计算
    dividend === quotient * divisor + remainder;
}

component main = IntegerDivide(9);

/* INPUT = {
    "dividend": "89",
    "divisor": "43"
} */