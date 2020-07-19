pageextension 50100 "JQH Hack Actions" extends "Job Queue Entries"
{
    layout
    {

    }

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
            }
            action("JQH Create Concurrent Records")
            {
                ApplicationArea = All;
                Caption = 'Create demo concurrent error records';
                Image = Entries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    JQH: Codeunit "JQH Job Queue Hack";
                begin
                    JQH.CreateJQEntry(1, 20);
                end;
            }
            action("JQH Create Error Records")
            {
                ApplicationArea = All;
                Caption = 'Create demo error records';
                Image = Entries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    JQH: Codeunit "JQH Job Queue Hack";
                begin
                    JQH.CreateJQEntry(2, 5);
                end;
            }
            action("JQH Refresh")
            {
                ApplicationArea = All;
                Caption = 'Refresh';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    CurrPage.Update(false);
                end;
            }
        }
    }
}