pageextension 50088 "SalesQuotesExt" extends "Sales Quotes"
{
    layout
    {
        addafter("No.")
        {
            field("Sales Quote Date"; "Sales Quote Date")
            {
                ApplicationArea = all;
                ShowMandatory = true;
            }
        }
    }
}
