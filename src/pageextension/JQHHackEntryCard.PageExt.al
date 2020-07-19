pageextension 50101 "JQH Hack Entry Card" extends "Job Queue Entry Card"
{
    layout
    {
        addlast(content)
        {
            group("JQH Hack")
            {
                Caption = 'Hack Job Queue';
                field("JQH Disable Concurrent Run"; "JQH Disable Concurrent Run")
                { ApplicationArea = All; }
                field("JQH Recurrent On Error"; "JQH Recurrent On Error")
                { ApplicationArea = All; }
                field("JQH Rec. On Selected Errors"; "JQH Rec. On Selected Errors")
                { ApplicationArea = All; }
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
                Image = Error;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "JQH Allowed Errors";
                RunPageLink = "Object Type to Run" = field("Object Type to Run"), "Object ID to Run" = field("Object ID to Run");

            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        AllowedErr: Record "JQH Allowed Errors";
        EmptyAllowErr: Label 'Allowed errors must be set when %1 is selected';
    begin
        if "JQH Rec. On Selected Errors" then begin
            AllowedErr.SetRange("Object Type to Run", "Object Type to Run");
            AllowedErr.SetRange("Object ID to Run", "Object ID to Run");
            if AllowedErr.IsEmpty() then
                Error(EmptyAllowErr, "JQH Rec. On Selected Errors");
        end;
    end;
}