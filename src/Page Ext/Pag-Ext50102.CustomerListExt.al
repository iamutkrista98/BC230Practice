pageextension 50102 "Customer List Ext" extends "Customer List"
{

    trigger OnOpenPage()
    var
        JSON: Codeunit "JSON Tools";
    begin
        Rec.FindFirst();
        Message('%1', Json.Rec2Json(Rec));

    end;
}
