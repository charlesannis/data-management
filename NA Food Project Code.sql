CREATE DATABASE IF NOT EXISTS NAFood;
USE NAFood;
CREATE TABLE Manufacturer (
    ManufacturerID INT PRIMARY KEY,
    ManufacturerName VARCHAR(255) NOT NULL,
    Street VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    ZipCode VARCHAR(20),
    ManufacturerPhone VARCHAR(20),
    ManufacturerEmail VARCHAR(255),
    ManufacturerType VARCHAR(20) CHECK (ManufacturerType IN ('international', 'domestic'))
);

CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(255),
    Street VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    ZipCode VARCHAR(20),  -- Similar to ManufacturerAddress
    SupplierPhone VARCHAR(50),
    SupplierEmail VARCHAR(100),
    SupplierType VARCHAR(50) CHECK (SupplierType IN ('domestic', 'international'))
);

CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL
);


CREATE TABLE Product (
    ProductID INT PRIMARY KEY CHECK (ProductID BETWEEN 1000 AND 9999),
    ProductName VARCHAR(255),
    ManufacturerID INT,
    CategoryID INT,
	SupplierID INT,
    FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID),
	FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);



CREATE TABLE ProductUnit (
    ProductID INT,
    Unit VARCHAR(50),
    Cost DECIMAL(10, 2),
    ListPrice DECIMAL(10, 2),
    AvailableQuantity INT,
    PRIMARY KEY (ProductID, Unit),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE SalesPerson (
    SalesPersonID INT PRIMARY KEY,
    SalesPersonName VARCHAR(255) NOT NULL
);

CREATE TABLE Client (
    ClientID INT PRIMARY KEY,
    ClientName VARCHAR(255) NOT NULL,
    Street VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    ZipCode VARCHAR(20),
	SalesPersonID INT, 
    ClientContact VARCHAR(255),
    ClientPhone VARCHAR(20),
    ClientEmail VARCHAR(255),
    ClientType VARCHAR(20) CHECK (ClientType IN ('grocery store', 'restaurant')),
    FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(SalesPersonID)
);


CREATE TABLE SalesOrder (
    OrderID INT PRIMARY KEY,
    ClientID INT,
    SalesPersonID INT,
    OrderDate DATE,
    OrderTotal DECIMAL(10, 2),
    DeliveryMethod VARCHAR(20) CHECK (DeliveryMethod IN ('pickup', 'delivery')),
    DeliveryDate DATE,
    FOREIGN KEY (ClientID) REFERENCES Client (ClientID),
    FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(SalesPersonID)
);

CREATE TABLE OrderLine (
    OrderID INT,
    ProductID INT,
    Unit VARCHAR(50),
    DiscountRate DECIMAL(5, 2),  -- Discount as percentage (e.g., 10.00 for 10%)
    SoldPrice DECIMAL(10, 2),    -- Price of the product at the time of sale
    PurchaseQuantity INT,        -- Quantity of the product in the order line
    Amount DECIMAL(10, 2),       -- Total amount for the product line (SoldPrice * PurchaseQuantity)
    PRIMARY KEY (OrderID, ProductID, Unit),
    FOREIGN KEY (OrderID) REFERENCES SalesOrder(OrderID),
    FOREIGN KEY (ProductID, Unit) REFERENCES ProductUnit(ProductID, Unit)
);
show tables;

Populate
INSERT INTO Manufacturer (ManufacturerID, ManufacturerName, Street, City, State, Country, ZipCode, ManufacturerPhone, ManufacturerEmail, ManufacturerType)
VALUES 
(1, 'MingHong', '123 Seafood St.', 'Los Angeles', 'CA', 'USA', '90001', '555-1234', 'contact@minghong.com', 'domestic'),
(2, 'Azuma Food', '456 Market Blvd.', 'San Francisco', 'CA', 'USA', '94105', '555-5678', 'sales@azumafood.com', 'domestic'),
(3, 'Takakoya', '789 Ocean Rd.', 'San Diego', 'CA', 'USA', '92101', '555-8765', 'info@takakoya.com', 'domestic'),
(4, 'Kikusui', '101 Sake Ave.', 'New York', 'NY', 'USA', '10001', '555-4321', 'support@kikusui.com', 'international'),
(5, 'Yamasa', '202 Soybean St.', 'Chicago', 'IL', 'USA', '60601', '555-8764', 'service@yamasa.com', 'domestic'),
(6, 'Na Food', '303 Brew Lane', 'Seattle', 'WA', 'USA', '98101', '555-5643', 'info@nafood.com', 'international'),
(7, 'UCC', '404 Coffee Rd.', 'Portland', 'OR', 'USA', '97201', '555-9876', 'contact@ucc.com', 'international'),
(8, 'Marukan', '505 Vinegar Way', 'Houston', 'TX', 'USA', '77001', '555-3456', 'sales@marukan.com', 'domestic'),
(9, 'Hime', '606 Seaweed St.', 'Miami', 'FL', 'USA', '33101', '555-6789', 'info@hime.com', 'domestic'),
(10, 'Ito En', '707 Green Tea Blvd.', 'Honolulu', 'HI', 'USA', '96801', '555-4322', 'support@itoen.com', 'international'),
(11, 'Takara USA', '789 Sake Way', 'Berkeley', 'CA', 'USA', '94704', '555-5678', 'info@takarausa.com', 'domestic'), -- Manufacturer of Takara Premium Ginjo and Takara Junmai
(12, 'Seko', '456 Tradition Blvd.', 'Tokyo', 'Tokyo', 'Japan', '100-0001', '555-8765', 'contact@seko.jp', 'international'), -- Manufacturer of Ninja Special Junmai
(13, 'Oceanic Delights', '100 Marine St.', 'Miami', 'FL', 'USA', '33101', '555-0101', 'contact@oceanicdelights.com', 'international'),
(14, 'Pacific Delights', '700 Shoreline Dr.', 'Honolulu', 'HI', 'USA', '96801', '555-0160', 'info@pacificdelights.com', 'domestic');

INSERT INTO Supplier (SupplierID, SupplierName, Street, City, State, Country, ZipCode, SupplierPhone, SupplierEmail, SupplierType)
VALUES 
(1, 'MingHong', '123 Frozen St.', 'Los Angeles', 'CA', 'USA', '90001', '555-0001', 'contact@minghong.com', 'domestic'),
(2, 'Azuma Food', '456 Frozen Ave.', 'San Francisco', 'CA', 'USA', '94105', '555-0010', 'info@azumafood.com', 'domestic'),
(3, 'Takakoya', '789 Seaweed Rd.', 'San Diego', 'CA', 'USA', '92101', '555-0020', 'sales@takakoya.com', 'domestic'),
(4, 'LA Mutual', '101 Mutual Ln.', 'New York', 'NY', 'USA', '10001', '555-0030', 'support@lamutual.com', 'international'),
(5, 'Yamasa', '202 Soy Sauce St.', 'Chicago', 'IL', 'USA', '60601', '555-0040', 'service@yamasa.com', 'domestic'),
(6, 'Na Food', '303 Brewery St.', 'Seattle', 'WA', 'USA', '98101', '555-0050', 'contact@nafood.com', 'international'),
(7, 'Pacific Delights', '700 Shoreline Dr.', 'Honolulu', 'HI', 'USA', '96801', '555-0160', 'info@pacificdelights.com', 'domestic'),
(8, 'Harvest Traditions', '800 Farm Rd.', 'Sacramento', 'CA', 'USA', '95814', '555-0170', 'sales@harvesttraditions.com', 'domestic'),
(9, 'EcoFoods Supply', '900 Eco St.', 'Portland', 'OR', 'USA', '97209', '555-0180', 'service@ecofoodssupply.com', 'international'),
(10, 'Zenith Supply Co.', '1000 Zenith Blvd.', 'Las Vegas', 'NV', 'USA', '89101', '555-0190', 'support@zenithsupply.com', 'domestic'),
(11, 'Oceanic Delights', '100 Marine St.', 'Miami', 'FL', 'USA', '33101', '555-0101', 'contact@oceanicdelights.com', 'international'),
(12, 'Sunrise Trading', '200 Sun St.', 'San Jose', 'CA', 'USA', '95101', '555-0110', 'info@sunrisetrading.com', 'domestic'),
(13, 'Green Hills Produce', '300 Organic Ave.', 'Denver', 'CO', 'USA', '80202', '555-0120', 'sales@greenhillsproduce.com', 'domestic'),
(14, 'Fresh Horizon Foods', '400 Horizon Blvd.', 'Dallas', 'TX', 'USA', '75201', '555-0130', 'service@freshhorizon.com', 'international'),
(15, 'Crystal Waters', '500 Waterfall Rd.', 'New Orleans', 'LA', 'USA', '70112', '555-0140', 'support@crystalwaters.com', 'domestic'),
(16, 'Global Gusto', '600 Global St.', 'Atlanta', 'GA', 'USA', '30301', '555-0150', 'contact@globalgusto.com', 'international'),
(17, 'Takara USA', '789 Sake Way', 'Berkeley', 'CA', 'USA', '94704', '555-5678', 'info@takarausa.com', 'domestic');

INSERT INTO Category (CategoryID, CategoryName)
VALUES 
    (1, 'Frozen Food'),
    (2, 'Seaweed'),
    (3, 'Sake'),
    (4, 'Soy Sauce'),
    (5, 'Beer'),
    (6, 'Soft Drinks'),
    (7, 'Seasoning'),
    (8, 'Snacks'),
    (9, 'Refrigerated Grocery'),
    (10, 'Dry Grocery'),
    (11, 'Bulk Dry Food'),
    (12, 'Hard Liquor'),
    (13, 'Appliances'),
    (14, 'Tableware'),
    (15, 'To-Go Containers'),
    (16, 'Sushi Knives');


INSERT INTO Product (ProductID, ProductName, ManufacturerID, CategoryID, SupplierID)
VALUES 
(1001, 'Smoked Salmon', 1, 1, 1), -- MingHong 1, frozen 1, Minghong 1
(1002, 'Frozen Unagi', 2, 1, 2),  -- Azuma Food 2, frozen 1, Azuma Food 2
(1003, 'Takoyaki', 1, 1, 1), -- MingHong 1, frozen 1, Minghong 1
(2001, 'Nori Sheets Half Cut Green', 3, 2, 3),  -- Takakoya 3, seaweed 2, Takakoya 3
(2002, 'Nori Sheets Half Cut Gold', 3, 2, 3),  -- Takakoya 3, seaweed 2, Takakoya 3            
(4001, 'Kikusui Junmai Ginjo', 4, 3, 4), -- Kikusui 4, sake 3, LA Mutual 4  
(4002, 'Kikusui Perfect Snow', 4, 3, 4), -- Kikusui 4, sake 3, LA Mutual 4  
(5001, 'Yamasa Low Sodium Soy Sauce', 5, 4, 5),    -- Yamasa 5, soy sauce 4, Yamasa 5
(6001, 'Onibi Matcha Cream Stout', 6, 5, 6), -- Na Food 6, beer 5, Na Food 6
(6002, 'UCC Caffe Latte', 7, 6, 4),  -- UCC 7, soft drink 6, LA Mutual 4 
(7001, 'Marukan Seasoned Rice Vinegar', 8, 7, 5), -- Marukan 8, Seasoning 7, Yamasa 5
(8001, 'Hime Dashi Kombu', 9, 2, 3), -- Hime 9, seaweed 2, Takakoya 3
(9001, 'Ito En Unsweetened Green Tea', 10, 6, 4), -- Ito En 10, soft drink 6, LA Mutual 4
(4003, 'Takara Premium Ginjo', 11, 3, 17), -- Takara USA 11, sake 3, Takara USA 17
(4004, 'Takara Junmai', 11, 3, 17),  -- Takara USA 11, sake 3, Takara USA 17
(4005, 'Ninja Special Junmai', 12, 3, 4), -- Seko 12, sake 3, LA Mutual 4   (Seko is international)
(1005, 'Smoked Salmon', 2, 1, 2), -- Azuma Food 2, frozen 1, Azuma Food 2
(1006, 'Smoked Salmon', 14, 1, 7), -- Pacific Delights 7, frozen 1, Pacific Delights 7
(1007, 'Smoked Salmon', 13, 1, 11), -- Oceanic Delights 11, frozen 1, Oceanic Delights 11
(1008, 'Smoked Salmon', 1, 1, 14); -- MingHong 1, frozen 1, Fresh Horizon Foods 14


INSERT INTO ProductUnit (ProductID, Unit, Cost, ListPrice, AvailableQuantity)
VALUES 
-- Smoked Salmon: ProductID 1001
(1001, '500g Pack', 12.50, 15.00, 100),
(1001, '1kg Pack', 24.00, 30.00, 50),

-- Frozen Unagi: ProductID 1002
(1002, '250g Pack', 8.00, 10.00, 200),
(1002, '500g Pack', 15.50, 19.00, 120),

-- Takoyaki: ProductID 1003
(1003, '20 pcs Box', 5.00, 7.00, 300),
(1003, '50 pcs Box', 12.00, 15.00, 150),

-- Nori Sheets Half Cut Green: ProductID 2001
(2001, '50 Sheets', 3.50, 5.00, 400),
(2001, '100 Sheets', 6.50, 9.00, 250),

-- Nori Sheets Half Cut Gold: ProductID 2002
(2002, '50 Sheets', 4.00, 5.50, 350),
(2002, '100 Sheets', 7.50, 10.00, 200),

-- Kikusui Junmai Ginjo: ProductID 4001
(4001, '720ml Bottle', 15.00, 20.00, 80),
(4001, '1.8L Bottle', 35.00, 45.00, 40),

-- Kikusui Perfect Snow: ProductID 4002
(4002, '300ml Bottle', 8.00, 12.00, 120),
(4002, '720ml Bottle', 18.00, 25.00, 60),

-- Yamasa Low Sodium Soy Sauce: ProductID 5001
(5001, '500ml Bottle', 3.00, 4.50, 500),
(5001, '1L Bottle', 5.50, 8.00, 300),

-- Onibi Matcha Cream Stout: ProductID 6001
(6001, '330ml Can', 2.00, 3.50, 400),
(6001, '6-Pack', 11.00, 15.00, 100),

-- UCC Caffe Latte: ProductID 6002
(6002, '200ml Can', 1.50, 2.50, 600),
(6002, '6-Pack', 8.00, 12.00, 200),

-- Marukan Seasoned Rice Vinegar: ProductID 7001
(7001, '500ml Bottle', 2.50, 4.00, 450),
(7001, '1L Bottle', 4.50, 7.00, 200),

-- Hime Dashi Kombu: ProductID 8001
(8001, '100g Pack', 4.00, 6.00, 300),
(8001, '250g Pack', 9.50, 12.00, 150),

-- Ito En Unsweetened Green Tea: ProductID 9001
(9001, '500ml Bottle', 1.20, 2.00, 800),
(9001, '1.5L Bottle', 2.80, 4.00, 400),

-- Takara Premium Ginjo (4003)
(4003, '350ml', 10.50, 15.99, 120), 
(4003, '720ml', 10.50, 15.99, 120), 
(4003, '1.8L', 25.00, 38.99, 60), 

-- Takara Junmai (4004)
(4004, '350ml', 5.50, 8.99, 150), 
(4004, '720ml', 10.00, 14.99, 100), 
(4004, '1.8L', 22.00, 34.99, 50), 
(4004, '18L', 180.00, 259.99, 10), 

-- Ninja Special Junmai (4005)
(4005, '720ml', 12.00, 18.99, 80), 
(4005, '1.8L', 28.00, 44.99, 40),

-- Smoked Salmon: ProductID 1005 (Azuma Food)
(1005, '500g Pack', 12.50, 15.00, 100),
(1005, '1kg Pack', 22.00, 27.50, 50),

-- Smoked Salmon: ProductID 1006 (Pacific Delights) -- Convert lbs to g (1lb = 453.6g)
(1006, '1lb Pack', 12.00, 14.50, 120), -- 1 lb = 453.6g
(1006, '2lb Pack', 21.00, 25.00, 80), -- 2 lb = 907.2g

-- Smoked Salmon: ProductID 1007 (Oceanic Delights) -- Convert lbs to g (1lb = 453.6g)
(1007, '1lb Pack', 13.00, 16.00, 110), -- 1 lb = 453.6g
(1007, '2lb Pack', 23.00, 28.00, 70), -- 2 lb = 907.2g

-- Smoked Salmon: ProductID 1008 (MingHong, supplied by Fresh Horizon Foods)
(1008, '500g Pack', 11.00, 14.00, 150),
(1008, '1kg Pack', 19.00, 24.00, 90);

INSERT INTO Client (ClientID, ClientName, Street, City, State, Country, ZipCode, ClientContact, ClientPhone, ClientEmail, ClientType)
VALUES
(1, 'Sweet Spot', '123 Sweet Ave', 'Sacramento', 'CA', 'USA', '95814', 'John Doe', '916-555-1234', 'sweetspot@gmail.com', 'grocery store'),
(2, 'Bonsai Sushi Fusion', '456 Bonsai Blvd', 'Folsom', 'CA', 'USA', '95630', 'Lisa Tanaka', '916-555-2345', 'bonsaisushi@fusion.com', 'restaurant'),
(3, 'Lao Market', '789 Lao St', 'Elk Grove', 'CA', 'USA', '95758', 'Sam Phan', '916-555-3456', 'laomarket@store.com', 'grocery store'),
(4, 'Raku Ramen', '101 Raku Rd', 'Rocklin', 'CA', 'USA', '95677', 'Ken Nakamura', '916-555-4567', 'rakuramen@ramen.com', 'restaurant'),
(5, 'Tokyo Garden', '202 Tokyo Ln', 'Roseville', 'CA', 'USA', '95678', 'Aya Sato', '916-555-5678', 'tokyogarden@gmail.com', 'restaurant'),
(6, 'Kobe Seafood', '303 Kobe Dr', 'Davis', 'CA', 'USA', '95616', 'Hiro Matsuda', '530-555-6789', 'kobeseafood@gmail.com', 'grocery store'),
(7, 'Hito Yatai', '404 Hito Path', 'Woodland', 'CA', 'USA', '95776', 'Mei Chang', '530-555-7890', 'hitoyatai@gmail.com', 'restaurant'),
(8, 'Mikuni', '505 Mikuni Blvd', 'Sacramento', 'CA', 'USA', '95825', 'Taro Mikuni', '916-555-8901', 'mikuni@fusion.com', 'restaurant'),
(9, 'Kru', '606 Kru Ct', 'Davis', 'CA', 'USA', '95616', 'Katsu Yamada', '530-555-9012', 'kru@cruisine.com', 'restaurant'),
(10, 'Sushi Q', '707 Sushi Cir', 'Elk Grove', 'CA', 'USA', '95757', 'Hana Yoshida', '916-555-0123', 'sushiq@gmail.com', 'restaurant');

INSERT INTO SalesPerson (SalesPersonID, SalesPersonName)
VALUES
(1, 'Alice Johnson'),
(2, 'Bob Smith'),
(3, 'Catherine Lee'),
(4, 'David Brown'),
(5, 'Eva Martinez'),
(6, 'Frank Wilson'),
(7, 'Grace Davis'),
(8, 'Henry Moore'),
(9, 'Ivy Clark'),
(10, 'Jack Robinson');

INSERT INTO SalesOrder (OrderID, ClientID, SalesPersonID, OrderDate, OrderTotal, DeliveryMethod, DeliveryDate)
VALUES
(1, 1, 3, '2024-12-01', 1300.00, 'delivery', '2024-12-05'),
(2, 2, 9, '2024-12-02', 1200.40, 'pickup', '2024-12-04'),
(3, 3, 5, '2024-12-03', 1800.00, 'delivery', '2024-12-06'),
(4, 4, 7, '2024-12-04', 950.00, 'pickup', '2024-12-07'),
(5, 5, 1, '2024-12-05', 1300.50, 'delivery', '2024-12-10'),
(6, 6, 4, '2024-12-06', 1700.75, 'pickup', '2024-12-08'),
(7, 7, 6, '2024-12-07', 2100.30, 'delivery', '2024-12-11'),
(8, 8, 10, '2024-12-08', 800.20, 'pickup', '2024-12-12'),
(9, 9, 2, '2024-12-09', 2500.10, 'delivery', '2024-12-13'),
(10, 10, 8, '2024-12-10', 2800.40, 'pickup', '2024-12-14');


-- Insert 40 rows of order lines with varying number of lines per order
INSERT INTO OrderLine (OrderID, ProductID, Unit, DiscountRate, SoldPrice, PurchaseQuantity, Amount)
VALUES
(1, 1001, '500g Pack', 0.00, 15.00, 2, 30.00),
(1, 1002, '250g Pack', 0.00, 10.00, 10, 100.00),
(1, 2001, '50 Sheets', 10.00, 5.00, 3809, 900.00),
(1, 1003, '50 pcs Box', 10.00, 15.00, 20, 270.00);
