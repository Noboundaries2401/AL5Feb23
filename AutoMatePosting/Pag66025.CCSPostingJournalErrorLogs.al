page 66025 "CCS Posting Journal Error Logs"
{
    ApplicationArea = All;
    Caption = 'Posting Journal Error Logs';
    PageType = List;
    SourceTable = "CCS Posting Journal Error Log";
    
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Batch Name"; Rec."Batch Name")
                {
                    ToolTip = 'Specifies the value of the Batch Name field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Error Description"; Rec."Error Description")
                {
                    ToolTip = 'Specifies the value of the Error Description field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                field("Template Name"; Rec."Template Name")
                {
                    ToolTip = 'Specifies the value of the Template Name field.';
                }
            }
        }
    }
}
