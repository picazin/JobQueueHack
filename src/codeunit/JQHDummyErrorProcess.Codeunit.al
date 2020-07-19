codeunit 50102 "JQH Dummy Error Process"
{
    trigger OnRun()
    begin
        Error('other user cause deadlock.');
    end;
}