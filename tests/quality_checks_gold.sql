/*
===============================================================================
Kiểm tra Chất lượng Dữ liệu (Quality Checks)
===============================================================================
Mục đích Script:
    Script này thực hiện các bước kiểm tra chất lượng nhằm xác thực tính toàn vẹn, 
    nhất quán và độ chính xác của Tầng Gold. Các kiểm tra này đảm bảo:
    - Tính duy nhất của khóa thay thế (surrogate keys) trong các bảng dimension.
    - Tính toàn vẹn tham chiếu (referential integrity) giữa bảng fact và bảng dimension.
    - Xác thực các mối quan hệ trong mô hình dữ liệu phục vụ mục đích phân tích.

Ghi chú sử dụng:
    - Điều tra và xử lý bất kỳ sai lệch nào tìm thấy trong quá trình kiểm tra.
===============================================================================
*/

-- ====================================================================
-- Kiểm tra bảng 'gold.dim_customers'
-- ====================================================================
-- Kiểm tra tính duy nhất của Customer Key trong gold.dim_customers
-- Mong đợi: Không có kết quả trả về
SELECT 
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- Checking 'gold.product_key'
-- ====================================================================
-- Check for Uniqueness of Product Key in gold.dim_products
-- Expectation: No results 
SELECT 
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- Kiểm tra bảng 'gold.fact_sales'
-- ====================================================================
-- Kiểm tra sự kết nối giữa Dim/ fact
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL  
