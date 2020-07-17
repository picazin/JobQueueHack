pageextension 50100 "JQH Hack Actions" extends "Job Queue Entries"
{
    layout
    {

    }

    actions
    {
        addlast("Job &Queue")
        {
            action("JQH CreateRecords")
            {
                ApplicationArea = All;
                Caption = 'Create 100 demo records';
                Image = Entries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    JQH: Codeunit "JQH Job Queue Hack";
                begin
                    JQH.CreateJQEntry(100);
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