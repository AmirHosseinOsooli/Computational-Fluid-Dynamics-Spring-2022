# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Feature requests and planned enhancements

### Changed
- Planned modifications

### Deprecated
- Features to be removed

### Removed
- Removed features

### Fixed
- Bug fixes in development

### Security
- Security updates

## [1.0.0] - 2024-MM-DD

### Added
- Initial release of Burgers' Equation Keller Box Solver
- Uniform mesh solver implementation
- Non-uniform mesh solver with expansion ratio
- Thomas algorithm for tridiagonal system solution
- Real-time visualization of solution evolution
- Comprehensive documentation (README, METHODOLOGY, THEORY)
- Example results with different parameter sets
- MATLAB code with detailed comments
- MIT License
- Contributing guidelines
- Quick start guide

### Features
- Second-order accuracy in space and time
- Implicit finite difference scheme (Keller Box)
- Customizable initial and boundary conditions
- Support for both uniform and non-uniform grids
- Efficient O(n) solution per time step

### Documentation
- Complete README with installation and usage
- Theoretical background (THEORY.md)
- Methodology and implementation details (METHODOLOGY.md)
- Contributing guidelines (CONTRIBUTING.md)
- Quick setup guide (QUICKSTART.md)

### Examples
- Uniform mesh: dx=0.1, dt=0.01
- Non-uniform mesh: nodes=20, ER=1.1, dt=0.005
- Visual results included in results/ directory

---

## Version History Summary

- **v1.0.0** (2024) - Initial release with core functionality

---

## How to Update This File

When making changes:

1. Add new entries under `[Unreleased]` section
2. When releasing a version:
   - Change `[Unreleased]` to `[Version] - Date`
   - Add new `[Unreleased]` section above it
   - Update version numbers in code if applicable

### Categories

- **Added**: New features
- **Changed**: Changes to existing functionality
- **Deprecated**: Soon-to-be removed features
- **Removed**: Removed features
- **Fixed**: Bug fixes
- **Security**: Security-related changes

### Example Entry Format

```markdown
### Added
- Brief description of what was added [#IssueNumber]
- Another addition with reference to PR [#PullRequest]

### Fixed
- Fix for specific bug [#BugNumber]
```

---

For complete details of changes, see the [commit history](https://github.com/yourusername/burgers-equation-keller-box/commits/main).
