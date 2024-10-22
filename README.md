# Confidence intervals that utilize uncertain prior information (CIUUPI) in the case of two nested linear regression models.
During research, a researcher may encounter uncertain prior information regarding whether certain parameters should be included in a model. If this information were certain, the researcher could easily incorporate it into the statistical model. However, this information is often uncertain. [Kabaila, P. & Giri, K. (2009)](https://doi.org/10.1016/j.jspi.2009.03.018) introduced a family of confidence intervals that utilizes the uncertain prior information that the simpler model is true in the context of two nested linear regression models with a known error variance. They considered a linear regression model
$$Y = X \beta + \varepsilon,$$ 
where $Y$ is a random $n$-vector of responses, $X$ is a known $n \times p$ design matrix with linearly independent columns, $\beta$ is an unknown parameter $p$-vector, and  $\varepsilon \sim N(0, \, \sigma^2 \, I)$, with $\sigma^2$ assumed known. Suppose that the parameter of interest is $\theta = a^{\top} \beta$. Let $\tau = c^{\top} \beta - t = 0$, where $a$ and $c$ are specified linearly independent nonzero $p$-vectors and $t$ is a specified number. [Kabaila, P. & Giri, K. (2009)](https://doi.org/10.1016/j.jspi.2009.03.018) considered the uncertain prior information that $\tau = 0$ and introduced the confidence interval for $\theta$ with minimum coverage probability $1 - \alpha$ that utilizes this uncertain prior information. They also defined the scaled expected length of the confidence interval as 

$$\frac{\text{expected length of this confidence interval}} {\text{expected length of the standard } 1-\alpha \text{ confidence interval for }\theta}.$$

[Kabaila, P. & Giri, K. (2009)](https://doi.org/10.1016/j.jspi.2009.03.018) emphasized that the confidence interval must satisfy the following three conditions to ensure that the uncertain prior information has been effectively utilized. 

* The scaled expected length of the confidence interval that utilizes uncertain prior information is substantially less than 1 when $\tau =0$. 
* The maximum (over the parameter space) of the scaled expected length is not too much larger than 1. 
* The confidence interval reverts to the usual $1 - \alpha$ confidence interval when the data strongly contradict the uncertain prior information that $\tau = 0$. 

$$\text{CI}(b,s) = \Big [ \widehat{\theta} - v_{\theta}^{1/2} \, \sigma \, b(\widetilde{\gamma}) \pm v_{\theta}^{1/2} \, \sigma \,s(\widetilde{\gamma}) \Big]$$

where $b: \mathbb{R} \rightarrow \mathbb{R}$ is an odd continuous function and $s: \mathbb{R} \rightarrow [0, \infty)$ is an even continuous function. Also $b(x)=0$ and $s(x)= z_{1-\alpha/2}$ for all $|x| \ge d$, where $z_{1-\alpha/2}$ denotes the $1 - \alpha/2$ quantile of the standard normal distribution and $d$ is a sufficiently large number. 

Let $\widehat{\boldsymbol{\beta}} = (\boldsymbol{X}^{\top} \boldsymbol{X})^{-1} \, \boldsymbol{X}^{\top} \, \boldsymbol{Y}$, the least squares estimator of $\boldsymbol{\beta}$. Then $\widehat{\theta} = \boldsymbol{a}^{\top} \widehat{\boldsymbol{\beta}}$ and $\widehat{\tau} = \boldsymbol{c}^{\top} \widehat{\boldsymbol{\beta}}$ are the least squares estimators of $\theta$ and $\tau$, respectively.  
Now let 
$v_{\theta} = \text{var}(\widehat{\theta}) / \sigma^2
= \boldsymbol{a}^{\top}(\boldsymbol{X}^{\top}\boldsymbol{X})^{-1}\boldsymbol{a}$,
$v_{\tau} = \text{var}(\widehat{\tau}) / \sigma^2 = \boldsymbol{c}^{\top}(\boldsymbol{X}^{\top} \boldsymbol{X})^{-1} \boldsymbol{c}$.
Let $\rho = \text{corr}(\widehat{\theta}, \widehat{\tau})$, so that  $\rho 
= \boldsymbol{a}^{\top}(\boldsymbol{X}^{\top}\boldsymbol{X})^{-1}\boldsymbol{c} \big / (v_{\theta} v_{\tau} )^{1/2}$. Note that $v_{\theta}$, $v_{\tau}$ and $\rho$ are known quantities. 
Let $\gamma = \tau \big/ \big(\sigma \, v_{\tau}^{1/2} \big)$, which is an unknown parameter and $\widetilde{\gamma}$ be the estimate of $\gamma$. 

[Kabaila, P. & Giri, K. (2009)](https://doi.org/10.1016/j.jspi.2009.03.018) derived the form of this confidence interval that utilizes the uncertain prior information to be 

$$
	\text{CI}(b,s) = \Big [ \widehat{\theta}
	- v_{\theta}^{1/2} \, \sigma \, b(\widetilde{\gamma}) 
	\pm 
	v_{\theta}^{1/2} \, \sigma \,
	s(\widetilde{\gamma}) \Big].
$$

where $b: \mathbb{R} \rightarrow \mathbb{R}$ is an odd continuous 
function and $s: \mathbb{R} \rightarrow [0, \infty)$ is an even continuous function. 
In addition, $b(x) = 0$ and $s(x) = z_{1 - \alpha/2}$ for all $|x| \ge d$, where 
the quantile $z_a$ is defined by $\Pr(Z \le z_a) = a$ for $Z \sim N(0,1)$ and 
$d$ is a sufficiently large number. 
[ciuupi 1.2.3](https://cran.r-project.org/package=ciuupi) uses cubic spline 
interpolation to specify these functions using $q$ equally spaced nodes within 
the interval $[0,d]$. This package specifies the functions $b$ and $s$  
using sinc function interpolation.

### Advantages of using sinc function interpolation instead of cubic spline interpolation
Even though cubic splines are continuous between nodes, their derivatives are discontinuous at the nodes. As a result, the integrals must be split at the nodes, and the integration between nodes must be computed separately and then summed. This approach consumes considerable computational time and makes the formulas difficult to scale. Sinc function interpolation allows $b$ and $s$ to be infinitely differentiable, even at the nodes, making it an elegant replacement for cubic splines interpolation.

### Specification of the functions $b$ and $s$
The confidence interval that utilizes the uncertain prior information (CIUUPI)  is determined by the vector $\big(b(h), \dots, b(d-h), s_c(0), s_c(h), \dots, s_c(d-h)\big)$ where $h=d/h$ and $s_c$ is the corrected $s$ function. This vector is found through numerical nonlinear optimization so that the confidence interval $\text{CI}(b,s)$ has minimum coverage probability $1-\alpha$ and the desired scaled expected length properties. 

###### **It should be considered that this is an extension of [ciuupi 1.2.3](https://cran.r-project.org/package=ciuupi), and the approach used in this package is similar to the approach used in [ciuupi 1.2.3](https://cran.r-project.org/package=ciuupi). **

## Functions in this package
The functions in this package are used as follows:
```{r setup}
library(ciuupi.sinc)
```

#### `acX_to_rho`
Computes the correlation $\rho$ between $\widehat{\theta}$ and $\widehat{\tau}$.
```{r}
a <- c(0, 2, 0, -2)
c <- c(0, 0, 0, 1)
X <- cbind(rep(1,4), c(-1, 1, -1, 1), c(-1, -1, 1, 1),
c(1, -1, -1, 1))
rho <- acX_to_rho(a, c, X)
print(rho)
```

#### `ci_standard`
Computes the standard $1-\alpha$ confidence interval for $\theta$
```{r}
y <- c(87.2, 88.4, 86.7, 89.2)
sig <- 0.8
alpha <- 0.05
ci_standard(a, X, y, alpha, sig)
```

### Spefication of $b$ and $s$
#### `bsc_ciuupi_sinc`
Computes the vector $\big(b(h), \dots, b(d-h), s_c(0), s_c(h), \dots, s_c(d-h)\big)$ that specifies the functions $b$ and $s$. The values for $d$ and the number of nodes $q$ in the interval $[0,d]$ are calculated internally to accommodate $\alpha$ and $\rho$. It should be noted that the computation of $d$ and $q$ uses the same approach used in [ciuupi 1.2.3](https://cran.r-project.org/package=ciuupi).
```{r}
bsc.list <- bsc_ciuupi_sinc(rho, alpha)
print(bsc.list)
```

We can now use this specified vector to compute the observed value of the CIUUPI.

ciuupi_observed_value

#### `bsc_at_x`
Computes the value of the functions $b$ and $s$ at a given value of $x$ or a vector of $x$.
This function depends on the output produced by `bsc_ciuupi_sinc`.
```{r}
x.seq <- seq(-10,10, length.out=1000)
bsc.x <- bsc_at_x(x.seq, bsc.list)
print(bsc.list)
```

#### `plot_b` and `plot_s`
These functions plot the graphs of $b$ and $s$ for the computed nodes and function values in the interval $[0,d+2]$. They use the output produced by `bsc_ciuupi_sinc`.
```{r, fig.align='center', fig.width=5, fig.height=4}
plot_b(bsc.list)
plot_s(bsc.list)
```


### Evaluating the performance of the confidence interval that utilizes uncertain prior information

The coverage probability and the scaled expected length of the confidence interval evaluate the performance of the CIUUPI. This package provides several useful functions that could be used for this purpose. 

#### `cp_at_gamma`
Computes the value of the coverage probability of the confidence interval at a specified value of $\gamma$ or a vector of $\gamma$. This function depends on the output of `bsc_ciuupi_sinc`.
```{r}
gamma.vec <- seq(0,10, length.out=10)
cp.gamma <- cp_at_gamma(gamma.vec, bsc.list)
print(cp.gamma)
```

#### `sel_at_gamma`
Computes the value of the scaled expected length of the confidence interval for a given value of $\gamma$ or a vector of $\gamma$. This function depends on the output of `bsc_ciuupi_sinc`.

```{r}
gamma.vec <- seq(0,10, length.out=10)
sel.gamma <- sel_at_gamma(gamma.vec, bsc.list)
print(sel.gamma)
```

#### `plot_cp` and `plot_squared_sel`
The function `plot_cp` plots the graph of coverage probability minus $1-\alpha$ as a function of $\gamma$. This plot represents the function in the interval $[0, d+4]$ only since coverage probability is an even function of $\gamma$. This function depends on the output of `bsc_ciuupi_sinc`.
```{r, fig.align='center', fig.width=5, fig.height=4}
plot_cp(bsc.list)
```
The scaled expected length of the confidence interval is also an even function of $\gamma$. The squared scaled expected length may be interpreted as the following measure of the efficiency of the standard $1-\alpha$ confidence interval for $\theta$ relative to the CIUUPI with minimum coverage $1-\alpha$. The function  `plot_squared_sel`plots the graph of squared scaled expected length in the interval $[0,d+4]$.
```{r, fig.align='center', fig.width=5, fig.height=4}
plot_squared_sel(bsc.list)
```

