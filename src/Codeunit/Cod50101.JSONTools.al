codeunit 50101 "JSON Tools"
{

    procedure Rec2Json(Rec: Variant): JsonObject
    var
        Ref: RecordRef;
        Out: JsonObject;
        FRef: FieldRef;
        i: Integer;
    begin
        if not Rec.IsRecord then
            error('Parameter Rec is not a record');
        Ref.GetTable(Rec);
        for i := 1 to Ref.FieldCount() do begin
            FRef := Ref.FieldIndex(i);
            Out.Add('F' + format(Fref.Number(), 0, 9), FieldRef2JsonValue(FRef));
        end;

        exit(Out);
    end;


    local procedure FieldRef2JsonValue(FRef: FieldRef): JsonValue
    var
        V: JsonValue;
        D: Date;
    begin
        Case Fref.Type() of

            FieldType::Date:
                begin
                    D := FRef.Value;
                    V.SetValue(D);
                end;
            else
                V.SetValue(Format(FRef.Value, 0, 9));
        End;

    end;

}
