-- consulta SQL para obter as cinco principais categorias de produtos com o maior total de vendas por ano
with result as (
    select c.category_name categoria, DATE_PART(year, o.order_date) ano,
    sum(od.unit_price * od.quantity - od.discount) total
    , row_number() over (partition by ano order by ano, total desc) as res
    from categories c
    inner join products p on (c.category_id = p.category_id)
    inner join order_details od on (p.product_id = od.product_id)
    inner join orders o on (o.order_id = od.order_id)
    group by categoria, ano
    order by ano, total desc
),
filtro as (
    select * from result where res <=5
)
select categoria, ano, total, res from filtro