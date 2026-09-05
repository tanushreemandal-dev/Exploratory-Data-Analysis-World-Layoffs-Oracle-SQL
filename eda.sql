-- viewing cleaned dataset
SELECT * FROM layoffs_copy1
ORDER BY company;

-- checking max layoffs
SELECT MAX(total_laid_off) AS max_total_laid_off,
       MAX(percentage_laid_off) AS max_percentage_laid_off
FROM layoffs_copy1;

-- Fixing data types and changing text NULL to actual null values)

-- percentage_laid_off
UPDATE layoffs_copy1
SET percentage_laid_off = NULL
WHERE UPPER(percentage_laid_off) = 'NULL' OR percentage_laid_off IS NULL;

ALTER TABLE layoffs_copy1 ADD percentage_temp NUMBER;
UPDATE layoffs_copy1 SET percentage_temp = percentage_laid_off;
ALTER TABLE layoffs_copy1 DROP COLUMN percentage_laid_off;
ALTER TABLE layoffs_copy1 RENAME COLUMN percentage_temp TO percentage_laid_off;

-- total_laid_off
UPDATE layoffs_copy1
SET total_laid_off = NULL
WHERE UPPER(total_laid_off) = 'NULL' OR total_laid_off IS NULL;

ALTER TABLE layoffs_copy1 ADD total_temp NUMBER;
UPDATE layoffs_copy1 SET total_temp = total_laid_off;
ALTER TABLE layoffs_copy1 DROP COLUMN total_laid_off;
ALTER TABLE layoffs_copy1 RENAME COLUMN total_temp TO total_laid_off;

-- funds_raised_millions
UPDATE layoffs_copy1
SET funds_raised_millions = NULL
WHERE UPPER(funds_raised_millions) = 'NULL' OR funds_raised_millions IS NULL;

ALTER TABLE layoffs_copy1 ADD funds_temp NUMBER;
UPDATE layoffs_copy1 SET funds_temp = funds_raised_millions;
ALTER TABLE layoffs_copy1 DROP COLUMN funds_raised_millions;
ALTER TABLE layoffs_copy1 RENAME COLUMN funds_temp TO funds_raised_millions;

-- stage
UPDATE layoffs_copy1
SET stage = NULL
WHERE UPPER(stage) = 'NULL';


-- changing date column from TIMESTAMP to DATE datatype

ALTER TABLE layoffs_copy1 ADD new_date DATE;
UPDATE layoffs_copy1 SET new_date = TRUNC("date");
ALTER TABLE layoffs_copy1 DROP COLUMN "date";
ALTER TABLE layoffs_copy1 RENAME COLUMN new_date TO "date";


SELECT MAX("date"), MIN("date") FROM layoffs_copy1;

SELECT EXTRACT(YEAR FROM "date") AS layoff_year, COUNT(*)
FROM layoffs_copy1
GROUP BY EXTRACT(YEAR FROM "date")
ORDER BY 1 DESC NULLS LAST;

-- Exploratory Analysis


-- Total layoffs by companies
SELECT company, SUM(total_laid_off) AS sum_total_laid_off
FROM layoffs_copy1
GROUP BY company
ORDER BY sum_total_laid_off DESC NULLS LAST;

-- Total layoffs by industries
SELECT industry, SUM(total_laid_off) AS sum_total_laid_off
FROM layoffs_copy1
GROUP BY industry
ORDER BY sum_total_laid_off DESC NULLS LAST;

-- Total layoffs by countries
SELECT country, SUM(total_laid_off) AS sum_total_laid_off
FROM layoffs_copy1
GROUP BY country
ORDER BY sum_total_laid_off DESC NULLS LAST;

-- Total layoffs by stages
SELECT stage, SUM(total_laid_off) AS sum_total_laid_off
FROM layoffs_copy1
GROUP BY stage
ORDER BY sum_total_laid_off DESC NULLS LAST;

-- Total layoffs by year
SELECT EXTRACT(YEAR FROM "date") AS layoff_year,
       SUM(total_laid_off) AS sum_total_laid_off
FROM layoffs_copy1
GROUP BY EXTRACT(YEAR FROM "date")
ORDER BY 1 DESC NULLS LAST;

-- layoffs in various months,years
SELECT TO_CHAR("date", 'YYYY-MM') AS year_month,
       SUM(total_laid_off) AS sum_laid_off
FROM layoffs_copy1
GROUP BY TO_CHAR("date", 'YYYY-MM')
ORDER BY 1;

-- Companies with 100% lay off
SELECT *
FROM layoffs_copy1
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC NULLS LAST;

-- Companies with 100% lay off ranked by funds raised
SELECT *
FROM layoffs_copy1
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC NULLS LAST;

-- filtering top 3 companies by total layoffs per year
WITH rank_table AS (
    SELECT company,
           EXTRACT(YEAR FROM "date") AS "year",
           SUM(total_laid_off) AS sum_laid_off,
           DENSE_RANK() OVER (
               PARTITION BY EXTRACT(YEAR FROM "date")
               ORDER BY SUM(total_laid_off) DESC
           ) AS ranking
    FROM layoffs_copy1
    WHERE "date" IS NOT NULL
      AND total_laid_off IS NOT NULL
    GROUP BY company, EXTRACT(YEAR FROM "date")
)
SELECT *
FROM rank_table
WHERE ranking <= 3
ORDER BY "year" DESC, ranking;

commit;