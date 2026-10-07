-- =====================================================
-- BÀI THỰC HÀNH: STORED PROCEDURE
-- Database: classicmodels
-- =====================================================

USE classicmodels;


-- =====================================================
-- 1. Tạo Stored Procedure lấy toàn bộ customers
-- =====================================================

DELIMITER //

DROP PROCEDURE IF EXISTS findAllCustomers//

CREATE PROCEDURE findAllCustomers()
BEGIN
    SELECT *
    FROM customers;
END //

DELIMITER ;


-- =====================================================
-- 2. Gọi Stored Procedure
-- =====================================================

CALL findAllCustomers();


-- =====================================================
-- 3. Xóa Procedure cũ và tạo lại
--    Procedure tìm customer có customerNumber = 175
-- =====================================================

DELIMITER //

DROP PROCEDURE IF EXISTS findAllCustomers//

CREATE PROCEDURE findAllCustomers()
BEGIN
    SELECT *
    FROM customers
    WHERE customerNumber = 175;
END //

DELIMITER ;


-- =====================================================
-- 4. Kiểm tra Procedure sau khi tạo lại
-- =====================================================

CALL findAllCustomers();
