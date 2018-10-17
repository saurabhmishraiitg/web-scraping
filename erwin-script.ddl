PRCHG_DOC_ACCT_ASSGNMNT
PRCHG_DOC_LINE


=IF(J2="CHAR",CONCAT("CHAR","(",K2,")"),IF(J2="DATS","DATE",IF(OR(J2="NUMC", J2="DEC", J2="QUAN",J2="CURR",J2="FLTP"),CONCAT("DECIMAL(",K2,",",L2,")"),IF(J2="TIMESTAMP","TIMESTAMP",CONCAT("CHAR(",K2,")")))))

--EKKO Table
CREATE TABLE GG_SAP_PRCH_DOC (
"Purchase Document Number" CHAR(10) PRIMARY KEY,
"Geo Region Code" CHAR(2),
"Company Code" CHAR(4),
"Document Category Code" CHAR(1),
"Document Type Code" CHAR(4),
"Document Type Indicator" CHAR(1),
"Document Deletion Indicator" CHAR(1),
"Status Code" CHAR(1),
"Source Create Date" DATE,
"Source Create Person Name" CHAR(12),
"Item Number Interval Number" DECIMAL(5,0),
"Last Item Number" DECIMAL(5,0),
"Vendor Account Identifier" CHAR(10),
"Language Key Code" CHAR(1),
"Payment Term Key Code" CHAR(4),
"Cash Payment Discount 1 Day Quantity" DECIMAL(3,0),
"Cash Payment Discount 2 Day Quantity" DECIMAL(3,0),
"Cash Payment Discount 3 Day Quantity" DECIMAL(3,0),
"Cash Discount 1 Percentage" DECIMAL(5,3),
"Cash Discount 2 Percentage" DECIMAL(5,3),
"Purchasing Oraganisation Code" CHAR(4),
"Purchasing Group Code" CHAR(3),
"Currency Code" CHAR(5),
"Exchange Rate Amount" DECIMAL(9,5),
"Fixed Exchange Rate Indicator" CHAR(1),
"Purchasing Document Date" DATE,
"Validity Period Start Date" DATE,
"Validity Period End Date" DATE,
"Application Close Date" DATE,
"Quotation Submission End Date" DATE,
"Quotation Binding Date" DATE,
"Warranty Date" DATE,
"Quotation Invitation Number" CHAR(10),
"Quotation Number" CHAR(10),
"Quotation Submission Date" DATE,
"Reference Number" CHAR(12),
"Vendor Salesperson Name" CHAR(30),
"Vendor Telephone Number" CHAR(16),
"Vendor Identifier" CHAR(10),
"Customer Number" CHAR(10),
"Purchase Agreement Number" CHAR(10),
"Unused Field 1" CHAR(2),
"Single Delivery Indicator" CHAR(1),
"Goods Reciept Indicator" CHAR(1),
"Supplier Plant Name" CHAR(4),
"Unused Field 2" CHAR(10),
"Incoterm 1" CHAR(3),
"Incoterm 2" CHAR(28),
"Document Condition Code" CHAR(10),
"Document Procedure Code" CHAR(6),
"Status Update Group Code" CHAR(6),
"Document Owner Name" CHAR(12),
"Sub Item Interval Number" DECIMAL(5,0),
"Release Group Identifier" CHAR(2),
"Release Strategy Identifier" CHAR(2),
"Release Code" CHAR(1),
"Release Status Indicator" CHAR(8),
"Release Approval Indicator" CHAR(1),
"Tax Return Country Code" CHAR(3),
"Address Number" CHAR(10),
"Tax ID Country Code" CHAR(3),
"Cancel Reason Code" DECIMAL(2,0),
"Processing Status Code" CHAR(2),
"Total Purchase Amount" DECIMAL(15,2),
"Version Number" CHAR(8),
"Down Payment Indicator" CHAR(4),
"Down Payment Percentage" DECIMAL(5,2),
"Down Payment Amount" DECIMAL(11,2),
"Down Payment Due Date" DATE,
"Requirement Status Description" CHAR(20),
"Requirement Type Code" CHAR(1),
"Source Receive Timestamp" TIMESTAMP,
"Load User Identifier" VARCHAR(20),
"Load Timestamp" TIMESTAMP,
"Update User Identifier" VARCHAR(20),
"Update Timestamp" TIMESTAMP
);

COMMENT ON TABLE "GG_SAP_PRCH_DOC" IS '"EKKO (Purchasing Document Header) is a standard table in SAP R3 ERP systems.
A purchasing document has a header and one or more line items. The header is stored in table EKKO the line items are stored in table EKPO. The two tables can be linked together based on the purchasing document number (field EBELN). The header contains information relevant to the whole document. The items specify the materials or services to be procured. For example, information about the vendor and the document number is contained in the document header, and the material description and the order quantity are specified in each item.
The purchasing document table contains different categories of documents that share the same document structure but do not necessarily have the same business purpose. The document category is defined in field EKKO.BSTYP. The following document categories can be found in tables EKKO/EKPO:
Request for quotation (RFQ)
Transmits a requirement defined in a requisition for a material or service to potential vendors. The purpose is to ask vendors to send in quotations.
Quotation
Contains the prices and conditions received from the vendor and is the basis for vendor selection.
Purchase order (PO)
The buying entitys request or instruction to a vendor (external supplier) to supply certain materials or render/perform certain services/works, formalizing a purchase transaction.
Contract
In the SAP Purchasing component, a type of ""outline agreement"", or longer-term buying arrangement. The contract is a binding commitment to procure a certain material or service from a vendor over a certain period of time.
Scheduling agreement
Another type of ""outline agreement"", or longer-term buying arrangement. Scheduling agreements provide for the creation of delivery schedules specifying purchase quantities, delivery dates, and possibly also precise times of delivery over a predefined period.
One other purchasing document type are purchase requisitions. These are documents that are internal to the organization and are not stored in the purchasing document table but in table EBAN"';

