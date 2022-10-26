codeunit 50010 "IMUSubVariantMgtNEW"
{
    procedure CreateItemVariantAndItemUoM(var Item: Record item; UseDialog: Boolean)
    var
        ItemCreationTemplate: Record ItemCreationTemplateHeader;
        ItemSalesPriceTemplateLine: Record "ItemSalesPriceTemplateLine";
        SalesPrice: Record "Sales Price";
        Created: Boolean;
        MsgDone: Label 'Item Variants and Item Unit of Measures Created', Comment = 'Varevarianter og vareenheder er oprettet';
        MsgNothingToDo: Label 'Nothing to do', Comment = 'Intet at udføre';
    begin
        Item.TestField("Base Unit of Measure");
        Item.TestField(ItemCreationTemplateCode);
        Created := false;

        ItemCreationTemplate.reseT;
        ItemCreationTemplate.setrange(code, Item.ItemCreationTemplateCode);
        ItemCreationTemplate.FindFirst;
        ItemSalesPriceTemplateLine.RESET;
        ItemSalesPriceTemplateLine.SetRange("Item No.", ItemCreationTemplate.Code);
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

    end;
}
