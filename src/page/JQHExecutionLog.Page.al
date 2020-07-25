page 50101 "JQH Execution Log"
{

    ApplicationArea = All;
    Caption = 'JQH Execution Log';
    PageType = List;
    SourceTable = "JQH Execution Log";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Object Type to Run"; "Object Type to Run")
                {
                    ApplicationArea = All;
                }
                field("Object ID to Run"; "Object ID to Run")
                {
                    ApplicationArea = All;
                }
                field("Object Caption to Run"; "Object Caption to Run")
                {
                    ApplicationArea = All;
                }
                field("Start DT"; Format("Start DT", 0, '<Hours24,2>:<Minutes,2>:<Seconds,2><Second dec.>'))
                {
                    Caption = 'Start Processing';
                    ApplicationArea = All;
                }
                field("End DT"; Format("End DT", 0, '<Hours24,2>:<Minutes,2>:<Seconds,2><Second dec.>'))
                {
                    Caption = 'End Processing';
                    ApplicationArea = All;
                }
                field(RunTime; RunTime)
                {
                    Caption = 'Run Time';
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        RunTime: Duration;

    trigger OnAfterGetRecord()
    begin
        RunTime := "End DT" - "Start DT";
    end;
}
