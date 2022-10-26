pageextension 50024 "ShiptoAddressExt" extends "Ship-to Address"
{
    layout
    {
        addafter("Service Zone Code")
        {
            field("Salesperson Code"; "Salesperson Code")
            {
                ApplicationArea = all;
            }
        }
    }
}
