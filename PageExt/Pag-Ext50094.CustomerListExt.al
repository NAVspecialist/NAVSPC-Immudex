pageextension 50094 "CustomerListExt" extends "Customer List"
{
    layout
    {
        addafter("Name")
        {
            field("VAT Registration No."; "VAT Registration No.")
            {
                ApplicationArea = all;
                ShowMandatory = false;
                Visible = false;
            }
        }
        addafter("Salesperson Code")
        {
            field("County"; County)
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
    }
}
