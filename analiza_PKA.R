# gotowa analiza by amelia osucha
# Pociąg do efektywności. 
library(readxl)
library(tidyverse)
library(e1071)


arkusz = read_excel("~/dane_pociag.xlsx")

# 1. Konwersja na liczby i czyszczenie
arkusz$C = as.numeric(arkusz$C)
arkusz$P = as.numeric(arkusz$P)
arkusz$W = as.numeric(arkusz$W)
arkusz$D = as.numeric(arkusz$D)
arkusz$L = as.numeric(arkusz$L)
arkusz = na.omit(arkusz)

# 1. POPRAWIONE MAPOWANIE (L to Frequency, D to Time)
arkusz = arkusz %>%
  rename(L_raw = W, F_raw = L, T_raw = D, A_raw = C, B_raw = P)
# destymulanta

arkusz$T = (max(arkusz$T_raw, na.rm = TRUE) - arkusz$T_raw) / 
  (max(arkusz$T_raw, na.rm = TRUE) - min(arkusz$T_raw, na.rm = TRUE))

# 2. Reszta to stymulanty 
# Skala: [ 0 - 1 ]

arkusz$L = (arkusz$L_raw - min(arkusz$L_raw, na.rm = TRUE)) / 
  (max(arkusz$L_raw, na.rm = TRUE) - min(arkusz$L_raw, na.rm = TRUE))

arkusz$A = (arkusz$A_raw - min(arkusz$A_raw, na.rm = TRUE)) / 
  (max(arkusz$A_raw, na.rm = TRUE) - min(arkusz$A_raw, na.rm = TRUE))

arkusz$B = (arkusz$B_raw - min(arkusz$B_raw, na.rm = TRUE)) / 
  (max(arkusz$B_raw, na.rm = TRUE) - min(arkusz$B_raw, na.rm = TRUE))

arkusz$F = arkusz$F_raw / max(arkusz$F_raw)

# 4. Przeliczenie E 
arkusz$E = ( arkusz$F +  arkusz$B +  arkusz$L+  arkusz$T + arkusz$A ) / 5

# 5. SPRAWDZENIE ŚREDNICH
print("Nowe średnie efektywności:")
print(tapply(arkusz$E, arkusz$Rok, mean))

# wykres do wykorzystania:
ggplot(arkusz, aes(x = E, fill = as.factor(Rok))) +
  geom_density(alpha = 0.5) + 
  labs(title = "Rozkład wskaźnika efektywności: 2021 vs 2024",
       x = "Wskaźnik efektywności (E)",
       y = "Gęstość występowania",
       fill = "Rok") +
  theme_minimal()

statystyki <- arkusz %>%
  group_by(Rok) %>%
  summarise(
    Srednia = mean(E, na.rm = TRUE),
    Mediana = median(E, na.rm = TRUE),
    Kwartyl_1 = quantile(E, 0.25, na.rm = TRUE),
    Kwartyl_3 = quantile(E, 0.75, na.rm = TRUE),
    Odchylenie_std = sd(E, na.rm = TRUE),
    Wsp_zmiennosci = sd(E, na.rm = TRUE) / mean(E, na.rm = TRUE)
  )
print(statystyki)

statystyki2 = arkusz %>%
  group_by(Rok) %>%
  summarize(wsp_asymetrii = skewness(E),
            kurtoza = kurtosis(E),
            min = min(E),
            max = max(E))
print(statystyki2)
# sprawdzenie czy jest n 2021 = n 2024
length(arkusz$E[arkusz$Rok == 2021])
length(arkusz$E[arkusz$Rok == 2024]) #jest taki sam


e_2021 = arkusz$E[arkusz$Rok == 2021]
e_2024 = arkusz$E[arkusz$Rok == 2024]
roznice = e_2024 - e_2021

shapiro.test(roznice)
t.test(e_2024,e_2021,paired=TRUE,alternative='greater')

wilcox.test(e_2024,e_2021,paired=TRUE,alternative='greater')

arkusz2 = arkusz %>% select(Rok,`Stacja kolejowa`,L,F,T,A,B,E)
View(arkusz2)

# użyty wykres

dane <- data.frame(
  Linia = factor(c("Linia nr 68\n(Grupa kontrolna, brak PKA)", "Linia nr 91\n(System PKA)"),
                 levels = c("Linia nr 68\n(Grupa kontrolna, brak PKA)", "Linia nr 91\n(System PKA)")),
  Wzrost = c(35.33, 112.55)
)

wykres = ggplot(dane, aes(x = Linia, y = Wzrost, fill = Linia)) +
  geom_col(width = 0.5, color = "black", linewidth = 0.5) +
  scale_fill_manual(values = c("#95a5a6", "#2ecc71")) +
  geom_text(aes(label = paste0("+", Wzrost, "%")), 
  vjust = -0.8, fontface = "bold", size = 6) +
  scale_y_continuous(limits = c(0, 130), breaks = seq(0, 120, by = 20)) +
  labs(title = "Względny wzrost popytu pasażerskiego (2021 vs 2024)",subtitle = "Efekt wdrożenia systemu PKA na tle grupy kontrolnej",y = "Wzrost wymiany pasażerskiej (%)",x = NULL) +
  theme_minimal() 
print(wykres)


# ciekawe, ale nie użyte wykresy !!!!

stacje = c("Dębica", "Dębica Wschodnia", "Lubzina", "Ropczyce", "Ropczyce Witkowice",
            "Sędziszów Małopolski", "Będziemyśl", "Trzciana", "Świlcza", "Rudna Wielka",
            "Strażów", "Krzemienica", "Łańcut", "Głuchów", "Kosina", 
            "Rogóżno k. Łańcuta", "Grzęska", "Przeworsk") 

roznice = c(0.113539220, -0.004619216, 0.028815351, -0.009523528, -0.024404403, 
             0.038893335, 0.084533621, 0.137117017, 0.034794705, 0.025316579, 
             0.105917851, 0.072972601, 0.091832617, 0.059157873, 0.088718618, 
             0.075885731, 0.059164050, 0.101711468)

df = data.frame(stacja = stacje, roznica = roznice)

ggplot(df, aes(x = reorder(stacja, roznica), y = roznica, fill = roznica > 0)) +
  geom_bar(stat = "identity") +
  coord_flip() + # Zamiana osi na poziome słupki
  scale_fill_manual(values = c("red", "darkgreen"), guide = "none") +
  theme_minimal() +
  labs(title = "Ranking zmian efektywności na stacjach",
       x = "Stacja kolejowa",
       y = "Zmiana wskaźnika E (2024 - 2021)") +
  geom_hline(yintercept = 0, linetype = "solid", color = "black")
