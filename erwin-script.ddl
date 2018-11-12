-- Bank master record - GG_SAP_BNK_REC - GG_SAP_BNK_REC
-- One-Time Account Data Document Segment - BSEC - GG_SAP_ACCT_DATA
-- Vendor Master (Bank Details) - GG_SAP_VEND_BNK - GG_SAP_VEND_BNK
-- Payment Medium File - GG_SAP_PYMT_MED - GG_SAP_PYMT_MED

-- Settlement data from payment program	REGUH - GG_SAP_SET_DATA
-- G/L Account Master (Chart of Accounts)	SKA1 - GG_SAP_GL_ACCT
-- G/L Account Master Record (Chart of Accounts: Description)	SKAT - GG_SAP_GL_ACCT_REC
-- G/L account master (company code)	SKB1 -- GG_SAP_GL_ACCT_CMPNY
-- Document Types	T003 - GG_SAP_DOC_TYPE
-- Document Type Texts	T003T - GG_SAP_DOC_TYPE_TXT
-- Blocking Reasons for Automatic Payment Transcations	T008 - GG_SAP_AUTOM_PYMT_BLKING_RSN
-- Blocking Reason Names in Automatic Payment Trans.	T008T - GG_SAP_AUTOM_PYMT_BLKING_RSN_NM
-- House Banks	T012 - GG_SAP_HSE_BNK
-- Payment Methods for Automatic Payment	T042Z - GG_SAP_AUTOM_PYMT_MTHD
-- Account Group Names (Table T077K)	T077Y - GG_SAP_ACCT_GRP_NM
-- Posting Key	TBSL - GG_SAP_POSTG_KEY
-- Posting Key Names	TBSLT - GG_SAP_POSTG_KEY_NM

--T163
CREATE TABLE "GG_SAP_PRCHG_DOC_ITEM_CATG" (
"Inventory Management Indicator " CHAR(1),
"Material Number Required Indicator" CHAR(1),
"Account Assignment Required Indicator" CHAR(1),
"Goods Receipt Indicator Binding" CHAR(1),
"Purchase Document Item Category" CHAR(1) PRIMARY KEY,
"Goods Receipt Indicator" CHAR(1),
"Client" CHAR(3),
"Goods Receipt Non Valuated Binding" CHAR(1),
"Invoice Receipt Indicator" CHAR(1),
"Invoice Receipt Indicator Binding" CHAR(1),
"Goods Receipt Non Valuated Indicator" CHAR(1),
"Statistic Update Group Identifier" CHAR(6),
"Nota Fiscal Item Type" CHAR(2),
"Differential Invoice" CHAR(2),
"Source Receive Timestamp" TIMESTAMP,
"Load User Identifier" VARCHAR(20),
"Load Timestamp" TIMESTAMP,
"Update User Identifier" VARCHAR(20),
"Update Timestamp" TIMESTAMP,
"Geo Region Code" CHAR(2)
);

COMMENT ON COLUMN GG_SAP_PRCHG_DOC_ITEM_CATG."Inventory Management Indicator " IS 'FIELD: BFKNZ
ELEMENT: EBFKZ
DOMAIN: EBFKZ
Definition
Indicates whether
goods receipts
:
Can occur (as with item category "normal")
Are not allowed (as with item category "text").';
COMMENT ON COLUMN GG_SAP_PRCHG_DOC_ITEM_CATG."Material Number Required Indicator" IS 'FIELD: MATNO
ELEMENT: MATNO
DOMAIN: PLUMI
Definition
Determines, for the specified
item category
, whether the entry of a
material number
 is:
Possible (as with item category "normal")
Allowed (as with item category "text")';
COMMENT ON COLUMN GG_SAP_PRCHG_DOC_ITEM_CATG."Account Assignment Required Indicator" IS 'FIELD: KNTZU
ELEMENT: KNTZU
DOMAIN: PLUMI
Definition
Determines (in relation to the item category) whether the entry of an account assignment category is:
Possible (as with item category "standard"), or';
COMMENT ON COLUMN GG_SAP_PRCHG_DOC_ITEM_CATG."Goods Receipt Indicator Binding" IS 'FIELD: WEPOV
ELEMENT: WEPOV
DOMAIN: XFELD
Definition
Indicates that a
goods receipt
 is mandatory for the account assignment category.';
