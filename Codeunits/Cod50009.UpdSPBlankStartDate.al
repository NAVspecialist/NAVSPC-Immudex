codeunit 50009 "Upd. SP Blank StartDate"
{
    var
        salesPrice: Record "Sales Price";
        newSalesPrice: Record "Sales Price";
        Windowdialog: Dialog;
        Counter: Decimal;
        TotalCounter: Decimal;

    trigger OnRun()
    begin
        salesPrice.reset;
        SalesPrice.Setfilter("Starting Date", '%1', 0D);
        SalesPrice.Setfilter("Ending Date", '%1', 0D);
        TotalCounter := salesPrice.count;
        WindowDialog.open('#1###### out of #2###### processed', Counter, TotalCounter);
        WindowDialog.Update(2, TotalCounter);
        if salesPrice.findset(true, false) then
            repeat
                Counter += 1;
                WindowDialog.Update(1, Counter);
                newSalesPrice.RESET;
                newsalesprice.setrange("Item No.", salesprice."Item No.");
                newsalesprice.setrange("Sales Type", salesprice."Sales Type");
                newsalesprice.setrange("Sales Code", salesprice."Sales Code");
                newsalesprice.SetRange("Starting Date", 20220701D);
                newsalesprice.setrange("Currency Code", salesprice."Currency Code");
                newsalesprice.setrange("Variant Code", salesprice."Variant Code");
                newsalesprice.SetRange("Unit of Measure Code", salesprice."Unit of Measure Code");
                newsalesprice.setrange("Minimum Quantity", salesprice."Minimum Quantity");
                if newSalesPrice.FINDFIRST then
                    if salesPrice."Starting Date" = 0D then begin
                        salesPrice."Ending Date" := 20220630D;
                        salesPrice.Modify(false);
                    end;
            until salesPrice.next = 0;
        Windowdialog.Close;
    end;
}
