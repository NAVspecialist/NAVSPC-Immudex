pageextension 50025 "ShiptoAddressListExt" extends "Ship-to Address List"
{
    layout
    {
        addafter("Name")
        {
            field("Salesperson Code"; "Salesperson Code")
            {
                ApplicationArea = All;
            }
        }
        addbefore("Name")
        {
            field("Customer No."; "Customer No.")
            {
                ApplicationArea = All;
            }
        }
        addbefore("City")
        {
            field("County"; County)
            {
                ApplicationArea = All;
            }
        }
    }
}