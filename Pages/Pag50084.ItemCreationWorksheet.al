page 50084 "Item Creation Worksheet"
{
    Caption = 'Item Creation Worksheet', Comment = 'Vareoprettelseskladde';
    PageType = Worksheet;
    SourceTable = "Item Creation Template Line";
    SaveValues = true;
    layout
    {
        area(content)
        {
            field(Allele; Allele)
            {
                Caption = 'Allele (%F1)';
            }
            field(Peptid_seq; Peptid_seq)
            {
                Caption = 'Peptid Seq (%F2)';
            }
            field(Grundcatno; Grundcatno)
            {
                Caption = 'Ground Cat No. (%F3)';
            }
            repeater(General)
            {
                field("Item Creation Group Code"; Rec."Item Creation Group Code")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field(Reserve; Rec.Reserve)
                {
                    ApplicationArea = All;
                }
                field("Assembly Policy"; Rec."Assembly Policy")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                }
                field("Replenishment System"; Rec."Replenishment System")
                {
                    ApplicationArea = All;
                }
                field("Tariff No."; Rec."Tariff No.")
                {
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Country/Region of Origin Code"; Rec."Country/Region of Origin Code")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field(ItemCreationTemplateCode; Rec.ItemCreationTemplateCode)
                {
                    ApplicationArea = All;
                }
                field("Item Tracking Code"; Rec."Item Tracking Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            Action(SuggestNewItems)
            {
                CaptionML = DAN = 'Foreslå nye varer', ENU = 'Suggest new items';
                Promoted = true;
                Image = NewItem;
                ApplicationArea = ALL;
                trigger OnAction()
                var
                    TempItemCTLine: Record "Item Creation Template Line" temporary;
                    TextString: Text[250];
                    TextPos: Integer;

                begin
                    IF Rec.IsEmpty then
                        ERROR('No Records in table') else begin
                        TempItemctline.Reset();
                        TempItemctline.DeleteAll();
                        Rec.Findset(False, false);
                        repeat
                            TempItemctline.TransferFields(Rec);
                            TempItemCTLine."Item No." := MyReplaceString(TempItemCTLine."Item No.", '%F1', Allele);
                            TempItemCTLine."Item No." := MyReplaceString(TempItemCTLine."Item No.", '%F2', Peptid_seq);
                            TempItemCTLine."Item No." := MyReplaceString(TempItemCTLine."Item No.", '%F3', Grundcatno);
                            TextPos := STRPOS(TempItemCTLine."Item No.", '%H5');
                            IF TextPos <> 0 then begin
                                TextString := Copystr(TempItemCTLine."Item No.", STRLEN(TempItemCTLine."Item No.") - 5 + 1);
                                TempItemCTLine."Item No." := CopySTr(TempItemCTLine."Item No.", 1, TextPoS - 1) + TextString;
                            end;


                            TempItemCTLine.Description := MyReplaceString(TempItemCTLine.Description, '%F1', Allele);
                            TempItemCTLine.Description := MyReplaceString(TempItemCTLine.Description, '%F2', Peptid_seq);
                            TempItemCTLine.Description := MyReplaceString(TempItemCTLine.Description, '%FF', Grundcatno);

                            TempItemCTLine."Search Description" := MyReplaceString(TempItemCTLine."Search Description", '%F1', Allele);
                            TempItemCTLine."Search Description" := MyReplaceString(TempItemCTLine."Search Description", '%F2', Peptid_seq);
                            TempItemCTLine."Search Description" := MyReplaceString(TempItemCTLine."Search Description", '%F3', Grundcatno);

                            TempItemCTLine.Insert(true);
                        until rec.next() = 0;
                        page.Run(Page::"Temp Item Creation Worksheet", TempItemCTLine);
                    end;
                end;

            }
        }
    }
    var
        Allele: Code[20];
        Peptid_seq: Code[20];
        Grundcatno: Code[20];

    procedure MyReplaceString(String: Text[250]; FindWhat: Text[100]; ReplaceWith: Text[100]): Text[250];
    var
        StartPos: Integer;
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        EXIT(String);
    end;
}