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
        field(30; "Inventory Posting Group"; Code[20])
        {
            TableRelation = "Inventory Posting Group";
            CaptionML = DAN = 'Varebogføringsgruppe', ENU = 'Inventory Posting Group';
        }

        field(31; "Net Weight"; Decimal)
        {
            CaptionML = DAN = 'Nettovægt', ENU = 'Net Weight';
        }

        field(32; "Tariff No."; Code[20])
        {
            TableRelation = "Tariff Number";
            CaptionML = DAN = 'Varekode', ENU = 'Tariff No.';
        }

        field(33; "Gen. Prod. Posting Group"; Code[20])
        {
            TableRelation = "Gen. Product Posting Group";
            CaptionML = DAN = 'Produktbogføringsgruppe', ENU = 'Gen. Prod. Posting Group';
        }

        field(34; "Country/Region of Origin Code"; Code[10])
        {
            TableRelation = "Country/Region";
            CaptionML = DAN = 'Lande-/områdekode for oprindelse', ENU = 'Country/Region of Origin Code';
        }

        field(35; "VAT Prod. Posting Group"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";
            CaptionML = DAN = 'Momsproduktbogf.gruppe', ENU = 'VAT Prod. Posting Group';
        }
        field(36; Reserve; Option)
        {
            OptionMembers = Never,Optional,Always;
            CaptionML = DAN = 'Reserver', ENU = 'Reserve';
        }

        field(37; "Assembly Policy"; Option)
        {
            OptionMembers = "Assemble-to-Stock","Assemble-to-Order";
            CaptionML = DAN = 'Montagepolitik', ENU = 'Assembly Policy';
        }

        field(50; "Reordering Policy"; Option)
        {
            OptionMembers = " ","Fixed Reorder Qty.","Maximum Qty.",Order,"Lot-for-Lot";
            CaptionML = DAN = 'Genbestillingsmetode', ENU = 'Reordering Policy';
        }

        field(60; "Item Category Id"; Code[20])
        {
            TableRelation = "Item Category";
            CaptionML = DAN = 'Varekategori-id', ENU = 'Item Category Id';
        }

        field(70; "Item Tracking Code"; Code[10])
        {
            TableRelation = "Item Tracking Code";
            CaptionML = DAN = 'Varesporingskode', ENU = 'Item Tracking Code';
        }
    }

    keys
    {
        key(PK; "Item Creation Group Code", "Item No.")
        {
            Clustered = false;
        }
    }
}