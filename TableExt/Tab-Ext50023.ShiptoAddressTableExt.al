tableextension 50023 "ShiptoAddressTableExt" extends "Ship-to Address"
{
    fields
    {
        field(50000; "Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
            DataClassification = ToBeClassified;
        }
    }
}
