pageextension 50087 "SalesInvoiceExt" extends "Sales Invoice"
{
    layout
    {
        addafter("Location Code")
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
    }
}