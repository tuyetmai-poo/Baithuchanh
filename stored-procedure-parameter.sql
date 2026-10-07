-- =====================================================
-- BÀI THỰC HÀNH: STORED PROCEDURE - PARAMETERS
-- Database: classicmodels
-- =====================================================

USE classicmodels;


-- =====================================================
-- 1. THAM SỐ IN
-- Lấy thông tin customer theo customerNumber
-- =====================================================

DELIMITER //

DROP PROCEDURE IF EXISTS getCusById//

CREATE PROCEDURE getCusById(
    IN cusNum INT
)
BEGIN
    SELECT *
    FROM customers
    WHERE customerNumber = cusNum;
END //

DELIMITER ;


-- Gọi Procedure
CALL getCusById(175);


-- =====================================================
-- 2. THAM SỐ OUT
-- Đếm số lượng customer theo thành phố
-- =====================================================

DELIMITER //

DROP PROCEDURE IF EXISTS GetCustomersCountByCity//

CREATE PROCEDURE GetCustomersCountByCity(
    IN in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END //

DELIMITER ;


-- Gọi Procedure
CALL GetCustomersCountByCity('Lyon', @total);

-- Xem kết quả
SELECT @total;


-- =====================================================
-- 3. THAM SỐ INOUT
-- Tăng giá trị của counter
-- =====================================================

DELIMITER //

DROP PROCEDURE IF EXISTS SetCounter//

CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END //

DELIMITER ;


-- Khởi tạo giá trị ban đầu
SET @counter = 1;

-- @counter = 2
CALL SetCounter(@counter, 1);

-- @counter = 3
CALL SetCounter(@counter, 1);

-- @counter = 8
CALL SetCounter(@counter, 5);

-- Xem kết quả cuối cùng
SELECT @counter;