COMMENT ON COLUMN GG_SAP_PRCH_DOC."Purchase Document Number" IS 'Definition
Alphanumeric key uniquely identifying the document.
Use
This number identifies the last purchase order or scheduling agreement to be included in the
info record
.
Procedure
Enter the purchase order to which the delivery costs relate.
Procedure
Enter the number of the purchasing document whose
output (messages)
 you wish to display."
Use
Procedure
You have the following options for entering your selection criteria for this field:"
Enter an individual value in this field.
Enter an interval of values (from - to) in this and the adjacent field.
Click on the arrow next to the field to enter several intervals or individual values.
All documents that satisfy your selection criteria will be displayed. (Copied from TX,SELECT_CRITERIA)';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Geo Region Code" IS '"A code which represents an operational geographic region. This can be a country, a group of countries or all countries.Values -  "AR" - Argentina               "BR" - Brazil                "CA" - Canada               "CN" - China               "GB" - Great Britian               "IN" - India                "JP" - Japan               "K1" - Central America               "K2" - Chile               "K3" - Southern Africa               "MX" - Mexico               "US" - United States             "WW" - World Wide "';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Company Code" IS 'Definition
The company code is an organizational unit within financial accounting.
Use
Company code in which the accounting document is posted.
Use
Company code in which the accounting document was posted.
Use
Company code which is allocated to the controlling area.
Procedure
Examples
Dependencies
Depending on the indicator of the
assignment control
, specific validations are carried out for new allocations.
If all allocations are deleted for indicator 2 (providing this is allowed for consistency reasons) and if a company code is then allocated with a
currency
 different from the controlling area and/or another
chart of accounts
, then the currency and/or chart of accounts from the company code are transferred into the controlling area.
Use
With this selection, you can include or exclude company codes. However, The system takes into account only those company codes in which cash management is activated.
Use
The G/L account master data is maintained in this source company code. Changes can be transferred from here into target company codes.
Use
You assign one or more business areas to this company code that can be posted to in this company code.
Procedure
Examples
Dependencies
During automatic creation of consolidation units for business consolidation, the system interprets the company code/business area assignments from the Financial Accounting (FI) organizational units and during integrated data transfer to Consolidation.
If you implement business area consolidation, you can specify during your consolidation preparations that the assignments you enter here are checked at time of posting.
Use
Dependencies
The system uses the selection criteria entered here to select and display dunning notices. If you are in the change function, the system blocks the dunning notices you have selected so they cannot be processed by another user. Use the selection criteria to divide long dunning lists between different users.
Use
Allows a limitation of the company codes.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Document Category Code" IS 'Definition
Identifier that allows you to differentiate between various kinds of
purchasing document
 in the SAP System.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Document Type Code" IS 'Definition
Identifier allowing differentiation between the various kinds of purchasing document in the SAP system.
On the basis of the purchasing document type, you can, for example, distinguish between a
purchase order
, an
RFQ
 and a
scheduling agreement
.
Use
The purchasing document type controls, for instance, the
number assignment
 of a purchase order, as well as the selection of the fields to be maintained.
Use
When this SAP transaction is invoked, this value is proposed as document type.
Use
The document type entered will always appear as the default value at the time of document creation.
Example
You create a new document type for purchase orders and you enter the new document type as default document type. The new document type then always appears as the default value during the creation of POs.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Document Type Indicator" IS 'Definition
Allows differentiation between the various kinds of purchasing document.
Use
On the basis of the purchasing document type you can, for example, distinguish between a standard purchase order and a stock transport order, although both documents belong to the
purchasing document category

purchase requisition
.
The purchasing document type controls, for instance, the
number assignment
 for a purchase order, as well as the fields to be maintained.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Document Deletion Indicator" IS 'Definition
Determines whether the item in the
purchasing document
 is deleted or blocked.
Use
You can set the deletion indicator by choosing
Edit -> Delete
 if:
You want to cancel an item
An item is closed and can be archived
You can set the blocking indicator by selecting the item and then choosing
Edit -> Block
 if you do not want to allow subsequent functions for the item. Note that you must manually remove the indicator as soon as subsequent functions are allowed again.
Procedure
Examples
You have entered a purchase order item by mistake. You cancel it by setting the deletion indicator.
A purchase order item has been delivered, invoiced, and paid for, and can now be archived. You can set the deletion indicator.
Dependencies';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Status Code" IS 'Definition
Key specifying whether a
quotation
 has been received in respect of an
RFQ
.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Source Create Date" IS 'Note:
When using create with reference, the selected records are created again with, for example, the creation date  (default value from Customizing).
Procedure
The system suggests for deletion all
info records
 created before this date for which no POs yet exist.
Use
Date on which this
task
 was entered in the message.
Procedure
Examples
Dependencies
Use
Date on which this
activity
 was entered in the message.
Procedure
Examples
Dependencies
Use
Date on which this item was saved in the message.
Procedure
Examples
Dependencies
Use
Allows a limitation of the dates on which master records were created in the company code.
Procedure
Examples
Dependencies
Use
All vendors which were not assessed since the entry date will be displayed.
Procedure
Examples
Dependencies
Use
Allows a limitation of the dates on which general specifications of the customer master records were created.
Procedure
Examples
Dependencies
Use
Allows the limitation of the dates on which company code-specific specifications of the customer master records were created.
Procedure
Examples
Dependencies
Use
Allows the limitation of the dates on which general specifications of the vendor master records were created.
Procedure
Examples
Dependencies
Use
Allows the limitation of the dates on which company code-specific specifications of the vendor master records were created.
Procedure
Examples
Dependencies
Use
Allows the limitation of the dates on which company code-specific specifications of the G/L account master records were created.
Procedure
Examples
Dependencies';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Source Create Person Name" IS 'Use
Displays the person who created the condition record.
Note

