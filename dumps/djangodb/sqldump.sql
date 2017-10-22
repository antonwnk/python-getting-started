BEGIN;
--
-- Create model Customer
--
CREATE TABLE "hello_customer" (
  "customerId"      SERIAL       NOT NULL PRIMARY KEY,
  "name"            VARCHAR(50)  NOT NULL,
  "email"           VARCHAR(254) NOT NULL,
  "hashed_password" VARCHAR(32)  NOT NULL,
  "address"         TEXT         NOT NULL
);
--
-- Create model Order_Items
--
CREATE TABLE "hello_order_items" (
  "id"       SERIAL   NOT NULL PRIMARY KEY,
  "quantity" SMALLINT NOT NULL
);
--
-- Create model Product
--
CREATE TABLE "hello_product" (
  "productId"   SERIAL      NOT NULL PRIMARY KEY,
  "category"    VARCHAR(2)  NOT NULL,
  "price"       DECIMAL     NOT NULL,
  "full_name"   VARCHAR(50) NOT NULL,
  "description" TEXT        NOT NULL
);
--
-- Create model Sale
--
CREATE TABLE "hello_sale" (
  "saleId"       SERIAL     NOT NULL PRIMARY KEY,
  "date"         DATE       NOT NULL,
  "time"         TIME       NOT NULL,
  "order_status" VARCHAR(2) NOT NULL,
  "customer_id"  INTEGER    NOT NULL REFERENCES "hello_customer" ("customerId")
);
--
-- Create model Stock
--
CREATE TABLE "hello_stock" (
  "id"         SERIAL   NOT NULL PRIMARY KEY,
  "quantity"   SMALLINT NOT NULL,
  "product_id" INTEGER  NOT NULL REFERENCES "hello_product" ("productId")
);
--
-- Create model Supplier
--
CREATE TABLE "hello_supplier" (
  "supplierId" SERIAL      NOT NULL PRIMARY KEY,
  "name"       VARCHAR(20) NOT NULL
);
--
-- Create model Supplier_Contact
--
CREATE TABLE "hello_supplier_contact" (
  "id"          SERIAL      NOT NULL PRIMARY KEY,
  "phone_no"    VARCHAR(12) NOT NULL,
  "address"     VARCHAR(50) NOT NULL,
  "email"       VARCHAR(25) NOT NULL,
  "supplier_id" INTEGER     NOT NULL REFERENCES "hello_supplier" ("supplierId")
);
--
-- Create model Supplier_Stock
--
CREATE TABLE "hello_supplier_stock" (
  "id"          SERIAL   NOT NULL PRIMARY KEY,
  "quantity"    SMALLINT NOT NULL,
  "product_id"  INTEGER  NOT NULL REFERENCES "hello_product" ("productId"),
  "supplier_id" INTEGER  NOT NULL REFERENCES "hello_supplier" ("supplierId")
);
--
-- Create model Warehouse
--
CREATE TABLE "hello_warehouse" (
  "warehouseId" SERIAL NOT NULL PRIMARY KEY,
  "address"     TEXT   NOT NULL
);
--
-- Add field warehouse to stock
--
ALTER TABLE "hello_stock"
  RENAME TO "hello_stock__old";
CREATE TABLE "hello_stock" (
  "id"           SERIAL   NOT NULL PRIMARY KEY,
  "quantity"     SMALLINT NOT NULL,
  "product_id"   INTEGER  NOT NULL REFERENCES "hello_product" ("productId"),
  "warehouse_id" INTEGER  NOT NULL REFERENCES "hello_warehouse" ("warehouseId")
);
INSERT INTO "hello_stock" ("id", "quantity", "product_id", "warehouse_id") SELECT
                                                                             "id",
                                                                             "quantity",
                                                                             "product_id",
                                                                             NULL
                                                                           FROM "hello_stock__old";
DROP TABLE "hello_stock__old";
CREATE INDEX "hello_sale_customer_id_e793af55"
  ON "hello_sale" ("customer_id");
CREATE INDEX "hello_supplier_contact_supplier_id_66a9ceb6"
  ON "hello_supplier_contact" ("supplier_id");
CREATE INDEX "hello_supplier_stock_product_id_aa980f31"
  ON "hello_supplier_stock" ("product_id");
CREATE INDEX "hello_supplier_stock_supplier_id_610a946e"
  ON "hello_supplier_stock" ("supplier_id");
CREATE INDEX "hello_stock_product_id_450fe114"
  ON "hello_stock" ("product_id");
CREATE INDEX "hello_stock_warehouse_id_ed07c1df"
  ON "hello_stock" ("warehouse_id");
--
-- Add field product to order_items
--
ALTER TABLE "hello_order_items"
  RENAME TO "hello_order_items__old";
CREATE TABLE "hello_order_items" (
  "id"         SERIAL   NOT NULL PRIMARY KEY,
  "quantity"   SMALLINT NOT NULL,
  "product_id" INTEGER  NOT NULL REFERENCES "hello_product" ("productId")
);
INSERT INTO "hello_order_items" ("id", "quantity", "product_id") SELECT
                                                                   "id",
                                                                   "quantity",
                                                                   NULL
                                                                 FROM "hello_order_items__old";
DROP TABLE "hello_order_items__old";
CREATE INDEX "hello_order_items_product_id_226671d9"
  ON "hello_order_items" ("product_id");
--
-- Add field sale to order_items
--
ALTER TABLE "hello_order_items"
  RENAME TO "hello_order_items__old";
CREATE TABLE "hello_order_items" (
  "id"         SERIAL   NOT NULL PRIMARY KEY,
  "quantity"   SMALLINT NOT NULL,
  "product_id" INTEGER  NOT NULL REFERENCES "hello_product" ("productId"),
  "sale_id"    INTEGER  NOT NULL REFERENCES "hello_sale" ("saleId")
);
INSERT INTO "hello_order_items" ("id", "quantity", "product_id", "sale_id") SELECT
                                                                              "id",
                                                                              "quantity",
                                                                              "product_id",
                                                                              NULL
                                                                            FROM "hello_order_items__old";
DROP TABLE "hello_order_items__old";
CREATE INDEX "hello_order_items_product_id_226671d9"
  ON "hello_order_items" ("product_id");
CREATE INDEX "hello_order_items_sale_id_eee930ce"
  ON "hello_order_items" ("sale_id");
--
-- Add field history to customer
--
CREATE TABLE "hello_customer_history" (
  "id"          SERIAL  NOT NULL PRIMARY KEY,
  "customer_id" INTEGER NOT NULL REFERENCES "hello_customer" ("customerId"),
  "product_id"  INTEGER NOT NULL REFERENCES "hello_product" ("productId")
);
CREATE UNIQUE INDEX "hello_customer_history_customer_id_product_id_fb0c4c52_uniq"
  ON "hello_customer_history" ("customer_id", "product_id");
CREATE INDEX "hello_customer_history_customer_id_b884103d"
  ON "hello_customer_history" ("customer_id");
CREATE INDEX "hello_customer_history_product_id_85731f57"
  ON "hello_customer_history" ("product_id");
COMMIT;
