codeunit 50008 "Update Item Sales Prices"
{
    var
        Item: Record Item;
        salesPriceWorksheet: Record "Sales Price Worksheet";
        salesPrice: Record "Sales Price";
        purchasePrice: Record "Purchase Price";
        Windowdialog: Dialog;
        Counter: Decimal;
        TotalCounter: Decimal;

    trigger OnRun()
    begin
        item.reset;
        TotalCounter := Item.count;
        WindowDialog.open('#1###### out of #2###### Items is processed', Counter, TotalCounter);
        WindowDialog.Update(2, TotalCounter);
        if item.findset then
            repeat
                Counter += 1;
                WindowDialog.Update(1, Counter);
                if Item."Item Category Code" <> '' then begin
                    salesPriceWorksheet.RESET;
                    salesPriceWorksheet.Setrange("Sales Code", Item."Item Category Code");
                    salesPriceWorksheet.Setfilter("New Unit Price", '<>0');
                    salespriceworksheet.setrange("Currency Code", 'EUR');
                    if salesPriceWorksheet.FINDSET then
                        if CompanyName = 'Immudex ApS' then begin
                            repeat
                                SalesPrice.Reset();
                                salesPrice.Init();
                                salesPrice."Item No." := Item."No.";
                                Salesprice."Sales Type" := salesPrice."Sales Type"::"All Customers";
                                salesprice."Starting Date" := 20220701D;
                                salesPrice."Currency Code" := 'EUR';
                                salesprice."Unit of Measure Code" := salesPriceWorksheet."Unit of Measure Code";
                                salesprice."Unit Price" := salesPriceWorksheet."New Unit Price";
                                if not salesPrice.Insert then;
                            until salesPriceWorksheet.next = 0;
                        end;
                    salespriceworksheet.setrange("Currency Code", 'USD');
                    if salesPriceWorksheet.FINDSET then
                        repeat
                            SalesPrice.Reset();
                            salesPrice.Init();
                            salesPrice."Item No." := Item."No.";
                            Salesprice."Sales Type" := salesPrice."Sales Type"::"All Customers";
                            salesprice."Starting Date" := 20220701D;
                            salesPrice."Currency Code" := 'USD';
                            salesprice."Unit of Measure Code" := salesPriceWorksheet."Unit of Measure Code";
                            salesprice."Unit Price" := salesPriceWorksheet."New Unit Price";
                            if not salesPrice.Insert then;
                        until salesPriceWorksheet.next = 0;

                    if CompanyName = 'Immudex LLC' then begin
                        salesPriceWorksheet.RESET;
                        salesPriceWorksheet.Setrange("Sales Code", Item."Item Category Code");
                        salesPriceWorksheet.Setfilter("Current Unit Price", '<>0');
                        salespriceworksheet.setrange("Currency Code", 'USD');
                        if salesPriceWorksheet.FINDSET then
                            repeat
                                purchasePrice.Reset();
                                purchasePrice.Init();
                                purchasePrice."Item No." := Item."No.";
                                purchaseprice."Vendor No." := 'K00386';
                                purchasePrice."Starting Date" := 20220701D;
                                purchasePrice."Currency Code" := 'USD';
                                purchasePrice."Unit of Measure Code" := salesPriceWorksheet."Unit of Measure Code";
                                purchasePrice."Direct Unit Cost" := salesPriceWorksheet."Current Unit Price";
                                if not purchasePrice.Insert then;
                            until salesPriceWorksheet.next = 0;
                    end;
                end;
            until item.next = 0;
        Windowdialog.Close;
    end;
}
