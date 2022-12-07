codeunit 50011 "Fix Sales Invoice Lines"
{
    var
        SalesInvoiceLines: Record "Sales Invoice Line";
        Item: Record Item;
        ItemVariant: Record "Item Variant";
        WindowDialog: Dialog;
        Counter: Integer;
        TotalCounter: Integer;

    trigger OnRun()
    begin
        //# Update Sub Variant Code 1
        SalesInvoiceLines.RESET;
        TotalCounter := SalesInvoiceLines.Count;
        WindowDialog.open('#1###### out of #2###### processed', Counter, TotalCounter);
        WindowDialog.Update(2, TotalCounter);
        if SalesInvoiceLines.findset(true, false) then
            repeat
                Counter += 1;
                WindowDialog.Update(1, Counter);

                if ((SalesInvoiceLines.type = SalesInvoiceLines.Type::Item) and
                    (SalesInvoiceLines."No." <> '') and
                    (SalesInvoiceLines."Variant Code" <> '') and
                    (SalesInvoiceLines."IMU Sub Variant 1 Code" = '')) then
                    IF ItemVariant.Get(SalesInvoiceLines."No.", SalesInvoiceLines."Variant Code") then begin
                        SalesInvoiceLines."IMU Sub Variant 1 Code" := ItemVariant."IMU Sub Variant 1 Code";
                        SalesInvoiceLines.Modify(false);
                    end;
            until SalesInvoiceLines.next = 0;
        Windowdialog.Close;
        //# Update Item Category Code
        SalesInvoiceLines.RESET;
        TotalCounter := SalesInvoiceLines.Count;
        WindowDialog.open('#1###### out of #2###### processed', Counter, TotalCounter);
        WindowDialog.Update(2, TotalCounter);
        if SalesInvoiceLines.findset(true, false) then
            repeat
                Counter += 1;
                WindowDialog.Update(1, Counter);

                if ((SalesInvoiceLines.type = SalesInvoiceLines.Type::Item) and
                    (SalesInvoiceLines."No." <> '') and
                    (SalesInvoiceLines."Item Category Code" = '')) then
                    IF Item.Get(SalesInvoiceLines."No.") then
                        IF Item."Item Category Code" <> '' then begin
                            SalesInvoiceLines."Item Category Code" := Item."Item Category Code";
                            SalesInvoiceLines.Modify(false);
                        end;
            until SalesInvoiceLines.next = 0;
        Windowdialog.Close;
    end;
}
