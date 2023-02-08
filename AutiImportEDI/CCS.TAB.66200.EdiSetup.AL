table 66200 "CCS EDI Setup"
{
    DataClassification = ToBeClassified;
    Caption = 'EDI Setup';
    fields
    {
        field(1;"Pmt Jnl Template Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template" where (Type = const(Payments));     
            
        }
        field(2;"Pmt Jnl Batch Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name Where ("Journal Template Name" =field ("Pmt Jnl Template Name"));
        }

    }
    
    keys
    {
        key(Key1; "Pmt Jnl Template Name","Pmt Jnl Batch Name")
        {
            Clustered = true;
        }
    }
    
    
    trigger OnInsert()
    begin
        
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;
    
}