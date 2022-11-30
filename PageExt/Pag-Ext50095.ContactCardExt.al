pageextension 50095 "ContactCardExt" extends "Contact Card"
{
    layout
    {
        addafter("Country/Region Code")
        {
            field(County; County)
            {
                ApplicationArea = all;
            }
        }
    }
}
