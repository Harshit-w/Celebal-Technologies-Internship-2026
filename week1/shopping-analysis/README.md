# Shopping Dataset

Exploratory data analysis, cleaning, and feature engineering on an e-commerce product dataset (Myntra fashion & lifestyle listings — 1,000 products across 97 categories).

## Project Structure

```
shopping-analysis/
│── data/
│   ├── combined_dataset.csv 
│── notebook/
│   └── analysis.ipynb                
│── requirements.txt
│── README.md
```

## working of project

1. **Load Data** — import libraries, load the CSV, inspect shape/columns
2. **Understand Data** — dtypes, missing values, `.info()` / `.describe()`
3. **Data Cleaning** — numeric price conversion, missing-value handling, duplicate removal
4. **Feature Engineering** — `price_difference`, `popularity_score`, `gender`, `brand`, availability flags
5. **Analysis** — univariate, bivariate, and category-level analysis
6. **Visualization** — histograms, bar charts, boxplots, correlation heatmap
7. **Insights** — key findings and business implications

## Setup

```bash
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
```

Open `notebook/analysis.ipynb`

```bash
jupyter notebook notebook/analysis.ipynb
```
## Key Findings (summary)

- Discounting is the norm across the catalog; final prices sit well below initial list prices on average.
- ~11% of products have zero ratings, indicating a meaningful "unrated" inventory segment rather than poor performance.
- A handful of categories (tops, dresses, shirts, jeans, sports shoes) dominate the listing count.
- Discount depth correlates only weakly with rating/popularity — heavier markdowns don't reliably mean better-performing products.
- Price spread varies notably by category, useful for category-level pricing strategy.

Full details and supporting charts are in `notebook/analysis.ipynb`.

## Dataset Source

Combined dataset built from Myntra product listing scrapes, covering apparel, footwear, accessories, beauty, and home categories.
dataset link : https://www.kaggle.com/datasets/anvitkumar/shopping-dataset
