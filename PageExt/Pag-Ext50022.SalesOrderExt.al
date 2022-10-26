pageextension 50022 SalesOrderExt extends "Sales Order"
{
    layout
    {
        addafter("Order Date")
        {
            field("Shipment Date2"; "Shipment Date")
            {
                Caption = 'Act. Shipment Date';
                ApplicationArea = All;
                ShowMandatory = true;
            }
        }
        addafter("Direct Debit Mandate ID")
        {
            field("Applies-to Doc. Type"; "Applies-to Doc. Type")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
            field("Applies-to Doc. No."; "Applies-to Doc. No.")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
        }
        addbefore("Order Date")
        {
            field("Sales Quote Date"; "Sales Quote Date")
            {
                ApplicationArea = All;
            }
        }
        addbefore("Shipment Date2")
        {
            field("Exp. Shipment Date"; "Exp. Shipment Date")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
        }
        addafter("Shipment Date2")
        {
            field("Act. Delivery Date"; "Act. Delivery Date")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
        }
    }
}