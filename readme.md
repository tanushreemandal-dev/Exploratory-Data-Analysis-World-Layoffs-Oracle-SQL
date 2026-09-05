# 📊 Exploratory Data Analysis — World Layoffs (Oracle SQL)

> Exploring trends in company size, industry, geography, and time in a cleaned layoffs dataset - using Oracle SQL.

![SQL](https://img.shields.io/badge/SQL-Oracle-red)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)
![Type](https://img.shields.io/badge/Type-Exploratory%20Data%20Analysis-blue)

---

## 📌 Overview

This project explores a layoffs dataset to answer real business questions — which companies, industries, and countries were hit hardest, how layoffs trended over time, and who the top-affected companies were each year — using Oracle SQL.

This analysis was carried out on the cleaned dataset produced in a separate project: [Oracle SQL Data Cleaning](https://github.com/tanushreemandal-dev/ORACLE-SQL-DATA-CLEANING).

---

## 🛠️ Tools & Environment

- **Database:** Oracle Database (via [FreeSQL](https://freesql.com), Oracle's free cloud SQL environment)
- **Language:** Oracle SQL
- **Editor:** VS Code
- **Version Control:** Git & GitHub

---

## 📊 Analysis Covered

- Which companies had the largest layoffs overall
- Which industries and countries were hit hardest
- Yearly and monthly layoff trends
- Companies that shut down entirely (100% laid off), ranked by size and funding raised
- Top 3 hardest-hit companies each year, using ranking window functions

---

## ✅ Skills Demonstrated

- Aggregation and trend analysis using `GROUP BY`, `SUM()`, and date functions
- Ranking-based analysis using `DENSE_RANK()` with `PARTITION BY`
- Common Table Expressions (CTEs) for multi-step analytical queries
- Translating business questions into structured SQL queries

---

## ▶️ How to Run

1. Clone or reference the cleaned dataset from the [Oracle SQL Data Cleaning](https://github.com/tanushreemandal-dev/ORACLE-SQL-DATA-CLEANING) repository.
2. Run `eda.sql` in an Oracle SQL environment (e.g. [FreeSQL](https://freesql.com), Oracle APEX, or any Oracle Database instance) against the cleaned table.

---

## 📁 Repository Structure

```
oracle-sql-eda/
│
├── eda.sql     # Exploratory analysis queries
└── README.md   # Project documentation
```

---

## 🤝 Connect

If you have feedback, questions, or just want to talk data — feel free to reach out or open an issue on this repo!

- 💼 LinkedIn: [Tanushree Mandal](https://linkedin.com/in/tanushree-mandal-aba24b286)
- 📧 Email: [tanushreemandal235@gmail.com](tanushreemandal235@gmail.com)