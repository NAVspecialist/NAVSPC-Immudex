tableextension 50026 "SalesAndReceivablesSetup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "Default Currency Code"; Code[10])
        {
            Caption = 'Default Currency Code';
            TableRelation = "Currency";
            DataClassification = ToBeClassified;
        }
    }
}
