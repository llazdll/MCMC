n <- 20000
n_repeats <- 100
A_hat <- numeric(n_repeats)
B_hat <- numeric(n_repeats)
C_hat <- numeric(n_repeats)
D_hat <- numeric(n_repeats)
true_vals <- list(A = 2, B = 1, C = 2, D = 2)
fn <- function(n) {
  A <- numeric(n)
  B <- numeric(n)
  C <- numeric(n)
  D <- numeric(n)
  A[1] <- true_vals$A
  B[1] <- true_vals$B
  C[1] <- true_vals$C
  D[1] <- true_vals$D
  for (i in 1:(n - 1)) {
    A[i + 1] <- rgamma(1, 1, 1 + B[i])
    B[i + 1] <- rexp(1, 1 + abs(D[i] - C[i]))
    # mcmc for C
    z <- rnorm(1, C[i], 1)
    y <- abs(z)
    ro <- ifelse(C[i] == 0, 1, (y / A[i + 1]) / (C[i] / A[i + 1]))
    RO <- min(1, ro)
    C[i + 1] <- if (runif(1) < RO) y else C[i]
    D[i + 1] <- runif(1, A[i + 1], A[i + 1] + 2)
  }
  par(mfrow = c(2, 2))
  plot(1:n,cumsum(A)/(1:n),type="l")
  plot(1:n,cumsum(B)/(1:n),type="l")
  plot(1:n,cumsum(C)/(1:n),type="l")
  plot(1:n,cumsum(D)/(1:n),type="l")
  return(list(
    A_mean = mean(A),
    B_mean = mean(B),
    C_mean = mean(C),
    D_mean = mean(D)
  ))
}

pb <- txtProgressBar(min = 0, max = n_repeats, style = 3)
start_time <- Sys.time()
fn(n)
for (t in 1:n_repeats) {
  result <- fn(n)
  A_hat[t] <- result$A_mean
  B_hat[t] <- result$B_mean
  C_hat[t] <- result$C_mean
  D_hat[t] <- result$D_mean
  
  setTxtProgressBar(pb, t)
  
  if (t %% 10 == 0) {
    elapsed <- as.numeric(difftime(Sys.time(), start_time, units = "secs"))
    avg_time <- elapsed / t
    remaining_time <- avg_time * (n_repeats - t)
    
    cat(sprintf("[%s] Completed %d iterations | Elapsed: %.1f secs | Remaining: %.1f secs\n",
                format(Sys.time(), "%H:%M:%S"), t, elapsed, remaining_time))
  }
}

calculate_metrics <- function(estimates, true_value) {
  bias <- mean(estimates) - true_value
  mse <- mean((estimates - true_value)^2)
  rmse <- sqrt(mse)
  return(list(bias = bias, mse = mse, rmse = rmse))
}

metrics_A <- calculate_metrics(A_hat, true_vals$A)
metrics_B <- calculate_metrics(B_hat, true_vals$B)
metrics_C <- calculate_metrics(C_hat, true_vals$C)
metrics_D <- calculate_metrics(D_hat, true_vals$D)

end_time <- Sys.time()
total_time <- as.numeric(difftime(end_time, start_time, units = "secs"))

cat("\n--- Summary ---\n")
cat(sprintf("A: Mean = %.4f | Bias = %.4f | MSE = %.4f | RMSE = %.4f\n",mean(A_hat), metrics_A$bias, metrics_A$mse, metrics_A$rmse))
cat(sprintf("B: Mean = %.4f | Bias = %.4f | MSE = %.4f | RMSE = %.4f\n",mean(B_hat), metrics_B$bias, metrics_B$mse, metrics_B$rmse))
cat(sprintf("C: Mean = %.4f | Bias = %.4f | MSE = %.4f | RMSE = %.4f\n",mean(C_hat), metrics_C$bias, metrics_C$mse, metrics_C$rmse))
cat(sprintf("D: Mean = %.4f | Bias = %.4f | MSE = %.4f | RMSE = %.4f\n",mean(D_hat), metrics_D$bias, metrics_D$mse, metrics_D$rmse))
cat(sprintf("Total runtime: %.1f seconds (%.1f minutes)\n",total_time, total_time / 60))
