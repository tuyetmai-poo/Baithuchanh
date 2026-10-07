-- =====================================================
-- BÀI THỰC HÀNH: VIEW TRONG MYSQL
-- Database: classicmodels
-- =====================================================

USE classicmodels;


-- =====================================================
-- 1. TẠO VIEW
-- Lấy customerNumber, customerName, phone
-- từ bảng customers
-- =====================================================

DROP VIEW IF EXISTS customer_views;

CREATE VIEW customer_views AS
SELECT
    customerNumber,
    customerName,
    phone
FROM customers;


-- Kiểm tra dữ liệu trong View
SELECT *
FROM customer_views;


-- =====================================================
-- 2. CẬP NHẬT VIEW
-- Hiển thị thêm contactFirstName, contactLastName
-- và chỉ lấy customer ở thành phố Nantes
-- =====================================================

CREATE OR REPLACE VIEW customer_views AS
SELECT
    customerNumber,
    customerName,
    contactFirstName,
    contactLastName,
    phone
FROM customers
WHERE city = 'Nantes';


-- Kiểm tra View sau khi cập nhật
SELECT *
FROM customer_views;


-- =====================================================
-- 3. XÓA VIEW
-- =====================================================

DROP VIEW IF EXISTS customer_views;
