pageextension 50100 "Sales Order Subform Ext" extends "Sales Order Subform"
{

    layout
    {
        modify("No.")
        {
            AssistEdit = true;
            trigger OnAssistEdit()
            var
                ItemList: Page "Item List";
                Item: Record Item;
                SL: Record "Sales Line";
                LineNo: Integer;
            begin
                ItemList.LookupMode := true;
                if ItemList.RunModal() = Action::LookupOK then begin
                    SL.SetRange("Document No.", Rec."Document No.");
                    SL.SetRange("Document Type", Rec."Document Type");
                    if SL.FindLast() then
                        LineNo := SL."Line No.";
                    Item.SetFilter("No.", ItemList.GetSelectionFilter());
                    if Item.FindSet() then
                        repeat
                            LineNo += 10000;
                            SL.Init();
                            SL."Document Type" := Rec."Document Type";
                            SL."Document No." := Rec."Document No.";
                            SL."Line No." := LineNo;
                            SL.Insert(true);
                            SL.Validate(Type, SL.Type::Item);
                            SL.Validate("No.", Item."No.");
                            SL.Validate(Quantity, 1);
                            SL.Modify(true);
                        until Item.Next() = 0;

                    CurrPage.Update(false);

                end

            end;
        }
    }
}
