# Part 4 — SQL & Spreadsheet Analysis

## 1. Project Overview

This project analyzes YouTube Trending Video Statistics from the US, GB, and IN datasets using Python, MySQL Workbench, SQL, and Microsoft Excel.

The objective is to prepare relational CSV tables, store them in MySQL, answer business questions using SQL, and build a spreadsheet analysis workbook.

## 2. Dataset Source

Trending YouTube Video Statistics dataset.

Original files:
- USvideos.csv
- GBvideos.csv
- INvideos.csv
- categories.csv

The cleaned files used in this part are committed under `data/`.

## 3. Tools Used

- Python
- Pandas
- NumPy
- MySQL Server
- MySQL Workbench
- Microsoft Excel

## 4. Folder Structure

```text
part4_sql_spreadsheet/
├── data/
│   ├── categories.csv
│   ├── videos.csv
│   └── trending_records.csv
├── notebooks/
│   └── prepare_data.ipynb
├── sql/
│   └── trendpulse.sql
├── workbook/
│   └── trendpulse_analysis.xlsx
├── README.md
└── requirements.txt
```

## 5. CSV Preparation

The three CSV files were prepared independently using Python and Pandas.

### categories.csv
Contains one record per category:
- category_id
- category_name

### videos.csv
Contains one record per unique video:
- video_id
- title
- channel_title
- category_id
- publish_time

### trending_records.csv
Contains one record per video, country, and trending date:
- video_id
- country
- trending_date
- views
- likes
- dislikes
- comment_count

Cleaning steps:
1. Loaded the three country CSV files.
2. Added country identifiers.
3. Combined the country datasets.
4. Converted dates and numeric columns.
5. Removed duplicate video-country-date records.
6. Removed records marked as removed or erroneous.
7. Removed records with missing essential fields.
8. Created the category lookup table.
9. Created one unique video record per video ID.
10. Created the daily trending records table.
11. Validated primary and foreign key references.
12. Exported the three CSV files.

## 6. Database Schema Design

Database: `trendpulse_db`

### categories
- category_id — Primary key
- category_name

### videos
- video_id — Primary key
- title
- channel_title
- category_id — Foreign key referencing categories
- publish_time

### trending_records
- record_id — Primary key
- video_id — Foreign key referencing videos
- country
- trending_date
- views
- likes
- dislikes
- comment_count

### Relationship design

- One category can contain multiple videos.
- One video can have multiple trending records.
- Every trending record references a video.
- Every video references a category when a category is available.
- A unique constraint prevents duplicate video-country-date records.

## 7. Database Setup and Execution Order

1. Open MySQL Workbench.
2. Open `sql/trendpulse.sql`.
3. Execute the database and table creation statements.
4. Import `categories.csv`.
5. Import `videos.csv`.
6. Import `trending_records.csv`.
7. Run the row-count queries.
8. Execute the analysis queries.

### Table row counts

| Table | Actual row count |
|---|---:|
| categories | [Insert result] |
| videos | [Insert result] |
| trending_records | [Insert result] |

## 8. SQL Queries and Results

For each query, include:
- Query number and objective.
- SQL statement.
- Actual MySQL Workbench text output.
- Short explanation of the result.

Include all ten queries from the SQL analysis, covering:
- SELECT and WHERE
- ORDER BY
- LIMIT
- DISTINCT
- Column aliases
- GROUP BY
- HAVING
- INNER JOIN
- LEFT JOIN
- RIGHT JOIN

## 9. Excel Workbook

Workbook: `workbook/trendpulse_analysis.xlsx`

### A. Pivot Table

- Rows: category_name
- Columns: country
- Values: Average of views

This compares average views for each category across countries.

### B. Lookup Formula

Formula:

```excel
=XLOOKUP(J2,Categories!$A:$A,Categories!$B:$B,"Unknown")
```

This maps category IDs to category names.

### C. Headline Calculations

```excel
=COUNTIF(Records!B:B,"IN")
=COUNTIF(Records!B:B,"US")
=COUNTIF(Records!B:B,"GB")
=SUM(Records!D:D)
=AVERAGE(Records!D:D)
```

These calculate country record counts, total views, and average views.

### D. Filters and Sorting

Enabled filters on the Records sheet and sorted the views column from largest to smallest.

### E. Conditional Formatting

Formula:

```excel
=D2>=PERCENTILE.INC($D$2:$D$40000,0.9)
```

Highlights records whose views are in the top 10%.

Replace the example final row with the actual last row.

### F. Named Range

Named range: `ViewsRange`

Refers to:

```excel
=Records!$D$2:$D$40000
```

Formula using the named range:

```excel
=AVERAGE(ViewsRange)
```

## 10. SQL and Excel Cross-check

### Check 1 — India record count

SQL:

```sql
SELECT COUNT(*)
FROM trending_records
WHERE country = 'IN';
```

Excel:

```excel
=COUNTIF(Records!B:B,"IN")
```

| Tool | Result |
|---|---:|
| MySQL | [Insert result] |
| Excel | [Insert result] |

### Check 2 — Average views for Music

SQL:

```sql
SELECT AVG(tr.views)
FROM trending_records tr
JOIN videos v ON tr.video_id = v.video_id
JOIN categories c ON v.category_id = c.category_id
WHERE c.category_name = 'Music';
```

Excel:

```excel
=AVERAGEIF(Records!K:K,"Music",Records!D:D)
```

| Tool | Result |
|---|---:|
| MySQL | [Insert result] |
| Excel | [Insert result] |

### Cross-check conclusion

[Explain whether the SQL and Excel values match. If they differ, document the reason.]

## 11. Conclusion

This project demonstrates how to prepare relational datasets, design primary and foreign key relationships, load CSV data into MySQL, answer analytical questions with SQL, and create a shareable Excel workbook.

The SQL and Excel cross-checks demonstrate consistency between database queries and spreadsheet calculations.