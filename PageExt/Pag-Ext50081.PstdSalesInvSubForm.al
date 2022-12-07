pageextension 50081 "PstdSalesInvSubForm" extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter("No.")
        {
            field("IMU Sub Variant 1 Code"; "IMU Sub Variant 1 Code")
            {
                ApplicationArea = All;
                ShowMandatory = true;
                Editable = false;
            }
            field("IMU Sub Variant 2 Code"; "IMU Sub Variant 2 Code")
            {
                ApplicationArea = All;
                ShowMandatory = true;
                Editable = false;
            }
        }
    }
}