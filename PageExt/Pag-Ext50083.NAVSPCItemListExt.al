pageextension 50083 "NAVSPC_ItemListExt" extends "Item List"
{
    layout
    {
        addafter(Description)
        {

            field("Allele"; Allele)
            {
                ApplicationArea = all;
                ShowMandatory = false;
                Visible = false;
            }
            field("Peptide"; Peptide)
            {
                ApplicationArea = all;
                ShowMandatory = false;
                Visible = false;
            }
            field("Antigen"; Antigen)
            {
                ApplicationArea = all;
                ShowMandatory = false;
                Visible = false;
            }
            field("Disease Area"; "Disease Area")
            {
                ApplicationArea = all;
                ShowMandatory = false;
                Visible = false;
            }
        }
    }
    actions
    {
        addlast("Processing")
        {
            action("Item Creation Worksheet")
            {
                Caption = 'Item Creation Worksheet', Comment = 'Vareoprettelsesskabelon';
                Promoted = True;

                ApplicationArea = All;
                RunObject = page "Item Creation Worksheet";
            }
        }

    }
}