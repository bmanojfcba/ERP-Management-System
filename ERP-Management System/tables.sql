CREATE DATABASE erp;
USE erp;

-- 1. Departments
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(100) NOT NULL
);

-- 2. Roles
CREATE TABLE Roles (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(100) NOT NULL
);

-- 3. Employees
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    salary DECIMAL(10,2),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

-- 4. Employee_Roles (Many-to-Many)
CREATE TABLE Employee_Roles (
    emp_id INT,
    role_id INT,
    PRIMARY KEY (emp_id, role_id),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id),
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

-- 5. Customers
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100),
    address TEXT
);

-- 6. Suppliers
CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100),
    phone VARCHAR(15),
    address TEXT
);

-- 7. Categories
CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100)
);

-- 8. Products
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    stock INT,
    category_id INT,
    supplier_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

-- 9. Warehouses
CREATE TABLE Warehouses (
    warehouse_id INT PRIMARY KEY AUTO_INCREMENT,
    location VARCHAR(150)
);

-- 10. Inventory
CREATE TABLE Inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    warehouse_id INT,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id)
);

-- 11. Orders
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- 12. Order_Details
CREATE TABLE Order_Details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- 13. Payments
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    payment_method VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- 14. Invoices
CREATE TABLE Invoices (
    invoice_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    invoice_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- 15. Purchase_Orders
CREATE TABLE Purchase_Orders (
    purchase_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_id INT,
    purchase_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

-- 16. Purchase_Details
CREATE TABLE Purchase_Details (
    purchase_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    purchase_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (purchase_id) REFERENCES Purchase_Orders(purchase_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- 17. Audit_Log
CREATE TABLE Audit_Log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    table_name VARCHAR(100),
    action_type VARCHAR(20),
    action_date DATETIME,
    performed_by VARCHAR(100)
);

-- 18. Attendance
CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    check_in DATETIME,
    check_out DATETIME,
    work_hours DECIMAL(5,2),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);

-- 19. Payroll
CREATE TABLE Payroll (
    payroll_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    basic_salary DECIMAL(10,2),
    bonus DECIMAL(10,2),
    deductions DECIMAL(10,2),
    net_salary DECIMAL(10,2),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);

-- 20. User_Login
CREATE TABLE User_Login (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    role VARCHAR(50)
);

-- 21. Returns
CREATE TABLE Returns (
    return_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    return_date DATE,
    reason TEXT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO payments (payment_id, order_id, amount, payment_date, payment_method) VALUES
(1,1,15000,'2024-01-10','UPI'),
(2,2,22000,'2024-01-12','Card'),
(3,3,18000,'2024-01-15','Cash'),
(4,4,35000,'2024-01-18','UPI'),
(5,5,12000,'2024-01-20','NetBanking'),
(6,6,45000,'2024-01-22','Card'),
(7,7,28000,'2024-01-25','UPI'),
(8,8,16000,'2024-01-28','Cash'),
(9,9,52000,'2024-02-02','Card'),
(10,10,30000,'2024-02-05','UPI'),
(11,11,41000,'2024-02-08','NetBanking'),
(12,12,26000,'2024-02-10','Card'),
(13,13,39000,'2024-02-12','UPI'),
(14,14,17000,'2024-02-15','Cash'),
(15,15,21000,'2024-02-18','Card'),
(16,16,33000,'2024-02-20','UPI'),
(17,17,29000,'2024-02-23','NetBanking'),
(18,18,47000,'2024-02-25','Card'),
(19,19,36000,'2024-02-27','UPI'),
(20,20,25000,'2024-03-01','Cash');

INSERT INTO attendance (attendance_id, emp_id, check_in, check_out, work_hours) VALUES
(1,1,'2024-01-05 09:00:00','2024-01-05 17:30:00',8.5),
(2,2,'2024-01-05 09:15:00','2024-01-05 17:15:00',8),
(3,3,'2024-01-05 09:05:00','2024-01-05 17:20:00',8.25),
(4,4,'2024-01-05 09:10:00','2024-01-05 17:40:00',8.5),
(5,5,'2024-01-05 08:55:00','2024-01-05 17:10:00',8.25),
(6,6,'2024-01-06 09:00:00','2024-01-06 17:30:00',8.5),
(7,7,'2024-01-06 09:20:00','2024-01-06 17:10:00',7.8),
(8,8,'2024-01-06 09:05:00','2024-01-06 17:35:00',8.5),
(9,9,'2024-01-06 09:00:00','2024-01-06 17:25:00',8.4),
(10,10,'2024-01-06 09:10:00','2024-01-06 17:30:00',8.3),
(11,11,'2024-01-07 09:00:00','2024-01-07 17:30:00',8.5),
(12,12,'2024-01-07 09:15:00','2024-01-07 17:20:00',8.1),
(13,13,'2024-01-07 09:05:00','2024-01-07 17:15:00',8.1),
(14,14,'2024-01-07 09:10:00','2024-01-07 17:30:00',8.3),
(15,15,'2024-01-07 08:50:00','2024-01-07 17:10:00',8.3),
(16,16,'2024-01-08 09:00:00','2024-01-08 17:30:00',8.5),
(17,17,'2024-01-08 09:20:00','2024-01-08 17:25:00',8),
(18,18,'2024-01-08 09:10:00','2024-01-08 17:35:00',8.4),
(19,19,'2024-01-08 09:00:00','2024-01-08 17:30:00',8.5),
(20,20,'2024-01-08 09:05:00','2024-01-08 17:20:00',8.2);
