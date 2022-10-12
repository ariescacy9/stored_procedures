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

--- procedimiento venta en inventario
create or replace procedure buy_or_sell(
  products_id int, 
  amount_buy float,
  amount_sale float
)
language plpgsql    
as $$
begin
  -- se aumenta una cantidad si se compran mas unidades del producto en inventario
  update inventory 
  set amount_total  = amount_total  + amount_buy
  where id = products_id;

  -- ase disminuye una cantidad si se venden las unidades del producto en inventario
  update inventory
  set amount_total = amount_total - amount_sale
  where id = products_id;

    commit;
end;$$

--- se hace el llamado al procedimiento
call buy_or_sell(1, 0, 50);

--- se verifica que se hicieron los cambios en la tabla inventory del producto con id=1 restando 50 unidades
SELECT * FROM inventory;