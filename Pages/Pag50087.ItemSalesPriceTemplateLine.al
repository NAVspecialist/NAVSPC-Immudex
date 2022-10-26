page 50087 "ItemSalesPriceTemplateLine"
{
    Caption = 'Item Sales Price Template Line';
    PageType = ListPart;
    SourceTable = ItemSalesPriceTemplateLine;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Sales Type"; Rec."Sales Type")
                {
                    ApplicationArea = All;

                }
                field("Sales Code"; Rec."Sales Code")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Minimum Quantity"; Rec."Minimum Quantity")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Starting Date" := WorkDate();
    end;
}