COMMENT ON COLUMN GG_SAP_PRCHG_DOC_ITEM_CATG."Purchase Document Item Category" IS 'FIELD: PSTYP
ELEMENT: PSTYP
DOMAIN: PSTYP
Definition
Indicator which shows the item features.
Use
The item category controls whether the following entries and procedures are necessary or permitted for the item:
material number
additional account assignment
inventory management in the SAP System
goods receipt
invoice receipt
Example
In the standard system an item in the "normal" category requires goods and invoice receipts. On the other hand for items in the "
consignment
" category, (that is order item for consignment material) invoice receipts are not allowed.
Use
Depending on the item category, the following entries or transactions the item are required or possible for the item:
Material number
Additional account assignment
Inventory management with the SAP System for the material
Goods receipt
Invoice receipt
Procedure
Any value that you enter in this field will appear in each item as the default value.
Example
An item with category "normal" requires goods/invoice receipt in the standard system. For items with category "consignment" (that means order item for consignment material) on the other hand, invoice receipts are not allowed.
Dependencies
Which item category is allowed depends on the category (for example, purchase requisition) and type (for example, transport requisition for stock transfer) of the relevant purchasing document.
Dependencies
Which item category is allowed depends on the category (for example, purchase requisition) and type (for example, transport requisition for stock transfer) of the relevant purchasing document.
Use
Procedure
You can enter your selection criteria for this field in the following ways:
You enter an individual value in this field.
You enter an interval of values in this field and in the adjacent field.
You enter several intervals.
All purchase requisitions that satisfy your selection criteria will be displayed.
Use
If you enter an item type, then it will be proposed for each item in the purchasing document.';
COMMENT ON COLUMN GG_SAP_PRCHG_DOC_ITEM_CATG."Goods Receipt Indicator" IS 'FIELD: WEPOS
ELEMENT: WEPOS
DOMAIN: XFELD
Definition
Specifies whether the item involves a
goods receipt
.
Dependencies
In the processing of production and process orders, the indicator specifies whether a goods receipt is allowed and expected for the order item.
If the indicator is set, the order item is relevant to inventory management. The indicator is set during the creation of the order if the order is settled in respect of a material or a sales order item.';
COMMENT ON COLUMN GG_SAP_PRCHG_DOC_ITEM_CATG."Client" IS 'FIELD: MANDT
ELEMENT: MANDT
DOMAIN: MANDT
Definition
A legally and organizationally independent unit which uses the system.
Use
MANDT is part of the key of the control record of an EDI buffer. It uniquely identifies an EDI buffer number.
Procedure
Das EDI subsystem  must ensure that the Client field is filled and maintained for the SAP applications.
Examples
Dependencies';
COMMENT ON COLUMN GG_SAP_PRCHG_DOC_ITEM_CATG."Goods Receipt Non Valuated Binding" IS 'FIELD: WEUNV
ELEMENT: WEUNV
DOMAIN: XFELD
Definition
Indicates that a
goods receipt
 is mandatory for the relevant item category. The GR will be non-valuated.
Use
If this indicator has been set, the indicator for non-valuated goods receipts in the item cannot be overwritten.
Example
This indicator is set in the case of the item category for
consignment
 orders for example.';
COMMENT ON COLUMN GG_SAP_PRCHG_DOC_ITEM_CATG."Invoice Receipt Indicator" IS 'FIELD: REPOS
ELEMENT: REPOS
DOMAIN: XFELD
Definition
Specifies whether an invoice receipt is linked to the purchase order item.
Use
If the indicator is not set, the goods are to be delivered free of charge.';
COMMENT ON COLUMN GG_SAP_PRCHG_DOC_ITEM_CATG."Invoice Receipt Indicator Binding" IS 'FIELD: REPOV
ELEMENT: REPOV
DOMAIN: XFELD
Definition
Determines whether or not an invoice receipt is mandatory for the relevant
item category
.';
COMMENT ON COLUMN GG_SAP_PRCHG_DOC_ITEM_CATG."Goods Receipt Non Valuated Indicator" IS 'FIELD: WEUNB
ELEMENT: WEUNB
DOMAIN: XFELD
Definition
Specifies that the
goods receipt
 for this item is not to be valuated.
Use
Set the indicator if goods receipts involving this material are not to be valuated. The valuation of the purchase order item will then take place at the time of invoice verification.
This indicator must be set in the case of
multiple account assignment
 for example.
Note
If the indicator has been set for an item with the
material type

non- valuated
, the quantity recorded in Inventory Management can differ from the value in Financial Accounting during the period between goods receipt and invoice receipt, since the value is not updated until the invoice is posted in Financial Accounting.
Use
If this indicator has been set, the indicator for non-valuated goods receipts is also set in PO items with this item category. However, the indicator can be overwritten in the PO item.
Procedure
Examples
Dependencies
Dependencies
This indicator is only relevant to production orders, projects and and configurable materials with account assignment to a
sales order
.';
COMMENT ON COLUMN GG_SAP_PRCHG_DOC_ITEM_CATG."Statistic Update Group Identifier" IS 'FIELD: STAFO
ELEMENT: STAFO
DOMAIN: STAFO
Definition
The update group is a control element in the updating definition, which allows all the different business events in the various applications to have a uniform influence on the statistics update in the Logistics Information System (LIS).
In an application, one update group is allocated to a specific business event or a group of business events. This update group is then used to determine the fields which will be created for the statistics.
The type of allocation and the organizational elements that determine how the allocation takes place vary from application to application.
Use
At present, you can use the update group to define how the application influences the statistics update in the following applications (information systems):
Sales
Purchasing
Plant Maintenance
Quality Management
Only one fixed update group each is permitted for all of the other respective information systems in Logistics.
All update groups that begin with numbers or with the letter "S" lie within the SAP name range.
Example
In sales processes, the following elements determine the update group:
sales organization
distribution channel
division
a group of customers
a group of materials
sales document type
item type
In sales processes, a distinction is made between "normal" sales and so-called returns. These different types of business events are identified by various types of sales documents.
You want to save the order quantities from the various types of business event in different statistics fields in an
information structure
. This means that only the appropriate statistics fields will be updated when a "normal" sale takes place, and not those statistics fields in which the returns quantities are cumulated, and vice versa.
You can control these different updates by using two different update groups.
For example, assign the update group "000001" to the sales document types that represent the "normal" sales.
Assign the update group "000002" to the sales document types that represent a returns process.
If you define the
update rules
 for the key figures in an information structure, always always make a reference to an update group.