The records selected are always created when data is created with a reference. The person creating the data is proposed.
Use
Procedure
If you want a list of maintenance notifications which were created by a specific person, enter the name of that person here.
Examples
Dependencies
Use
Name of the person who created this
task
 in the notification.
Procedure
Examples
Dependencies
Use
Name of the person who created this
activity
 in the message.
Procedure
Examples
Dependencies
Use
Name of the person who created this item in the message.
Procedure
Examples
Dependencies
Use
Allows the limitation of the accounting clerks who have created general data of the customer master records.
Procedure
Examples
Dependencies
Use
Allows the limitation of the accounting clerks who have created company code-specific data of the customer master records.
Procedure
Examples
Dependencies
Use
Allows the limitation of the accounting clerks who created general data of the vendor master records.
Procedure
Examples
Dependencies
Use
Allows you to limit selection of the accounting clerks who created company code-specific data for the vendor master records.
Procedure
Examples
Dependencies
Use
Allows you to limit the selection of users who created company code-specific data in the G/L account master records.
Procedure
Examples
Dependencies';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Item Number Interval Number" IS 'Definition
Determines the size of the steps between the default item numbers.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Last Item Number" IS 'Definition
Number of the last item of the
RFQ
 or
outline agreement
.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Vendor Account Identifier" IS 'Definition
Alphanumeric key uniquely identifying the document.
Use
With the vendor number, information from the vendor master record (such as the vendor"s address and bank details) is copied into a purchasing document (such as a request for quotation or a purchase order).
You can use the vendor number to keep track of
requests for quotation
,
purchase orders
 and
outline agreements
.
Dependencies
You can enter only one vendor number
or
 one
plant
 per
quota arrangement item
.
Procedure
You can enter your selection criteria for this field in the following ways:
You enter an individual value in this field.
You enter an interval of values in this field and in the adjacent field.
You enter several intervals.
All
purchasing documents
 that satisfy your selection criteria will be displayed.
Use
Vendor from whom the goods were ordered.
Use
Depending on the movement, the content of this field can have different meanings:
In the case of a pipeline movement, this is the number of the pipeline vendor.
Procedure
Enter your selection value here, or press F5 to enter a selection interval.
Procedure
Enter the vendor"s number.
You can search for the number with the aid of a
matchcode
. To do so, press F4=Possible entries and enter the selection data for the field.
Procedure
Choose the
source of supply
 that is to be assigned to the
purchase requisition
.
Use
Procedure
Enter a vendor number only if this is allowed by the movement type.
Examples
For movement type 501 (goods receipt without PO), the standard system permits the entry of a vendor number.
Dependencies
Procedure
You can enter your selection criteria for this field in the following ways:
You enter an individual value in this field.
You enter an interval of values in this field and in the adjacent field.
You enter several intervals.
All
info that satisfy your selection criteria will be displayed.
Use
Procedure
Enter a value in this field if you want to search for
purchase orders
 that satisfy this criterion.
Examples
Dependencies
Procedure
Enter a vendor if you want to select documents that contain the vendor as item data. This is the case, for instance, with
movements affecting vendor special stocks (e.g. consignment), and
goods receipts without a purchase order, where the vendor has been entered.
Examples
Dependencies
For vendor special stocks, you must likewise enter a special stock indicator.
Use
Procedure
You have the following options for entering your selection criteria for this field:
Enter an individual value in this field.
Enter an interval of values (from - to) in this and the adjacent field.
Click on the arrow next to the field to enter several intervals or individual values.
All documents that satisfy your selection criteria will be displayed. (Copied from TX,SELECT_CRITERIA)
Examples
Dependencies
Procedure
Enter the number of the vendor from whom materials are to be procured during the relevant period.
Dependencies
If you want to enter an
outline agreement
 as
source of supply
, the vendor number from the outline agreement will be proposed by the system.
Procedure
Enter the number of the vendor whose reference document you want to list for selection purposes.
Procedure
Enter the number of the vendor for whom you want to define
master conditions
.
These master conditions will be taken into account in calculating the
effective price
 for the order items of purchase orders issued to this vendor.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Language Key Code" IS 'Definition
The language key indicates
- the language in which texts are displayed,
- the language in which you enter texts,
- the language in which the system prints texts.
Use
This language key refers to the purchase order text.
Notes
Field changes
This field can be changed at day level.
Time independence
You can define this field time-independently in the cost center accounting customizing menu item "Master data".
If you activate the time-dependence flag in the customizing, you can maintain different field contents for any period.
If you do not activate the customizing flag, you can only maintain one field value which is valid for all periods. There is, however, an indirect time-dependence, if you simultaneously change a time-dependent field. A new field value can be entered for the time-independent field for the validity interval of the time-dependent field.
Use
This language key refers to the purchase order text.
Use
This language key refers to the material short text.
Use
This language key refers to the internal note.
When Field "S" is blank, the language is taken from the partner"s customer master.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Payment Term Key Code" IS 'Definition
Key for defining payment terms composed of cash discount percentages and payment periods.
Use
It is used in sales orders, purchase orders, and invoices. Terms of payment provide information for:
Cash management
Dunning procedures
Payment transactions
Procedure
Data can be entered in the field for the terms of payment key in various ways as you enter a business transaction:
In most business transactions, the system defaults the key specified in the master record of the customer/vendor in question.
In some transactions (for example, credit memos), however, the system does not default the key from the master record. Despite this, you can use the key from the customer/vendor master record by entering "*" in the field.
Regardless of whether or not a key is defaulted from the master record, you can manually enter a key during document entry at:
Note
Master records have separate areas for Financial Accounting, Sales, and Purchasing. You can specify different terms of payment keys in each of these areas. When you then enter a business transaction, the application in question will use the key specified in its area of the master record.
Use
This terms of payment key is proposed when entering business transactions in Sales and Distribution (for example, orders). If you transfer the billing documents from the Sales and Distribution system into Financial Accounting, the terms of payment are also valid there, for example, for dunning.
Procedure
Examples
Dependencies
If you install the Financial Accounting (FI) application, you should ensure that the same key was entered in the master record areas for Sales and Distribution and Financial Accounting.
Use
This terms of payment key is proposed when entering business transactions in Purchasing (for example, purchase orders). If you enter invoices without order reference, the key is transferred from the Financial Accounting master record area.
Procedure
Examples
Dependencies
If you install the Financial Accounting (FI) application, you should ensure that the same key was entered in the master record areas for Purchasing and Financial Accounting.
Use
This terms of payment key is defaulted when you enter business transactions in Financial Accounting.
Dependencies
If you install the Sales and Distribution (SD) application, you should ensure that the same key was entered in the master record areas for Sales and Distribution and Financial Accounting.
Use
This terms of payment key is proposed when entering business transactions in Financial Accounting.
Procedure
Examples
Dependencies
If you install the Purchasing (PUR) application, you should ensure that the same key was entered in the master record areas for Purchasing and Financial Accounting.
Use
Here you can store payment terms for the automatic posting of interest.
Procedure
Examples
Dependencies
Use
The payment terms for a transaction provide information on the payment transaction itself.
Procedure
If you have entered a purchase order or goods receipt reference in the initial invoice verification screen, the system defaults the terms of payment contained in the header of the purchase order.
If you have not entered a purchase order or goods receipt reference in the initial screen, the system defaults the terms of payment key that is defined in the accounting data section of the vendor master record.
Examples
Dependencies
Use
Description of the terms of payment independent of the date limit. This only applies to the SD application.
Notes
If this description changes in one table entry, so does the description for all entries for this term of payment.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Cash Payment Discount 1 Day Quantity" IS 'Definition
Number of days. In conjunction with the baseline date for payment, this number represents a payment period or period of qualification for discount.
Use
If payment is effected within this period, the relevant percentage
discount
 will be granted.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Cash Payment Discount 2 Day Quantity" IS 'Definition
Number of days. In conjunction with the baseline date for payment, this number represents a payment period or period of qualification for discount.
Use
If payment is effected within this period, the relevant percentage
discount
 will be granted.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Cash Payment Discount 3 Day Quantity" IS 'Definition
Number of days. In conjunction with the baseline date for payment, this number represents a payment period or period of qualification for discount.
Use
If payment is effected within this period, the relevant percentage
discount
 will be granted.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Cash Discount 1 Percentage" IS 'Definition
Cash discount percentage rate applied to the shortest payment period.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Cash Discount 2 Percentage" IS 'Definition
Cash discount percentage rate applied to the second payment period.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Purchasing Oraganisation Code" IS 'Definition
Denotes the
purchasing organization
.
Use
A purchase order must be assigned to a purchasing organization.
Procedure
Entry of the responsible purchasing organization is mandatory.
Procedure
If you enter a
purchasing organization
, the
info record
 relates to the purchasing organization. Certain data can only be entered if the purchasing organization has previously been entered.
Dependencies
The specified purchasing organization must be responsible for this vendor.
If the info record is to relate to a plant, it is necessary to enter the purchasing organization.
Use
A request for quotation must be assigned to a purchasing organization.
Procedure
Entry of the responsible purchasing organization is mandatory.
Use
An outline purchase agreement must be assigned to a purchasing organization. This purchasing organization is responsible for negotiating the terms and conditions of such an agreement.
Procedure
Entry of the responsible purchasing organization is mandatory.
Use
Enter the purchasing organization to which you wish to limit the selection.
This is the purchasing organization that is to be responsible for the procurement of the
material
. It represents a source of supply for this
purchase requisition
.
If a purchasing organization has been entered, it will be proposed to the purchasing department during the ordering process.
Procedure
You have two options with regard to the source of supply. You can:
Enter the source manually, or
The following purchasing data is checked in the order shown in order to determine whether it represents a
source of supply
 for the requested material:
quota arrangement
source list
outline agreement
The system suggests existing sources of supply for selection purposes.
Procedure
You can enter your selection criteria for this field in the following ways:
You enter an individual value in this field.
You enter an interval of values in this field and in the adjacent field.
You enter several intervals.
All
purchasing documents
 that satisfy your selection criteria will be displayed.
Procedure
You can enter your selection criteria for this field in the following ways:
You enter an individual value in this field.
You enter an interval of values in this field and in the adjacent field.
You enter several intervals.
All
info that satisfy your selection criteria will be displayed.
Procedure
Enter the key of the purchasing organization for which you want to define
master conditions
.
Procedure
Enter your selection value here, or press F5 to enter a selection interval.
Use
Procedure
You have the following options for entering your selection criteria for this field:
Enter an individual value in this field.
Enter an interval of values (from - to) in this and the adjacent field.
Click on the arrow next to the field to enter several intervals or individual values.
All documents that satisfy your selection criteria will be displayed. (Copied from TX,SELECT_CRITERIA)
Examples
Dependencies
Use
This is the purchasing organization used by the system to determine a source of supply in the case of goods movements (e.g. stock transfers, pipeline movements) in a plant.
Procedure
Examples
You define the pipeline price for a pipeline material with a pipeline info record. To enable the system to determine the pipeline price from the info record in the case of a goods movement in a plant, the relevant purchasing organization must be assigned to the plant.
Dependencies';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Purchasing Group Code" IS 'Definition
Key for a buyer or a group of buyers, who is/are responsible for certain purchasing activities.
Use
Frequently, purchasing documents (such as purchase orders) are monitored by the purchasing group. Urging letters (in the case of overdue deliveries) fall also within the group"s scope of activities.
For each purchasing group, statistical analyses can be performed. The purchasing group can be used as a sort criterion when creating purchasing-specific reports.
Procedure
Enter the key for the responsible purchasing group.
Dependencies
When you create an
info record
for a material with a
material master record
 at plant level, a value from the master record is suggested.
This value is suggested when a purchase order item or an
outline agreement
 item is created.
Procedure
You can enter your selection criteria for this field in the following ways:
You enter an individual value in this field.
You enter an interval of values in this field and in the adjacent field.
You enter several intervals.
All
purchasing documents
 that satisfy your selection criteria will be displayed.
Enter the key of the purchasing group whose purchasing documents you want to display.
Procedure
You can enter your selection criteria for this field in the following ways:
You enter an individual value in this field.
You enter an interval of values in this field and in the adjacent field.
You enter several intervals.
All
info records
 that satisfy your selection criteria will be displayed.
Enter the key for the purchasing group whose purchasing info records you want to display.
Procedure
You can enter your selection criteria for this field in the following ways:
You enter an individual value in this field.
You enter an interval of values in this field and in the adjacent field.
You enter several intervals.
All documents that satisfy your selection criteria will be displayed.
Procedure
Enter the key for the purchasing group whose purchasing documents you want to display.
You can enter an interval of values (that is, from value 1 to value 2).';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Currency Code" IS 'Definition
Currency
 key for amounts in the system.
Dependencies
This value is suggested when a purchase order item or an
outline agreement
 item is created.
Use
The controlling area and company code currencies must be identical both in a 1:1 relationship as well as in a 1:n relationship between controlling area and company code. If you activate the indicator "All currencies" in the control indicators, the SAP system will also update object and transaction currencies along with the controlling area currency.
In a 1:1 relationship between controlling area and company code, the system adopts the currency of the company code in the controlling area.
Use
You can plan your primary costs in as many currencies as you wish.
The currency which you enter in this field is the transaction currency. The data base records are updated separately according to this transaction currency.
Procedure
You must decide on one of the two alternatives:
If you do not determine a transaction currency, then all planning records are selected independent of their transaction currency. It is then possible to plan records in whichever transaction currencies you wish.
After you have determined a transaction currency, it then remains constant for the duration of a planning transaction.
The system can calculate the amounts of the other currency field groups automatically, for example the amount in cost center currency, based on the transaction currency.
The translations are carried out according to the following rule:
the amount is translated from the transaction currency into the controlling area currency and
This means that you should only include entries for these types of currency translation in the exchange rate table.
Examples
If your controlling area is managed in German Marks (group) and the foreign cost centers in Swiss Francs, you can still plan the costs of these cost centers in US dollars. The system will then automatically calculate the amounts in German Marks and Swiss francs for you. The amounts in each of the three currencies are stored in parallel.
Dependencies
There are direct dependencies between the controlling area, fiscal year, version and planning parameters fields. These dependencies determine whether the primary costs can be planned in different currencies or not.
If you want to plan in different currencies, you should note the following during translation:
The exchange rate in the exchange rate table is derived from the exchange rate type and the value date from the plan version. All translations then take place on this date. If you have not specified a value date, the system takes the first day of each plan period as the default.
The translation occurs in the sequence
Use
This entry determines the currency for your company code (country currency). The general ledger is managed in this currency.
Examples
Dependencies
Dependencies
If the allocation control indicator is set to 1, the SAP system makes an entry in the field automatically. If the indicator is set to 2, you must make an entry in the field yourself.
Use
The currency key can be used to determine the ranking order of the company"s banks as well as for method of payment. Entry is optional.
The payment program determines the ranking order based on the method and currency of payments. Here the following situations can arise:
If no entry for this combination is found, the system checks the banks for method of payment without specification of currency.
If the system finds an entry for this combination, it ignores any entry for the method of payment without specification of currency.
Procedure
Examples
Dependencies
Use
You can use as many currencies as you wish for activity-related cost transfer within controlling.
The currency you enter in this field is the transaction currency and remains constant for the duration of the cost transfer transaction. The system automatically calculates the amounts of the other currency field groups, such as the amount in cost center currency, from this currency.
The translations are carried out according to the following rule:
This means that you should only include entries for these types of currency translation in the exchange rate table.
Procedure
When you enter a transaction currency, the system translates the costs to be transferred in the above sequence with the posting date at the average rate.
Examples
Dependencies
There are direct and indirect dependencies to the controlling area and posting date fields. These dependencies determine whether a transfer posting can take place in different currencies or not.
The system determines the fiscal year for the posting date from the controlling area where a fiscal year variant is defined. The fiscal year enables the system to determine the control parameters for the controlling area. In the field "Update all currencies?" the control parameters define whether postings are allowed to be made in foreign currencies other than the controlling area currency.
Use
The currency key can be used to determine the bank account as well as the bank ID and the method of payment. This entry is optional.
The payment program determines the bank accounts based on the bank ID, the method of payment and the currency of payment. Here the following situations can arise:
If the system does not find an entry for this combination, it checks for the combination bank ID and method of payment without currency
If the system finds an entry for this combination, it ignores any entry for the method of payment without specification of currency.
Procedure
Examples
Dependencies
Use
This key is used to compute the amounts scheduled. This entry is obligatory.
The payment program checks the amounts based on the currency of payment. If no entry is found for this currency, the system defaults to the local currency.
Procedure
Examples
Dependencies
Use
You can select payment media issued in certain currencies. You must enter a currency key if you are looking for payment media which were issued for a particular amount.
Use
You can only select checks for a particular currency, because the system issues a summary record of all the checks selected. The currency is therefore a required entry for the program.
Use
The currency key for the country modifier is determined as follows:
the system searchs the plant section table (T001P) for the first entry which contains the current country modifier; this determines the plant
the valuation area is determined in the plant table (T001W)
the company code for this is read from the the valuation area table (T001K)
the company code currency from the company code table (T001) is displayed
If any one of these table entries is missing, the system does not issue a currency key.
Procedure
Examples
Dependencies
Use
This currency is the currency of the special advance payment amount for the advance report for tax on sales/purchases.
Use
The program works based on the transaction currency of the documents. In order that global sums can be created by the program (for displaying an overview of the differences of all company code pairs, for example), the transaction currency amounts are translated during the program run into the
display currency
 you specified. The current exchange rate on that particular day is usually used for this translation. If you wish to use a different exchange rate type, or a different date for translation, you can make the relevant setting on the
Further selections
 tab page.
Dependencies
Example
Dependencies
If you want to enter a purchase order in a currency different from the one defined in the vendor master record, then you must change the currency before entering the order items.
Dependencies
You need only specify a currency key if this is not transferred from the external system.
Use
Enter the currency in which the payroll accounting run, on which the posting data is based, was carried out.
Procedure
Examples
Dependencies
Use
Program RPLPAY00 (payments and deductions) lists the amounts of different infotypes in the relevant infotype currency.
If you specify a special output currency, all amounts are converted into this currency and output accordingly.
Procedure
Examples
Dependencies
Use
SAP stores every amount in the database without decimal places. The number of decimal places can only be determined once the currency is known - the amount can then be formatted.
Where no currency is defined for an amount field in a logging record, the system attempts to determine a currency using the organizational allocation of HR master data. If no currency is defined here, the amount is formatted using the currency defined in the "default currency" field.
The number of decimal places the amount has will therefore depends on the currency that is used.
Procedure
Examples
Dependencies
Note
Field changes
You can change this field for each fiscal year. For example, you can change the field content for a new fiscal year.
Time dependency
The data in this field is always
time-based
.
Use
Procedure
Examples
Dependencies
Use
Procedure
Examples
Dependencies
If you enter the
ordering costs
 in a currency which does not have two decimal places (Belgian Franc, for example), you must specify the currency here to ensure that the ordering costs are not incorrectly transferred to the material master.
Use
Currency in billing or invoicing plan. The transaction currency for the transaction or components is included as the currency.
Use
Limitation of items for processing.
Dependencies
You can only select items for an installment plan which were posted in the same currency.
Procedure
Examples
Dependencies';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Exchange Rate Amount" IS 'Definition
Rate used by the system in translating figures from a
foreign currency
 into the
local currency
.
Use
Your system is configured in such a way that it expects:
No prefix (leading sign) for direct rates
No prefix for indirect rates
Dependencies
Example
Your local currency is the US Dollar (USD) and your foreign currency is the Euro (EUR).
Direct rate (price notation)

One unit of the foreign currency EUR costs the displayed number of units of the local currency (1.95583 USD).
Indirect rate (volume notation)

One unit of your local currency, USD, costs the displayed number of units of the foreign currency (0.51129 EUR).';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Fixed Exchange Rate Indicator" IS 'Definition
Determines that the exchange rate used for currency translation purposes calculated or entered in the purchasing document is fixed.
Use
If you fix the exchange rate, the purchase order currency and the
exchange rate
 cannot be changed during
invoice verification
.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Purchasing Document Date" IS 'Definition
Date on which the
purchasing document
 was created.
Procedure
In the fields "PO date from/to" you specify the periods you wish to compare.
If you enter a date in the field "PO date 1 to" or "PO date 2 from", the system sets the remaining data to the beginning and end date of the year.
You can also compare overlapping periods e.g. 1.1. - 31.3 : 1.3. - 31.5.
Examples
If you enter the date 30.6. of the current year in the field "PO date to ", the system will set the data for a comparison of half-years (1.1. - 30.6 : 1.7. - 31.12).
Use
You can enter two different periods for which you wish to analyze changes in purchasing activities.
The system will then supply you with an overview of the purchasing documents created during this period.
Dependencies
Example';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Validity Period Start Date" IS 'Definition
Date as of which services can be performed or materials delivered.
Use
In the case of
outline agreements
:
Start of the stipulated validity period of an outline agreement.
In the case of
RFQs
:
Start of the period in which the quotation is to be submitted.
In the case of
purchase orders
:
Start of the period in which the service is to be performed or the material delivered.
Note
Service entry sheets can only be created within the specified period.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Validity Period End Date" IS 'Definition
Date up to which services can be performed or materials delivered.
Use
In the case of
outline agreements
:
End of the stipulated validity period of the agreement.
In the case of
RFQs
:
End of the period in which the quotation is to be submitted.
In the case of
POs
:
End of the period in which the service is to be performed or the material delivered.
Note
No further service entry sheets can be created after this date.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Application Close Date" IS 'Definition
Date by which the bidder must have indicated his willingness to submit a
quotation
 (bid).';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Quotation Submission End Date" IS 'Definition
Date by which the vendor is to submit the
quotation
.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Quotation Binding Date" IS 'Definition
Date until which the
quotation
 submitted is to be regarded as binding.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Warranty Date" IS 'Definition
Date defining the warranty period.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Quotation Invitation Number" IS 'Dependencies
The scrap in the operation causes a decrease in quantity in the next operation because the quantity to be processed is reduced by the scrap quantity. The reduction of quantity is taken into account in scheduling and costing.
Dependencies
Scrap accumulated during operation is calculated into a scrap-adjusted quantity. The quantity to be processed in the next operation is reduced to this value.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Quotation Number" IS 'Definition
Number of vendor"s
quotation
.
Use
The specification is for information only and is not evaluated by the system.
Procedure
Examples
Dependencies';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Quotation Submission Date" IS 'Definition
Date on which the vendor submitted the quotation.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Reference Number" IS 'Definition
The internal reference number of the customer or vendor.
Use
The reference number usually identifies the individual who is responsible for the document at the customer or vendor site. It can, for example, be the person"s initials.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Vendor Salesperson Name" IS 'NA';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Vendor Telephone Number" IS 'This entry is for information only. It is not copied into purchasing documents.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Vendor Identifier" IS 'Definition
Key identifying the vendor within the SAP system.
Use
If the vendor from whom the goods are ordered is not the actual supplier, you can enter the account number of the supplying vendor here.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Customer Number" IS 'Definition
Gives an alphanumeric key, which clearly identifies the customer or vendor in the SAP system.
Use
The customer number is used by the payment and dunning programs for clearing open items. For
line item display
, the link to the customer line items is established using this number.
Dependencies
If you require clearing between the
customer
 and vendor, the following requirements must be met:
The vendor number must have been entered in the corresponding customer master record.
The fields "Clrg with vend." or "Clrg with cust." must have been selected in both master records.
Use
The customer number is used to be able to call a VAT registration number (VAT reg.no.) from the master record.
It can be necessary to specify a VAT reg.no. in the G/L account items when entering cash discount paid manually. This number can, however, not be entered manually but is called by specifying a customer account number and the reporting country from the customer master record. This specification is needed for the EC sales list which is required for deliveries to other EC member states.
Procedure
Examples
Dependencies
Use
Limitation of the additional log to certain customer accounts
Procedure
Examples
Dependencies
The accrurals/deferrals of this report should only be used for test runs, or in instances where it is not possible to run the report without accrurals/deferrals. Further information can be found in the report documentation (application help).
Use
Bill of exchange:
You can specify the customer number. If you have specified this, the system checks whether the bill of exchange really concerns this customer. If not, a document is not posted during the posting run and an error message is issued.
Check:
This function has not yet been implemented.
Bank collection:
For bank collection, you always need to specify the customer to make sure that the correct customer is debited with the receivable.
Use
Allows the limitation of the customer numbers.
Procedure
Examples
Dependencies';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Purchase Agreement Number" IS 'Definition
Specifies the number of the
outline agreement
 that this purchase order or purchase requisition refers to.
Use
The outline agreement represents a source of supply for this purchase requisition.
When an outline agreement number has been entered, it is proposed to the purchasing department during the ordering process.
Procedure
You have two options with regard to the source of supply. You can:
Enter the source manually, or
The following purchasing data is checked in the order shown in order to determine whether it represents a
source of supply
 for the requested material:
quota arrangement
source list
outline agreement
The system suggests existing sources of supply for selection purposes.
Procedure
Enter the number of the contract for the release order.
Procedure
You can enter your selection criteria for this field in the following ways:
You enter an individual value in this field.
You enter an interval of values in this field and in the adjacent field.
You enter several intervals.
All
purchasing documents
 that satisfy your selection criteria will be displayed.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Unused Field 1" IS 'Definition
The reason for rejecting a quotation or a sales order.
Use
The rejection can come from your organization (for example, you can reject a customer request for a credit memo because it is unreasonable) or from the customer (for example, the customer rejects a quotation because the price is too high). The following list shows the effects on different document types after you enter a reason for rejection:
Inquiries and quotations: no further references by other documents
Sales orders: no further delivery of items
Contracts: no further creation of release orders
Credit and debit memo requests: no further processing of credit or debit memos
Procedure
Enter one of the values predefined for your system.
Dependencies
If you enter a reason for rejection, the system automatically cancels any
MRP
 requirements previously generated for the items.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Single Delivery Indicator" IS 'Definition
Specifies whether the materials of a
purchase order
 are to be supplied in a single delivery, or whether the purchase order may be fulfilled via several partial deliveries.
Note
The indicator is not checked at the time of goods receipt.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Goods Reciept Indicator" IS 'Definition
Indicator specifying that the system is to issue an appropriate message to the buyer following each
goods receipt
 in respect of this
purchase order
.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Supplier Plant Name" IS 'Definition
Describes the
plant
 from which the ordered material is supplied.
Use
The supplying, or issuing, plant is only entered in the case of
stock transport orders
.
Procedure
Enter the 4-character description of the plant that is to receive the material. Enter the supplying plant only if it differs from the ordering plant.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Unused Field 2" IS 'Definition
Alphanumeric key uniquely identifying the document.
Use
This number identifies the vendor who is to receive the goods in a
third-party
 or
subcontract
 order.
With the vendor number, information from the vendor master record (e.g. vendor"s address and bank) are copied into a purchasing document (e.g.
RFQ
 or
purchase order
).
The vendor number can be used to monitor RFQs, purchase orders and
outline agreements
.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Incoterm 1" IS 'Definition
Commonly-used trading terms that comply with the standards established by the International Chamber of Commerce (ICC).
Use
Incoterms specify certain internationally recognised procedures that the shipper and the receiving party must follow for the shipping transaction to be successfully completed.
Example
If goods are shipped through a port of departure, the appropriate Incoterm might be: FOB ("Free On Board"). You can provide further details (for example, the name of the port) in the secondary Incoterm field: FOB Boston, for example.
Procedure
The system proposes the Incoterm from the
customer master record
. You can change the Incoterm manually in the sales document.
Example
For a European customer to whom you ship goods through the port of Boston, the standard Incoterm might be: FOB ("Free on Board"). In the additional Incoterm field, you can add the port of departure "Boston".
Use
In the standard system, you can define a statistical value for the import or export of goods between member countries of the European Community in
purchasing info records
 and using specific
Incoterms
.
Procedure
Enter the key for the Incoterms which you want to define for the
master conditions
.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Incoterm 2" IS 'Definition
Additional information for the primary Incoterm.
Example
If the primary Incoterm is, for example, FOB ("Free on Board"), then the second field provides details of the port from which the delivery leaves (for example, "FOB Boston").
Procedure
The system proposes the secondary Incoterm from the
customer master record
. You can change it manually in the sales document.
Example
If the primary Incoterm is, for example, FOB ("Free on Board"), then the second field provides details of the port from which the shipment leaves (for example, "FOB Boston").';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Document Condition Code" IS 'Definition
The internal number under which the system saves
conditions
 that apply to a sales order, for example.
Example
The purchasing and sales departments may want to use the same order number for a document even though different conditions may apply in each area. The system uses the internal number to identify the different conditions.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Document Procedure Code" IS 'Definition
Specifies the conditions that are allowed for a
document
 and defines the sequence in which they are used.
Example
Procedures are used, for example, in the following applications:
Pricing in sales and distribution
Applying overhead in Product Costing (costing sheets) and for CO internal orders
Calculating accrued costs in Profitability Analysis
Output control (printed confirmations, EDI messages, electronic mail)
Account determination
Calculating taxes on sales/purchases
Calculating accruals in Cost Center Accounting
Pricing for resource planning';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Status Update Group Code" IS 'Definition
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
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Document Owner Name" IS 'Definition
Your company"s internal reference number or code.
Use
This usually identifies the person responsible for the purchasing document in your company. The reference number/code often consists of the relevant person"s initials.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Sub Item Interval Number" IS 'Definition
Indicates the interval in which sub-item numbers are suggested.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Release Group Identifier" IS 'Definition
Contains one or more
release strategies
.
Use
This permits the multiple usage of the same release strategy key.
Example
Release group 01 is defined for purchase requisitions and release group 02 for purchase orders. You can define release strategy S3 for both purchase requisitions and purchase orders.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Release Strategy Identifier" IS 'Definition
Key for the
release strategy
.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Release Code" IS 'Definition
Specifies whether the
purchasing document
 can be processed in or is blocked for follow-on functions.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Release Status Indicator" IS 'NA';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Release Approval Indicator" IS 'Definition
Specifies that the release (approval) process for the purchasing document has not yet been completed.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Tax Return Country Code" IS 'Definition
If the tax return is not to go to the tax authorities of the company code country, then here you can enter a country key which differs from the company code country.
Notes
You can only use this field if the "Plants abroad" flag is active.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Address Number" IS 'Definition
Internal key for identifying a Business Address Services address.
For more information about the meaning and use of the address number and the Business Address Services concepts, see the
function group SZA0
 documentation.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Tax ID Country Code" IS 'Definition
Specifies the key for the country of the VAT registration number.
Use
This key is used to check country-specific entries such as the length of the zip code or bank account number.
Note
You can define your own country keys in Customizing. Usually, the ID for vehicles (such as GB = Great Britain, CH = Switzerland) is used.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Cancel Reason Code" IS 'Definition
Reason why an end date was set in a periodic invoicing plan.
Use
This field is only used for the invoicing plan.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Processing Status Code" IS 'Purchasing document processing state
Field: PROCSTAT
Element: MEPROCSTATE
Domain: MEPROCSTATE                   ';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Total Purchase Amount" IS 'Total value at time of release
Field: RLWRT
Element: RLWRT
Domain: WERT15                        ';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Version Number" IS 'Version number in Purchasing
Field: REVNO
Element: REVNO';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Down Payment Indicator" IS 'Down Payment Indicator
Field: DPTYP
Element: ME_DPTYP';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Down Payment Percentage" IS 'Down Payment Percentage
Field: DPPCT
Element: ME_DPPCNT';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Down Payment Amount" IS 'Down Payment Amount in Document Currency
Field: DPAMT
Element: ME_DPAMNT';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Down Payment Due Date" IS 'Due Date for Down Payment
Field: DPDAT
Element: ME_DPDDAT';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Requirement Status Description" IS 'Requirement Status
Field: ZZREQMT_STAT
Element: ZD_REQMT_STAT';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Requirement Type Code" IS 'Requirement Type
Field: ZZREQMT_TYPE
Element: ZD_REQMT_TYPE';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Source Receive Timestamp" IS 'The date and time the source data file was received for processing and loading into a Data Lake / Data Warehouse table.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Load User Identifier" IS 'The userid or process id of the person or process which loaded the row into this data lake / data warehouse table.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Load Timestamp" IS 'The date and time when this row was inserted/loaded into the data lake / data warehouse table.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Update User Identifier" IS 'The userid or process id which last updated this row.';
COMMENT ON COLUMN GG_SAP_PRCH_DOC."Update Timestamp" IS 'The data and time this row was last updated.';
