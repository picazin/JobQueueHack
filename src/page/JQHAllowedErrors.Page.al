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
                field("Object Type to Run"; Rec."Object Type to Run")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Object Type to Run field';
                    trigger OnValidate()
                    begin
                        if Rec."Object Type to Run" <> xRec."Object Type to Run" then
                            Rec.Validate("Object ID to Run", 0);
                    end;
                }
                field("Object ID to Run"; Rec."Object ID to Run")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Object ID to Run field';
                }
                field("Object Caption to Run"; Rec."Object Caption to Run")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field';
                }
                field("Error Text"; Rec."Error Text")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Error Text field';
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        Rec.CalcFields("Object Caption to Run");
    end;
}
