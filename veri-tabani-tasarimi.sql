--Veri Tabaný Tasarýmý

--Kategoriler tablosu oluþturuldu.
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1), -- Otomatik artýþ
    CategoryName VARCHAR(100) NOT NULL
  
);

--Adresler tablosu oluþturuldu.
CREATE TABLE Addresses (
    AddressID INT PRIMARY KEY IDENTITY(1,1), -- Otomatik artýþ
    CustomerID INT NULL,
    Title VARCHAR(50) NOT NULL,
    AddressLine1 VARCHAR(255) NOT NULL,
    AddressLine2 VARCHAR(255) NULL,
    PostalCode VARCHAR(10) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL
);

--Müþteri/kullanýcý tablosu oluþturuldu.
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1), -- Otomatik artýþ
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20) NULL,
    PasswordHash VARCHAR(255) NOT NULL, 
    Gender CHAR(1) NULL CHECK (Gender IN ('M','F','O')), -- M: Male, F: Female, O: Other
    RegistrationDate DATETIME DEFAULT GETDATE()  
);

--Satýcýlar tablosu oluþturuldu.
CREATE TABLE Sellers (
    SellerID INT PRIMARY KEY IDENTITY(1,1), -- Otomatik artýþ
    CompanyName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    TaxNumber VARCHAR(50) UNIQUE NOT NULL,
    MainAddressID INT NULL,
    FOREIGN KEY (MainAddressID) REFERENCES Addresses(AddressID)
);

--Ürünler tablosu oluþturuldu.
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1), -- Otomatik artýþ
    SellerID INT NOT NULL,
    CategoryID INT NOT NULL,
    ProductName VARCHAR(255) NOT NULL,
    Brand VARCHAR(100) NULL,
    Description TEXT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT NOT NULL DEFAULT 0,
    AddedDate DATETIME DEFAULT GETDATE(),  
    IsActive BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (SellerID) REFERENCES Sellers(SellerID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

--Sipariþler tablosu oluþturuldu.
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),  
    TotalAmount DECIMAL(10, 2) NOT NULL,
    OrderStatus VARCHAR(50) NOT NULL,
    ShippingAddressID INT NOT NULL,
    BillingAddressID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ShippingAddressID) REFERENCES Addresses(AddressID),
    FOREIGN KEY (BillingAddressID) REFERENCES Addresses(AddressID)
);

--Sipariþ detaylarý tablosu oluþturuldu.
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    LineTotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

--Ödeme tablosu oluþturuldu.
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    PaymentDate DATETIME DEFAULT GETDATE(),  
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    TransactionStatus VARCHAR(50) NOT NULL,
    TransactionCode VARCHAR(100) NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

--Kargolar tablosu oluþturuldu.
CREATE TABLE Shipments (
    ShipmentID INT PRIMARY KEY IDENTITY(1,1), 
    OrderID INT NOT NULL UNIQUE,
    TrackingNumber VARCHAR(100) UNIQUE NOT NULL,
    ShipperName VARCHAR(100) NOT NULL,
    ShipmentDate DATETIME DEFAULT GETDATE(),  
    EstimatedDeliveryDate DATE NULL,
    ShipmentStatus VARCHAR(50) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
 