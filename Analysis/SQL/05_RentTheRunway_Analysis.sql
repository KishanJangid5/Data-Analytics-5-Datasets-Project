
USE DataAnalyticsProject;
GO

-- 1. Rental purpose summary
CREATE OR ALTER VIEW dbo.vw_RentalPurposeSummary AS
SELECT
    rented_for,
    CAST(AVG(CAST(rating AS FLOAT)) AS DECIMAL(5,2))
        AS AverageRating,
    COUNT(*) AS ReviewCount
FROM dbo.RentTheRunway_SQL
GROUP BY rented_for;
GO

-- 2. Clothing category summary
CREATE OR ALTER VIEW dbo.vw_CategorySummary AS
SELECT
    category,
    CAST(AVG(CAST(rating AS FLOAT)) AS DECIMAL(5,2))
        AS AverageRating,
    COUNT(*) AS ReviewCount
FROM dbo.RentTheRunway_SQL
GROUP BY category;
GO

-- 3. Fit summary
CREATE OR ALTER VIEW dbo.vw_FitSummary AS
SELECT
    fit,
    COUNT(*) AS ReviewCount,
    CAST(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()
        AS DECIMAL(5,2)
    ) AS ReviewPercentage
FROM dbo.RentTheRunway_SQL
GROUP BY fit;
GO


SELECT * FROM dbo.vw_RentalPurposeSummary
ORDER BY AverageRating DESC;

SELECT * FROM dbo.vw_CategorySummary
ORDER BY ReviewCount DESC;

SELECT * FROM dbo.vw_FitSummary
ORDER BY ReviewCount DESC;


USE DataAnalyticsProject;
GO

SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.VIEWS
ORDER BY TABLE_NAME;