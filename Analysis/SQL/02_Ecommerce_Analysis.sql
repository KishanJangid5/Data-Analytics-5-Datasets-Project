USE DataAnalyticsProject;

-- 1. Check total rows and unique products
SELECT
    COUNT(*) AS TotalRows,
    COUNT(DISTINCT product_id) AS UniqueProducts
FROM dbo.ecommerce_cleaned;

-- 2. Check missing values in important columns
SELECT
    SUM(CASE WHEN discount IS NULL THEN 1 ELSE 0 END) AS MissingDiscount,
    SUM(CASE WHEN seller_name IS NULL THEN 1 ELSE 0 END) AS MissingSeller,
    SUM(CASE WHEN videos IS NULL THEN 1 ELSE 0 END) AS MissingVideos
FROM dbo.ecommerce_cleaned;

-- 3. Check product categories
SELECT
    category,
    COUNT(*) AS ProductCount,
    ROUND(AVG(rating), 2) AS AverageRating
FROM dbo.ecommerce_cleaned
GROUP BY category
ORDER BY ProductCount DESC;


-- 4. Overall product rating and pricing
SELECT
    ROUND(AVG(rating), 2) AS AverageRating,
    ROUND(AVG(final_price), 2) AS AverageFinalPrice,
    ROUND(AVG(initial_price), 2) AS AverageInitialPrice,
    ROUND(AVG(discount), 2) AS AverageDiscount
FROM dbo.ecommerce_cleaned;


-- 5. Top 10 categories by average rating
SELECT TOP 10
    category,
    COUNT(*) AS ProductCount,
    ROUND(AVG(rating), 2) AS AverageRating
FROM dbo.ecommerce_cleaned
WHERE rating IS NOT NULL
GROUP BY category
HAVING COUNT(*) >= 5
ORDER BY AverageRating DESC;


-- 6. Top 10 categories by average final price
SELECT TOP 10
    category,
    COUNT(*) AS ProductCount,
    ROUND(AVG(final_price), 2) AS AverageFinalPrice
FROM dbo.ecommerce_cleaned
WHERE final_price IS NOT NULL
GROUP BY category
HAVING COUNT(*) >= 5
ORDER BY AverageFinalPrice DESC;


-- 7. Products with the highest ratings
SELECT TOP 10
    product_id,
    title,
    category,
    rating,
    final_price
FROM dbo.ecommerce_cleaned
WHERE rating IS NOT NULL
ORDER BY rating DESC, ratings_count DESC;


-- 8. Product rating distribution
SELECT
    CAST(rating AS DECIMAL(3,1)) AS Rating,
    COUNT(*) AS ProductCount
FROM dbo.ecommerce_cleaned
WHERE rating IS NOT NULL
GROUP BY CAST(rating AS DECIMAL(3,1))
ORDER BY Rating;

