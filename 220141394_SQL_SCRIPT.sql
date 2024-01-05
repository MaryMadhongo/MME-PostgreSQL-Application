-- Drop tables (if they exist)
DROP TABLE IF EXISTS transactions CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS stores CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS warehouse_items CASCADE;
DROP TABLE IF EXISTS bookings CASCADE;

-- Create tables
CREATE TABLE stores (
  store_id SERIAL PRIMARY KEY,
  store_name VARCHAR(100) NOT NULL,
  store_address VARCHAR(255) NOT NULL
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    store_id INTEGER REFERENCES stores(store_id),
    employee_name VARCHAR(255) NOT NULL,
    job_title VARCHAR(255) NOT NULL
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    c_customer_name VARCHAR(255) NOT NULL,
    c_address VARCHAR(255) NOT NULL,
    c_telephone_number VARCHAR(20) NOT NULL,
    c_date_of_birth DATE NOT NULL CHECK (c_date_of_birth BETWEEN '1923-01-01' AND CURRENT_DATE),
    c_bank_name VARCHAR(255) NOT NULL,
    c_bank_address VARCHAR(255) NOT NULL,
    c_sort_code VARCHAR(10) NOT NULL,
    c_account_number VARCHAR(20) NOT NULL
);

CREATE TABLE products (
  product_id SERIAL PRIMARY KEY,
  p_product_type VARCHAR(100) NOT NULL,
  p_product_name VARCHAR(100) NOT NULL,
  p_description TEXT,
  p_product_cost NUMERIC(10, 2) NOT NULL
);

CREATE TABLE warehouse_items (
  warehouse_item_id SERIAL PRIMARY KEY,
  product_id INT NOT NULL,
  store_id INT NOT NULL,
  quantity INT NOT NULL,
  FOREIGN KEY (product_id) REFERENCES products (product_id),
  FOREIGN KEY (store_id) REFERENCES stores (store_id)
);

CREATE TABLE transactions (
  transaction_id SERIAL PRIMARY KEY,
  customer_id INT ,
  transaction_date DATE NOT NULL,
  store_id INT NOT NULL,
  product_id INT ,
  quantity INT NOT NULL,
  total_cost NUMERIC(10, 2) ,
  FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
  FOREIGN KEY (store_id) REFERENCES stores (store_id),
  FOREIGN KEY (product_id) REFERENCES products (product_id)
);

CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    b_delivery_date DATE NOT NULL,
    b_delivery_time TIME NOT NULL,
    store_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    total_cost NUMERIC(10, 2) ,
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
    FOREIGN KEY (store_id) REFERENCES stores (store_id),
    FOREIGN KEY (product_id) REFERENCES products (product_id)
);

-- Insert sample data into tables
-- Stores
INSERT INTO stores (store_name, store_address) VALUES ('MME London', 'London');
INSERT INTO stores (store_name, store_address) VALUES ('MME Birmingham', 'Birmingham');
INSERT INTO stores (store_name, store_address) VALUES ('MME Manchester', 'Manchester');
INSERT INTO stores (store_name, store_address) VALUES ('MME Liverpool', 'Liverpool');
INSERT INTO stores (store_name, store_address) VALUES ('MME Leeds', 'Leeds');
INSERT INTO stores (store_name, store_address) VALUES ('MME Bristol', 'Bristol');

-- Employees
INSERT INTO employees (store_id, employee_name, job_title) VALUES (1, 'Mary Smith', 'Delivery Person');
INSERT INTO employees (store_id, employee_name, job_title) VALUES (2, 'Bill Bornwell', 'Salesperson');
INSERT INTO employees (store_id, employee_name, job_title) VALUES (3, 'Father Don', 'Manager');
INSERT INTO employees (store_id, employee_name, job_title) VALUES (4, 'Joe Joseph', 'Manager');
INSERT INTO employees (store_id, employee_name, job_title) VALUES (5, 'Cox Tee', 'Delivery Person');
INSERT INTO employees (store_id, employee_name, job_title) VALUES (6, 'Bill Fol', 'Salesperson');

