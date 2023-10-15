d = read.table("durations.txt", h=F, sep=",")
colnames(d) = c("start", "target", "duration")
head(d)

stations = read.table("stations_eva.txt", sep=",")
colnames(stations) = c("station", "eva")
head(stations)

nrow(d)
d = merge(d, stations, by.x="start", by.y="eva")
d = merge(d, stations, by.x="target", by.y="eva")
nrow(d)

d$total_minutes = d$duration/1000/60

result = data.frame(target=unique(d$station.y))
for (home in unique(d$station.x)) {
  dists = d[d$station.x == home, c("station.y", "total_minutes")]
  colnames(dists) = c("target", home)
  result = merge(result, dists, all.x=T)
}

colnames(result)[1] = "ZIEL"

result$Mittelwert = rowMeans(result[,2:5])
result$Standardabweichung = apply(result[,2:5], 1, sd)
result$Produkt = result$Mittelwert * result$Standardabweichung

result = result[order(result$Produkt),]

library(ggplot2)
library(ggrepel)

#ggplot(result, aes(x = Mittelwert, y = Standardabweichung, label = ZIEL)) +
#  geom_point() +
#  geom_text_repel()

result2 = subset(result, result$Mittelwert < 250 & result$Standardabweichung < 100)

png("results.png")
ggplot(result2, aes(x = Mittelwert, y = Standardabweichung, label = ZIEL)) +
  geom_point() +
  geom_text_repel()
dev.off()

library(openxlsx)
write.xlsx(result2, "results.xlsx")

result$Freiburg_gewichtet = result$`Freiburg (Breisgau) Hbf` * 6
result$Berlin_gewichtet = result$`Berlin Hauptbahnhof` * 4
result$Hamburg_gewichtet = result$`Hamburg Hbf` * 3
result$Heidelberg_gewichtet = result$`Heidelberg Hbf` * 5
result$Mittelwert_gewichtet = (result$Freiburg_gewichtet + result$Berlin_gewichtet +
                               result$Hamburg_gewichtet + result$Heidelberg_gewichtet) / 18
