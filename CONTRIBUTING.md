# Contributing to Burgers' Equation Keller Box Solver

Thank you for your interest in contributing to this project! This document provides guidelines for contributing to the repository.

## How to Contribute

### Reporting Bugs

If you find a bug, please open an issue with:

1. **Clear title** describing the problem
2. **Detailed description** of the bug
3. **Steps to reproduce** the issue
4. **Expected behavior** vs actual behavior
5. **MATLAB version** and operating system
6. **Parameter values** used (mesh size, time step, etc.)
7. **Error messages** or screenshots if applicable

### Suggesting Enhancements

Enhancement suggestions are welcome! Please include:

1. **Clear description** of the feature
2. **Use case**: Why is this feature useful?
3. **Proposed implementation** (if you have ideas)
4. **Alternatives considered**

### Pull Requests

We welcome pull requests! Please follow these steps:

1. **Fork** the repository
2. **Create a branch** for your feature (`git checkout -b feature/AmazingFeature`)
3. **Make your changes** with clear, commented code
4. **Test thoroughly** with multiple parameter sets
5. **Update documentation** if needed
6. **Commit** with descriptive messages
7. **Push** to your fork
8. **Open a Pull Request** with detailed description

## Coding Standards

### MATLAB Style Guidelines

1. **Naming Conventions**
   - Variables: lowercase with underscores (`time_step`, `mesh_size`)
   - Functions: camelCase (`calculateFlux`, `applyBoundary`)
   - Constants: UPPERCASE (`MAX_ITERATIONS`, `TOLERANCE`)

2. **Comments**
   - Use `%` for single-line comments
   - Use `%%` for section headers
   - Document all functions with header comments
   - Explain complex algorithms

3. **Code Structure**
   ```matlab
   %% Section 1: Initialization
   % Clear description of what this section does
   
   % Variable initialization
   variable = value;  % Inline comment if needed
   
   %% Section 2: Main Loop
   % Description...
   for i = 1:n
       % Loop body
   end
   ```

4. **Indentation**
   - Use 4 spaces (or one tab)
   - Consistent throughout

5. **Line Length**
   - Keep lines under 80-100 characters where possible
   - Break long lines logically

### Code Quality

1. **Vectorization**
   - Use vectorized operations where possible
   - Avoid unnecessary loops

2. **Pre-allocation**
   - Pre-allocate arrays with `zeros`, `ones`, or `cell`
   - Improves performance significantly

3. **Error Handling**
   - Validate input parameters
   - Use `error()` for critical issues
   - Use `warning()` for non-critical issues

4. **Documentation**
   - Function headers should include:
     ```matlab
     function output = myFunction(input1, input2)
     % MYFUNCTION Brief description
     %
     % Syntax:
     %   output = myFunction(input1, input2)
     %
     % Description:
     %   Detailed description of what the function does
     %
     % Inputs:
     %   input1 - Description (units, type)
     %   input2 - Description (units, type)
     %
     % Outputs:
     %   output - Description (units, type)
     %
     % Example:
     %   result = myFunction(5, 10);
     %
     % See also: relatedFunction1, relatedFunction2
     
     % Implementation
     end
     ```

## Testing

### Before Submitting

Test your changes with:

1. **Various mesh sizes**: 0.01, 0.05, 0.1
2. **Different time steps**: 0.001, 0.005, 0.01
3. **Multiple expansion ratios** (for non-uniform): 1.05, 1.1, 1.2
4. **Edge cases**: Very fine mesh, very coarse mesh
5. **Boundary conditions**: Different BC combinations

### Expected Behavior

Verify:
- Solution remains stable
- No NaN or Inf values
- Physically reasonable results
- Conservation properties maintained
- Proper convergence

## Documentation

### README Updates

If your changes affect usage:
- Update the relevant sections in README.md
- Add examples if introducing new features
- Update parameter tables

### Code Documentation

- Add comments explaining your logic
- Update function headers
- Document any new files

### Theoretical Documentation

If adding new methods or significantly modifying existing ones:
- Update METHODOLOGY.md
- Update THEORY.md if relevant
- Add references for new methods

## Commit Messages

Use clear, descriptive commit messages:

### Format

```
Type: Brief description (50 chars or less)

More detailed explanation if needed. Wrap at 72 characters.
Explain the problem this commit solves and why this solution
was chosen.

- Bullet points are okay
- Typically a hyphen or asterisk is used for the bullet
- Use a hanging indent
```

### Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Formatting, missing semicolons, etc.
- `refactor`: Code restructuring without changing functionality
- `test`: Adding tests
- `chore`: Maintenance tasks

### Examples

```
feat: Add adaptive time stepping

Implements adaptive time stepping based on local truncation error
estimation. Improves efficiency for problems with varying dynamics.

- Calculates error at each step
- Adjusts dt automatically
- Adds optional parameter 'adaptive_dt'
```

```
fix: Correct boundary condition indexing

Fixed off-by-one error in boundary condition application for
non-uniform mesh. Was causing incorrect results at boundaries.

Closes #15
```

## Priority Areas for Contribution

### High Priority

1. **Testing suite**: Automated tests with known solutions
2. **Error analysis**: Convergence rate verification
3. **Performance optimization**: Profiling and speedup
4. **Documentation improvements**: Clarify existing docs

### Medium Priority

1. **2D Burgers' equation**: Extension to 2D
2. **Adaptive meshing**: Dynamic mesh refinement
3. **Visualization improvements**: Better plotting options
4. **GUI**: User-friendly interface

### Low Priority (but welcome!)

1. **Alternative schemes**: Implement other methods for comparison
2. **Parallel processing**: GPU or parallel CPU implementation
3. **Advanced features**: Sensitivity analysis, uncertainty quantification
4. **Additional examples**: More test cases and applications

## Getting Help

- **Questions**: Open an issue with the "question" label
- **Discussions**: Use GitHub Discussions (if enabled)
- **Bugs**: Open an issue with the "bug" label

## Recognition

Contributors will be:
- Listed in a CONTRIBUTORS.md file
- Acknowledged in release notes
- Credited in relevant documentation

## Code of Conduct

### Our Standards

- Be respectful and inclusive
- Welcome newcomers
- Accept constructive criticism
- Focus on what's best for the project

### Unacceptable Behavior

- Harassment or discrimination
- Trolling or insulting comments
- Personal or political attacks
- Other unprofessional conduct

## License

By contributing, you agree that your contributions will be licensed under the same MIT License that covers the project.

## Additional Resources

### Learning Resources

- [MATLAB Documentation](https://www.mathworks.com/help/matlab/)
- [Git Tutorial](https://git-scm.com/docs/gittutorial)
- [Markdown Guide](https://www.markdownguide.org/)

### CFD Resources

- Computational Fluid Dynamics textbooks listed in THEORY.md
- Online courses on numerical methods
- CFD-Online community forums

## Questions?

If you have questions about contributing, feel free to:
- Open an issue
- Contact the maintainer
- Check existing documentation

---

Thank you for contributing to this project! Your efforts help make this a better resource for the CFD community.
