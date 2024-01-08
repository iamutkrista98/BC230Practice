page 50101 "Excel Viewer"
{
    ApplicationArea = All;
    Caption = 'Excel Viewer';
    PageType = List;
    SourceTable = Integer;
    SourceTableView = where(Number = filter(1 ..));
    Editable = false;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Rep)
            {
                field(Number; Rec.Number)
                {
                    Caption = '';
                    ApplicationArea = All;
                }
                field(Col1; GetExcelCell(Rec.Number, LeftMostColumn))
                {
                    CaptionClass = '3,' + GetColumnHeading(LeftMostColumn);
                    ApplicationArea = All;
                }
                field(Col2; GetExcelCell(Rec.Number, LeftMostColumn + 1))
                {
                    CaptionClass = '3,' + GetColumnHeading(LeftMostColumn + 1);
                    ApplicationArea = All;
                }
                field(Col3; GetExcelCell(Rec.Number, LeftMostColumn + 2))
                {
                    CaptionClass = '3,' + GetColumnHeading(LeftMostColumn + 2);
                    ApplicationArea = All;
                }
                field(Col4; GetExcelCell(Rec.Number, LeftMostColumn + 3))
                {
                    CaptionClass = '3,' + GetColumnHeading(LeftMostColumn + 3);
                    ApplicationArea = All;
                }
                field(Col5; GetExcelCell(Rec.Number, LeftMostColumn + 4))
                {
                    CaptionClass = '3,' + GetColumnHeading(LeftMostColumn + 4);
                    ApplicationArea = All;
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action(ScrollRight)
            {
                Caption = 'Scroll Right';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = NextRecord;
                trigger OnAction()
                begin
                    LeftMostColumn += 1;
                end;

            }
            action(ScrollLeft)
            {
                Caption = 'Scroll Left';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = PreviousRecord;
                trigger OnAction()
                begin
                    if LeftMostColumn > 1 then
                        LeftMostColumn -= 1;
                end;

            }
            action(Load)
            {
                Caption = 'Load';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    FileName: Text;
                    InS: InStream;
                begin
                    if UploadIntoStream('Excel File', '', '', FileName, InS) then begin
                        ExcelBuffer.DeleteAll();
                        ExcelBuffer.OpenBookStream(InS, 'Sheet1');
                        ExcelBuffer.ReadSheet();
                    end

                end;

            }

        }
    }


    local procedure GetExcelCell(row: Integer; column: Integer): Text
    begin
        if ExcelBuffer.Get(row, column) then
            exit(ExcelBuffer."Cell Value as Text");

    end;

    local procedure GetColumnHeading(columnNumber: Integer): Text
    var
        dividend: Integer;
        columnName: Text;
        modulo: Integer;
        c: Char;

    begin
        dividend := columnNumber;

        while (dividend > 0) do begin
            modulo := (dividend - 1) mod 26;
            c := 65 + modulo;
            columnName := format(c) + columnName;
            dividend := (dividend - modulo) DIV 26;
        end;

        exit(columnName);


    end;

    var
        ExcelBuffer: Record "Excel Buffer" temporary;
        LeftMostColumn: Integer;



    trigger OnOpenPage()
    begin
        LeftMostColumn := 1;

    end;

}
