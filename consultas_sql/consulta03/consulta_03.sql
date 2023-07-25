-- consulta SQL para mostrar os 10 produtos mais caros
select product_name produto, unit_price preco
from products
order by unit_price desc limit 10
