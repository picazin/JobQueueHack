pageextension 83251 "JQH Hack Entry Card" extends "Job Queue Entry Card"
{
    layout
    {
        addlast(content)
        {
            group("JQH Hack")
            {
                Caption = 'Hack Job Queue';
                field("JQH Disable Concurrent Run"; "JQH Disable Concurrent Run")
                {
                    Caption = 'Disable Concurrent Run';
                    ApplicationArea = All;
                    ToolTip = 'If checked, only one record of this type will run at the same time';
                }
                field("JQH Disable Concurrency"; "JQH Disable Concurrency")
                {
                    Caption = 'Disable Concurrency';
                    ApplicationArea = All;
                    ToolTip = 'If checked, only one record will run';
                }
                field("JQH Recurrent On Error"; "JQH Recurrent On Error")
                {
                    Caption = 'Recurrent On Error';
                    ApplicationArea = All;
                    ToolTip = 'The entry will be reprocessed again and again if the execution result is an error';
                }
                field("JQH Rec. On Selected Errors"; "JQH Rec. On Selected Errors")
                {
                    Caption = 'Recurrent On Selected Errors';
                    ApplicationArea = All;
                    ToolTip = 'The entry will be reprocessed again and again if the execution result is an error and this error matches one of the defined errors';
                }
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action("JQH_Allowed_Errors")
            {
                ApplicationArea = All;
                Caption = 'Allowed Errors';
                Image = ErrorLog;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "JQH Allowed Errors";
                RunPageLink = "Object Type to Run" = field("Object Type to Run"), "Object ID to Run" = field("Object ID to Run");
                ToolTip = 'List of allowed errors that will be ignored.';
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        AllowedErr: Record "JQH Allowed Errors";
        EmptyAllowErr: Label 'Allowed errors must be set when %1 is selected.', Comment = '%1 = field name';
    begin
        if "JQH Rec. On Selected Errors" then begin
            AllowedErr.SetRange("Object Type to Run", "Object Type to Run");
            AllowedErr.SetRange("Object ID to Run", "Object ID to Run");
            if AllowedErr.IsEmpty() then
                Error(EmptyAllowErr, "JQH Rec. On Selected Errors");
        end;
    end;
}