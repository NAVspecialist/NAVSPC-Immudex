pageextension 50090 "SalesOrderListExt" extends "Sales Order List"
{
    layout
    {
        addbefore("Document Date")
        {
            field("Sales Quote Date"; "Sales Quote Date")
            {
                ApplicationArea = all;
            }
        }
    }
}
