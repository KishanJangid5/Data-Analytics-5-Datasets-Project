
USE DataAnalyticsProject;
GO

CREATE TABLE dbo.consumer_complaints_cleaned (
    [Complaint ID] BIGINT PRIMARY KEY,
    [Date received] DATE,
    [Product] NVARCHAR(200),
    [Sub-product] NVARCHAR(300),
    [Issue] NVARCHAR(500),
    [Sub-issue] NVARCHAR(500),
    [Consumer complaint narrative] NVARCHAR(MAX),
    [Company public response] NVARCHAR(MAX),
    [Company] NVARCHAR(500),
    [State] NVARCHAR(20),
    [ZIP code] NVARCHAR(20),
    [Tags] NVARCHAR(100),
    [Consumer consent provided?] NVARCHAR(100),
    [Submitted via] NVARCHAR(100),
    [Date sent to company] DATE,
    [Company response to consumer] NVARCHAR(200),
    [Timely response?] NVARCHAR(10),
    [Consumer disputed?] NVARCHAR(10),
    [response_days] FLOAT
);
GO

USE DataAnalyticsProject;
GO

SELECT COUNT(*) AS TotalComplaints
FROM dbo.consumer_complaints_cleaned;
GO

SELECT
    Product,
    COUNT(*) AS TotalComplaints
FROM dbo.consumer_complaints_cleaned
GROUP BY Product
ORDER BY TotalComplaints DESC;

SELECT
    [Timely response?],
    COUNT(*) AS TotalComplaints,
    CAST(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM dbo.consumer_complaints_cleaned)
        AS DECIMAL(5,2)
    ) AS Percentage
FROM dbo.consumer_complaints_cleaned
GROUP BY [Timely response?]
ORDER BY TotalComplaints DESC;

SELECT
    [Consumer disputed?],
    COUNT(*) AS TotalComplaints,
    CAST(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER ()
        AS DECIMAL(5,2)
    ) AS Percentage
FROM dbo.consumer_complaints_cleaned
WHERE [Consumer disputed?] IS NOT NULL
GROUP BY [Consumer disputed?]
ORDER BY TotalComplaints DESC;

SELECT TOP 10
    Company,
    COUNT(*) AS TotalComplaints
FROM dbo.consumer_complaints_cleaned
GROUP BY Company
ORDER BY TotalComplaints DESC;

SELECT
    [Submitted via],
    COUNT(*) AS TotalComplaints
FROM dbo.consumer_complaints_cleaned
GROUP BY [Submitted via]
ORDER BY TotalComplaints DESC;

SELECT
    [Company response to consumer],
    COUNT(*) AS TotalComplaints
FROM dbo.consumer_complaints_cleaned
GROUP BY [Company response to consumer]
ORDER BY TotalComplaints DESC;

SELECT
    YEAR([Date received]) AS ComplaintYear,
    COUNT(*) AS TotalComplaints
FROM dbo.consumer_complaints_cleaned
GROUP BY YEAR([Date received])
ORDER BY ComplaintYear;

USE DataAnalyticsProject;
GO

-- 1. Complaints by product
-- 2. Timely response analysis
-- 3. Consumer dispute analysis
-- 4. Average response time by product
-- 5. Top 10 companies by complaint volume
-- 6. Complaints by submission channel
-- 7. Company response analysis
-- 8. Complaints by year