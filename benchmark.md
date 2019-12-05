---
layout: page
title: Benchmark
---

More detailed benchmark, please check [quantum-benchmark](https://github.com/Roger-luo/quantum-benchmarks).

## Single Gate Benchmark

Benchmarks of a) Pauli-X gate; b) Hadamard gate; c) CNOT gate; d) Toffolli gate.

<img src="https://github.com/Roger-luo/quantum-benchmarks/raw/master/images/gates.png" alt="single-gate-benchmark" width="100%">

<img src="https://github.com/Roger-luo/quantum-benchmarks/raw/master/images/gates_relative.png" alt="single-gate-relative" width="100%">

## Parameterized Circuit Benchmark

b) Benchmarks of parameterized circuit. c) Benchmarks of parametrized circuit with batched registers (batch size = 1000).

NOTE:

qiskit state vector simulator does not support rotation x/z gate, thus there is no benchmark on the following circuits.
PennyLane benchmark contains some overhead from error handling since we do not include measurement in this benchmark ([#7](https://github.com/Roger-luo/quantum-benchmarks/pull/7))
the performance of CUDA may vary on different machine ([#6](https://github.com/Roger-luo/quantum-benchmarks/issues/6)), although the difference is not very huge

<img src="https://github.com/Roger-luo/quantum-benchmarks/raw/master/images/pcircuit.png" alt="parameterized" width="100%">

<img src="https://github.com/Roger-luo/quantum-benchmarks/raw/master/images/pcircuit_relative.png" alt="parameterized-relative" width="100%">
