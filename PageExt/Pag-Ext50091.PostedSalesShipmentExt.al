pageextension 50091 "PostedSalesShipmentExt" extends "Posted Sales Shipment"
{
    layout
    {
        addafter("Promised Delivery Date")
        {
            field("Act. Delivery Date"; "Act. Delivery Date")
            {
                ApplicationArea = all;
            }
        }
    }
}
