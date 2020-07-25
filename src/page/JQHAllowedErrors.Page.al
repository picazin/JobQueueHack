page 83250 "JQH Allowed Errors"
{

    ApplicationArea = All;
    Caption = 'JQH Allowed Errors';
    PageType = List;
    SourceTable = "JQH Allowed Errors";
    UsageCategory = Lists;
    DelayedInsert = true;
    //MultipleNewLines = true;
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
                    trigger OnValidate()
                    begin
                        if "Object Type to Run" <> xRec."Object Type to Run" then
                            Validate("Object ID to Run", 0);
                    end;
                }
                field("Object ID to Run"; "Object ID to Run")
                {
                    ApplicationArea = All;
                }
                field("Object Caption to Run"; "Object Caption to Run")
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
    trigger OnAfterGetCurrRecord()
    begin
        CalcFields("Object Caption to Run");
    end;
}
