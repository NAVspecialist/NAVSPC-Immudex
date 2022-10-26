pageextension 50086 "SalesAndReceivablesSetupExt" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Credit Warnings")
        {
            field("Default Currency Code"; "Default Currency Code")
            {
                ApplicationArea = all;
                ShowMandatory = true;
            }
        }
    }
}
