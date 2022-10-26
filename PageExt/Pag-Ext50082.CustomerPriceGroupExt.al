pageextension 50082 "CustomerPriceGroupExt" extends "Customer Price Groups"
{
    actions
    {
        addlast(Creation)
        {
            action(MyNewAction)
            {
                Caption = 'KEEP AWAY';
                ApplicationArea = ALL;
                trigger OnAction();

                var
                    //  cuUpdateSalesPrices: Codeunit "Update Item Sales Prices";
                    cuUpdateSalesPrices: Codeunit "Upd. SP Blank StartDate";
                begin
                    cuUpdateSalesPrices.Run();
                end;
            }

        }
    }
}