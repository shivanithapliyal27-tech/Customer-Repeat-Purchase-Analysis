# Customer Repeat Purchase Analysis

## Project Overview
Customer Repeat Purchase Analysis is a data analytics project designed to understand customer purchasing behavior, identify repeat customers, and compare the average order value (AOV) of one-time and repeat customers.

The project uses Python and SQL to clean transaction data, analyze customer purchase frequency, calculate key business metrics, and generate useful insights for customer retention strategies.

## Objectives
- Identify one-time and repeat customers.
- Calculate the repeat purchase rate.
- Compare Average Order Value (AOV) across customer segments.
- Analyze customer purchase frequency.
- Generate customer segment summaries and business KPIs.
- Provide insights to support customer retention and marketing decisions.

## Dataset
**Dataset:** Online Retail II

The dataset contains retail transaction information, including:
- Invoice
- InvoiceDate
- Quantity
- Price
- Customer ID
- Country

The cleaned transaction data is used for customer-level analysis.

## Tools and Technologies
- **Python:** Data analysis and calculations
- **Google Colab:** Python notebook environment
- **Pandas and NumPy:** Data cleaning and transformation
- **Matplotlib and Seaborn:** Data visualization
- **SQL Server Management Studio (SSMS):** SQL analysis
- **CSV:** Exporting analysis results

## Project Workflow

### 1. Data Cleaning
- Handled missing customer identifiers and essential transaction fields.
- Converted columns to appropriate data types.
- Excluded cancelled invoices and non-positive quantities or prices from the positive-sales analysis.
- Calculated revenue using Quantity × Price.

### 2. Customer Segmentation
Customers were classified into two groups:
- **One-Time Customer:** Customer with one distinct invoice.
- **Repeat Customer:** Customer with more than one distinct invoice.

### 3. Repeat Purchase Rate
The repeat purchase rate was calculated as:

Repeat Purchase Rate (%) = (Repeat Customers / Total Identifiable Customers) × 100

### 4. Average Order Value Analysis
Average Order Value was calculated at invoice level and compared between one-time and repeat customer segments.

### 5. SQL Analysis
SQL queries were used to calculate:
- Customer order counts and segments
- Repeat purchase rate
- Average Order Value comparison
- Customer segment summary
- Overall KPI summary

## Key Metrics
- Total Customers
- Repeat Customers
- One-Time Customers
- Repeat Purchase Rate
- Average Orders per Customer Segment
- Average Order Value by Segment
- Total Orders
- Total Revenue

*Actual metric values should be added after validating the executed Python and SQL outputs.*

## Project Files
- `Customer_Repeat_Purchase_Analysis.ipynb` — Python analysis notebook
- `Customer_Repeat_Purchase_Analysis.sql` — SQL queries
- `Customer_Segment_SQL.csv` — Customer-level segment results
- `Repeat_Purchase_Rate_SQL.csv` — Repeat purchase rate results
- `AOV_Comparison_SQL.csv` — AOV comparison results
- `Customer_Segment_Summary_SQL.csv` — Customer segment summary
- `Repeat_Purchase_KPI_Summary.csv` — Overall KPI results
- `Customer_Repeat_Purchase_Analysis_Report.pdf` — Project report

The large cleaned dataset may be kept locally instead of being uploaded to GitHub. Users should download the source dataset and follow the notebook's data-loading instructions to reproduce the analysis.

## Business Recommendations
- Develop targeted campaigns to encourage one-time customers to purchase again.
- Use loyalty programs and personalized offers to engage repeat customers.
- Monitor repeat purchase rate over time.
- Compare purchase frequency with AOV to better
