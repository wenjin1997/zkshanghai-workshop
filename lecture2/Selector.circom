pragma circom 2.1.4;

// 判断两数是否相等
template IsEqual () {
    signal input in[2];
    signal output out;
    signal inv;

    inv <-- (in[0] - in[1]) == 0 ? 0 : 1 / (in[0] - in[1]);
    out <== - inv * (in[0] - in[1]) + 1;
    out * (in[0] - in[1]) === 0;
}

// 累加，计算 n 个数的和
template Sum (n) {
    signal input in[n];
    signal output out;
    signal sum[n + 1];

    sum[0] <== 0;
    for (var i = 0; i < n; i++) {
        sum[i + 1] <== in[i] + sum[i];
    }
    out <== sum[n];
}

template Selector (nChoices) {
    signal input in[nChoices];
    signal input index;
    signal output out;
    
    component iseq[nChoices];
    component sum = Sum(nChoices);
    for (var i = 0; i < nChoices; i++) {
        // 判断 i 与 index 是否相等
        iseq[i] = IsEqual();
        iseq[i].in[0] <== i;
        iseq[i].in[1] <== index;

        // 如果 i == index，累加 1 * in[i]
        // 如果 i != index，累加 0 * in[i]
        sum.in[i] <== iseq[i].out * in[i]; 
    }

    // 如果 index 不在索引范围内，则每个iseq[i].out = 0，因此 sum.out = 0
    out <== sum.out;
}

component main = Selector(5);

/* INPUT = {
    "in": ["9", "13", "21", "35", "5"],
    "index": "2"
} */