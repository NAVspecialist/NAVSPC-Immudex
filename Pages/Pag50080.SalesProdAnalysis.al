page 50080 "Sales Prod Analysis"
{
    Caption = 'Sales Prod Analysis';
    PageType = List;
    SourceTable = "Sales Line";
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
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
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ApplicationArea = All;
                }
                //#                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                //#                {
                //#                    ApplicationArea = All;
                //#                }
                //#                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                //#                {
                //#                    ApplicationArea = All;
                //#                }
                //#                field("Planned Shipment Date"; Rec."Planned Shipment Date")
                //#                {
                //#                    ApplicationArea = All;
                //#                }
                field("Exp. Shipment Date"; salesHeader."Exp. Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Act. Shipment Date"; salesHeader."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Act. Delivery Date"; salesHeader."Act. Delivery Date")
                {
                    ApplicationArea = All;
                }

                //#                field("Shipment Date"; Rec."Shipment Date")
                //#                {
                //#                    ApplicationArea = All;
                //#                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Name"; salesHeader."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Country"; salesHeader."Sell-to Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Ext. Sales Order No."; SalesHeader."Ext. Sales Order No.")
                {
                    ApplicationArea = all;
                }

                field("Assembly BOM No."; assemblyHeader."No.")
                {
                    ApplicationArea = All;
                }
                field("Assembly BOM Starting Date"; assemblyHeader."Starting Date")
                {
                    ApplicationArea = all;
                }
                field("Assembly BOM Ending Date"; assemblyHeader."Ending Date")
                {
                    ApplicationArea = all;
                }
                field("Assembly BOM Posting Date"; assemblyHeader."Posting Date")
                {
                    ApplicationArea = all;
                }

            }
        }
    }
    var
        salesHeader: Record "Sales Header";
        orderTrackingEntry: Record "Order Tracking Entry";
        reservationEntry: Record "Reservation Entry";
        assemblyHeader: Record "Assembly Header";

    trigger OnAfterGetRecord()
    begin
        salesHeader.get("Document Type", "Document No.");
        ReservationEntry.Reset();
        ReservationEntry.Setrange("Source ID", salesHeader."No.");
        ReservationEntry.Setrange("Source Ref. No.", rec."Line No.");
        ReservationEntry.SetRange("Source Type", 37); // Sales Line
        ReservationEntry.setrange("Source Subtype", 1); // Document Type = Order
        ReservationEntry.SetRange("Reservation Status", ReservationEntry."Reservation Status"::Reservation);
        if ReservationEntry.FindFirst then begin
            ReservationEntry.GET(ReservationEntry."Entry No.", true); // Find matching Reservation Entry
            assemblyHeader.Reset;
            assemblyHeader.SetRange("Document Type", ReservationEntry."Source Subtype");
            assemblyHeader.SetRange("No.", ReservationEntry."Source ID");
            if not assemblyHeader.findfirst then
                Clear(assemblyHeader)
        end;
    end;
}

