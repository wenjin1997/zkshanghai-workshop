pragma circom 2.1.4;

template IsEqual () {
    signal input in[2];
    signal output out;
    
    signal inv; // 计算逆元
    
    inv <-- (in[0] - in[1]) == 0 ? 0 : 1 / (in[0] - in[1]);
    out <== - (in[0] - in[1]) * inv + 1;
    out * (in[0] - in[1]) === 0;
}

component main = IsEqual();

/* INPUT = {
    "in": ["1", "2"]
} */