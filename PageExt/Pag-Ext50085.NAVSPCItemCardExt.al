pageextension 50085 "NAVSPC_ItemCardExt" extends "Item Card"
{
    layout
    {
        addlast(Content)
        {
            group("Web Fields")
            {
                field("Allele"; Allele)
                {
                    ApplicationArea = all;
                    ShowMandatory = false;
                    Visible = true;
                }
                field("Peptide"; Peptide)
                {
                    ApplicationArea = all;
                    ShowMandatory = false;
                    Visible = true;
                }
                field("Antigen"; Antigen)
                {
                    ApplicationArea = all;
                    ShowMandatory = false;
                    Visible = true;
                }
                field("Disease Area"; "Disease Area")
                {
                    ApplicationArea = all;
                    ShowMandatory = false;
                    Visible = true;
                }
                field("Publishable online"; "Publishable online")
                {
                    ApplicationArea = all;
                    ShowMandatory = false;
                    Visible = true;
                }
            }
        }
        addafter(Description)
        {
            Field("Editable Description"; "Editable Description")
            {
                ApplicationArea = alle;
                ShowMandatory = false;
                Visible = true;
            }
        }
    }
    actions
    {
        addafter(CreateItemVariantAndItemUoM)
        {
            action(UpdateSalesPrices)
            {
                CaptionML = DAN = 'Opdater salgspriser', ENU = 'Update Salesprices';
                ToolTipML = DAN = 'Bruger Item Creation Template Koden ', ENU = 'Using the Item Creation Template Code';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;
                Image = NewItem;
                ApplicationArea = ALL;
                trigger OnAction();
                var
                    SalesPrice: Record "Sales Price";
                    ItemSalesPriceTemplateLine: Record ItemSalesPriceTemplateLine;
                    PricesUpdated_lbl: Label 'Prices are now updated';
                begin
                    Rec.TestField(ItemCreationTemplateCode);
                    ItemSalesPriceTemplateLine.RESET;
                    ItemSalesPriceTemplateLine.SetRange("Item No.", rec.ItemCreationTemplateCode);
                    if ItemSalesPriceTemplateLine.FINDSET(false, false) then begin
                        repeat
                            SalesPrice.RESET;
                            Salesprice.Setrange("Item No.", Rec."No.");
                            SalesPrice.Setrange("Sales Type", ItemSalesPriceTemplateLine."Sales Type");
                            salesprice.Setrange("Sales Code", ItemSalesPriceTemplateLine."Sales Code");
                            salesprice.Setrange("Starting Date", ItemSalesPriceTemplateLine."Starting Date");
                            salesprice.Setrange("Currency Code", ItemSalesPriceTemplateLine."Currency Code");
                            salesprice.Setrange("Variant Code", ItemSalesPriceTemplateLine."Variant Code");
                            salesprice.Setrange("Unit of Measure Code", ItemSalesPriceTemplateLine."Unit of Measure Code");
                            salesprice.Setrange("Minimum Quantity", ItemSalesPriceTemplateLine."Minimum Quantity");
                            if not SalesPrice.FindFirst() then begin
                                SalesPrice.INIT;
                                Salesprice.Validate("Item No.", rec."No.");
                                SalesPrice.Validate("Sales Type", ItemSalesPriceTemplateLine."Sales Type");
                                salesprice.Validate("Sales Code", ItemSalesPriceTemplateLine."Sales Code");
                                salesprice.Validate("Starting Date", ItemSalesPriceTemplateLine."Starting Date");
                                salesprice.Validate("Currency Code", ItemSalesPriceTemplateLine."Currency Code");
                                salesprice.Validate("Variant Code", ItemSalesPriceTemplateLine."Variant Code");
                                salesprice.Validate("Unit of Measure Code", ItemSalesPriceTemplateLine."Unit of Measure Code");
                                salesprice.Validate("Minimum Quantity", ItemSalesPriceTemplateLine."Minimum Quantity");
                                SalesPrice.Validate("Unit Price", ItemSalesPriceTemplateLine."Unit Price");
                                salesprice.Validate("Ending Date", ItemSalesPriceTemplateLine."Ending Date");
                                SalesPrice.Insert(true);
                            end else begin
                                SalesPrice.Validate("Unit Price", ItemSalesPriceTemplateLine."Unit Price");
                                salesprice.Validate("Ending Date", ItemSalesPriceTemplateLine."Ending Date");
                                Salesprice.Modify(true);
                            end;
                        until ItemSalesPriceTemplateLine.Next = 0;
                        Message(PricesUpdated_lbl);
                    end;
                end;
            }
        }
        modify(CreateItemVariantAndItemUoM)
        {
            Caption = 'Create Variants and UoM', Comment = 'Opret varevarianter og vareenheder';
            Promoted = True;
            trigger OnAfterAction()
            var
                IMUSubVariantMgtNew: Codeunit IMUSubVariantMgtNew;
            begin
                IMUSubVariantMgtNew.CreateItemVariantAndItemUoM(Rec, true);
            end;
        }
        modify(UpdateItemVariantAndItemUoM)
        {
            Caption = 'Update Variants and UoM', Comment = 'Opdater varevarianter og vareenheder';
            Promoted = True;
            trigger OnAfterAction()
            var
                IMUSubVariantMgtNew: Codeunit IMUSubVariantMgtNew;
            begin
                IMUSubVariantMgtNew.CreateItemVariantAndItemUoM(Rec, true);
            end;
        }
    }
}