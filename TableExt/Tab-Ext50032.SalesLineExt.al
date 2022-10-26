tableextension 50032 SalesLineExt extends "Sales Line"
{
    fields
    {
        modify(Description)
        {
            trigger OnAfterValidate()
            var
                Item: Record "Item";
                NotEditabletxt: Label 'It is not allowed to change the Description!', Comment = '', MaxLength = 999, Locked = true;
            begin
                if (("Document Type" = "Document Type"::Order) and (Type = type::Item) and ("No." <> '')) then
                    if Item.Get("No.") then
                        if Item."Editable Description" = false then begin
                            If CurrFieldNo = 11 then
                                Error(NotEditabletxt);
                        end;

            end
                ;
        }
    }
}
