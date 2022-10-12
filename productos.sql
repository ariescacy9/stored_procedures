create table product (
  id serial primary key not null,
  name varchar not null,
  material_id serial,
  category_id serial,
  brand_id serial
);

create table inventory (
  id serial primary key not null,
  product_id serial not null,
  amount_total float
);

 --- procedimiento compra en inventario
 create or replace procedure buy_products(
   products_id int, 
   amount_buy float
)
language plpgsql    
as $$
begin
    -- subtracting the amount from the sender's account 
    update inventory 
    set amount_total  = amount_total  + amount_buy
    where id = products_id;

    commit;
end;$$

--- procedimiento venta en inventario
create or replace procedure sell_products(
  products_id int, 
  amount_sale float
)
language plpgsql    
as $$
begin
    -- adding the amount to the receiver's account
    update inventory
    set amount_total = amount_total - amount_sale
    where id = products_id;

    commit;
end;$$


---drop procedure buy_or_sell;

--- se hace el llamado al procedimiento
call buy_products(1, 50);
call sell_products(1, 23);

--- se verifica que se hicieron los cambios en la tabla inventory del producto con id=1 restando 50 unidades
SELECT * FROM inventory;