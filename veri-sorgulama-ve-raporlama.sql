--Veri Sorgulama ve Raporlama
SELECT * FROM Categories 
SELECT * FROM Customers 
SELECT * FROM Addresses 
SELECT * FROM Sellers 
SELECT * FROM Products 
SELECT * FROM Orders 
SELECT * FROM OrderDetails 
SELECT * FROM Payments 
SELECT * FROM Shipments 

--En çok sipariþ veren 5 müþteri
select Top 5 
C.FirstName,C.LASTNAME, COUNT(O.OrderID) AS TOTAL_ORDERS
from Orders O JOIN Customers C ON O.CUSTOMERID=C.CUSTOMERID
GROUP BY C.CUSTOMERID, C.FirstName,C.LASTNAME
ORDER BY TOTAL_ORDERS DESC

--En çok satýlan ürünler.
select P.categoryId, P.productName , SUM(O.Quantity) AS TotalQuantitySold
from Products P Join OrderDetails O on P.categoryId=O.categoryId
GROUP BY P.categoryId, P.productName
Order by TotalQuantitySold desc

-- En yüksek cirosu olan satýcýlar.
SELECT
    S.SellerID,
    S.CompanyName,
    SUM(OD.LineTotal) AS Total
FROM Sellers S JOIN Products P ON S.SellerID = P.SellerID
JOIN orderDetails OD ON P.categoryId = OD.categoryId 
GROUP BY S.SellerID, S.CompanyName
order by Total desc; 

-- Þehirlere göre müþteri sayýsý.
select A.City, Count(C.customerId)
from Addresses A join customers C on  A.CustomerId=C.CustomerId
group by  A.City

-- Kategori bazlý toplam satýþlar.
select c.CategoryName, SUM(OD.Quantity)
from Products P join Categories C on P.categoryId=C.categoryId
join orderDetails OD on OD.categoryId=P.categoryId
Group by c.CategoryName

-- Aylara göre sipariþ sayýsý.
select datename(month, orderdate) as ay_adi,
       month(orderDate) as ay_numarasi,
       count(orderId) as toplam_siparis_sayisi
from orders
group by month(orderdate), datename(month, orderdate)
order by ay_numarasi;

-- Sipariþlerde müþteri bilgisi + ürün bilgisi + satýcý bilgisi.
select 
    o.OrderID,
    o.OrderDate,
    c.FirstName,
    c.LastName,
    c.Email as CustomerEmail,
    p.ProductName,
    p.Brand,
    p.Price,
    od.Quantity,
    s.CompanyName as SellerName,
    s.Email as SellerEmail
from Orders o
join Customers c on o.CustomerID = c.CustomerID
join OrderDetails od on o.OrderID = od.OrderID
join Products p on od.categoryId = p.categoryId
join Sellers s on p.SellerID = s.SellerID
order by o.OrderID;



-- Hiç satýlmamýþ ürünler.
select p.productname
from products p
where p.categoryId not in (
    select od.categoryId
    from orderdetails od
);

-- Hiç sipariþ vermemiþ müþteriler.
select FirstName,LastName
from customers
where customerId not in(
select CustomerId
from Orders)

-- En çok kazanç saðlayan ilk 3 kategori.
select top 3 c.categoryname, sum(od.linetotal) as toplamciro
from categories c
join products p on c.categoryId = p.categoryId  
join orderdetails od on p.productId = od.productId 
group by c.categoryname
order by toplamciro desc

-- Ortalama sipariþ tutarýný geçen sipariþleri bul.
select o.orderId 
from orders o
where o.totalamount > (
        select avg(totalamount)
        from orders)
