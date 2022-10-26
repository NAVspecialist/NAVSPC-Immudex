pageextension 50092 "PostedSalesInvoiceExt" extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Exp. Shipment Date"; "Exp. Shipment Date")
            {
                ApplicationArea = all;
            }
            field("Shipment Date2"; "Shipment Date")
            {
                Caption = 'Act. Shipment Date';
                ApplicationArea = all;
            }
            field("Act. Delivery Date"; "Act. Delivery Date")
            {
                ApplicationArea = All;
            }
        }
    }
}