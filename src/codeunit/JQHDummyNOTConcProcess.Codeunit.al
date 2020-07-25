codeunit 50103 "JQH Dummy NOT Conc. Process"
{
    trigger OnRun()
    var
        ExLog: Record "JQH Execution Log";
    begin
        ExLog.LockTable();
        ExLog.Init();
        ExLog."Object Type to Run" := ExLog."Object Type to Run"::Codeunit;
        ExLog."Object ID to Run" := Codeunit::"JQH Dummy NOT Conc. Process";
        ExLog."Start DT" := CurrentDateTime();
        Sleep(1000);
        ExLog."End DT" := CurrentDateTime();
        ExLog.Insert();
        Commit();
    end;
}