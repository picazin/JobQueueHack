tableextension 83250 "JQH Hack Queue" extends "Job Queue Entry"
{
    fields
    {
        field(83250; "JQH Disable Concurrent Run"; Boolean)
        {
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin
                "JQH Disable Concurrency" := false;
            end;
        }
        field(83251; "JQH Disable Concurrency"; Boolean)
        {
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin
                "JQH Disable Concurrent Run" := false;
            end;
        }

        field(83252; "JQH Recurrent On Error"; Boolean)
        {
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin
                "JQH Rec. On Selected Errors" := false;
            end;
        }
        field(83253; "JQH Rec. On Selected Errors"; Boolean)
        {
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin
                "JQH Recurrent On Error" := false;
            end;
        }
    }
}