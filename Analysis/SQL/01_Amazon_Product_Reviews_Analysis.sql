
USE DataAnalyticsProject;

-- 1. Check total rows
SELECT COUNT(*) AS TotalRows
FROM dbo.amazon_reviews_cleaned;

-- 2. Check missing values
SELECT
    SUM(CASE WHEN [Text] IS NULL THEN 1 ELSE 0 END) AS MissingReviews,
    SUM(CASE WHEN label IS NULL THEN 1 ELSE 0 END) AS MissingLabels
FROM dbo.amazon_reviews_cleaned;

-- 3. Check sentiment distribution
SELECT
    label,
    COUNT(*) AS ReviewCount
FROM dbo.amazon_reviews_cleaned
GROUP BY label
ORDER BY label;

-- 4. Check average review length by sentiment
SELECT
    label,
    ROUND(AVG(CAST(LEN([Text]) AS FLOAT)), 2) AS AverageReviewLength
FROM amazon_reviews_cleaned
WHERE [Text] IS NOT NULL
GROUP BY label
ORDER BY label;


-- 5. Sentiment distribution with percentages
SELECT
    label,
    COUNT(*) AS ReviewCount,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        2
    ) AS Percentage
FROM dbo.amazon_reviews_cleaned
GROUP BY label
ORDER BY label;


-- 6. Review length statistics by sentiment
SELECT
    label,
    MIN(LEN([Text])) AS MinimumLength,
    MAX(LEN([Text])) AS MaximumLength,
    ROUND(AVG(CAST(LEN([Text]) AS FLOAT)), 2) AS AverageLength
FROM dbo.amazon_reviews_cleaned
GROUP BY label
ORDER BY label;


-- 7. Count reviews by length category
SELECT
    CASE
        WHEN LEN([Text]) < 100 THEN 'Short'
        WHEN LEN([Text]) <= 200 THEN 'Medium'
        ELSE 'Long'
    END AS LengthCategory,
    COUNT(*) AS ReviewCount
FROM dbo.amazon_reviews_cleaned
GROUP BY
    CASE
        WHEN LEN([Text]) < 100 THEN 'Short'
        WHEN LEN([Text]) <= 200 THEN 'Medium'
        ELSE 'Long'
    END
ORDER BY ReviewCount DESC;


-- 8. Count reviews containing selected positive and negative terms
SELECT
    SUM(CASE WHEN LOWER([Text]) LIKE '%love%' OR LOWER([Text]) LIKE '%great%'
        THEN 1 ELSE 0 END) AS ReviewsWithPositiveTerms,
    SUM(CASE WHEN LOWER([Text]) LIKE '%bad%' OR LOWER([Text]) LIKE '%poor%'
        THEN 1 ELSE 0 END) AS ReviewsWithNegativeTerms
FROM dbo.amazon_reviews_cleaned;
