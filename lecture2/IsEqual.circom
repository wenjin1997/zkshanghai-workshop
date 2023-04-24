pragma circom 2.1.4;

template IsZero () {
    signal input in;
    
    signal output out;

    signal inv <-- in == 0 ? 0 : 1/in; // 先辅助计算出 inv 的值

    // 约束
    out <== -in * inv + 1;
    in * out === 0;
}

template IsEqual () {
    signal input in[2];

    signal output out;
    
    component iszero = IsZero();
    iszero.in <== in[0] - in[1];
    out <== iszero.out;
}

component main = IsEqual();

/* INPUT = {
    "in": ["1", "1"]
} */