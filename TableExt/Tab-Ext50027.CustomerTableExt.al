tableextension 50027 "CustomerTableExt" extends Customer
{
    fields
    {
        modify(Name)
        {
            trigger OnAfterValidate()
            var
                SalesSetup: Record "Sales & Receivables Setup";
                GenSetup: Record "General Ledger Setup";
            begin
                GenSetup.Get;
                if ((GenSetup."LCY Code" = 'DKK') and (xrec.Name = '')) then begin
                    SalesSetup.Get;
                    if SalesSetup."Default Currency Code" <> '' then
                        if Rec."Currency Code" = '' then
                            Rec.Validate("Currency Code", SalesSetup."Default Currency Code");
                end;
            end;
        }
    }
}
