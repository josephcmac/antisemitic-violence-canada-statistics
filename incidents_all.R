library(tidyverse)

df <- read.csv("../../datasets/antisemitism-canada/antisemitic-violence.csv")

g <- ggplot(df, aes(x = year, y = incidents)) +
	geom_line(color = "darkblue") +  
	geom_point(color = "darkblue", size = 2) +
	labs(
    		title    = "Antisemitic Violence",
		subtitle = "Canada",
    		x        = "Year",
    		y        = "Number of Incidents",
    		caption  = "Data Source: B'nai Brith Canada, 2024"
  	) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title      = element_text(face = "bold"),
    plot.subtitle      = element_text(face = "bold"),
    plot.caption    = element_text(size = 8, color = "gray40"),
    panel.grid.minor = element_blank()
  )

png("pictures/incidents.png")
print(g)
dev.off()
