pageextension 66026 "CCSShowErrorLog" extends "Cash Receipt Journal" //255
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter(Approval)
        {
            action("OpenErrorLog")
            {
                ApplicationArea = All;
                Caption = 'Posting Error Logs';
                Image = ErrorLog;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Promoted = true;
                trigger OnAction()
                var
                    CCSPostingJournalErrorLog: Record "CCS Posting Journal Error Log";
                begin
                    CCSPostingJournalErrorLog.Reset();
                    CCSPostingJournalErrorLog.SetRange("Template Name", rec."Journal Template Name");
                    CCSPostingJournalErrorLog.SetRange("Batch Name", rec."Journal Batch Name");
                    Page.Runmodal(PAGE::"CCS Posting Journal Error Logs", CCSPostingJournalErrorLog);
                end;
            }
        }
    }

    var
        myInt: Integer;
}