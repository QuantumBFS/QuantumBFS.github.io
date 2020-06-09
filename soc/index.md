---
layout: page
title: Summer of Code
---

**Yao** is part of [Julia's Summer of Code](https://julialang.org/soc/gsoc/science.html). Please check if you are interested
in the ideas we propose, or you can also propose your own idea to us!

## Quantum Computation: Visualization of Quantum Circuits

Although, there is already a pretty printing for quantum circuits in [Yao.jl](https://github.com/QuantumBFS/Yao.jl) as a tree, we are still lack of visualizing a quantum circuit defined as [block tree](hhttps://docs.yaoquantum.org/dev/man/blocks.html). And we have already had basic plotting utilities in Julia, like [Luxor.jl](https://github.com/JuliaGraphics/Luxor.jl). It would be great and more convenient to provide multiple theme for plotting a quantum circuit with Yao.jl to various formats.

**Recommended Skills**: Basic knowledge in programatic visualization. Experienced with Luxor.jl is preferred but can be learned along the way.

**Expected Results**: Provide Yao.jl an extension package that converts a block tree to an image, which contains not only the circuit but also mark of composite blocks, users should be able to change theme for paper or multi-media use.

**Mentors**: [Roger Luo](https://github.com/Roger-luo/)

**References**: some demo image can be found in Yao.jl's [doc](https://docs.yaoquantum.org/dev/index.html)
