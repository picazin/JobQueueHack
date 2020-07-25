pageextension 83250 "JQH Hack Actions" extends "Job Queue Entries"
{
    actions
    {
        addlast("Job &Queue")
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
                ToolTip = 'List of allowed errors for selected process';
            }
            action("JQH Refresh")
            {
                ApplicationArea = All;
                Caption = 'Refresh';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Get refreshed data';

                trigger OnAction()
                begin
                    CurrPage.Update(false);
                end;
            }
        }
    }
}