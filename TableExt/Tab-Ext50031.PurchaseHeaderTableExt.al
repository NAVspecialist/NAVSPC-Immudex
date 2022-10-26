tableextension 50031 "PurchaseHeaderTableExt" extends "Purchase Header"
{
    fields
    {
        field(50083; "Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            DataClassification = ToBeClassified;
        }
    }
}
