tableextension 50100 "Sales Line Ext" extends "Sales Line"
{
    fields
    {
        field(50100; VendorItemNo; Text[50])
        {
            Caption = 'VendorItemNo';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Vendor Item No." where("Common Item No." = field("No.")));
        }
    }
}
