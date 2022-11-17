table 50017 "Item Creation Template Line"
{
    Caption = 'Item Creation Template Line', Comment = 'Item Creation Template Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Item Creation Group Code"; Code[10])
        {
            Caption = 'Item Creation Group Code';
            DataClassification = ToBeClassified;
        }
        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Description"; Text[80])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(7; "Search Description"; Text[80])
        {
            Caption = 'Search Description';
            DataClassification = ToBeClassified;
        }
        field(8; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }

        field(20; ItemCreationTemplateCode; Code[20])
        {
            Caption = 'Item Creation Template Code', Comment = 'Vareoprettelsesskabelonkode';
            TableRelation = ItemCreationTemplateHeader where(Code = filter(<> ''));
        }
    }

    keys
    {
        key(PK; "Item Creation Group Code", "Item No.")
        {
            Clustered = false;
        }
        //       key(KEY1; "Item Creation Group Code","Item No.")
        //       {
        //       }
    }
}