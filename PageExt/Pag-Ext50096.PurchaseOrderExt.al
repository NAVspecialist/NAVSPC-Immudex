pageextension 50096 "PurchaseOrderExt" extends "Purchase Order"
{
    layout
    {
        addafter("Vendor Order No.")
        {
            field("Sales Order No."; "Sales Order No.")
            {
                ApplicationArea = all;
            }
        }
    }
}
