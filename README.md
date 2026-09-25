## train-to-effectivity
# MY FULL CHAPTER: https://books.google.pl/books?id=x9QAEgAAQBAJ&newbks=0&lpg=PA99&dq=Analiza%20ilo%C5%9Bciowa%20wybranych%20problem%C3%B3w%20z%20zakresu%20ekonomii%20i%20finans%C3%B3w&hl=pl&pg=PA219#v=onepage&q&f=false 
## Powyższe badanie naukowe było wygłoszone na konferencji Narzędzia Analityczne w Naukach Społecznych (NAWNE) w Maju 2026.

### Ewaluacja efektywności przystanków osobowych w kontekście wdrożenia Podkarpackiej Kolei Aglomeracyjnej (PKA) / Evaluation of Passenger Stop Efficiency in the Context of the Subcarpathian Metropolitan Railway (PKA) Implementation

Projekt badawczy poświęcony analizie zmian wskaźników efektywności i wymiany pasażerskiej na stacjach kolejowych na Podkarpaciu (ze szczególnym uwzględnieniem tras PKA oraz odcinka referencyjnego).

*A research project dedicated to analyzing changes in efficiency indicators and passenger exchange at railway stations in the Subcarpathian Voivodeship (with a particular focus on PKA routes and a reference section).*

---

## Zawartość repozytorium / Repository Contents

1. **`analiza_PKA.R`** - skrypt w języku R odpowiedzialny za przetwarzanie danych, normalizację zmiennych (unitaryzację) oraz obliczanie syntetycznego miernika efektywności.  
   *(The R script responsible for data processing, variable normalization (unitary), and calculating the synthetic efficiency measure.)*

2. **`dane_pociag.xlsx`** - arkusz kalkulacyjny zawierający surowe dane statystyczne, zestawienia z portalu UTK, GUS / Spis Powszechny oraz obliczenia pośrednie dla lat 2021 i 2024.  
   *(The spreadsheet containing raw statistical data, compilations from the UTK portal, Statistics Poland / Census, and intermediate calculations for 2021 and 2024.)*

---

## 🛠️ Wykorzystane narzędzia i pakiety / Tools and Packages Used
* **Język R (R Language)**: obsługa struktur danych i modelowanie / *data structure handling and modeling* (`dplyr`, `stringr`, `ggplot2` itp.)
* **Microsoft Excel**: wstępna agregacja danych, macierze i weryfikacja obliczeń / *initial data aggregation, matrices, and calculation verification*.
* **Źródła danych (Data Sources)**: Urząd Transportu Kolejowego (UTK), Główny Urząd Statystyczny / Spis Powszechny (Statistics Poland / Census).
* Reszta źródeł dostępna jest w podrozdziale 'bibliografia' w monografii.

---

## Metodologia w pigułce / Methodology in a Nutshell
* Badanie w pierwszej części opiera się na **analizie porównawczej z grupą kontrolną** (odcinek linii nr 68 jako linia referencyjna) w ujęciu lat 2021 i 2024.  
  *(The study is at first based on a **comparative analysis with a control group** (railway line no. 68 section as a reference line) for the years 2021 and 2024.)*
* Do oceny przystanków skonstruowano **syntetyczny miernik efektywności** z podziałem na stymulanty i destymulanty, przyjmując założenie o równej wadze kryteriów (zgodnie z metodologią wielowymiarowej analizy statystycznej).  
  *(To evaluate the stops, a **synthetic efficiency measure** was constructed with a division into stimulants and destimulants, assuming equal weights for criteria in accordance with multidimensional statistical analysis methodology.)*
* Weryfikacja statystyczna: Wykorzystano testy istotności oraz analizę rozkładu (m.in. test Shapiro-Wilka do badania normalności rozkładu, testy t-Studenta / odpowiedniki nieparametryczne do oceny istotności różnic między grupami).  
  *(Statistical verification: Significance tests and distribution analysis were applied, including the Shapiro-Wilk test for normality and Student's t-tests / non-parametric equivalents to assess the significance of differences between groups.)*
