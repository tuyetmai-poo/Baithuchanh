-- ============================================================
-- BÀI THỰC HÀNH: VIEW - INDEX - STORED PROCEDURE
-- ============================================================


-- ============================================================
-- BƯỚC 1: TẠO DATABASE
-- ============================================================

CREATE DATABASE IF NOT EXISTS product_management;

USE product_management;


-- ============================================================
-- BƯỚC 2: TẠO BẢNG PRODUCTS
-- ============================================================

DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    productCode VARCHAR(50) NOT NULL,
    productName VARCHAR(100) NOT NULL,
    productPrice DECIMAL(15,2) NOT NULL,
    productAmount INT NOT NULL,
    productDescription VARCHAR(255),
    productStatus VARCHAR(50)
);


-- ============================================================
-- CHÈN DỮ LIỆU MẪU
-- ============================================================

INSERT INTO Products
    (productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES
    ('P001', 'Laptop Dell', 1500.00, 10, 'Laptop Dell Inspiron', 'Available'),
    ('P002', 'Laptop HP', 1300.00, 15, 'Laptop HP Pavilion', 'Available'),
    ('P003', 'MacBook Air', 1800.00, 8, 'Apple MacBook Air', 'Available'),
    ('P004', 'iPhone 17', 1200.00, 20, 'Apple iPhone 17', 'Available'),
    ('P005', 'Samsung Galaxy', 900.00, 25, 'Samsung Galaxy Phone', 'Available'),
    ('P006', 'iPad Pro', 1100.00, 12, 'Apple iPad Pro', 'Available'),
    ('P007', 'Dell Monitor', 350.00, 30, 'Dell 24 inch Monitor', 'Available'),
    ('P008', 'Logitech Mouse', 50.00, 50, 'Wireless Mouse', 'Available'),
    ('P009', 'Mechanical Keyboard', 100.00, 40, 'Mechanical Gaming Keyboard', 'Available'),
    ('P010', 'Sony Headphone', 250.00, 18, 'Wireless Headphone', 'Out of stock');


-- Kiểm tra dữ liệu
SELECT *
FROM Products;


-- ============================================================
-- BƯỚC 3: INDEX
-- ============================================================

-- 3.1. Tạo Unique Index trên productCode
-- Không cho phép hai sản phẩm có cùng productCode.

CREATE UNIQUE INDEX idx_product_code
ON Products(productCode);


-- 3.2. Tạo Composite Index trên productName và productPrice

CREATE INDEX idx_product_name_price
ON Products(productName, productPrice);


-- ============================================================
-- 3.3. EXPLAIN TRƯỚC VÀ SAU KHI TẠO INDEX
-- ============================================================

-- Có thể dùng EXPLAIN để xem MySQL thực hiện truy vấn như thế nào.

EXPLAIN
SELECT *
FROM Products
WHERE productCode = 'P001';


EXPLAIN
SELECT *
FROM Products
WHERE productName = 'Laptop Dell'
  AND productPrice = 1500.00;


-- Kiểm tra các Index hiện tại
SHOW INDEX FROM Products;


-- ============================================================
-- BƯỚC 4: VIEW
-- ============================================================

-- 4.1. Tạo View

DROP VIEW IF EXISTS product_views;

CREATE VIEW product_views AS
SELECT
    productCode,
    productName,
    productPrice,
    productStatus
FROM Products;


-- Kiểm tra View
SELECT *
FROM product_views;


-- 4.2. Sửa đổi View
-- Thêm điều kiện chỉ lấy các sản phẩm đang Available.

CREATE OR REPLACE VIEW product_views AS
SELECT
    productCode,
    productName,
    productPrice,
    productStatus
FROM Products
WHERE productStatus = 'Available';


-- Kiểm tra View sau khi sửa
SELECT *
FROM product_views;


-- 4.3. Xóa View

DROP VIEW IF EXISTS product_views;


-- ============================================================
-- BƯỚC 5: STORED PROCEDURE
-- ============================================================


-- ============================================================
-- 5.1. Procedure lấy tất cả sản phẩm
-- ============================================================

DELIMITER //

DROP PROCEDURE IF EXISTS getAllProducts//

CREATE PROCEDURE getAllProducts()
BEGIN
    SELECT *
    FROM Products;
END //

DELIMITER ;


-- Gọi Procedure
CALL getAllProducts();


-- ============================================================
-- 5.2. Procedure thêm sản phẩm mới
-- ============================================================

DELIMITER //

DROP PROCEDURE IF EXISTS addProduct//

CREATE PROCEDURE addProduct(
    IN p_productCode VARCHAR(50),
    IN p_productName VARCHAR(100),
    IN p_productPrice DECIMAL(15,2),
    IN p_productAmount INT,
    IN p_productDescription VARCHAR(255),
    IN p_productStatus VARCHAR(50)
)
BEGIN
    INSERT INTO Products (
        productCode,
        productName,
        productPrice,
        productAmount,
        productDescription,
        productStatus
    )
    VALUES (
        p_productCode,
        p_productName,
        p_productPrice,
        p_productAmount,
        p_productDescription,
        p_productStatus
    );
END //

DELIMITER ;


-- Test thêm sản phẩm
CALL addProduct(
    'P011',
    'Gaming Laptop',
    2000.00,
    10,
    'High performance gaming laptop',
    'Available'
);


-- Kiểm tra
SELECT *
FROM Products
WHERE productCode = 'P011';


-- ============================================================
-- 5.3. Procedure sửa sản phẩm theo ID
-- ============================================================

DELIMITER //

DROP PROCEDURE IF EXISTS updateProduct//

CREATE PROCEDURE updateProduct(
    IN p_id INT,
    IN p_productCode VARCHAR(50),
    IN p_productName VARCHAR(100),
    IN p_productPrice DECIMAL(15,2),
    IN p_productAmount INT,
    IN p_productDescription VARCHAR(255),
    IN p_productStatus VARCHAR(50)
)
BEGIN
    UPDATE Products
    SET
        productCode = p_productCode,
        productName = p_productName,
        productPrice = p_productPrice,
        productAmount = p_productAmount,
        productDescription = p_productDescription,
        productStatus = p_productStatus
    WHERE Id = p_id;
END //

DELIMITER ;


-- Test sửa sản phẩm có ID = 1
CALL updateProduct(
    1,
    'P001',
    'Dell Laptop Updated',
    1600.00,
    12,
    'Updated Dell Laptop',
    'Available'
);


-- Kiểm tra
SELECT *
FROM Products
WHERE Id = 1;


-- ============================================================
-- 5.4. Procedure xóa sản phẩm theo ID
-- ============================================================

DELIMITER //

DROP PROCEDURE IF EXISTS deleteProduct//

CREATE PROCEDURE deleteProduct(
    IN p_id INT
)
BEGIN
    DELETE FROM Products
    WHERE Id = p_id;
END //

DELIMITER ;


-- Test xóa sản phẩm có ID = 10
CALL deleteProduct(10);


-- Kiểm tra
SELECT *
FROM Products;


-- ============================================================
-- KẾT THÚC BÀI THỰC HÀNH
-- ============================================================
