tableextension 50100 "JQH Hack Queue" extends "Job Queue Entry"
{
    fields
    {
        field(50100; "JQH Disable Concurrent Run"; Boolean)
        {
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin
                "JQH Disable Concurrency" := false;
            end;
        }
        field(50101; "JQH Disable Concurrency"; Boolean)
        {
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin
                "JQH Disable Concurrent Run" := false;
            end;
        }

        field(50102; "JQH Recurrent On Error"; Boolean)
        {
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin
                "JQH Rec. On Selected Errors" := false;
            end;
        }
        field(50103; "JQH Rec. On Selected Errors"; Boolean)
        {
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin
                "JQH Recurrent On Error" := false;
            end;
        }
    }
}