file_path <- "../../datasets/antisemitism-canada/antisemitic-violence.csv"

########################################
## 1. Setup
########################################
library(tidyverse)
library(MASS)

########################################
## 2. Data Import
########################################
df <- read.csv(file_path)

########################################
## 3. Split Data (Training & Full for Plot)
########################################
df_train <- df %>%
  filter(year >= 2002 & year <= 2020) %>%
  arrange(year)

df_plot <- df %>%
  filter(year >= 2002 & year <= 2023) %>%
  arrange(year)

########################################
## 4. Fit Poisson Regression (2002–2020)
########################################
# Model: log(incidents) = Intercept + beta*year
model_pois <- glm(
  incidents ~ year,
  data   = df_train,
  family = poisson(link = "log")
)

summary(model_pois)  # Inspect the model

########################################
## 5. Non-Parametric Bootstrap for Prediction Intervals
########################################
newdata <- data.frame(year = 2002:2023)

X_mat <- model.matrix(~ year, data = newdata)
n_years <- nrow(newdata)

# Number of bootstrap samples (quite large for stable intervals)
B <- 100000  

Y_future <- matrix(NA, nrow = B, ncol = n_years)

set.seed(123)  # for reproducibility

for (b in seq_len(B)) {
  # 1. Create a bootstrap sample of df_train
  #    with the same number of rows as df_train, sampling with replacement
  df_boot <- df_train[sample(seq_len(nrow(df_train)), 
                             size = nrow(df_train), 
                             replace = TRUE), ]
  
  # 2. Fit the Poisson model on this bootstrap sample
  model_boot <- glm(
    incidents ~ year,
    data   = df_boot,
    family = poisson(link = "log")
  )
  
  # 3. Predict means for newdata (2002–2023) from this bootstrap-fitted model
  mu_star <- predict(model_boot, newdata = newdata, type = "response")
  
  # 4. Generate future observations from Poisson(mu_star)
  Y_future[b, ] <- rpois(n = n_years, lambda = mu_star)
}

# Compute the 2.5% and 97.5% quantiles across the B draws for each year
alpha_lower <- 0.025
alpha_upper <- 0.975

pred_intervals <- apply(Y_future, 2, function(vals) {
  c(
    lower           = quantile(vals, probs = alpha_lower),
    upper           = quantile(vals, probs = alpha_upper),
    mean_prediction = mean(vals)  # average future count from all draws
  )
}) %>%
  t() %>%
  as.data.frame()

# Attach intervals to newdata
newdata <- newdata %>%
  mutate(
    lower       = pred_intervals$lower,
    upper       = pred_intervals$upper,
    pred_future = pred_intervals$mean_prediction
  )

########################################
## 6. Visualization
########################################

g <- ggplot() +
  # A) Observed data in BLUE (dotted line + points)
  geom_line(
    data = df_plot,
    aes(x = year, y = incidents),
    color = "blue", size = 1, linetype = "dotted"
  ) +
  geom_point(
    data = df_plot,
    aes(x = year, y = incidents),
    color = "blue", size = 3 
  ) +
  
  # B) Mean predicted future count in BLACK
  geom_line(
    data = newdata,
    aes(x = year, y = pred_future),
    color = "black", size = 1
  ) +
  
  # C) Ribbon for the prediction intervals in GRAY
  geom_ribbon(
    data = newdata,
    aes(x = year, ymin = lower, ymax = upper),
    fill = "gray", alpha = 0.3
  ) +
  
  labs(
    title    = "Antisemitic Violence in Canada",
    subtitle = "Prediction Intervals (Model Trained on 2002–2020)",
    x        = "Year",
    y        = "Number of Incidents",
    caption  = "Source: B'nai Brith Canada, 2024"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title       = element_text(face = "bold"),
    plot.subtitle    = element_text(face = "bold"),
    plot.caption     = element_text(size = 8, color = "gray40"),
    panel.grid.minor = element_blank()
  )

png("pictures/antisemitic_violence_canada.png", width = 800, height = 600)
print(g)
dev.off()

