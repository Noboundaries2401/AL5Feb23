pageextension 66025 "GenJnlBatch" extends "General Journal Batches"//251
{
    layout
    {
        addafter("No. Series")
        {
            field("Automatic Posting"; rec."CCS Automatic Posting")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }


}