-- Customers
INSERT INTO customers (c_customer_name, c_address, c_telephone_number, c_date_of_birth, c_bank_name, c_bank_address, c_sort_code, c_account_number)
VALUES ('Emma Ossy', '123 Main St, London', '123456789', '1990-01-01', 'Bank of England', 'Threadneedle St, London', '111111', '123456');
INSERT INTO customers (c_customer_name, c_address, c_telephone_number, c_date_of_birth, c_bank_name, c_bank_address, c_sort_code, c_account_number)
VALUES ('Bob Mary', '456 High St, Birmingham', '987654321', '1985-02-02', 'Lloyds Bank', '25 Gresham St, London', '222222', '654321');
INSERT INTO customers (c_customer_name, c_address, c_telephone_number, c_date_of_birth, c_bank_name, c_bank_address, c_sort_code, c_account_number)
VALUES ('Charlotte Davis', '789 Market St, Manchester', '555555555', '1995-03-03', 'Barclays Bank', '1 Churchill Pl, London', '333333', '789456');
INSERT INTO customers (c_customer_name, c_address, c_telephone_number, c_date_of_birth, c_bank_name, c_bank_address, c_sort_code, c_account_number)
VALUES ('Visal Ossy', '123 Main St, London', '456673829', '1999-04-15', 'Bank of England', 'Threadneedle St, London', '444467', '444456');
INSERT INTO customers (c_customer_name, c_address, c_telephone_number, c_date_of_birth, c_bank_name, c_bank_address, c_sort_code, c_account_number)
VALUES ('Bobby Martha', '321 Duke St, Liverpool', '987654321', '1985-02-02', 'HSBC UK', ' 8 Canada Square, London, London', '222222', '654321');
INSERT INTO customers (c_customer_name, c_address, c_telephone_number, c_date_of_birth, c_bank_name, c_bank_address, c_sort_code, c_account_number)
VALUES ('Charles Dan', '740 Market St, Manchester', '9249096345', '2007-03-03', 'Barclays Bank', '1 Churchill Pl, London', '336792', '780000');

-- Products
INSERT INTO products (p_product_name, p_description, p_product_cost, p_product_type)
VALUES ('Just Kids', 'Beethovana’s famous piano', 500.00, 'Printed music');
INSERT INTO products (p_product_name, p_description, p_product_cost, p_product_type)
VALUES ('How to play guitar', 'Comprehensive guide to learning guitar', 50.00, 'Book');
INSERT INTO products (p_product_name, p_description, p_product_cost, p_product_type)
VALUES ('Gospell26', 'Mary’s album', 20.00, 'CD');
INSERT INTO products (p_product_name, p_description, p_product_cost, p_product_type)
VALUES ('The Lord', 'Collection of classical compositions', 80.00, 'DVD');

-- Warehouses
INSERT INTO warehouse_items (product_id, store_id, quantity) VALUES (1, 1, 100);
INSERT INTO warehouse_items (product_id, store_id, quantity) VALUES (2, 1, 50);
INSERT INTO warehouse_items (product_id, store_id, quantity) VALUES (2, 2, 20);
INSERT INTO warehouse_items (product_id, store_id, quantity) VALUES (3, 3, 150);
INSERT INTO warehouse_items (product_id, store_id, quantity) VALUES (3, 4, 106);
INSERT INTO warehouse_items (product_id, store_id, quantity) VALUES (3, 4, 78);
INSERT INTO warehouse_items (product_id, store_id, quantity) VALUES (1, 5, 27);
INSERT INTO warehouse_items (product_id, store_id, quantity) VALUES (4, 6, 0);

--Bookings
INSERT INTO bookings (customer_id, b_delivery_date, b_delivery_time, store_id, product_id, quantity, total_cost) 
VALUES 
(1, '2021-10-01', '08:00:00', 1, 1, 3, 100.00),
(2, '2021-11-11', '20:00:00', 2, 2, 2, 200.00);

