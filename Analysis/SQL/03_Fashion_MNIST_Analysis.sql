
USE DataAnalyticsProject;
GO

-- 1. Total images
SELECT COUNT(*) AS TotalImages
FROM dbo.fashion_mnist_cleaned;
GO

-- 2. Number of images in each label
SELECT
    label,
    COUNT(*) AS ImageCount
FROM dbo.fashion_mnist_cleaned
GROUP BY label
ORDER BY label;
GO

-- 3. Percentage of images in each label
SELECT
    label,
    COUNT(*) AS ImageCount,
    CAST(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM dbo.fashion_mnist_cleaned)
        AS DECIMAL(5,2)
    ) AS PercentageOfImages
FROM dbo.fashion_mnist_cleaned
GROUP BY label
ORDER BY label;
GO

-- 4. Average pixel intensity for each label
SELECT
    label,
    CAST(AVG(PixelTotal / 784.0) AS DECIMAL(6,2))
        AS AveragePixelIntensity
FROM (
    SELECT
        label,
        (
            CAST(pixel1 AS BIGINT) + pixel2 + pixel3 + pixel4 +
            pixel5 + pixel6 + pixel7 + pixel8 + pixel9 + pixel10
        ) AS PixelTotal
    FROM dbo.fashion_mnist_cleaned
) AS P
GROUP BY label
ORDER BY label;
GO


USE DataAnalyticsProject;
GO

DECLARE @PixelExpression NVARCHAR(MAX);
DECLARE @SQL NVARCHAR(MAX);

SELECT @PixelExpression =
    STRING_AGG(
        CAST('CAST(' + QUOTENAME(name) + ' AS BIGINT)' AS NVARCHAR(MAX)),
        ' + '
    )
FROM sys.columns
WHERE object_id = OBJECT_ID('dbo.fashion_mnist_cleaned')
  AND name LIKE 'pixel[0-9]%';

SET @SQL = N'
SELECT
    label,
    COUNT(*) AS ImageCount,
    CAST(AVG(' + @PixelExpression + N' / 784.0)
         AS DECIMAL(8,2)) AS AveragePixelIntensity
FROM dbo.fashion_mnist_cleaned
GROUP BY label
ORDER BY label;';

EXEC sp_executesql @SQL;
GO
