# Methodology and Implementation Details

## Table of Contents

- [Numerical Method](#numerical-method)
- [Discretization](#discretization)
- [Algorithm Implementation](#algorithm-implementation)
- [Thomas Algorithm](#thomas-algorithm)
- [Mesh Generation](#mesh-generation)
- [Stability Analysis](#stability-analysis)

## Numerical Method

### Keller Box Scheme Overview

The Keller Box method is an implicit finite difference scheme that offers several advantages:

1. **Second-order accuracy** in both space and time
2. **Unconditional stability** for linear problems
3. **Efficient computation** through tridiagonal systems
4. **Flexible mesh** compatibility (uniform and non-uniform)

### Transformation to First-Order System

The Burgers' equation:
```
∂u/∂t + u(∂u/∂x) = ν(∂²u/∂x²)
```

is transformed by introducing an auxiliary variable v = ∂u/∂x:

```
∂u/∂t + u·v = ν(∂v/∂x)
∂u/∂x = v
```

This converts the second-order PDE into a coupled system of first-order PDEs.

## Discretization

### Spatial Discretization

Grid points are defined at positions xᵢ, where i = 1, 2, ..., n.

**First derivative** (centered difference):
```
∂u/∂x ≈ (uᵢ₊₁ - uᵢ₋₁)/(2·Δx)
```

**Mixed derivatives** are evaluated at midpoints using the box scheme approach.

### Temporal Discretization

Time is discretized into steps tᵏ where k = 1, 2, ..., T.

**Backward difference**:
```
∂u/∂t ≈ (uᵏ⁺¹ - uᵏ)/Δt
```

### Box Scheme Grid

The Keller Box method uses a staggered grid approach:

```
     k+1  |----+----+----+----+---|
          |    ■    ■    ■    ■   |
          | (i-1/2) (i+1/2)       |
      k   |----+----+----+----+---|
          x(i-1) x(i) x(i+1)
```

Where ■ represents the "box" center where equations are evaluated.

## Algorithm Implementation

### Matrix Formulation

At each time step, the discretized equations form a block tridiagonal system:

```
[B₁][X₁] + [A₁][X₂]                           = [r₁]
[C₂][X₁] + [B₂][X₂] + [A₂][X₃]               = [r₂]
           [C₃][X₂] + [B₃][X₃] + [A₃][X₄]    = [r₃]
                      ...
                      [Cₙ][Xₙ₋₁] + [Bₙ][Xₙ] = [rₙ]
```

Where:
- Xᵢ = [Δuᵢ, Δvᵢ]ᵀ (increments in u and v)
- Aᵢ, Bᵢ, Cᵢ are 2×2 coefficient matrices
- rᵢ are 2×1 right-hand side vectors

### Coefficient Matrices

#### For interior points (2 ≤ i ≤ n-1):

**Matrix A:**
```
Aᵢ = [0           0        ]
     [1/(2·Δxᵢ)  -1/4      ]
```

**Matrix B:**
```
Bᵢ = [1/(2·Δt) + vᵢ/4    -1/(2·Δxᵢ) + uᵢ/4]
     [-1/(2·Δxᵢ)         -1/4              ]
```

**Matrix C:**
```
Cᵢ = [1/(2·Δt) + vᵢ₋₁/4   1/(2·Δxᵢ) + uᵢ₋₁/4]
     [0                    0                  ]
```

#### Right-hand side vector:

```
rᵢ = [(-1/Δxᵢ)(vᵢ₋₁ - vᵢ) - ((uᵢ₋₁·vᵢ₋₁ + uᵢ·vᵢ)/2)    ]
     [(vᵢ₊₁ + vᵢ)/2 + (1/Δxᵢ)(uᵢ - uᵢ₊₁)              ]
```

### Boundary Conditions

Boundary conditions are incorporated into the first and last block equations:

**Left boundary (i = 1):**
- Apply u(0,t) = boundary value
- Modify B₁ and r₁ accordingly

**Right boundary (i = n):**
- Apply u(1,t) = boundary value
- Modify Bₙ and rₙ accordingly

## Thomas Algorithm

The Thomas algorithm (tridiagonal matrix algorithm) efficiently solves the block tridiagonal system in two passes:

### Forward Elimination

```matlab
for j = 2:n
    B{j} = B{j} - (C{j}/B{j-1}) * A{j-1}
    r{j} = r{j} - (C{j}/B{j-1}) * r{j-1}
end
```

This transforms the system into upper triangular form.

### Backward Substitution

```matlab
X{n} = B{n} \ r{n}

for i = n-1:-1:1
    X{i} = B{i} \ (r{i} - A{i} * X{i+1})
end
```

This recovers the solution vector from the transformed system.

### Complexity

- Time complexity: O(n) per time step
- Space complexity: O(n)
- Much more efficient than Gaussian elimination (O(n³))

## Mesh Generation

### Uniform Mesh

Simple equispaced grid:

```matlab
dx = constant
x(i) = (i-1) * dx,  i = 1, 2, ..., n
```

**Advantages:**
- Simple implementation
- Consistent accuracy throughout domain
- Easy error analysis

### Non-Uniform Mesh

Geometric progression with expansion ratio ER:

```matlab
dx(1) = ((1-ER)/(1-ER^((n-1)/2))) * 0.5
dx(i+1) = dx(i) * ER
```

The mesh is refined near the boundaries and coarser in the center.

**Mesh spacing calculation:**
1. Compute first element spacing dx(1)
2. Apply geometric progression outward from center
3. Ensure symmetry about domain center

**Advantages:**
- Efficient resolution of boundary layers
- Reduced computational cost
- Better capture of steep gradients

**Position calculation:**
```matlab
x(1) = 0
for i = 1:n-2
    x(i+1) = x(i) + dx(i)
end
```

## Stability Analysis

### CFL Condition

For stability, the Courant-Friedrichs-Lewy (CFL) condition should be satisfied:

```
CFL = |u| * Δt/Δx < 1
```

For implicit schemes like Keller Box, this condition is relaxed, but smaller CFL numbers improve accuracy.

### Recommended Parameters

Based on numerical experiments:

| Parameter | Uniform Mesh | Non-Uniform Mesh |
|-----------|--------------|------------------|
| dx | 0.01 - 0.1 | ER: 1.05 - 1.2 |
| dt | 0.001 - 0.01 | 0.001 - 0.01 |
| CFL | < 0.5 | < 0.5 |

### Convergence

The method exhibits:
- **Temporal convergence**: O(Δt²)
- **Spatial convergence**: O(Δx²)
- **Overall convergence**: O(Δt² + Δx²)

## Error Sources

### Truncation Error

From Taylor series expansion:
- Spatial: O(Δx²)
- Temporal: O(Δt²)

### Round-off Error

Minimized through:
- Double precision arithmetic
- Stable algorithm (Thomas algorithm)
- Proper matrix scaling

### Stability Considerations

While the Keller Box scheme is unconditionally stable for linear problems, nonlinear terms in Burgers' equation can affect stability. Use conservative time steps for highly nonlinear cases.

## Verification

### Code Verification

1. **Grid convergence**: Solution should converge as Δx, Δt → 0
2. **Consistency check**: Verify O(Δt²) and O(Δx²) convergence rates
3. **Conservation check**: Mass should be conserved (for conservative form)
4. **Boundary condition verification**: Ensure BC are satisfied at all times

### Validation

1. Compare with analytical solutions (small viscosity limit)
2. Benchmark against published results
3. Compare uniform vs non-uniform mesh solutions at same resolution

## Implementation Notes

### MATLAB Specific

- Cell arrays used for flexibility in matrix dimensions
- Matrix division (`\`) for efficient solution
- Vectorization where possible for performance
- Hold on for progressive plotting

### Numerical Considerations

1. Check for matrix singularity during Thomas algorithm
2. Monitor solution for non-physical behavior (negative values, unbounded growth)
3. Adjust parameters if stability issues arise
4. Use finer mesh near regions of high gradients

### Performance Tips

1. Pre-allocate arrays (done via `zeros`)
2. Minimize dynamic array resizing
3. Use built-in matrix operations
4. Consider sparse matrices for very large systems (not implemented here)

## Further Reading

1. Keller, H. B. (1970). "A new difference scheme for parabolic problems."
2. Fletcher, C. A. J. (1988). "Computational Techniques for Fluid Dynamics."
3. Hoffman, J. D. (2001). "Numerical Methods for Engineers and Scientists."
4. Tannehill, J. C., et al. (1997). "Computational Fluid Mechanics and Heat Transfer."

---

*This document provides the mathematical and computational foundation for the Keller Box implementation in this repository.*
