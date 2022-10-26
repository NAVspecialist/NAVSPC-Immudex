tableextension 50028 "SalesInvoiceHeaderTableExt" extends "Sales Invoice Header"
{
    fields
    {
        field(50080; "Sales Quote Date"; Date)
        {
            Caption = 'Sales Quote Date';
            DataClassification = ToBeClassified;
        }
        field(50081; "Exp. Shipment Date"; Date)
        {
            Caption = 'Exp. Shipment Date';
            DataClassification = ToBeClassified;
        }
        field(50082; "Act. Delivery Date"; Date)
        {
            Caption = 'Act. Delivery Date';
            DataClassification = ToBeClassified;
        }
        field(50083; "Ext. Sales Order No."; Code[20])
        {
            Caption = 'Ext. Sales Order No.';
            DataClassification = ToBeClassified;
        }
    }
}
