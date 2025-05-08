Problem statement (easy)
You are a data analyst and you are given customers data as follows:


Table-Customers

CustomerID (int): The primary key column for the customers table.
CustomerName (varchar(50)): The first name of the customer.
LastName (varchar(50)): The last name of the customer.
Country (varchar(50)): The country that the customer belongs to.
Age (int): The age of the customer.


Write a SQL query to find out all the details of the customers whose age ranges from 20(inclusive) - 23(inclusive).

ANSWER-

SELECT
    CustomerID,
    CustomerName AS FirstName,
    LastName,
    Country,
    Age
FROM
    Customers
WHERE
    Age >= 20 AND Age <= 23;


SQL

SELECT
    CustomerID,
    CustomerName AS FirstName,
    LastName,
    Country,
    Age
FROM
    Customers
WHERE
    Age >= 20 AND Age <= 23;
Explanation:

SELECT CustomerID, CustomerName AS FirstName, LastName, Country, Age: This specifies the columns you want to retrieve. We select CustomerID, LastName, Country, and Age directly. We also select CustomerName and use the alias AS FirstName to rename this column in the output, as per the hint.
FROM Customers: This indicates that you are querying the Customers table.
WHERE Age >= 20 AND Age <= 23: This is the filtering condition. It selects only those rows where the value in the Age column is greater than or equal to 20 and less than or equal to 23. This ensures that you get the details of customers whose age falls within the specified range (20 to 23, inclusive).


---------------------------------------------------------------------------------------------------------


Problem statement(moderate)
Table: Users

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| user_id        | int     |
| name           | varchar |
+----------------+---------+
user_id is the primary key for this table.
This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.


Write an SQL query to fix the names so that only the first character is uppercase and the rest are lowercase.

Return the result table ordered by user_id.

The query result format is in the following example:



Users table:
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | aLice |
| 2       | bOB   |
+---------+-------+

Result table:
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | Alice |
| 2       | Bob   |
+---------+-------+


ANSWER 

SELECT
    user_id,
    UPPER(SUBSTR(name, 1, 1)) || LOWER(SUBSTR(name, 2)) AS name
FROM
    Users
ORDER BY
    user_id;

The SQL query aims to standardize the name column in the Users table. It selects the user_id and then constructs a modified name. This new name is created by taking the first character of the original name and converting it to uppercase. Subsequently, the remaining characters of the original name, starting from the second, are converted to lowercase, and these two parts are combined to form the final corrected name, which is then aliased as name. The results are finally ordered by the user_id.


----------------------------------------------------------------------------------

Problem statement (HARD)
Table: Stocks

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| stock_name    | varchar |
| operation     | enum    |
| operation_day | int     |
| price         | int     |
+---------------+---------+
(stock_name, operation_day) is the primary key for this table.
The operation column is an ENUM of type ('Sell', 'Buy')
Each row of this table indicates that the stock which has stock_name had an operation on the day operation_day with the price.
It is guaranteed that each 'Sell' operation for a stock has a corresponding 'Buy' operation in a previous day.


Write an SQL query to report the Capital gain/loss for each stock.

The capital gain/loss of a stock is total gain or loss after buying and selling the stock one or many times.

Return the result table in any order.

The query result format is in the following example:



Stocks table:
+---------------+-----------+---------------+--------+
| stock_name    | operation | operation_day | price  |
+---------------+-----------+---------------+--------+
| Leetcode      | Buy       | 1             | 1000   |
| Corona Masks  | Buy       | 2             | 10     |
| Leetcode      | Sell      | 5             | 9000   |
| Handbags      | Buy       | 17            | 30000  |
| Corona Masks  | Sell      | 3             | 1010   |
| Corona Masks  | Buy       | 4             | 1000   |
| Corona Masks  | Sell      | 5             | 500    |
| Corona Masks  | Buy       | 6             | 1000   |
| Handbags      | Sell      | 29            | 7000   |
| Corona Masks  | Sell      | 10            | 10000  |
+---------------+-----------+---------------+--------+

Result table:
+---------------+-------------------+
| stock_name    | capital_gain_loss |
+---------------+-------------------+
| Corona Masks  | 9500              |
| Leetcode      | 8000              |
| Handbags      | -23000            |
+---------------+-------------------+
Leetcode stock was bought at day 1 for 1000$ and was sold at day 5 for 9000$. Capital gain = 9000 - 1000 = 8000$.
Handbags stock was bought at day 17 for 30000$ and was sold at day 29 for 7000$. Capital loss = 7000 - 30000 = -23000$.
Corona Masks stock was bought at day 1 for 10$ and was sold at day 3 for 1010$. It was bought again at day 4 for 1000$ and was sold at day 5 for 500$. At last, it was bought at day 6 for 1000$ and was sold at day 10 for 10000$. Capital gain/loss is the sum of capital gains/losses for each ('Buy' --> 'Sell') operation = (1010 - 10) + (500 - 1000) + (10000 - 1000) = 1000 - 500 + 9000 = 9500$.

ANSWER

WITH BuyOperations AS (
    SELECT
        stock_name,
        operation_day,
        price AS buy_price
    FROM
        Stocks
    WHERE
        operation = 'Buy'
), SellOperations AS (
    SELECT
        stock_name,
        operation_day,
        price AS sell_price
    FROM
        Stocks
    WHERE
        operation = 'Sell'
)
SELECT
    b.stock_name,
    SUM(s.sell_price - b.buy_price) AS capital_gain_loss
FROM
    BuyOperations b
JOIN
    SellOperations s ON b.stock_name = s.stock_name AND s.operation_day > b.operation_day
GROUP BY
    b.stock_name;


expalin
