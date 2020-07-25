table 50101 "JQH Execution Log"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "Object Type to Run"; Option)
        {
            Caption = 'Object Type to Run';
            DataClassification = SystemMetadata;
            OptionCaption = ',,,Report,,Codeunit';
            OptionMembers = ,,,"Report",,"Codeunit";

        }
        field(3; "Object ID to Run"; Integer)
        {
            Caption = 'Object ID to Run';
            DataClassification = SystemMetadata;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = field("Object Type to Run"));
        }
        field(4; "Object Caption to Run"; Text[250])
        {
            CalcFormula = Lookup (AllObjWithCaption."Object Caption" where("Object Type" = field("Object Type to Run"), "Object ID" = field("Object ID to Run")));
            Caption = 'Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Start DT"; DateTime)
        {
            Caption = 'Start Processing';
            DataClassification = SystemMetadata;
        }
        field(6; "End DT"; DateTime)
        {
            Caption = 'End Processing';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
    /*
    trigger OnInsert()
    var
        ExecutionLog: Record "JQH Execution Log";
    begin
        if ExecutionLog.FindLast() then
            "Entry No." := ExecutionLog."Entry No." + 1
        else
            "Entry No." := 1;
    end;
    */
}