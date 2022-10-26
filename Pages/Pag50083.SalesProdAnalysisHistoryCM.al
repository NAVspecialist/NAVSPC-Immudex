page 50083 "Sales Prod Analysis History CM"
{
    Caption = 'Sales Prod Analysis History CM';
    PageType = List;
    SourceTable = "Sales Cr.Memo Line";
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTableView = where("Type" = filter(Item));
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Credit Memo No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("External Order No."; salesCrMemoHeader."External Document No.")
                {
                    ApplicationArea = All;
                }

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("IMU Sub Variant 1 Code"; Rec."IMU Sub Variant 1 Code")
                {
                    ApplicationArea = All;
                }
                field("IMU Sub Variant 2 Code"; Rec."IMU Sub Variant 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Line Discount%"; "Line Discount %")
                {
                    ApplicationArea = All;
                }
                field("Line Amount Excl. VAT"; "Line Amount")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Name"; salesCrMemoHeader."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Country"; salesCrMemoHeader."Sell-to Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Ext. Sales Order No."; salesCrMemoHeader."Ext. Sales Order No.")
                {
                    ApplicationArea = all;
                }

                field("Assembly BOM No."; postedAssemblyHeader."No.")
                {
                    ApplicationArea = All;
                }
                field("Assembly BOM Starting Date"; postedAssemblyHeader."Starting Date")
                {
                    ApplicationArea = all;
                }
                field("Assembly BOM Ending Date"; postedAssemblyHeader."Ending Date")
                {
                    ApplicationArea = all;
                }
                field("Assembly BOM Posting Date"; postedAssemblyHeader."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("valueEntry.Entry No."; valueEntry."Entry No.")
                {
                    ApplicationArea = all;
                }
                field("ILE.Entry No."; ItemLedgerEntry."Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Rev.ILE.Entry No."; reversingItemLedgerEntry."Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Applies-to Doc. No."; salesCrMemoHeader."Applies-to Doc. No.")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    var
        salesCrMemoHeader: Record "Sales Cr.Memo Header";
        valueEntry: Record "Value Entry";
        itemLedgerEntry: Record "Item Ledger Entry";
        reversingItemLedgerEntry: Record "Item Ledger Entry";
        postedAssemblyHeader: Record "Posted Assembly Header";

    trigger OnAfterGetRecord()
    begin
        clear(valueEntry);
        Clear(itemLedgerEntry);
        clear(reversingItemLedgerEntry);
        Clear(postedAssemblyHeader);

        salesCrMemoHeader.get(rec."Document No.");
        valueEntry.RESET;
        valueEntry.Setrange("Document Type", valueEntry."Document Type"::"Sales Credit Memo");
        valueEntry.setrange("Document No.", Rec."Document No.");
        valueEntry.SetRange("Document Line No.", rec."Line No.");
        if valueEntry.FindFirst() then begin
            if valueEntry."Item Ledger Entry No." <> 0 then
                if itemLedgerEntry.get(valueEntry."Item Ledger Entry No.") then begin
                    reversingItemLedgerEntry.RESET;
                    if reversingItemLedgerEntry.GET(itemLedgerEntry."Applies-to Entry") then begin
                        if reversingItemLedgerEntry."Entry Type" = reversingItemLedgerEntry."Entry Type"::"Assembly Output" then begin
                            postedAssemblyHeader.Reset;
                            if not postedAssemblyHeader.get(reversingItemLedgerEntry."Document No.") then
                                Clear(postedAssemblyHeader)
                        end;
                    end;
                end;
        end;
    end;
}

