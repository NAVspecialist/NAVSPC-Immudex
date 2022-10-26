pageextension 50093 "ItemCreationTemplateExt" extends ItemCreationTemplateCard
{
    layout
    {
        addafter(ItemUoMTemplLinesListPart)
        {
            part(ItemSalesPriceTemplateLine; ItemSalesPriceTemplateLine)
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Item No." = Field(Code);
                UpdatePropagation = Both;
            }
        }
    }
}