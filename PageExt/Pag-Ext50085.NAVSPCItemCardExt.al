pageextension 50085 "NAVSPC_ItemCardExt" extends "Item Card"
{
    layout
    {
        addlast(Content)
        {
            group("Web Fields")
            {
                field("Allele"; Allele)
                {
                    ApplicationArea = all;
                    ShowMandatory = false;
                    Visible = true;
                }
                field("Peptide"; Peptide)
                {
                    ApplicationArea = all;
                    ShowMandatory = false;
                    Visible = true;
                }
                field("Antigen"; Antigen)
                {
                    ApplicationArea = all;
                    ShowMandatory = false;
                    Visible = true;
                }
                field("Disease Area"; "Disease Area")
                {
                    ApplicationArea = all;
                    ShowMandatory = false;
                    Visible = true;
                }
                field("Publishable online"; "Publishable online")
                {
                    ApplicationArea = all;
                    ShowMandatory = false;
                    Visible = true;
                }
            }
        }
        addafter(Description)
        {
            Field("Editable Description"; "Editable Description")
            {
                ApplicationArea = alle;
                ShowMandatory = false;
                Visible = true;
            }
        }
    }
    actions
    {
        modify(CreateItemVariantAndItemUoM)
        {
            Caption = 'Create Variants and UoM', Comment = 'Opret varevarianter og vareenheder';
            Promoted = True;
            trigger OnAfterAction()
            var
                IMUSubVariantMgtNew: Codeunit IMUSubVariantMgtNew;
            begin
                IMUSubVariantMgtNew.CreateItemVariantAndItemUoM(Rec, true);
            end;
        }
        modify(UpdateItemVariantAndItemUoM)
        {
            Caption = 'Update Variants and UoM', Comment = 'Opdater varevarianter og vareenheder';
            Promoted = True;
            trigger OnAfterAction()
            var
                IMUSubVariantMgtNew: Codeunit IMUSubVariantMgtNew;
            begin
                IMUSubVariantMgtNew.CreateItemVariantAndItemUoM(Rec, true);
            end;
        }
    }
}