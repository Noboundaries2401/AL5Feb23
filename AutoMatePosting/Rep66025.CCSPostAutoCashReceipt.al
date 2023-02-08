report 66025 "CCS Post Auto Cash Receipt"
{
    Caption = 'Post Automatic Cash Receipt';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    ApplicationArea = All;

    trigger OnPreReport()
    var
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlLine2: Record "Gen. Journal Line";

    begin

        GenJnlBatch.Reset();
        GenJnlBatch.SetRange("CCS Automatic Posting", true);
        if GenJnlBatch.FindSet() then
            repeat
                GenJnlLine.Reset();
                GenJnlLine.SetRange("Journal Batch Name", GenJnlBatch.Name);
                GenJnlLine.Setrange("Journal Template Name", GenJnlBatch."Journal Template Name");
                if GenJnlLine.FindSET() then Begin
                    //repeat
                    /*                         GenJnlLine2.RESET;
                                            GenJnlLine2.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
                                            GenJnlLine2.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
                                            GenJnlLine2.SETRANGE("Line No.", GenJnlLine."Line No.");
                                            If GenJnlLine2.FindFirst() THEN
                     */
                    IF Not CODEUNIT.RUN(Codeunit::"Gen. Jnl.-Post Batch", GenJnlLine) then
                        CreateLog(GenJnlLine);
                    //until GenJnlLine.Next = 0;
                end;
                If BodyMessage <> '' then
                    SendEmail(GenJnlLine."Journal Batch Name");
                ClearEmailVariables();
            until GenJnlBatch.Next = 0;
    end;

    local procedure CreateLog(GenJnlLineP: Record "Gen. Journal Line")
    var
        PostingErrorLog: Record "CCS Posting Journal Error Log";
    begin
        PostingErrorLog.Init;
        PostingErrorLog."Entry No." := 0;
        PostingErrorLog."Batch Name" := GenJnlLineP."Journal Batch Name";
        PostingErrorLog."Template Name" := GenJnlLineP."Journal Template Name";
        PostingErrorLog."Document No." := GenJnlLineP."Document No.";
        PostingErrorLog."User ID" := UserId;
        PostingErrorLog."Error Description" := CopyStr(GetLastErrorText(), 1, MAXSTRLEN(PostingErrorLog."Error Description"));
        PostingErrorLog.Insert();
        Commit;//Ending all write transactions so that codeunit.run can work again

        AddBodyText(PostingErrorLog."Error Description");
    end;


    local procedure AddBodyText(ErrorDescription: Text);
    begin
        If ErrorDescription = '' then
            exit;

        IF BodyMessage = '' then
            BodyMessage := ErrorDescription
        else
            BodyMessage += '<br>' + ErrorDescription;
    end;

    local procedure SendEmail(BatchName: Text)
    var
        GenLedgerSetup: Record "General Ledger Setup";
    begin
        GenLedgerSetup.Get;
        If GenLedgerSetup."CCS Error Log Email" = '' then
            exit;
        if BodyMessage = '' then
            exit;

        EmailMessage.Create(GenLedgerSetup."CCS Error Log Email", StrSubstNo((EmailSubtxt), BatchName), BodyMessage, true);
        EmailSend.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;
    procedure AddCompanySign()
    var
        CompInfo: Record "Company Information";

    begin
        CompInfo.Get();
        BodyMessage += '<BR> <BR>' + 'Thanks <BR>' + CompInfo.Name;
    end;
    local procedure ClearEmailVariables()

    begin
        Clear(EmailAccount);
        Clear(EmailMessage);
        Clear(BodyMessage);
        Clear(EmailSend);

    end;

    var

        EmailAccount: Record "Email Account";
        EmailMessage: Codeunit "Email Message";
        BodyMessage: Text;
        EmailSend: Codeunit Email;

        EmailSubtxt: TextConst ENU = 'Cash Receipt Error Log for %1';


}

