tableextension 50025 "NAVSPC_ItemExt" extends "Item"
{
    fields
    {
        field(50020; "Allele"; Text[20])
        {
            Caption = 'Allele';
            DataClassification = ToBeClassified;
        }
        field(50021; "Peptide"; Text[20])
        {
            Caption = 'Peptide';
            DataClassification = ToBeClassified;
        }
        field(50022; "Antigen"; Text[50])
        {
            Caption = 'Antigen';
            DataClassification = ToBeClassified;
        }
        field(50023; "Disease Area"; Text[50])
        {
            Caption = 'Disease Area';
            DataClassification = ToBeClassified;
        }
        field(50024; "Publishable online"; Boolean)
        {
            Caption = 'Publishable online';
            DataClassification = ToBeClassified;
        }
        field(50030; "Editable Description"; Boolean)
        {
            Caption = 'Editable Description';
            DataClassification = ToBeClassified;
        }
    }
}