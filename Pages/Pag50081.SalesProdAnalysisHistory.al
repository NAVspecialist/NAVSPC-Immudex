page 50081 "Sales Prod Analysis History"
{
    Caption = 'Sales Prod Analysis History';
    PageType = List;
    SourceTable = "Sales Invoice Line";
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTableView = where("Type" = filter(Item));
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Invoice No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Order No."; salesInvHeader."Order No.")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; salesInvHeader."Order Date")
                {
                    ApplicationArea = All;
                }
                field("External Order No."; salesInvHeader."External Document No.")
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
                field("Exp. Shipment Date"; salesInvHeader."Exp. Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Act. Shipment Date"; salesInvHeader."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Act. Delivery Date"; salesInvHeader."Act. Delivery Date")
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

                field(Name; salesInvHeader."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field(ShiptoName; salesInvHeader."Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field(Country; salesInvHeader."Sell-to Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Ext. Sales Order No."; salesInvHeader."Ext. Sales Order No.")
                {
                    ApplicationArea = all;
                }
                field("Assembly BOM No."; postedAssemblyHeader."No.")
                {
                    ApplicationArea = All;
                }
                field("Assembly BOM Starting Date"; postedAssemblyHeader."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Assembly BOM Ending Date"; postedAssemblyHeader."Ending Date")
                {
                    ApplicationArea = All;
                }
                field("Assembly BOM Posting Date"; postedAssemblyHeader."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("valueEntry.Entry No."; valueEntry."Entry No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("ILE.Entry No."; itemLedgerEntry."Entry No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Rev.ILE.Entry No."; reversingItemLedgerEntry."Entry No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    var
        salesInvHeader: Record "Sales Invoice Header";
        valueEntry: Record "Value Entry";
        itemLedgerEntry: Record "Item Ledger Entry";
        reversingItemLedgerEntry: Record "Item Ledger Entry";
        postedAssemblyHeader: Record "Posted Assembly Header";

    trigger OnAfterGetRecord()
    begin
        Clear(valueEntry);
        Clear(itemLedgerEntry);
        Clear(reversingItemLedgerEntry);
        Clear(postedAssemblyHeader);

        salesInvHeader.Get(Rec."Document No.");
        valueEntry.Reset;
        valueEntry.SetRange("Document Type", valueEntry."Document Type"::"Sales Invoice");
        valueEntry.SetRange("Document No.", Rec."Document No.");
        valueEntry.SetRange("Document Line No.", Rec."Line No.");
        if valueEntry.FindFirst() then begin
            if valueEntry."Item Ledger Entry No." <> 0 then
                if itemLedgerEntry.Get(valueEntry."Item Ledger Entry No.") then begin
                    reversingItemLedgerEntry.Reset;
                    if reversingItemLedgerEntry.Get(itemLedgerEntry."Applies-to Entry") then begin
                        if reversingItemLedgerEntry."Entry Type" = reversingItemLedgerEntry."Entry Type"::"Assembly Output" then begin
                            postedAssemblyHeader.Reset;
                            if not postedAssemblyHeader.Get(reversingItemLedgerEntry."Document No.") then
                                Clear(postedAssemblyHeader)
                        end;
                    end;
                end;
        end;
    end;
}