-- PL/pgSQL stored procedures
-- Stored procedure to register a new customer
CREATE OR REPLACE PROCEDURE register_customer(
    customer_name VARCHAR(255),
    address VARCHAR(255),
    telephone_number VARCHAR(20),
    date_of_birth DATE,
    bank_name VARCHAR(255),
    bank_address VARCHAR(255),
    sort_code VARCHAR(10),
    account_number VARCHAR(20)
)
LANGUAGE plpgsql
AS $$
DECLARE
    found_customer_id INT;
BEGIN
	-- Validate mandatory fields
    IF customer_name IS NULL OR address IS NULL OR telephone_number IS NULL OR date_of_birth IS NULL
        OR bank_name IS NULL OR bank_address IS NULL OR sort_code IS NULL OR account_number IS NULL
    THEN
        RAISE NOTICE 'All fields are mandatory.To register as a customer fill in all the details.';
        RETURN;
    END IF;
	
	-- Check for duplicate customers
		found_customer_id := (
			SELECT customer_id
			FROM customers
			WHERE c_customer_name = customer_name
			LIMIT 1
		);

    IF found_customer_id IS NOT NULL THEN
        RAISE NOTICE 'Customer with the same name already exists.';
		RETURN;
    END IF;


    -- Insert new customer
	BEGIN
		INSERT INTO customers (c_customer_name, c_address, c_telephone_number, c_date_of_birth, c_bank_name, c_bank_address, c_sort_code, c_account_number)
			VALUES (customer_name, address, telephone_number, date_of_birth, bank_name, bank_address, sort_code, account_number);
			RAISE NOTICE 'The new customer %  has been registered', customer_name;
	EXCEPTION WHEN check_violation THEN
        RAISE NOTICE 'A check constraint was violated. Please ensure the date of birth is correct.';
    WHEN others THEN
        RAISE NOTICE 'An error occurred: %', SQLERRM;
    END;
END;
$$;

CALL register_customer('John Joe', '654 Call Ln, Leeds', '1234567890', '2000-01-01', 'NatWest', '250 Bishopsgate, London', '123456', '9876543210');


-- Stored procedure to allow an existing customer to purchase a product
CREATE OR REPLACE PROCEDURE purchase_product (
    customer_name VARCHAR(255),
    product_name VARCHAR(255),
    delivery_date DATE,
    delivery_time TIME,
	store_id INTEGER	
)

LANGUAGE plpgsql
AS $$
DECLARE
    l_product_id INTEGER;
    l_product_cost DECIMAL;
    l_quantity INTEGER;
    total_cost DECIMAL;
	l_store_name VARCHAR;
