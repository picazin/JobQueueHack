codeunit 50101 "JQH Dummy Process"
{
    trigger OnRun()
    begin
        //Sleep(5000);
        Error('TEST');
    end;
}