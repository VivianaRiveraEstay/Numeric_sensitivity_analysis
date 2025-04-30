# Numeric_sensitivity_analysis

# Sensitivity Analysis for a Phenotypic Change Model

This repository contains a MATLAB script for performing a **sensitivity analysis** on a system of ordinary differential equations that models ecological interactions with **phenotypic change**. The analysis focuses on one parameter at a time (in this example, `theta4`), though the same approach has been applied to other parameters like `d1`, `d2`, `cy`, `cz`, `Gy`, and `Gz`.

## Description

The script:
- Solves a system of ODEs using `ODE45` for different values of a target parameter
- Computes and stores the final population densities of prey, native predator, and exotic predator
- Calculates three sensitivity metrics:
  1. Absolute range of variation
  2. Relative variation (%)
  3. Numerical sensitivity (finite difference approximation)
- Generates two figures:
  - Final population densities as a function of the target parameter
  - Numerical sensitivity curves (derivatives)

## File

- `sensitivity_theta4.m`: Performs the full sensitivity analysis for `theta4`.

> You can modify the script to perform the same type of analysis on other parameters by changing the `theta4` vector and its position within the parameter list `P`.

## How to Use

1. Open the script in MATLAB.
2. Replace the vector `theta4` with the parameter you wish to analyze (e.g., `d1`, `cy`, etc.).
3. Run the script to:
   - Solve the system for all parameter values
   - Generate time series using `ODE45`
   - Compute final states and sensitivity metrics
   - Plot results

## Output

- Console outputs:
  - Range of variation
  - Relative variation
  - Numerical sensitivity (finite differences)
- Figures:
  - Final densities vs. parameter
  - Sensitivity curves

## Notes

- You can change the initial conditions in the variable `x0`.
- The script includes a threshold to discard near-zero values (`1e-6`) for better stability and interpretability.
- Simulation time is set to `tspan = [0 10000]` and can be adjusted as needed.
- Sensitivity values that involve division by zero are handled to avoid NaNs or infinities in calculations.

## Author

**Viviana Rivera-Estay**  
PhD in Applied Mathematical Modeling  
Email: vivianarivera.mate@gmail.com
