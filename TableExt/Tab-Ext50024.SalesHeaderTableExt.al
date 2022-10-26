tableextension 50024 "SalesHeaderTableExt" extends "Sales Header"
{
    fields
    {
        field(50080; "Sales Quote Date"; Date)
        {
            Caption = 'Sales Quote Date';
            DataClassification = ToBeClassified;
        }
        field(50081; "Exp. Shipment Date"; Date)
        {
            Caption = 'Exp. Shipment Date';
            DataClassification = ToBeClassified;
        }
        field(50082; "Act. Delivery Date"; Date)
        {
            Caption = 'Act. Delivery Date';
            DataClassification = ToBeClassified;
        }
        field(50083; "Ext. Sales Order No."; Code[20])
        {
            Caption = 'Ext. Sales Order No.';
            DataClassification = ToBeClassified;
        }
        modify("Ship-to Code")
        {
            trigger OnAfterValidate()
            var
                shipToAddress: Record "Ship-to Address";
                Message001: Label 'Salesperson changed!';
            begin
                if StrLen(Rec."Ship-to Code") <> 0 then begin
                    ShipToAddress.GET(Rec."Sell-to Customer No.", Rec."Ship-to Code");
                    if strlen(shipToAddress."Salesperson Code") <> 0 then begin
                        Validate("Salesperson Code", shipToAddress."Salesperson Code");
                        Message(Message001);
                    end;
                end;
            end;
        }
        modify("External Document No.")
        {
            trigger OnAfterValidate()
            var
                lSalesHeader: Record "Sales Header";
                lSalesInvoiceHeader: Record "Sales Invoice Header";
                MessageOrder: Label 'External Document No. found on order no. %1';
                MessageInvoice: Label 'External Document No. found on Invoice No. %1';

            begin
                if StrLen(Rec."External Document No.") <> 0 then begin
                    //# Test if External Document No. is used on Other Orders
                    lSalesHeader.Reset();
                    lSalesHeader.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                    lsalesHeader.Setrange("External Document No.", Rec."External Document No.");
                    lSalesHeader.Setfilter("No.", '<>%1', Rec."No.");
                    if lSalesHeader.Findfirst then
                        Message(MessageOrder, lSalesHeader."No.");

                    //# Test if External Document No. is used on Posted Invoices.
                    lSalesInvoiceHeader.Reset();
                    lSalesInvoiceHeader.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                    lsalesInvoiceHeader.Setrange("External Document No.", Rec."External Document No.");
                    if lSalesInvoiceHeader.Findfirst then
                        Message(MessageInvoice, lSalesInvoiceHeader."No.");
                end;
            end;
        }
    }
}
