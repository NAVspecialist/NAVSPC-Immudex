pageextension 50089 "SalesQuoteExt" extends "Sales Quote"
{
    layout
    {
        addbefore("Order Date")
        {
            field("Sales Quote Date"; "Sales Quote Date")
            {
                ApplicationArea = all;
                ShowMandatory = true;
            }
        }
        modify("Order Date")
        {
            Visible = false;
        }
        modify("Document Date")
        {
            Visible = false;
        }
    }
}
