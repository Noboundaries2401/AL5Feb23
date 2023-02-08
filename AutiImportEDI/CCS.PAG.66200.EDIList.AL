page 66200 "CCS EDI List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CCS EDI Setup";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Journal Template Name"; rec."Pmt Jnl Template Name")
                {
                    ApplicationArea = All;

                }
                field("Journal Batch Name"; rec."Pmt Jnl Batch Name")
                {
                    ApplicationArea = All;

                }



            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("&Import")
            {


                ApplicationArea = All;
                Caption = '&Import';
                Image = ImportDatabase;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Import data from CSV';

                trigger OnAction()
                begin
                    CheckBasicData();
                    ReadCSVdata();
                    ImportCSVData();

                end;
            }
        }

    }
    local procedure ReadCSVdata()
    var
        FileManagent: Codeunit "File Management";
        Istream: InStream;
        FromFile: Text[100];
    begin

        UploadIntoStream(UploadMsg, '', '', FromFile, Istream);
        if FromFile <> '' then begin
            FileName := FileManagent.GetFileName(FromFile);
        end else
            Error(NoFileMsg);
        TempCSVBuffer.Reset();
        TempCSVBuffer.DeleteAll();
        TempCSVBuffer.LoadDataFromStream(Istream, ',');
        TempCSVBuffer.GetNumberOfLines();

    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text

    begin
        TempCSVBuffer.Reset();
        if TempCSVBuffer.Get(RowNo, ColNo) then
            exit(TempCSVBuffer.Value)
        else
            exit('');
    end;


    local procedure ImportCSVData()
    var
        PaymentJournal: Record "Gen. Journal Line";
        RowNo: Integer;
        ColNo: Integer;
        LineNO: Integer;
        MaxRow: Integer;
    begin
        RowNo := 0;
        ColNo := 0;
        MaxRow := 0;
        LineNO := 0;
        LineNO := GetLastLineNoFromJournal();
        TempCSVBuffer.Reset();
        if TempCSVBuffer.FindLast() then begin
            MaxRow := TempCSVBuffer."Line No.";
        end;
        for RowNo := 2 to MaxRow do begin
            LineNO += 10000;
            PaymentJournal.Init();
            PaymentJournal."Journal Template Name" := Rec."Pmt Jnl Template Name";
            PaymentJournal."Journal Batch Name" := Rec."Pmt Jnl Batch Name";
            PaymentJournal."Line No." := LineNO;
            EVALUATE(PaymentJournal."Posting Date", GetValueAtCell(RowNo, 1));
            EVALUATE(PaymentJournal."Document Type", GetValueAtCell(RowNo, 2));
            EVALUATE(PaymentJournal."Document No.", GetValueAtCell(RowNo, 3));
            EVALUATE(PaymentJournal."External Document No.", GetValueAtCell(RowNo, 4));
            EVALUATE(PaymentJournal."Account Type", GetValueAtCell(RowNo, 5));
            EVALUATE(PaymentJournal."Account No.", GetValueAtCell(RowNo, 6));
            EVALUATE(PaymentJournal."Description", GetValueAtCell(RowNo, 7));
            Evaluate(PaymentJournal."Amount (LCY)", GetValueAtCell(RowNo, 8));
            Evaluate(PaymentJournal."Bal. Account Type", GetValueAtCell(RowNo, 9));
            Evaluate(PaymentJournal."Bal. Account No.", GetValueAtCell(RowNo, 10));
            PaymentJournal.Validate("Amount (LCY)");//To Put Value in Amount Also
            PaymentJournal.Insert();

        end;
        Message(CSVImportSuccess);
    end;

    local procedure GetLastLineNoFromJournal(): Integer;
    var
        GenJnl: Record "Gen. Journal Line";

    begin
        CheckBasicData();
        GenJnl.SetRange("Journal Template Name", rec."Pmt Jnl Template Name");
        GenJnl.SetRange("Journal Batch Name", rec."Pmt Jnl Batch Name");
        IF GenJnl.FindLast() then
            EXIT(GenJnl."Line No.");

        exit(0);
    end;

    local procedure CheckBasicData()

    begin
        Rec.TestField("Pmt Jnl Template Name");
        Rec.TestField("Pmt Jnl Batch Name");

    end;

    var

        FileName: Text[100];
        TempCSVBuffer: Record "CSV Buffer" temporary;
        UploadMsg: Label 'Please choose the CSV file';
        NoFileMsg: Label 'No CSV file found';
        BatchIsblankmsg: Label 'Trasaction name is blank';
        CSVImportSuccess: Label 'CSV imported successfully';

}