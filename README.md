# Retail Promotion Impact & Revenue Driver Analysis

> Quantifying promotional effectiveness and identifying revenue drivers across 26,000+ retail transactions using A/B testing and regression modeling.

---

## 🛠️ Tools & Technologies

![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![R](https://img.shields.io/badge/R-276DC3?style=flat&logo=r&logoColor=white)
![Excel](https://img.shields.io/badge/Excel-217346?style=flat&logo=microsoftexcel&logoColor=white)
![A/B Testing](https://img.shields.io/badge/A%2FB_Testing-FF6B35?style=flat)
![Regression](https://img.shields.io/badge/Regression_Modeling-6DB33F?style=flat)

---

## 📌 Business Problem

Retail teams run promotions constantly — but do they actually work? This project answers that question rigorously: **Which promotions are driving incremental revenue, and by how much?**

The goal was to move beyond intuition and anecdotal reporting to produce statistically defensible, quantified recommendations a merchandising or pricing team could act on.

---

## 📊 Data

| Attribute | Detail |
|---|---|
| Records | 26,000+ transactions |
| Source | Retail transaction dataset |
| Key fields | Date, product category, promotional flag, daily revenue, unit sales |

---

## ⚙️ Methodology

1. **Data Cleaning & Preparation** — Handled missing values, standardized date formats, validated transaction integrity across categories
2. **Exploratory Data Analysis** — Trend analysis by product category, time period, and promotional status; variance decomposition to isolate seasonal effects
3. **A/B Testing** — Compared revenue per day during promotional vs. non-promotional periods; tested for statistical significance using t-tests and confidence intervals
4. **Regression Modeling** — Built regression models in R to identify and quantify drivers of revenue variance; controlled for confounding variables
5. **Stakeholder Recommendations** — Translated model outputs into clear, prioritized business actions

---

## 📈 Key Results

| Metric | Result |
|---|---|
| Promotional revenue lift | **$236/day** (statistically significant) |
| Revenue drivers identified | Category mix, timing, and promotional frequency |
| Deliverable | Executive-ready findings with actionable recommendations |

The $236/day lift was validated at statistical significance — providing the business with a defensible number for ROI calculations on future promotional spend.

---

## 🖼️ Screenshots / Visuals

<img width="2100" height="2100" alt="avg_item_price_boxplot" src="https://github.com/user-attachments/assets/eebb645a-706f-4720-bbc1-540ee35056bb" />

---

## ▶️ How to Run

```bash
# Clone the repo
git clone https://github.com/SaloniShahi336/retail-promotion-analysis.git

# Install dependencies
pip install -r requirements.txt

# Run EDA notebook
jupyter notebook notebooks/eda_and_ab_testing.ipynb
```

R scripts for regression modeling are in `/r-scripts/`. Open in RStudio and run sequentially.

---

## 💡 Learnings

- A/B testing in observational (non-randomized) data requires careful control for confounders — regression adjustment matters more than most analysts acknowledge
- Business stakeholders respond better to "lift in dollars" than "statistical significance" — framing results in revenue terms is a communication skill as important as the analysis itself
- Simple regression with well-chosen features often outperforms complex models when the goal is explanation, not prediction

---

📁 [View project files on Google Drive](https://drive.google.com/drive/folders/1LZSNqPV25lVrMrOERd674xx9LhBdqZFv?usp=drive_link)