BEGIN
	-- Check if the customer exists
	IF NOT EXISTS (
	   SELECT c_customer_name
	   FROM customers
	   WHERE c_customer_name = customer_name
	) THEN
	   RAISE NOTICE 'Customer does not exist. Register first!';
	   RETURN;
	END IF;
   
    -- Check if the product exists
    SELECT product_id INTO l_product_id
    FROM products
    WHERE p_product_name = purchase_product.product_name;

    IF l_product_id IS NULL THEN
        RAISE NOTICE 'Product does not exist. Check if you like any other products.';
        RETURN;
    END IF;

	-- Display delivery slot
	RAISE NOTICE 'Checking delivery slot: Date - %, Time - %', delivery_date, delivery_time;

	-- Check if the delivery slot is available
	IF EXISTS (
		SELECT 1 FROM bookings
		WHERE b_delivery_date = delivery_date
		AND b_delivery_time = delivery_time
	) THEN
		RAISE NOTICE 'Delivery slot is not available. Try another date and time.';
		RETURN;
	ELSE
		RAISE NOTICE 'Delivery slot is available. Proceed with your purchase.';
	END IF;


	-- Display product id
	RAISE NOTICE 'Checking product stock: Product ID - %', l_product_id;

	-- Check if the product is in stock
	IF NOT EXISTS (
		SELECT 1 FROM warehouse_items
		WHERE product_id = l_product_id
		AND quantity > 0
	) THEN
		RAISE NOTICE 'Product is out of stock. Try again later!';
			RETURN;
	ELSE
		RAISE NOTICE 'Product is in stock. Proceed with your purchase.';
	END IF;
	
	-- Fetch product cost and quantity
	SELECT p_product_cost, quantity INTO l_product_cost, l_quantity
	FROM products
	JOIN warehouse_items ON products.product_id = warehouse_items.product_id
	WHERE p_product_name = purchase_product.product_name;

	IF l_quantity IS NULL THEN
		RAISE NOTICE 'Product quantity could not be fetched.';
		RETURN;
	END IF;
	
	-- Calculate the total cost
	total_cost := l_product_cost * 1;

	-- Insert into transactions table.
	INSERT INTO transactions (customer_id, product_id, store_id, transaction_date, quantity, total_cost)
	VALUES (
	    (SELECT customer_id FROM customers WHERE c_customer_name = purchase_product.customer_name),
	    l_product_id,
	    store_id,
	    delivery_date,
	    1,
	    total_cost);
		
	SELECT store_name INTO l_store_name FROM stores WHERE stores.store_id = purchase_product.store_id;
	
	RAISE NOTICE 'Purchase successful: % has purchased % from %. Delivery date is on  %',
   customer_name,product_name,  l_store_name, delivery_date;
   	

	-- Reduce the product stock quantity by 1
   UPDATE warehouse_items
   SET quantity = quantity - 1
   WHERE product_id = l_product_id;

END; 
$$;

CALL public.purchase_product('Emma Ossy', 'Just Kids', '2022-09-30', '15:00:00',1);

-- Test Example for register customer

	 -- Test Case 1: Valid Customer Registration
CALL register_customer('John Meli', '987 Park St, Bristol', '1234567893', '1990-01-03', 'Santander UK',
					   '2 Triton Square, London', '123906', '9876543000');
 	 -- Test Case 2: Mandatory fields
CALL register_customer(NULL, '650 Call Ln, Leeds', '1234567890', '2000-01-01', 'NatWest', 
					   '250 Bishopsgate, London', '2000-10-01', '12345678');
 	 -- Test Case 3: Duplicate customer
CALL register_customer('John Meli', '987 Park St, Bristol', '1234567893', '1990-01-03', 'Santander UK',
					   '2 Triton Square, London', '123906', '9876543000');
	 -- Test Case 4: Future date of birth 		   
CALL register_customer('Johny Sando', '5 Park St, Bristol', '5553345555', '2030-01-01', 'Santander UK',
					 '2 Triton Square, London', '334455', '234578901');
	 -- Test Case 5: Exceeding maximum legth of data types		 
CALL register_customer(repeat('a', 256), '800 Call Ln, Leeds', '0968953221', '1980-01-01', 'NatWest',
					 '250 Bishopsgate, London', 'Sort Code', 'Account Number');
					   
					   
-- Test Example for purchase product

    -- Test Case 1: Valid Purchase
CALL public.purchase_product('Charlotte Davis', 'Gospell26', '2023-10-11', '22:00:00',6);    
    -- Test Case 2: Customer does not exit
CALL public.purchase_product('Neang Kim', 'Gospell26' , '2021-10-04', '09:00:00',2); 
    -- Test Case 3: Product does not exit
CALL public.purchase_product('Charlotte Davis', 'Guitar', '2021-10-01', '08:00:00',1);    
    -- Test Case 4: No delivery slot
CALL public.purchase_product('Charlotte Davis', 'How to play guitar', '2021-10-01', '08:00:00',3);
    -- Test Case 5: Product not in stock
CALL public.purchase_product('Charlotte Davis', 'The Lord', '2022-09-30', '15:00:00',2);

--uncomment to check tables.
--SELECT 
--FROM 






