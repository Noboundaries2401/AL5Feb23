
pageextension 66027 "CCS Setup" extends "General Ledger Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter(Application)
        {
            group("CCS Setup")
            {
                Caption = 'CCS Setup';
                field("CCS Error Log Email";Rec."CCS Error Log Email")
                {
                    ApplicationArea = All;
                    Caption = 'Error Log Email';
                    Importance = Promoted;
                }
                
            }
        }
    }
    
    actions
    {
        // Add changes to page actions here
    }
    
    var
        myInt: Integer;
}
