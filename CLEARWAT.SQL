DROP TABLE ORDERLINE;
DROP TABLE SHIPPING;
DROP TABLE CUST_ORDER;
DROP TABLE ORDERSOURCE;
DROP TABLE CUSTOMER;
DROP TABLE BACKORDER;
DROP TABLE INVENTORY;
DROP TABLE COLOR;
DROP TABLE ITEM;

CREATE TABLE customer
(custid NUMBER(5) CONSTRAINT customer_custid_pk PRIMARY KEY,
last VARCHAR2(30) CONSTRAINT customer_last_nn NOT NULL,
first VARCHAR2(30),
mi CHAR(1),
cadd VARCHAR2(30),
city VARCHAR2(30),
state CHAR(2),
zip VARCHAR2(10),
dphone VARCHAR2(10),
ephone VARCHAR2(10));

CREATE TABLE ordersource
(ordersource VARCHAR2(20) CONSTRAINT ordersource_ordersource_pk PRIMARY KEY);

CREATE TABLE cust_order
(orderid NUMBER(8) CONSTRAINT cust_order_orderid_pk PRIMARY KEY,
orderdate DATE CONSTRAINT cust_order_orderdate_nn NOT NULL,
methpmt VARCHAR2(10) CONSTRAINT cust_order_methpmt_nn NOT NULL,
custid NUMBER(5) CONSTRAINT cust_order_custid_fk
       REFERENCES customer(custid),
ordersource VARCHAR2(20) CONSTRAINT cust_order_ordersource_fk
       REFERENCES ordersource(ordersource));

CREATE TABLE item
(itemid NUMBER(8) CONSTRAINT item_itemid_pk PRIMARY KEY,
itemdesc VARCHAR2(100) CONSTRAINT item_desc_nn NOT NULL,
category VARCHAR2(25) CONSTRAINT item_category_nn NOT NULL);

CREATE TABLE color
(color VARCHAR2(20) CONSTRAINT color_color_pk PRIMARY KEY);

CREATE TABLE inventory
(invid NUMBER(10) CONSTRAINT inventory_invid_pk PRIMARY KEY,
itemid NUMBER(8) CONSTRAINT inventory_itemid_fk 
	REFERENCES item(itemid) CONSTRAINT inventory_itemid_nn NOT NULL,
itemsize VARCHAR2(10),
color VARCHAR2(20) CONSTRAINT inventory_color_fk REFERENCES color(color),
curr_price NUMBER(6,2) CONSTRAINT inventory_curr_price_nn NOT NULL,
qoh NUMBER(4) CONSTRAINT inventory_qoh_nn NOT NULL);

CREATE TABLE shipping (
shipid NUMBER(10) CONSTRAINT shipping_shipid_nn NOT NULL,
invid NUMBER(10) CONSTRAINT shipping_invid_fk REFERENCES INVENTORY(INVID), 
date_expected DATE CONSTRAINT shipping_date_expected_nn NOT NULL, 
quantity_expected NUMBER(4) CONSTRAINT shipping_quantity_expected_nn NOT NULL, 
date_received DATE NULL, 
quantity_received NUMBER(4) NULL,  
PRIMARY KEY (shipid, invid));

CREATE TABLE backorder (
backorderid NUMBER(10) CONSTRAINT backorder_backorderid_pk PRIMARY KEY, 
shipid NUMBER(10) CONSTRAINT backorder_shipid_nn NOT NULL,
invid NUMBER(10) CONSTRAINT backorder_invid_fk REFERENCES INVENTORY (invid)
CONSTRAINT backorder_invid_nn NOT NULL, 
date_expected DATE CONSTRAINT backorder_date_expected_nn NOT NULL, 
quantity_expected NUMBER(4) CONSTRAINT backorder_quantity_expected_nn NOT NULL, 
date_received DATE NULL, 
quantity_received Number(4) NULL);

CREATE TABLE  orderline (
orderid NUMBER(8) NOT NULL, 
invid NUMBER(10) NOT NULL, 
order_price NUMBER(6,2) NOT NULL, 
quantity NUMBER(4) NOT NULL,  
CONSTRAINT orderline_pk PRIMARY KEY (orderid, invid),  
CONSTRAINT orderline_orderid_fk FOREIGN KEY (orderid) REFERENCES CUST_ORDER(ORDERID),
CONSTRAINT orderline_invid_fk FOREIGN KEY (invid) REFERENCES INVENTORY(INVID));

--- inserting records into CUSTOMER
INSERT INTO CUSTOMER VALUES
(107, 'Harris', 'Paula', 'E', '1156 Water Street, Apt. #3', 'Osseo', 'WI', 
'54705', '7155558943', '7155559035');

INSERT INTO CUSTOMER VALUES
(232, 'Edwards', 'Mitch', 'M', '4204 Garner Street', 'Washburn', 'WI', 
'54891', '7155558243', '7155556975');

