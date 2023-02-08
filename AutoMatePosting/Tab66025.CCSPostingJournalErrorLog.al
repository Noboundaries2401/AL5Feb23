table 66025 "CCS Posting Journal Error Log"
{
    Caption = 'Posting Error Logs';
    DataClassification = ToBeClassified;
    DrillDownPageId = "CCS Posting Journal Error Logs";
    LookupPageId = "CCS Posting Journal Error Logs";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = True;
            Editable = false;
            NotBlank = true;
            Caption = 'Entry No.';
        }
        field(2; "Batch Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Template Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(6; "Error Description"; Text[1024])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Pk; "Entry No.")
        {
            Clustered = true;
        }
    }
}