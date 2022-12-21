pageextension 50097 "ItemCreationTemplateListExt" extends "ItemCreationTemplateList"
{
    layout
    {
    }
    actions
    {
        addlast(Creation)
        {
            group(MyNewActionGroup)
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
                        Item: Record Item;
                        SalesPrice: Record "Sales Price";
                        ItemSalesPriceTemplateLine: Record ItemSalesPriceTemplateLine;
                        Dialog1_lbl: Label 'Updating Items: @1@@@@@@@@@@@@@\';
                        Dialog2_lbl: Label 'Item: #2############# ';
                        Error001_lbl: Label 'No Items with this Code';
                        PricesUpdated_lbl: Label 'SalesPrices are now updated';
                        Window: Dialog;
                        Counter: Integer;
                        CounterTotal: Integer;
                    begin
                        ItemSalesPriceTemplateLine.RESET;
                        ItemSalesPriceTemplateLine.SetRange("Item No.", rec.Code);

                        Item.Reset;
                        Item.setfilter(ItemCreationTemplateCode, Rec.Code);
                        Item.Findset(false, false);
                        CounterTotal := Item.Count;
                        IF CounterTotal = 0 then
                            error(Error001_lbl);
                        Window.Open(Dialog1_lbl + Dialog2_lbl);
                        Repeat
                            Counter += 1;
                            Window.Update(1, Round(Counter / CounterTotal * 10000, 1));
                            Window.Update(2, Item."No.");

                            if ItemSalesPriceTemplateLine.FINDSET(false, false) then begin
                                repeat
                                    SalesPrice.RESET;
                                    Salesprice.Setrange("Item No.", Item."No.");
                                    SalesPrice.Setrange("Sales Type", ItemSalesPriceTemplateLine."Sales Type");
                                    salesprice.Setrange("Sales Code", ItemSalesPriceTemplateLine."Sales Code");
                                    salesprice.Setrange("Starting Date", ItemSalesPriceTemplateLine."Starting Date");
                                    salesprice.Setrange("Currency Code", ItemSalesPriceTemplateLine."Currency Code");
                                    salesprice.Setrange("Variant Code", ItemSalesPriceTemplateLine."Variant Code");
                                    salesprice.Setrange("Unit of Measure Code", ItemSalesPriceTemplateLine."Unit of Measure Code");
                                    salesprice.Setrange("Minimum Quantity", ItemSalesPriceTemplateLine."Minimum Quantity");
                                    if not SalesPrice.FindFirst() then begin
                                        SalesPrice.INIT;
                                        Salesprice.Validate("Item No.", Item."No.");
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
                            end;
                        Until Item.Next = 0;
                        window.Close();
                        Message(PricesUpdated_lbl);
                    end;
                }
            }
        }
    }
}