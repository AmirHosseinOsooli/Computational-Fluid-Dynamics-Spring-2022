# Quick Setup Guide

## Getting Started in 5 Minutes

### 1. Repository Setup

```bash
# Navigate to your projects directory
cd ~/projects

# If downloading from GitHub:
git clone https://github.com/yourusername/burgers-equation-keller-box.git
cd burgers-equation-keller-box

# If using the provided files:
# Simply extract the folder to your desired location
```

### 2. Open MATLAB

```matlab
% Launch MATLAB and navigate to the repository
cd('path/to/burgers-equation-keller-box')

% Add the source folder to your path
addpath('src')
```

### 3. Run Your First Simulation

#### Option A: Uniform Mesh (Easier)

```matlab
cd src
project_one_uniform
```

When prompted, enter:
- `your mesh: 0.1`
- `your step time: 0.01`

#### Option B: Non-Uniform Mesh (More Advanced)

```matlab
cd src
project_one_non_uniform
```

When prompted, enter:
- `pleas enter your node's (odd): 21`
- `pleas enter your expansion rate: 1.1`
- `pleas enter your step time: 0.005`

### 4. What to Expect

You should see:
- A plot window opening
- Multiple curves showing solution evolution over time
- Information text on the plot showing your parameters

The simulation solves Burgers' equation from t=0 to t=5 seconds.

## Quick Parameter Guide

### Uniform Mesh Parameters

| Parameter | Good Starting Value | Range | Effect |
|-----------|-------------------|--------|---------|
| mesh | 0.1 | 0.01 - 0.2 | Smaller = more accurate but slower |
| step time | 0.01 | 0.001 - 0.02 | Smaller = more accurate but slower |

### Non-Uniform Mesh Parameters

| Parameter | Good Starting Value | Range | Effect |
|-----------|-------------------|--------|---------|
| nodes (odd) | 21 | 11 - 51 | More = better resolution |
| expansion rate | 1.1 | 1.05 - 1.2 | Higher = more stretched mesh |
| step time | 0.005 | 0.001 - 0.01 | Smaller = more stable |

## Common Issues

### Issue: "Error using /" or Division errors

**Solution**: Your time step might be too large. Try:
- Reducing `dt` to 0.005 or smaller
- Reducing mesh size for uniform mesh
- Using fewer nodes for non-uniform mesh

### Issue: Plot looks unstable or oscillatory

**Solution**: 
- Decrease time step (make it smaller)
- For non-uniform: reduce expansion rate closer to 1.0

### Issue: Simulation is too slow

**Solution**:
- Increase mesh size (uniform) or reduce nodes (non-uniform)
- Increase time step slightly
- Reduce simulation time in the code (change `t = 0:dt:5` to smaller end value)

## Next Steps

1. **Read the README.md** for detailed information
2. **Check docs/METHODOLOGY.md** to understand the method
3. **Experiment** with different parameters
4. **Modify** initial/boundary conditions in the code

## File Structure Quick Reference

```
burgers-equation-keller-box/
├── README.md              ← Start here
├── src/
│   ├── project_one_uniform.m       ← Run this
│   └── project_one_non_uniform.m   ← Or this
├── results/               ← Your plots
├── docs/                  ← Detailed documentation
│   ├── METHODOLOGY.md
│   └── THEORY.md
└── CONTRIBUTING.md        ← If you want to contribute
```

## Support

- **Questions?** Open an issue on GitHub
- **Found a bug?** Report it via GitHub issues
- **Want to contribute?** Read CONTRIBUTING.md

## Tips for Success

1. **Start simple**: Use recommended parameters first
2. **Visualize**: Watch how the solution evolves
3. **Compare**: Try both uniform and non-uniform meshes
4. **Document**: Keep notes on which parameters work best
5. **Learn**: Read the theory documentation to understand what you're seeing

---

**Happy Computing! 🚀**
