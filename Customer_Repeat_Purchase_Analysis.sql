
/*
Project: Customer Repeat Purchase Analysis
Database: CustomerRepeatPurchaseDB
Table: dbo.Cleaned_Online_Retail

Objectives:
1. Customer-level order analysis
2. Repeat purchase rate
3. Average Order Value (AOV) comparison
4. Customer segment summary
5. Final KPI summary
*/

USE CustomerRepeatPurchaseDB;
GO

/* =========================================
   1. VERIFY IMPORTED DATA
========================================= */

SELECT TOP 10 *
FROM dbo.Cleaned_Online_Retail;
GO

SELECT COUNT(*) AS Total_Rows
FROM dbo.Cleaned_Online_Retail;
GO


/* =========================================
   2. CUSTOMER REPEAT PURCHASE ANALYSIS
========================================= */

WITH CustomerOrders AS (
    SELECT
        Customer_ID,
        COUNT(DISTINCT Invoice) AS Total_Orders
    FROM dbo.Cleaned_Online_Retail
    WHERE Customer_ID IS NOT NULL
    GROUP BY Customer_ID
)
SELECT
    Customer_ID,
    Total_Orders,
    CASE
        WHEN Total_Orders > 1 THEN 'Repeat Customer'
        ELSE 'One-Time Customer'
    END AS Customer_Segment
FROM CustomerOrders
ORDER BY Total_Orders DESC;
GO


/* =========================================
   3. REPEAT PURCHASE RATE
========================================= */

WITH CustomerOrders AS (
    SELECT
        Customer_ID,
        COUNT(DISTINCT Invoice) AS Total_Orders
    FROM dbo.Cleaned_Online_Retail
    WHERE Customer_ID IS NOT NULL
    GROUP BY Customer_ID
),
CustomerSummary AS (
    SELECT
        COUNT(*) AS Total_Customers,
        SUM(CASE WHEN Total_Orders > 1
            THEN 1 ELSE 0 END) AS Repeat_Customers,
        SUM(CASE WHEN Total_Orders = 1
            THEN 1 ELSE 0 END) AS One_Time_Customers
    FROM CustomerOrders
)
SELECT
    Total_Customers,
    Repeat_Customers,
    One_Time_Customers,
    CAST(
        100.0 * Repeat_Customers /
        NULLIF(Total_Customers, 0)
        AS DECIMAL(10,2)
    ) AS Repeat_Purchase_Rate_Percent
FROM CustomerSummary;
GO


/* =========================================
   4. AVERAGE ORDER VALUE (AOV) COMPARISON
========================================= */

WITH CustomerOrders AS (
    SELECT
        Customer_ID,
        COUNT(DISTINCT Invoice) AS Total_Orders
    FROM dbo.Cleaned_Online_Retail
    WHERE Customer_ID IS NOT NULL
    GROUP BY Customer_ID
),
OrderValues AS (
    SELECT
        Customer_ID,
        Invoice,
        SUM(Revenue) AS Order_Value
    FROM dbo.Cleaned_Online_Retail
    WHERE Customer_ID IS NOT NULL
    GROUP BY Customer_ID, Invoice
),
ClassifiedOrders AS (
    SELECT
        ov.Invoice,
        ov.Order_Value,
        CASE
            WHEN co.Total_Orders > 1
                THEN 'Repeat Customer'
            ELSE 'One-Time Customer'
        END AS Customer_Segment
    FROM OrderValues ov
    INNER JOIN CustomerOrders co
        ON ov.Customer_ID = co.Customer_ID
)
SELECT
    Customer_Segment,
    COUNT(*) AS Total_Orders,
    CAST(
        AVG(Order_Value) AS DECIMAL(12,2)
    ) AS Average_Order_Value
FROM ClassifiedOrders
GROUP BY Customer_Segment
ORDER BY Customer_Segment;
GO


/* =========================================
   5. CUSTOMER SEGMENT SUMMARY
========================================= */

WITH CustomerOrders AS (
    SELECT
        Customer_ID,
        COUNT(DISTINCT Invoice) AS Total_Orders
    FROM dbo.Cleaned_Online_Retail
    WHERE Customer_ID IS NOT NULL
    GROUP BY Customer_ID
),
SegmentSummary AS (
    SELECT
        CASE
            WHEN Total_Orders > 1
                THEN 'Repeat Customer'
            ELSE 'One-Time Customer'
        END AS Customer_Segment,
        COUNT(*) AS Total_Customers,
        AVG(
            CAST(Total_Orders AS DECIMAL(10,2))
        ) AS Average_Orders
    FROM CustomerOrders
    GROUP BY
        CASE
            WHEN Total_Orders > 1
                THEN 'Repeat Customer'
            ELSE 'One-Time Customer'
        END
)
SELECT
    Customer_Segment,
    Total_Customers,
    CAST(
        Average_Orders AS DECIMAL(10,2)
    ) AS Average_Orders,
    CAST(
        100.0 * Total_Customers /
        SUM(Total_Customers) OVER ()
        AS DECIMAL(10,2)
    ) AS Customer_Percentage
FROM SegmentSummary
ORDER BY Customer_Segment;
GO


/* =========================================
   6. FINAL KPI SUMMARY
========================================= */

WITH CustomerOrders AS (
    SELECT
        Customer_ID,
        COUNT(DISTINCT Invoice) AS Total_Orders
    FROM dbo.Cleaned_Online_Retail
    WHERE Customer_ID IS NOT NULL
    GROUP BY Customer_ID
),
CustomerKPIs AS (
    SELECT
        COUNT(*) AS Total_Customers,
        SUM(CASE WHEN Total_Orders > 1
            THEN 1 ELSE 0 END) AS Repeat_Customers,
        SUM(CASE WHEN Total_Orders = 1
            THEN 1 ELSE 0 END) AS One_Time_Customers
    FROM CustomerOrders
),
SalesKPIs AS (
    SELECT
        COUNT(DISTINCT Invoice) AS Total_Orders,
        CAST(
            SUM(Revenue) AS DECIMAL(18,2)
        ) AS Total_Revenue
    FROM dbo.Cleaned_Online_Retail
)
SELECT
    c.Total_Customers,
    c.Repeat_Customers,
    c.One_Time_Customers,
    CAST(
        100.0 * c.Repeat_Customers /
        NULLIF(c.Total_Customers, 0)
        AS DECIMAL(10,2)
    ) AS Repeat_Purchase_Rate_Percent,
    s.Total_Orders,
    s.Total_Revenue
FROM CustomerKPIs c
CROSS JOIN SalesKPIs s;
GO
