# 🛒 Walmart Sales Dashboard Project

This project provides insights into Walmart's sales performance using **PostgreSQL for data analysis** and **Power BI for visualizations**. It explores transaction trends, category performance, sales timing, customer behavior, and profitability across different branches.


 Set Up the Environment
   - **Tools Used**:  SQL (PostgreSQL),Power BI.
   - **Goal**: Create a structured workspace within VS Code and organize project folders for smooth development and data handling.
### 2. Set Up Kaggle API
   - **API Setup**: Obtain your Kaggle API token from [Kaggle](https://www.kaggle.com/) by navigating to your profile settings and downloading the JSON file.
   - **Configure Kaggle**: 
      - Place the downloaded `kaggle.json` file in your local `.kaggle` folder.
      - Use the command `kaggle datasets download -d <dataset-path>` to pull datasets directly into your project.
### 3. Download Walmart Sales Data
   - **Data Source**: Use the Kaggle API to download the Walmart sales datasets from Kaggle.
   - **Dataset Link**: [Walmart Sales Dataset](https://www.kaggle.com/najir0123/walmart-10k-sales-datasets)
   - **Storage**: Save the data in the `data/` folder for easy reference and access.
## 📁 Project Files
- `sql.project.sql`: SQL queries used for extracting and analyzing insights from the `walmart_stage` dataset.
- `Walmart_stage.csv`: Cleaned and staged dataset containing Walmart sales data.
- `sql_project dashboard.pbix`: Power BI file used to visualize the insights derived from SQL analysis.
## 📊 Dataset Overview

The dataset (`walmart_stage.csv`) contains:
- **Transactional data** from Walmart retail stores.
- Fields like: `branch`, `city`, `category`, `quantity`, `unit_price`, `profit_margin`, `payment_method`, `rating`, `date`, `time`.

## 📌 Business Objectives & SQL Insights

Here are some of the key questions addressed using SQL:

### 1. 🔁 Payment Method Analysis
- Count of transactions and quantity sold per payment method.
```sql
SELECT payment_method, COUNT(*) AS no_payments, SUM(quantity) AS no_qty_sold
FROM walmart_stage
GROUP BY payment_method;
2. ⭐ Top Rated Category by Branch
Identify the highest-rated product category per branch using window functions.

sql
Copy
Edit
SELECT branch, category, AVG(rating) AS avg_rating
FROM walmart_stage
GROUP BY branch, category;
3. 📅 Busiest Day per Branch
Discover which day each branch experiences the highest footfall.

SELECT branch, day_name, COUNT(*) AS no_transactions
FROM walmart_stage
GROUP BY branch, TO_CHAR(date::date, 'Day');
4. 💸 Profit by Category
Compute total profit using unit_price * quantity * profit_margin.

sql
Copy
Edit
SELECT category, SUM(unit_price * quantity * profit_margin) AS total_profit
FROM walmart_stage
GROUP BY category;
5. ⏰ Sales Shift Analysis
Classify sales into Morning, Afternoon, and Evening shifts.

sql
Copy
Edit
CASE 
  WHEN EXTRACT(HOUR FROM time::time) < 12 THEN 'Morning'
  WHEN EXTRACT(HOUR FROM time::time) BETWEEN 12 AND 17 THEN 'Afternoon'
  ELSE 'Evening'
END AS day_time
6. 🏆 Preferred Payment Method per Branch
Use window functions to find most common payment method in each branch.

sql
RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS rank
📈 Power BI Dashboard
The Power BI report includes the following visuals:
Sales by Payment Method (Bar chart)
Top Rated Category per Branch (Matrix/Table)
Daily Transactions Heatmap
Total Profit by Category (Sorted bar chart)
Sales by Time of Day (Pie/Donut chart)
Branch-wise Preferences (Card visuals and slicers)
✅ Tools Used
PostgreSQL – SQL-based data analysis.
Power BI – Interactive dashboard creation.
Python (optional) – For data preprocessing (if needed).
🚀 How to Run
Load Walmart_stage.csv into PostgreSQL.
Run the SQL queries from sql.project.sql to explore the data.
Open sql_project dashboard.pbix in Power BI to explore visual insights.

Nishant Telrandhe
📧 [nishanttelrandhe06@gmail.com]
