tableextension 50100 "JQH Hack Queue" extends "Job Queue Entry"
{
    fields
    {
        field(50100; "JQH Disable Concurrent Run"; Boolean)
        {
            DataClassification = SystemMetadata;
        }
        field(50101; "JQH Recurrent On Error"; Boolean)
        {
            DataClassification = SystemMetadata;
        }
    }
}