If you define update rules for your information structure with reference to update group "000001", only define the key figures that are to be updated through "normal" sales.
Conversely, only refer the update group "000002" when defining those key figures that are going to be updated by the returns processes.
Key figures that are to be updated by both business transactions should be assigned to both update groups in the definition.';
COMMENT ON COLUMN GG_SAP_PRCHG_DOC_ITEM_CATG."Nota Fiscal Item Type" IS 'FIELD: J_1BITMTYP
ELEMENT: J_1BITMTYP
DOMAIN: J_1BITMTYP
Definition
Refers to a code that describes the business transaction at item level within a given process.
Procedure
Examples
An example of a nota fiscal item type within the business process of subcontracting is
subcontracting component shipment item
.
Dependencies
The system uses the nota fiscal item type primarily for:
CFOP determination
Posting of taxes
Definition of relationship between notas fiscais
Legal reporting';
COMMENT ON COLUMN GG_SAP_PRCHG_DOC_ITEM_CATG."Differential Invoice" IS 'FIELD: DIFF_INVOICE
ELEMENT: DIFF_INVOICE
DOMAIN: DIFF_INVOICE
Definition
The
Differential Invoicing
 indicator defines the subsequent process in invoice verification.
Use
If differential invoicing is defined as
Relevant
, you can enter the invoice in invoice verification as a provisional invoice, differential invoice, or final invoice.
Dependencies
You cannot manually change the setting in the purchase order item.
You can use Business Add-In
BAdI: Relevance Determination at Document Item Level
 (ITEM_RELVANCE_DETERMINATION) to define criteria that the system uses to determine the relevance of a purchase order item for differential invoicing.
Default implementation LOG_PO_COMMODITY_RELEVANCE looks at the relevant purchasing info record, which you can call within the purchase order item, and checks the
Differential Invoicing
 field, where you can manually change the relevance setting.
For more information, see Customizing for Materials Management and choose
Purchasing -> Business Add-Ins for Purchasing -> BAdI: Relevance Determination at Document Item Level
.
Example';
COMMENT ON COLUMN GG_SAP_PRCHG_DOC_ITEM_CATG."Source Receive Timestamp" IS 'FIELD: NA
ELEMENT: NA
DOMAIN: NA
The date and time the source data file was received for processing and loading into a Data Lake / Data Warehouse table.';
COMMENT ON COLUMN GG_SAP_PRCHG_DOC_ITEM_CATG."Load User Identifier" IS 'FIELD: NA
ELEMENT: NA
DOMAIN: NA
The userid or process id of the person or process which loaded the row into this data lake / data warehouse table.';
COMMENT ON COLUMN GG_SAP_PRCHG_DOC_ITEM_CATG."Load Timestamp" IS 'FIELD: NA
ELEMENT: NA
DOMAIN: NA
The date and time when this row was inserted/loaded into the data lake / data warehouse table.';
COMMENT ON COLUMN GG_SAP_PRCHG_DOC_ITEM_CATG."Update User Identifier" IS 'FIELD: NA
ELEMENT: NA
DOMAIN: NA
The userid or process id which last updated this row.';
COMMENT ON COLUMN GG_SAP_PRCHG_DOC_ITEM_CATG."Update Timestamp" IS 'FIELD: NA
ELEMENT: NA
DOMAIN: NA
The data and time this row was last updated.';
COMMENT ON COLUMN GG_SAP_PRCHG_DOC_ITEM_CATG."Geo Region Code" IS 'FIELD: NA
ELEMENT: NA
DOMAIN: NA
A code which represents an operational geographic region. This can be a country, a group of countries or all countries.Values -  "AR" - Argentina               "BR" - Brazil                "CA" - Canada               "CN" - China               "GB" - Great Britian               "IN" - India                "JP" - Japan               "K1" - Central America               "K2" - Chile               "K3" - Southern Africa               "MX" - Mexico               "US" - United States             "WW" - World Wide ';

COMMENT ON TABLE "GG_SAP_PRCHG_DOC_ITEM_CATG" IS 'SAP ABAP Table T163 (Item Categories in Purchasing Document)';