INSERT INTO CUSTOMER VALUES
(133, 'Garcia', 'Maria', 'H', '2211 Pine Drive', 'Radisson', 'WI', 
'54867', '7155558332', '7155558332');

INSERT INTO CUSTOMER VALUES
(154, 'Miller', 'Lee', NULL, '699 Pluto St. NW', 'Silver Lake', 'WI', 
'53821', '7155554978', '7155559002');

INSERT INTO CUSTOMER VALUES
(179, 'Chang', 'Alissa', 'R', '987 Durham Rd.', 'Sister Bay', 'WI', 
'54234', '7155557651', '7155550087');

--- inserting records into ITEM
INSERT INTO item VALUES
(894, 'Women''s Hiking Shorts', 'Women''s Clothing');

INSERT INTO item VALUES
(897, 'Women''s Fleece Pullover', 'Women''s Clothing');

INSERT INTO item VALUES
(995, 'Children''s Beachcomber Sandals', 'Children''s Clothing');

INSERT INTO item VALUES
(559, 'Men''s Expedition Parka', 'Men''s Clothing');

INSERT INTO item VALUES
(786, '3-Season Tent', 'Outdoor Gear');

--- inserting records into ORDERSOURCE
INSERT INTO ordersource VALUES ('99');
INSERT INTO ordersource VALUES ('122');
INSERT INTO ordersource VALUES ('123');
INSERT INTO ordersource VALUES ('145');
INSERT INTO ordersource VALUES ('146');
INSERT INTO ordersource VALUES ('151');
INSERT INTO ordersource VALUES ('152');
INSERT INTO ordersource VALUES ('153');
INSERT INTO ordersource VALUES ('211');
INSERT INTO ordersource VALUES ('WEBSITE');


--- inserting records into ORDER
INSERT INTO cust_order VALUES
(1057, TO_DATE('05/29/2001', 'MM/DD/YYYY'), 'CC', 107, '152');

INSERT INTO cust_order VALUES
(1058, TO_DATE('05/29/2001', 'MM/DD/YYYY'), 'CC', 232, 'WEBSITE');

INSERT INTO cust_order VALUES
(1059, TO_DATE('05/31/2001', 'MM/DD/YYYY'), 'CHECK', 133, '152');

INSERT INTO cust_order VALUES
(1060, TO_DATE('05/31/2001', 'MM/DD/YYYY'), 'CC', 154, '153');

INSERT INTO cust_order VALUES
(1061, TO_DATE('06/01/2001', 'MM/DD/YYYY'), 'CC', 179, 'WEBSITE');

INSERT INTO cust_order VALUES
(1062, TO_DATE('06/01/2001', 'MM/DD/YYYY'), 'CC', 179, 'WEBSITE');

--- inserting records into COLOR
INSERT INTO color VALUES ('Sienna');
INSERT INTO color VALUES ('Forest');
INSERT INTO color VALUES ('Khaki');
INSERT INTO color VALUES ('Olive');
INSERT INTO color VALUES ('Teal');
INSERT INTO color VALUES ('Coral');
INSERT INTO color VALUES ('Blue');
INSERT INTO color VALUES ('Red');
INSERT INTO color VALUES ('Navy');
INSERT INTO color VALUES ('Brown');

--- inserting records into INVENTORY
INSERT INTO inventory VALUES
(11668, 786, NULL, 'Sienna', 259.99, 16);

INSERT INTO inventory VALUES
(11669, 786, NULL, 'Forest', 259.99, 12);

INSERT INTO inventory VALUES
(11775, 894, 'S', 'Khaki', 29.95, 150);

INSERT INTO inventory VALUES
(11776, 894, 'M', 'Khaki', 29.95, 147);

INSERT INTO inventory VALUES
(11777, 894, 'L', 'Khaki', 29.95, 0);

INSERT INTO inventory VALUES
(11778, 894, 'S', 'Olive', 29.95, 139);

INSERT INTO inventory VALUES
(11779, 894, 'M', 'Olive', 29.95, 137);

INSERT INTO inventory VALUES
(11780, 894, 'L', 'Olive', 29.95, 115);

INSERT INTO inventory VALUES
(11795, 897, 'S', 'Teal', 59.95, 135);

INSERT INTO inventory VALUES
(11796, 897, 'M', 'Teal', 59.95, 168);

INSERT INTO inventory VALUES
(11797, 897, 'L', 'Teal', 59.95, 187);

INSERT INTO inventory VALUES
(11798, 897, 'S', 'Coral', 59.95, 0);

INSERT INTO inventory VALUES
(11799, 897, 'M', 'Coral', 59.95, 124);

INSERT INTO inventory VALUES
(11800, 897, 'L', 'Coral', 59.95, 112);

INSERT INTO inventory VALUES
(11820, 995, '10', 'Blue', 15.99, 121);

INSERT INTO inventory VALUES
(11821, 995, '11', 'Blue', 15.99, 111);

