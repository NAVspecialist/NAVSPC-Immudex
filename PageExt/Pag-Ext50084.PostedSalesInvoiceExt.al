pageextension 50084 "PostedSalesInvoicesExt" extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Remaining Amount")
        {
            field("Quote No."; "Quote No.")
            {
                ApplicationArea = all;
                ShowMandatory = false;
                Visible = true;
            }
        }
        addafter("Location Code")
        {
            field("Ship-to County"; "Ship-to County")
            {
                ApplicationArea = all;
            }
        }
    }
}