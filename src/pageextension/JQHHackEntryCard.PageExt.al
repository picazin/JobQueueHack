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
            }
        }
    }
}