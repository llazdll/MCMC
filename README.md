# Monte Carlo Simulation Analysis 📊

This repository contains an awesome R script that dives into a Monte Carlo simulation to analyze the convergence of four variables (A, B, C, D) using stochastic processes and Markov Chain Monte Carlo (MCMC) methods! ⛓️

## Description 🌟

The script simulates the evolution of variables A, B, C, and D over 20,000 iterations, repeated 100 times. It leverages:

- Gamma distribution for A 
- Exponential distribution for B 
- Metropolis-Hastings algorithm for C 
- Uniform distribution for D 

The code generates stunning convergence plots and calculates key statistical metrics (bias, mean squared error, and root mean squared error) by comparing the mean estimates with true values.

## Features 

- Generates cool convergence plots for A, B, C, and D in a 2x2 grid 🎨
- Tracks progress with a sleek progress bar ⏳
- Provides real-time estimates of elapsed and remaining time ⏰
- Computes bias, MSE, and RMSE for each variable with precision 🔢

## Requirements 🛠️

- R environment (no extra packages needed, just base R! ✅)

## Usage 🚀

1. Clone the repository:

   ```bash
   git clone <repository-url>
   ```
2. Open the R script and run it directly in your R environment. Let the magic happen! 🪄

## Output 🎥

- Four eye-catching convergence plots displayed in a 2x2 grid
- Progress updates every 10 iterations to keep you in the loop 📡
- Summary statistics including mean, bias, MSE, RMSE, and total runtime 📝

## Notes 📝

- The script uses true initial values: A = 2, B = 1, C = 2, D = 2 🎯
- Feel free to tweak `n` and `n_repeats` to scale the simulation or change repetitions! ⚙️

## License 🎫

MIT License (or specify your preferred license)

## Contributors 🙌

Made with ❤️ by \[Your Name or Team\]. Contributions are welcome! 🌍
