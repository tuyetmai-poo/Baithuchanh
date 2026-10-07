-- =====================================================
-- BÀI THỰC HÀNH: TRIGGER TRONG MYSQL
-- =====================================================


-- =====================================================
-- 1. TẠO DATABASE
-- =====================================================

CREATE DATABASE IF NOT EXISTS company;

USE company;


-- =====================================================
-- 2. TẠO BẢNG EMPLOYEES
-- =====================================================

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL
);


-- =====================================================
-- 3. TẠO TRIGGER
-- Tự động xác định department dựa vào salary
-- salary >= 5000  → Management
-- salary >= 3000  → Sales
-- salary < 3000   → Support
-- =====================================================

DELIMITER //

DROP TRIGGER IF EXISTS update_department//

CREATE TRIGGER update_department
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary >= 5000 THEN
        SET NEW.department = 'Management';

    ELSEIF NEW.salary >= 3000 THEN
        SET NEW.department = 'Sales';

    ELSE
        SET NEW.department = 'Support';

    END IF;
END //

DELIMITER ;


-- =====================================================
-- 4. INSERT DỮ LIỆU ĐỂ KIỂM TRA TRIGGER
-- =====================================================

INSERT INTO employees (name, department, salary)
VALUES
    ('John Doe', 'A', 3500),
    ('Jane Smith', 'A', 2000),
    ('David Johnson', 'A', 6000);


-- =====================================================
-- 5. KIỂM TRA KẾT QUẢ
-- =====================================================

SELECT *
FROM employees;
