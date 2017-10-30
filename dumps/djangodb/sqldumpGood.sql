BEGIN;
--
-- Create table Customer
--
CREATE TABLE "hello_customer" (
  "customerId"      SERIAL       NOT NULL PRIMARY KEY,
  "name"            VARCHAR(500) NOT NULL,
  "email"           VARCHAR(254) NOT NULL,
  "hashed_password" VARCHAR(32)  NOT NULL,
  "address"         TEXT         NOT NULL
);
--
-- Create table Order_Items
--
CREATE TABLE "hello_order_items" (
  "id"       SERIAL  NOT NULL PRIMARY KEY,
  "quantity" INTEGER NOT NULL
);
--
-- Create table Product
--
CREATE TABLE "hello_product" (
  "productId"   SERIAL        NOT NULL PRIMARY KEY,
  "category"    VARCHAR(2)    NOT NULL,
  "price"       NUMERIC(8, 2) NOT NULL,
  "full_name"   VARCHAR(500)  NOT NULL,
  "description" TEXT          NOT NULL
);
--
-- Create table Sale
--
CREATE TABLE "hello_sale" (
  "saleId"       SERIAL     NOT NULL PRIMARY KEY,
  "date"         DATE       NOT NULL,
  "time"         TIME       NOT NULL,
  "order_status" VARCHAR(2) NOT NULL,
  "customer_id"  INTEGER    NOT NULL
);
--
-- Create table Stock
--
CREATE TABLE "hello_stock" (
  "id"         SERIAL   NOT NULL PRIMARY KEY,
  "quantity"   SMALLINT NOT NULL,
  "product_id" INTEGER  NOT NULL
);
--
-- Create table Supplier
--
CREATE TABLE "hello_supplier" (
  "supplierId" SERIAL       NOT NULL PRIMARY KEY,
  "name"       VARCHAR(500) NOT NULL
);
--
-- Create table Supplier_Contact
--
CREATE TABLE "hello_supplier_contact" (
  "id"          SERIAL       NOT NULL PRIMARY KEY,
  "phone_no"    VARCHAR(12)  NOT NULL,
  "address"     VARCHAR(500) NOT NULL,
  "email"       VARCHAR(254) NOT NULL,
  "supplier_id" INTEGER      NOT NULL
);
--
-- Create table Supplier_Stock
--
CREATE TABLE "hello_supplier_stock" (
  "id"          SERIAL   NOT NULL PRIMARY KEY,
  "quantity"    SMALLINT NOT NULL,
  "product_id"  INTEGER  NOT NULL,
  "supplier_id" INTEGER  NOT NULL
);
--
-- Create table Warehouse
--
CREATE TABLE "hello_warehouse" (
  "warehouseId" SERIAL NOT NULL PRIMARY KEY,
  "address"     TEXT   NOT NULL
);
--
-- Add field warehouse to stock
--
ALTER TABLE "hello_stock"
  ADD COLUMN "warehouse_id" INTEGER NOT NULL;
--
-- Add field product to order_items
--
ALTER TABLE "hello_order_items"
  ADD COLUMN "product_id" INTEGER NOT NULL;
--
-- Add field sale to order_items
--
ALTER TABLE "hello_order_items"
  ADD COLUMN "sale_id" INTEGER NOT NULL;
--
-- Add field history to customer
--
CREATE TABLE "hello_customer_history" (
  "id"          SERIAL  NOT NULL PRIMARY KEY,
  "customer_id" INTEGER NOT NULL,
  "product_id"  INTEGER NOT NULL
);
ALTER TABLE "hello_sale"
  ADD CONSTRAINT "hello_sale_customer_id_e793af55_fk_hello_customer_customerId" FOREIGN KEY ("customer_id") REFERENCES "hello_customer" ("customerId")
  DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "hello_sale_customer_id_e793af55"
  ON "hello_sale" ("customer_id");
ALTER TABLE "hello_stock"
  ADD CONSTRAINT "hello_stock_product_id_450fe114_fk_hello_product_productId" FOREIGN KEY ("product_id") REFERENCES "hello_product" ("productId")
  DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "hello_stock_product_id_450fe114"
  ON "hello_stock" ("product_id");
ALTER TABLE "hello_supplier_contact"
  ADD CONSTRAINT "hello_supplier_conta_supplier_id_66a9ceb6_fk_hello_sup" FOREIGN KEY ("supplier_id") REFERENCES "hello_supplier" ("supplierId")
  DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "hello_supplier_contact_supplier_id_66a9ceb6"
  ON "hello_supplier_contact" ("supplier_id");
ALTER TABLE "hello_supplier_stock"
  ADD CONSTRAINT "hello_supplier_stock_product_id_aa980f31_fk_hello_pro" FOREIGN KEY ("product_id") REFERENCES "hello_product" ("productId")
  DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "hello_supplier_stock"
  ADD CONSTRAINT "hello_supplier_stock_supplier_id_610a946e_fk_hello_sup" FOREIGN KEY ("supplier_id") REFERENCES "hello_supplier" ("supplierId")
  DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "hello_supplier_stock_product_id_aa980f31"
  ON "hello_supplier_stock" ("product_id");
CREATE INDEX "hello_supplier_stock_supplier_id_610a946e"
  ON "hello_supplier_stock" ("supplier_id");
CREATE INDEX "hello_stock_warehouse_id_ed07c1df"
  ON "hello_stock" ("warehouse_id");
ALTER TABLE "hello_stock"
  ADD CONSTRAINT "hello_stock_warehouse_id_ed07c1df_fk_hello_war" FOREIGN KEY ("warehouse_id") REFERENCES "hello_warehouse" ("warehouseId")
  DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "hello_order_items_product_id_226671d9"
  ON "hello_order_items" ("product_id");
ALTER TABLE "hello_order_items"
  ADD CONSTRAINT "hello_order_items_product_id_226671d9_fk_hello_pro" FOREIGN KEY ("product_id") REFERENCES "hello_product" ("productId")
  DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "hello_order_items_sale_id_eee930ce"
  ON "hello_order_items" ("sale_id");
ALTER TABLE "hello_order_items"
  ADD CONSTRAINT "hello_order_items_sale_id_eee930ce_fk_hello_sale_saleId" FOREIGN KEY ("sale_id") REFERENCES "hello_sale" ("saleId")
  DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "hello_customer_history"
  ADD CONSTRAINT "hello_customer_histo_customer_id_b884103d_fk_hello_cus" FOREIGN KEY ("customer_id") REFERENCES "hello_customer" ("customerId")
  DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "hello_customer_history"
  ADD CONSTRAINT "hello_customer_histo_product_id_85731f57_fk_hello_pro" FOREIGN KEY ("product_id") REFERENCES "hello_product" ("productId")
  DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "hello_customer_history"
  ADD CONSTRAINT "hello_customer_history_customer_id_product_id_fb0c4c52_uniq" UNIQUE ("customer_id", "product_id");
CREATE INDEX "hello_customer_history_customer_id_b884103d"
  ON "hello_customer_history" ("customer_id");
CREATE INDEX "hello_customer_history_product_id_85731f57"
  ON "hello_customer_history" ("product_id");
COMMIT;
