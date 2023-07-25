-- consulta SQL para comparar os totais de vendas de fornecedores em 2020 e 2021 e mostrar a diferença
-- primeiro, cria-se a CTE (Common Table Expression) "for2020" que calcula o total de vendas de cada fornecedor em 2020
with for2020 as(
    select sup.supplier_id id, sup.company_name fornecedor, sum(od.unit_price * od.quantity) total_2020 from order_details od
    inner join products p on (p.product_id = od.product_id)
    inner join suppliers sup on (sup.supplier_id = p.supplier_id)
    inner join orders o on (o.order_id = od.order_id)
    where DATE_PART(year, o.order_date) = 2020
    group by id, fornecedor
-- Em seguida, cria-se a CTE "for2021" que calcula o total de vendas de cada fornecedor em 2021.
), for2021 as (
    select sup.supplier_id id, sup.company_name fornecedor, sum(od.unit_price * od.quantity) total_2021 from order_details od
    inner join products p on (p.product_id = od.product_id)
    inner join suppliers sup on (sup.supplier_id = p.supplier_id)
    inner join orders o on (o.order_id = od.order_id)
    where DATE_PART(year, o.order_date) = 2021
    group by id, fornecedor
-- Depois, cria-se a CTE "ambos" que junta os dados de "for2020" e "for2021" para comparar os totais de vendas.
), ambos as (
    select for2021.id, for2020.fornecedor, total_2020, total_2021, total_2021 - total_2020 resultado from for2020
    inner join for2021 on (for2020.id = for2021.id)
    order by resultado desc
)
    select * from ambos