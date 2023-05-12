# 第 4 课 练习

* [x] Check out https://semaphore.appliedzkp.org/ and set up a starter project!

安装步骤很简单，按照官方文档[quick-setup](https://semaphore.appliedzkp.org/docs/quick-setup)进行。

运行my-app中的测试合约：
```shell
jinjin@Mac-mini contracts % npm test

> monorepo-ethers-contracts@1.0.0 test
> hardhat run scripts/download-snark-artifacts.ts && hardhat test



  Feedback
    # joinGroup
      ✔ Should allow users to join the group (618ms)
    # sendFeedback
      ✔ Should allow users to send feedback anonymously (2138ms)


  2 passing (5s)
  ```

生成Generate a test coverage report:
```shell
jinjin@Mac-mini contracts % npm run test:coverage

> monorepo-ethers-contracts@1.0.0 test:coverage
> hardhat coverage


Version
=======
> solidity-coverage: v0.7.22

Instrumenting for coverage...
=============================

> Feedback.sol

Compilation:
============

Generating typings for: 12 artifacts in dir: ./build/typechain for target: ethers-v5
Successfully generated 40 typings!
Compiled 14 Solidity files successfully

Network Info
============
> HardhatEVM: v2.14.0
> network:    hardhat



  Feedback
    # joinGroup
      ✔ Should allow users to join the group (731ms)
    # sendFeedback
      ✔ Should allow users to send feedback anonymously (2396ms)


  2 passing (5s)

---------------|----------|----------|----------|----------|----------------|
File           |  % Stmts | % Branch |  % Funcs |  % Lines |Uncovered Lines |
---------------|----------|----------|----------|----------|----------------|
 contracts/    |      100 |      100 |      100 |      100 |                |
  Feedback.sol |      100 |      100 |      100 |      100 |                |
---------------|----------|----------|----------|----------|----------------|
All files      |      100 |      100 |      100 |      100 |                |
---------------|----------|----------|----------|----------|----------------|

> Istanbul reports written to ./coverage/ and ./coverage.json
```

a test gas report:
```shell
jinjin@Mac-mini contracts % npm run test:report-gas

> monorepo-ethers-contracts@1.0.0 test:report-gas
> REPORT_GAS=true hardhat test

Compiled 14 Solidity files successfully

  Feedback
    # joinGroup
      ✓ Should allow users to join the group
    # sendFeedback
      ✓ Should allow users to send feedback anonymously

·-----------------------------|----------------------------|-------------|-----------------------------·
|     Solc version: 0.8.4     ·  Optimizer enabled: false  ·  Runs: 200  ·  Block limit: 30000000 gas  │
······························|····························|·············|······························
|  Methods                                                                                             │
·············|················|·············|··············|·············|···············|··············
|  Contract  ·  Method        ·  Min        ·  Max         ·  Avg        ·  # calls      ·  usd (avg)  │
·············|················|·············|··············|·············|···············|··············
|  Feedback  ·  joinGroup     ·     896154  ·     1656004  ·    1276079  ·            4  ·          -  │
·············|················|·············|··············|·············|···············|··············
|  Feedback  ·  sendFeedback  ·          -  ·           -  ·     396055  ·            2  ·          -  │
·············|················|·············|··············|·············|···············|··············
|  Deployments                ·                                          ·  % of limit   ·             │
······························|·············|··············|·············|···············|··············
|  Feedback                   ·          -  ·           -  ·    1514107  ·          5 %  ·          -  │
······························|·············|··············|·············|···············|··············
|  IncrementalBinaryTree      ·          -  ·           -  ·    1667044  ·        5.6 %  ·          -  │
······························|·············|··············|·············|···············|··············
|  Pairing                    ·          -  ·           -  ·    1204971  ·          4 %  ·          -  │
······························|·············|··············|·············|···············|··············
|  Semaphore                  ·          -  ·           -  ·    1846388  ·        6.2 %  ·          -  │
······························|·············|··············|·············|···············|··············
|  SemaphoreVerifier          ·          -  ·           -  ·    7357877  ·       24.5 %  ·          -  │
·-----------------------------|-------------|--------------|-------------|---------------|-------------·

  2 passing (5s)
```