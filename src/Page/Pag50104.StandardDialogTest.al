page 50104 "Standard Dialog Test"
{
    ApplicationArea = All;
    Caption = 'Standard Dialog Test';
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            field(x; x)
            {
                ApplicationArea = All;
                Caption = 'This is X';
            }
            field(y; y)
            {
                ApplicationArea = All;
                Caption = 'This is Y';
            }
            field(z; z)
            {
                ApplicationArea = All;
                Caption = 'This is Z';
            }

        }

    }


    var
        x, y, z : Text;

}
