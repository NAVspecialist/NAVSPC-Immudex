table 50016 "ItemSalesPriceTemplateLine"
{
    Caption = 'Item SalesPrice Template Line', Comment = 'ItemSalesPriceTemplateLine';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Item No."; Code[20])
        {
        }

        field(2; "Sales Code"; Code[20])
        {
            TableRelation = IF ("Sales Type" = CONST("Customer Price Group")) "Customer Price Group"
            ELSE
            IF ("Sales Type" = CONST(Customer)) Customer
            ELSE
            IF ("Sales Type" = CONST(Campaign)) Campaign;
        }

        field(3; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }

        field(4; "Starting Date"; Date)
        {
        }

        field(5; "Unit Price"; Decimal)
        {
            MinValue = 0;
            AutoFormatType = 2;
            AutoFormatExpression = "Currency Code";
        }

        field(7; "Price Includes VAT"; Boolean)
        {
        }

        field(10; "Allow Invoice Disc."; Boolean)
        {
            InitValue = true;
        }

        field(11; "VAT Bus. Posting Gr. (Price)"; Code[20])
        {
            TableRelation = "VAT Business Posting Group";
        }

        field(13; "Sales Type"; Option)
        {
            OptionMembers = "Customer","Customer Price Group","All Customers","Campaign";
            InitValue = "All Customers";
        }

        field(14; "Minimum Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }

        field(15; "Ending Date"; Date)
        {
        }

        field(5400; "Unit of Measure Code"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }

        field(5700; "Variant Code"; Code[10])
        {
            //  TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }

        field(7001; "Allow Line Disc."; Boolean)
        {
            InitValue = true;
        }
    }

    keys
    {
        key(PK; "Item No.", "Sales Type", "Sales Code", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity")
        {
            Clustered = false;
        }
        key(KEY1; "Sales Type", "Sales Code", "Item No.", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity")
        {
        }
    }
}