INSERT INTO inventory VALUES
(11822, 995, '12', 'Blue', 15.99, 113);

INSERT INTO inventory VALUES
(11823, 995, '1', 'Blue', 15.99, 121);

INSERT INTO inventory VALUES
(11824, 995, '10', 'Red', 15.99, 148);

INSERT INTO inventory VALUES
(11825, 995, '11', 'Red', 15.99, 137);

INSERT INTO inventory VALUES
(11826, 995, '12', 'Red', 15.99, 134);

INSERT INTO inventory VALUES
(11827, 995, '1', 'Red', 15.99, 123);

INSERT INTO inventory VALUES
(11845, 559, 'S', 'Navy', 199.95, 114);

INSERT INTO inventory VALUES
(11846, 559, 'M', 'Navy', 199.95, 17);

INSERT INTO inventory VALUES
(11847, 559, 'L', 'Navy', 209.95, 0);

INSERT INTO inventory VALUES
(11848, 559, 'XL', 'Navy', 209.95, 12);

--- inserting records into SHIPPING
INSERT INTO shipping VALUES
(211, 11668, TO_DATE('09/15/2001', 'MM/DD/YYYY'), 25, NULL, NULL);

INSERT INTO shipping VALUES
(211, 11669, TO_DATE('09/15/2001', 'MM/DD/YYYY'), 25, NULL, NULL);

INSERT INTO shipping VALUES
(212, 11669, TO_DATE('11/15/2001', 'MM/DD/YYYY'), 25, NULL, NULL);

INSERT INTO shipping VALUES
(213, 11777, TO_DATE('06/25/2001', 'MM/DD/YYYY'), 200, NULL, NULL);

INSERT INTO shipping VALUES
(214, 11778, TO_DATE('09/25/2001', 'MM/DD/YYYY'), 200, NULL, NULL);

INSERT INTO shipping VALUES
(214, 11779, TO_DATE('09/25/2001', 'MM/DD/YYYY'), 200, NULL, NULL);

INSERT INTO shipping VALUES
(215, 11798, TO_DATE('08/15/2001', 'MM/DD/YYYY'), 100, NULL, NULL);

INSERT INTO shipping VALUES
(215, 11799, TO_DATE('08/15/2001', 'MM/DD/YYYY'), 100, NULL, NULL);

INSERT INTO shipping VALUES
(216, 11799, TO_DATE('09/25/2001', 'MM/DD/YYYY'), 100, 
TO_DATE('08/25/2001', 'MM/DD/YYYY'), 0);

INSERT INTO shipping VALUES
(217, 11800, TO_DATE('08/15/2001', 'MM/DD/YYYY'), 100, NULL, NULL);

INSERT INTO shipping VALUES
(218, 11845, TO_DATE('08/12/2001', 'MM/DD/YYYY'), 50, 
TO_DATE('08/15/2001', 'MM/DD/YYYY'), 0);

INSERT INTO shipping VALUES
(218, 11846, TO_DATE('08/12/2001', 'MM/DD/YYYY'), 100, 
TO_DATE('08/15/2001', 'MM/DD/YYYY'), 100);

INSERT INTO shipping VALUES
(218, 11847, TO_DATE('08/12/2001', 'MM/DD/YYYY'), 100, 
TO_DATE('08/15/2001', 'MM/DD/YYYY'), 50);

INSERT INTO shipping VALUES
(218, 11848, TO_DATE('08/12/2001', 'MM/DD/YYYY'), 50, 
TO_DATE('08/15/2001', 'MM/DD/YYYY'), 50);

--inserting into BACKORDER
INSERT INTO backorder VALUES
(1, 216, 11799, TO_DATE('09/01/2001', 'MM/DD/YYYY'), 100, 
TO_DATE('08/31/2001', 'MM/DD/YYYY'), 100);

INSERT INTO backorder VALUES
(2, 218, 11847, TO_DATE('09/15/2001', 'MM/DD/YYYY'), 50, 
NULL, NULL);

INSERT INTO backorder VALUES
(3, 218, 11847, TO_DATE('09/15/2001', 'MM/DD/YYYY'), 50, 
NULL, NULL);


--- inserting records into ORDERLINE
INSERT INTO orderline VALUES (1057, 11668, 259.99, 1);
INSERT INTO orderline VALUES (1057, 11800, 69.96, 2);
INSERT INTO orderline VALUES (1058, 11824, 15.99, 1);
INSERT INTO orderline VALUES (1059, 11846, 129.95, 1);
INSERT INTO orderline VALUES (1059, 11848, 139.95, 1);
INSERT INTO orderline VALUES (1060, 11798, 59.95, 2);
INSERT INTO orderline VALUES (1061, 11779, 29.95, 1);
INSERT INTO orderline VALUES (1061, 11780, 29.95, 1);
INSERT INTO orderline VALUES (1062, 11799, 59.95, 1);
INSERT INTO orderline VALUES (1062, 11669, 229.99, 3);



COMMIT;