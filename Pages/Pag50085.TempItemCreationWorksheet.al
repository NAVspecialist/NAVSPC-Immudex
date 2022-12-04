page 50085 "Temp Item Creation Worksheet"
{
    Caption = 'Item Creation Worksheet', Comment = 'Vareoprettelseskladde';
    PageType = Worksheet;
    SourceTable = "Item Creation Template Line";
    UsageCategory = Tasks;
    SourceTableTemporary = true;
    AutoSplitKey = true;
    DelayedInsert = true;

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
                field("Replenishment System"; Rec."Replenishment System")
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
                field("Item Category Code"; Rec."Item Category Code")
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
                    Dialog1_lbl: Label 'Creating Items: @1@@@@@@@@@@@@@\';
                    Dialog2_lbl: Label 'Item: #2############# ';
                    Error001_lbl: Label 'No Records in table!';
                    Created_lbl: Label 'Items created';
                    iTempItemCTLine: Record "Item Creation Template Line" temporary;
                    IMUSubVariantMgt: Codeunit IMUSubVariantMgt;
                    IMUSubVariantMgtNew: Codeunit IMUSubVariantMgtNew;
                    ItemUnitOfMeasure: Record "Item Unit of Measure";
                    Item: Record "Item";
                    Window: Dialog;
                    Counter: Integer;
                    CounterTotal: Integer;

                begin
                    Rec.reset;
                    Rec.Findset(false, false);
                    CounterTotal := rec.Count;
                    IF CounterTotal = 0 then
                        error(Error001_lbl);
                    Window.Open(Dialog1_lbl + Dialog2_lbl);
                    repeat
                        Counter += 1;
                        Window.Update(1, Round(Counter / CounterTotal * 10000, 1));
                        Window.Update(2, Rec."Item No.");
                        //# Create Item
                        IF NOT Item.Get(Rec."Item No.") then begin
                            clear(IMUSubVariantMgt);
                            clear(IMUSubVariantMgtNew);

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
                            Item.Validate("Inventory Posting Group", Rec."Inventory Posting Group");
                            Item.Validate(ItemCreationTemplateCode, rec.ItemCreationTemplateCode);
                            Item.Validate("Gen. Prod. Posting Group", rec."Gen. Prod. Posting Group");
                            Item.Validate("VAT Prod. Posting Group", rec."VAT Prod. Posting Group");
                            Item.Validate("Country/Region of Origin Code", rec."Country/Region of Origin Code");
                            Item.Validate("Tariff No.", Rec."Tariff No.");
                            Item.Validate(Reserve, rec.Reserve);
                            Item.validate("Replenishment System", Rec."Replenishment System");
                            Item.validate("Assembly Policy", Rec."Assembly Policy");
                            item.Validate("Item Category Code", rec."Item Category Code");
                            Item.Modify(true);
                            COMMIT;

                            //# Create Variants
                            IF strlen(rec.ItemCreationTemplateCode) <> 0 THEN begin
                                IMUSubVariantMgt.CreateItemVariantAndItemUoM(Item, false);
                                COMMIT;
                            end;
                            //# Create Salesprices
                            IF strlen(rec.ItemCreationTemplateCode) <> 0 THEN begin
                                IMUSubVariantMgtNew.CreateItemVariantAndItemUoM(Item, false);
                                COMMIT;
                            end;
                        end;
                    until rec.Next() = 0;
                    Window.Close();
                    Message(Created_lbl);
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
        IF item.get(rec."Item No.") then begin
            StyleTxt := 'Unfavorable';
            ItemExists := True;
        end
    end;

}