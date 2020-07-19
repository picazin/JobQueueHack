page 50100 "JQH Allowed Errors"
{

    ApplicationArea = All;
    Caption = 'JQH Allowed Errors';
    PageType = List;
    SourceTable = "JQH Allowed Errors";
    UsageCategory = Lists;
    DelayedInsert = true;
    MultipleNewLines = true;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Object Type to Run"; "Object Type to Run")
                {
                    ApplicationArea = All;
                }
                field("Object ID to Run"; "Object ID to Run")
                {
                    ApplicationArea = All;
                }
                field("Error Text"; "Error Text")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
