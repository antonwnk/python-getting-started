BEGIN;
--
-- Create model Customer
--
CREATE TABLE "hello_customer" ("customerId" serial NOT NULL PRIMARY KEY, "name" varchar(500) NOT NULL, "email" varchar(254) NOT NULL, "hashed_password" varchar(32) NOT NULL, "address" text NOT NULL);
--
-- Create model Order_Items
--
CREATE TABLE "hello_order_items" ("id" serial NOT NULL PRIMARY KEY, "quantity" integer NOT NULL);
--
-- Create model Product
--
CREATE TABLE "hello_product" ("productId" serial NOT NULL PRIMARY KEY, "category" varchar(2) NOT NULL, "price" numeric(8, 2) NOT NULL, "full_name" varchar(500) NOT NULL, "description" text NOT NULL);
--
-- Create model Sale
--
CREATE TABLE "hello_sale" ("saleId" serial NOT NULL PRIMARY KEY, "date" date NOT NULL, "time" time NOT NULL, "order_status" varchar(2) NOT NULL, "customer_id" integer NOT NULL);
--
-- Create model Stock
--
CREATE TABLE "hello_stock" ("id" serial NOT NULL PRIMARY KEY, "quantity" smallint NOT NULL, "product_id" integer NOT NULL);
--
-- Create model Supplier
--
CREATE TABLE "hello_supplier" ("supplierId" serial NOT NULL PRIMARY KEY, "name" varchar(500) NOT NULL);
--
-- Create model Supplier_Contact
--
CREATE TABLE "hello_supplier_contact" ("id" serial NOT NULL PRIMARY KEY, "phone_no" varchar(12) NOT NULL, "address" varchar(500) NOT NULL, "email" varchar(254) NOT NULL, "supplier_id" integer NOT NULL);
--
-- Create model Supplier_Stock
--
CREATE TABLE "hello_supplier_stock" ("id" serial NOT NULL PRIMARY KEY, "quantity" smallint NOT NULL, "product_id" integer NOT NULL, "supplier_id" integer NOT NULL);
--
-- Create model Warehouse
--
CREATE TABLE "hello_warehouse" ("warehouseId" serial NOT NULL PRIMARY KEY, "address" text NOT NULL);
--
-- Add field warehouse to stock
--
ALTER TABLE "hello_stock" ADD COLUMN "warehouse_id" integer NOT NULL;
--
-- Add field product to order_items
--
ALTER TABLE "hello_order_items" ADD COLUMN "product_id" integer NOT NULL;
--
-- Add field sale to order_items
--
ALTER TABLE "hello_order_items" ADD COLUMN "sale_id" integer NOT NULL;
--
-- Add field history to customer
--
CREATE TABLE "hello_customer_history" ("id" serial NOT NULL PRIMARY KEY, "customer_id" integer NOT NULL, "product_id" integer NOT NULL);
ALTER TABLE "hello_sale" ADD CONSTRAINT "hello_sale_customer_id_e793af55_fk_hello_customer_customerId" FOREIGN KEY ("customer_id") REFERENCES "hello_customer" ("customerId") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "hello_sale_customer_id_e793af55" ON "hello_sale" ("customer_id");
ALTER TABLE "hello_stock" ADD CONSTRAINT "hello_stock_product_id_450fe114_fk_hello_product_productId" FOREIGN KEY ("product_id") REFERENCES "hello_product" ("productId") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "hello_stock_product_id_450fe114" ON "hello_stock" ("product_id");
ALTER TABLE "hello_supplier_contact" ADD CONSTRAINT "hello_supplier_conta_supplier_id_66a9ceb6_fk_hello_sup" FOREIGN KEY ("supplier_id") REFERENCES "hello_supplier" ("supplierId") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "hello_supplier_contact_supplier_id_66a9ceb6" ON "hello_supplier_contact" ("supplier_id");
ALTER TABLE "hello_supplier_stock" ADD CONSTRAINT "hello_supplier_stock_product_id_aa980f31_fk_hello_pro" FOREIGN KEY ("product_id") REFERENCES "hello_product" ("productId") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "hello_supplier_stock" ADD CONSTRAINT "hello_supplier_stock_supplier_id_610a946e_fk_hello_sup" FOREIGN KEY ("supplier_id") REFERENCES "hello_supplier" ("supplierId") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "hello_supplier_stock_product_id_aa980f31" ON "hello_supplier_stock" ("product_id");
CREATE INDEX "hello_supplier_stock_supplier_id_610a946e" ON "hello_supplier_stock" ("supplier_id");
CREATE INDEX "hello_stock_warehouse_id_ed07c1df" ON "hello_stock" ("warehouse_id");
ALTER TABLE "hello_stock" ADD CONSTRAINT "hello_stock_warehouse_id_ed07c1df_fk_hello_war" FOREIGN KEY ("warehouse_id") REFERENCES "hello_warehouse" ("warehouseId") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "hello_order_items_product_id_226671d9" ON "hello_order_items" ("product_id");
ALTER TABLE "hello_order_items" ADD CONSTRAINT "hello_order_items_product_id_226671d9_fk_hello_pro" FOREIGN KEY ("product_id") REFERENCES "hello_product" ("productId") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "hello_order_items_sale_id_eee930ce" ON "hello_order_items" ("sale_id");
ALTER TABLE "hello_order_items" ADD CONSTRAINT "hello_order_items_sale_id_eee930ce_fk_hello_sale_saleId" FOREIGN KEY ("sale_id") REFERENCES "hello_sale" ("saleId") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "hello_customer_history" ADD CONSTRAINT "hello_customer_histo_customer_id_b884103d_fk_hello_cus" FOREIGN KEY ("customer_id") REFERENCES "hello_customer" ("customerId") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "hello_customer_history" ADD CONSTRAINT "hello_customer_histo_product_id_85731f57_fk_hello_pro" FOREIGN KEY ("product_id") REFERENCES "hello_product" ("productId") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "hello_customer_history" ADD CONSTRAINT "hello_customer_history_customer_id_product_id_fb0c4c52_uniq" UNIQUE ("customer_id", "product_id");
CREATE INDEX "hello_customer_history_customer_id_b884103d" ON "hello_customer_history" ("customer_id");
CREATE INDEX "hello_customer_history_product_id_85731f57" ON "hello_customer_history" ("product_id");
COMMIT;
