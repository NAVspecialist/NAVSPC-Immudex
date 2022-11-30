page 50085 "Temp Item Creation Worksheet"
{
    Caption = 'Item Creation Worksheet', Comment = 'Vareoprettelseskladde';
    PageType = Worksheet;
    SourceTable = "Item Creation Template Line";
    SourceTableTemporary = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item Creation Group Code"; Rec."Item Creation Group Code")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
                field(ItemExists; ItemExists)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field(Reserve; Rec.Reserve)
                {
                    ApplicationArea = All;
                }
                field("Assembly Policy"; Rec."Assembly Policy")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                }
                field("Reordering Policy"; Rec."Reordering Policy")
                {
                    ApplicationArea = All;
                }
                field("Tariff No."; Rec."Tariff No.")
                {
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Country/Region of Origin Code"; Rec."Country/Region of Origin Code")
                {
                    ApplicationArea = All;
                }
                field("Item Category Id"; Rec."Item Category Id")
                {
                    ApplicationArea = All;
                }
                field(ItemCreationTemplateCode; Rec.ItemCreationTemplateCode)
                {
                    ApplicationArea = All;
                }
                field("Item Tracking Code"; Rec."Item Tracking Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            Action(SuggestNewItems)
            {
                CaptionML = DAN = 'Opret nye varer', ENU = 'Create New Items';
                Promoted = true;
                Image = NewItem;
                ApplicationArea = ALL;
                trigger OnAction()
                var
                    TempItemCTLine: Record "Item Creation Template Line" temporary;
                    IMUSubVariantMgt: Codeunit IMUSubVariantMgt;
                    IMUSubVariantMgtNew: Codeunit IMUSubVariantMgtNew;
                    ItemUnitOfMeasure: Record "Item Unit of Measure";
                    Item: Record "Item";
                begin
                    IF Rec.IsEmpty then
                        ERROR('No Records in table') else begin
                        repeat
                            //# Create Item
                            IF NOT Item.Get(Rec."Item No.") then begin
                                //# clear(IMUSubVariantMgt);
                                //# clear(IMUSubVariantMgtNew);

                                Item.INIT;
                                Item.Validate("No.", Rec."Item No.");
                                ITEM.INSERT(true);
                                Item.Validate(Description, Rec.Description);
                                Item.Validate("Search Description", Rec."Search Description");

                                ItemUnitOfMeasure.INIT;
                                ItemUnitOfMeasure.Validate("Item No.", Item."No.");
                                ItemUnitOfMeasure.Validate(Code, Rec."Unit of Measure Code");
                                ItemUnitOfMeasure.insert(true);

                                Item.Validate("Base Unit of Measure", Rec."Unit of Measure Code");
                                //
                                //                                Item.Validate("Inventory Posting Group", Rec."Inventory Posting Group");
                                //                                Item.Validate("Item Category Id", Rec."Item Category Id");
                                Item.Validate(ItemCreationTemplateCode, rec.ItemCreationTemplateCode);
                                //                                Item.Validate("Tariff No.", Rec."Tariff No.");
                                //                                Item.Validate("Gen. Prod. Posting Group", rec."Gen. Prod. Posting Group");
                                //                                Item.Validate("Country/Region of Origin Code", rec."Country/Region of Origin Code");
                                //                                Item.Validate("VAT Prod. Posting Group", rec."VAT Prod. Posting Group");
                                //                                Item.Validate(Reserve, rec.Reserve);
                                //                                Item.validate("Assembly Policy", Rec."Assembly Policy");
                                //                                Item.validate("Reordering Policy", Rec."Reordering Policy");
                                //                                item.Validate("Item Category Id", rec."Item Category Id");

                                Item.Modify(true);
                                COMMIT;

                                //# Create Variants
                                IF strlen(rec.ItemCreationTemplateCode) <> 0 THEN
                                    IMUSubVariantMgt.CreateItemVariantAndItemUoM(Item, true);
                                COMMIT;
                                //# Create Salesprices
                                IF strlen(rec.ItemCreationTemplateCode) <> 0 THEN
                                    IMUSubVariantMgtNew.CreateItemVariantAndItemUoM(Item, true);
                                COMMIT;
                            end;
                        until rec.Next() = 0;
                        Message('Items Created!');
                    end;
                end;
            }
        }
    }
    var
        ItemExists: Boolean;
        Item: Record "Item";
        StyleTxt: Text[20];

    trigger OnAfterGetRecord()
    begin
        ItemExists := False;
        StyleTxt := '';
        IF item.get(rec."Item No.") then Begin
            StyleTxt := 'Unfavorable';
            ItemExists := True;
        End
    end;

}